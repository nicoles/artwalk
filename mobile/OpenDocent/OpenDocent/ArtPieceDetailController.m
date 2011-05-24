//
//  ArtPieceDetailController.m
//  ArtWalk
//
//  Created by Nicole Aptekar on 11/05/13.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ArtPieceDetailController.h"
#import "OpenDocentAppDelegate.h"
#import "ArtPiecesViewController.h"

@implementation ArtPieceDetailController

@synthesize theArt;
@synthesize fieldLabels;
@synthesize tempValues;
@synthesize textFieldBeingEdited;
@synthesize thisArtPieceContext;

- (IBAction)edit:(id)sender{
    [self.tableView setEditing:self.tableView.editing animated:YES];

    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStyleDone target:self action:@selector(save:)];
    self.navigationItem.rightBarButtonItem = saveButton;
    [saveButton release];
}

- (IBAction)cancel:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)save:(id)sender
{

    NSError *error;
    
    if (textFieldBeingEdited != nil) {
        NSNumber *tagAsNum = [[NSNumber alloc] initWithInt:textFieldBeingEdited.tag];
        [tempValues setObject:textFieldBeingEdited.text forKey:tagAsNum];
        [tagAsNum release];
    }
    /*
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"ArtPiece" inManagedObjectContext:context];
    [request setEntity:entityDescription];
    */
    // store the newly entered data in the CoreData object (existing or not)
    if(self.theArt == nil) {
        // make a new one!
        self.theArt = [NSEntityDescription insertNewObjectForEntityForName:@"ArtPiece" inManagedObjectContext:thisArtPieceContext];
        NSLog(@"NEW ART OMG");
    
    } else {
        NSLog(@"YO BITCHES THE ART IT EXISTS");
        // update the values in the existing artPiece
        // (ie. do nothing here)
    }  
    

    for (NSNumber *key in [tempValues allKeys]) {
        switch ([key intValue]) {
            case kTitleRowIndex:
                theArt.title = [tempValues objectForKey:key];               
                break;
            case kArtistRowIndex:
                theArt.artist = [tempValues objectForKey:key];
                break;
            case kDetailsRowIndex:
                theArt.details = [tempValues objectForKey:key];
                break;
            case kHistoryRowIndex:
                theArt.history = [tempValues objectForKey:key];
                break;
            default:
                break;
        }
    }
    
    NSLog(@"New Art! Title: %@, %@, %@, %@", theArt.title, theArt.artist, theArt.details, theArt.history);
    self.theArt.needsSync = [NSNumber numberWithBool:YES];

    //[request release];
    [thisArtPieceContext save:&error];
    
    
    [self.navigationController popViewControllerAnimated:YES];

    
}

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    [theTextField resignFirstResponder];
	
	return YES;
}


- (IBAction)textFieldDone:(id)sender
{
    UITableViewCell *cell = (UITableViewCell *)[[sender superview] superview];
    UITableView *table = (UITableView *)[cell superview];
    NSIndexPath *textFieldIndexPath = [table indexPathForCell:cell];
    NSUInteger row = [textFieldIndexPath row];
    row++;
    if (row >= kNumberOfTotalRows)
    {
        row = 0;
    }
    NSIndexPath *newPath = [NSIndexPath indexPathForRow:row inSection:0];
    UITableViewCell *nextCell = [self.tableView cellForRowAtIndexPath:newPath];
    UITextField *nextField = nil;
    for (UIView *oneView in nextCell.contentView.subviews)
    {
        if ([oneView isMemberOfClass:[UITextField class]])
            nextField = (UITextField *)oneView;
    }
    [nextField becomeFirstResponder];
}

#pragma mark -
- (void)viewDidLoad
{
    OpenDocentAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    self.thisArtPieceContext = context;
    
    self.tableView.editing = NO;
    
    NSArray *array = [[NSArray alloc] initWithObjects:@"Title:", @"Artist:", @"Details", @"History", nil];
    self.fieldLabels = array;
    [array release];
    
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(cancel:)];
    self.navigationItem.leftBarButtonItem = cancelButton;
    [cancelButton release];
    
    UIBarButtonItem *editButton = [[UIBarButtonItem alloc] initWithTitle:@"Edit" style:UIBarButtonItemStylePlain target:self action:@selector(edit:)];
    self.navigationItem.rightBarButtonItem = editButton;
    [editButton release];
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    self.tempValues = dict;
    [dict release];
    [super viewDidLoad];
}

- (void)dealloc
{
    [theArt release];
    [fieldLabels release];
    [tempValues release];
    [textFieldBeingEdited release];
    [thisArtPieceContext release];
    [super dealloc];
}

#pragma mark - 
#pragma mark Table Data Source Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return kNumberOfMainRows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ArtPieceCellIdentifier = @"ArtPieceCellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ArtPieceCellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ArtPieceCellIdentifier] autorelease];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 75, 25)];
        label.textAlignment = UITextAlignmentRight;
        label.tag = kLabelTag;
        label.font = [UIFont boldSystemFontOfSize:14];
        [cell.contentView addSubview:label];
        [label release];
        
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(90, 12, 200, 25  )];
        textField.clearsOnBeginEditing = NO;
        [textField setDelegate:self];
        [textField addTarget:self action:@selector(textFieldDone:) forControlEvents:UIControlEventEditingDidEndOnExit];
        [cell.contentView addSubview:textField];
        
    }
    NSUInteger row = [indexPath row];
    
    UILabel *label = (UILabel *)[cell viewWithTag:kLabelTag];
    UITextField *textField = nil;
    for (UIView *oneView in cell.contentView.subviews)
    {
        if ([oneView isMemberOfClass:[UITextField class]]) {
            textField = (UITextField *)oneView;
        }
        
    }
    label.text = [fieldLabels objectAtIndex:row];
    NSNumber *rowAsNum = [[NSNumber alloc] initWithInt:row];
    switch (row) {
        case kTitleRowIndex:
            if ([[tempValues allKeys] containsObject:rowAsNum]) {
                textField.text = [tempValues objectForKey:rowAsNum];    
            }else{
                textField.text = theArt.title;
            }
            break;
        case kArtistRowIndex:
            if ([[tempValues allKeys] containsObject:rowAsNum]) {
                textField.text = [tempValues objectForKey:rowAsNum];
                
            }else{
                textField.text = theArt.artist;
            }
            break;
        default:
            break;
    }
    if (textFieldBeingEdited == textField) {
        textFieldBeingEdited = nil;
    }
    textField.tag = row;
    [rowAsNum release];
    return cell;
}

#pragma mark -
#pragma mark Table Delegate Methods
- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
    
}

#pragma mark Text Field Delegate Methods
- (void)textFieldDidBeginEditing:(UITextField *)textField 
{
    self.textFieldBeingEdited = textField;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    NSNumber *tagAsNum = [[NSNumber alloc] initWithInt:textField.tag];
    [tempValues setObject:textField.text forKey:tagAsNum];
    [tagAsNum release];
}

@end
