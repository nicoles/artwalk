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

//@synthesize theArt = theArt_;
@synthesize theArt;
@synthesize fieldLabels;
@synthesize tempValues;
@synthesize textFieldBeingEdited;
@synthesize thisArtPieceContext;

//edit button. doesn't actually seem to change anything, as it's editable all the time, but it totally switches it over to save, and then launches the save method
- (IBAction)edit:(id)sender{
    [self.tableView setEditing:self.tableView.editing animated:YES];

    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStyleDone target:self action:@selector(save:)];
    self.navigationItem.rightBarButtonItem = saveButton;
    [saveButton release];
}

//cancel drops the view. i should probably release some stuff here? maybe set some things to null? dunno.
- (IBAction)cancel:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

//save method. 
- (IBAction)save:(id)sender
{

    NSError *error;
    
    //if a text field is currently being edited, it hasn't gotten it's stuff put into tempvalues. so do that right quick
    if (textFieldBeingEdited != nil) {
        NSNumber *tagAsNum = [[NSNumber alloc] initWithInt:textFieldBeingEdited.tag];
        [tempValues setObject:textFieldBeingEdited.text forKey:tagAsNum];
        [tagAsNum release];
    }
    //if there isn't an artpiece, make one. if there is one, you're good.
    if(self.theArt == nil) {
        // make a new one!
        self.theArt = [NSEntityDescription insertNewObjectForEntityForName:@"ArtPiece" inManagedObjectContext:thisArtPieceContext];
        NSLog(@"NEW ART OMG");
    
    } else {
        NSLog(@"YO BITCHES THE ART IT EXISTS");
    }  
    
    // store the tempvalues data in the CoreData object 
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
    //set this needssync guy, which we'll handle when we're smarter.
    self.theArt.needsSync = [NSNumber numberWithBool:YES];

    [thisArtPieceContext save:&error];
    
    
    [self.navigationController popViewControllerAnimated:YES];

    
}

/*
 //this makes the text field drop when you hit return, but i'm maybe more into having return go from next to next to next. iunno. we'll see. commented out for now
- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    [theTextField resignFirstResponder];
	
	return YES;
}
*/

//this launches when a textfield is no longer being manipulated
- (IBAction)textFieldDone:(id)sender
{
    //the superview of the superview of the sender is apparently the cell. this almost makes sense.
    UITableViewCell *cell = (UITableViewCell *)[[sender superview] superview];
    //i pick up a reference to the table via the cell
    UITableView *table = (UITableView *)[cell superview];
    //i pick up a reference to the indexpath via the table&cell
    NSIndexPath *textFieldIndexPath = [table indexPathForCell:cell];
    //this is the current row. we're about to use it to move to the next row.
    NSUInteger row = [textFieldIndexPath row];
    //here we go!
    row++;
    //if the row is more than the total number of rows, move back to the top. (maybe i could have it resign the keyboard here instead...)
    if (row >= kNumberOfTotalRows)
    {
        row = 0;
    }
    //set the indexpath to the new row.
    NSIndexPath *newPath = [NSIndexPath indexPathForRow:row inSection:0];
    //set the tableview cell to that indexpath
    UITableViewCell *nextCell = [self.tableView cellForRowAtIndexPath:newPath];
    //i'm not sure why i'm setting the textfield to nil. i know that this business is all pretty important, but it's pretty obtuse for me to figure out what i'm actually doing.
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
    if(theArt.title == nil){
        NSLog(@"new art piece coming!");
        //UIImagePickerController *newArtPhoto = [[UIImagePickerController alloc] init];
        
        
    }
    //getting a reference to the coredata context. i use it in the future. i promise.
    OpenDocentAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    self.thisArtPieceContext = context;
    
    //you would think that since i've set this to no, it wouldn't let me edit the table. you'd be wrong.
    self.tableView.editing = NO;
    
    //set up an array with the field labels
    NSArray *array = [[NSArray alloc] initWithObjects:@"Title:", @"Artist:", @"Details", @"History", nil];
    self.fieldLabels = array;
    [array release];
    
    //make a cancel and edit button.
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(cancel:)];
    self.navigationItem.leftBarButtonItem = cancelButton;
    [cancelButton release];
    
    UIBarButtonItem *editButton = [[UIBarButtonItem alloc] initWithTitle:@"Edit" style:UIBarButtonItemStylePlain target:self action:@selector(edit:)];
    self.navigationItem.rightBarButtonItem = editButton;
    [editButton release];
    
    //set up the tempvalues dictionary
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
//at some point this will have multiple sections. it's beyond me right now.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return kNumberOfMainRows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ArtPieceCellIdentifier = @"ArtPieceCellIdentifier";
    
    //set up a cell with a label and textfield
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
    //this chunk of code i still don't get. 
    for (UIView *oneView in cell.contentView.subviews)
    {
        if ([oneView isMemberOfClass:[UITextField class]]) {
            textField = (UITextField *)oneView;
        }
        
    }
    //populate label with it's label from the array of possible row labels
    label.text = [fieldLabels objectAtIndex:row];
    //populate textfield with the tempvalue or the stored value from the managed object (or, yknow, nothing)
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
        case kDetailsRowIndex:
            if ([[tempValues allKeys] containsObject:rowAsNum]) {
                textField.text = [tempValues objectForKey:rowAsNum];
            } else {
                textField.text = theArt.details;
            }
            break;
        case kHistoryRowIndex:
            if ([[tempValues allKeys] containsObject:rowAsNum]) {
                textField.text = [tempValues objectForKey:rowAsNum];
            } else {
                textField.text = theArt.history;
            }
            break;
        default:
            break;
    }
    //not entirely sure why i'm doing this. if the textfield that is being edited is this current textfield, initialize it? hm.
    if (textFieldBeingEdited == textField) {
        textFieldBeingEdited = nil;
    }
    //tag the textfield with the row number. again not quite sure why. this is what happens when i wait three weeks to comment my code
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
