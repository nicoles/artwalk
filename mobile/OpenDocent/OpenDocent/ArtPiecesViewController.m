//
//  ArtPiecesViewController.m
//  ArtWalk
//
//  Created by Nicole Aptekar on 11/05/13.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ArtPiecesViewController.h"
#import "ArtPieceDetailController.h"
#import "OpenDocentAppDelegate.h"
#import "ArtPiece.h"

@implementation ArtPiecesViewController
@synthesize artPiecesInStore;

- (void)viewDidLoad
{
    //coredata setup
    //pick up a reference to the app delegate, pull the context from the app delegate, pull the entity description from that context, make a request, tell the request to look for that entity. prep an error and an array, then figure out if there's objects. Soon following... do some stuff with those objects!
    OpenDocentAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    NSEntityDescription *entityDescripton = [NSEntityDescription entityForName:@"ArtPiece" inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescripton];
    
    NSError *error;
    NSArray *objects = [context executeFetchRequest:request error:&error];
    if (objects == nil) {
        NSLog(@"There was an error!");
        //might want some error handling here...
    }
    
    self.artPiecesInStore = objects;
    
    for (NSManagedObject *oneObject in artPiecesInStore){
        NSString *artPieceTitle = [oneObject valueForKey:@"title"];
        NSString *artPieceArtist = [oneObject valueForKey:@"artist"];
        
        NSLog(@"Title:%@ Artist:%@", artPieceTitle, artPieceArtist);
    }
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.tableView reloadData];
    [super viewWillAppear:animated];
}

- (void)refresh{
    [self.tableView reloadData];
}

- (void)dealloc
{
    [artPiecesInStore release];
    [super dealloc];
}

#pragma mark -
#pragma mark Table Data Source Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    OpenDocentAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    NSEntityDescription *entityDescripton = [NSEntityDescription entityForName:@"ArtPiece" inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescripton];
    
    NSError *error = nil;
    NSUInteger count = [context countForFetchRequest:request error:&error];
    [request release];
    
    if (!error){

        NSLog(@"%i", count);
        return count;
    }
    else
        return 0;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ArtPieceListCellIdentifier = @"ArtPieceListCellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ArtPieceListCellIdentifier];
    if (cell == nil)
    {
        cell = [[[UITableViewCell alloc]
                 initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ArtPieceListCellIdentifier] autorelease];
    }
    NSUInteger row = [indexPath row];
    ArtPiece *theArt = [self.artPiecesInStore objectAtIndex:row];
    cell.textLabel.text = theArt.title;
    cell.detailTextLabel.text = theArt.artist;
    return cell;
}


#pragma mark -
#pragma mark Table Delegate methods
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger row = [indexPath row];
    ArtPiece *theArt = [self.artPiecesInStore objectAtIndex:row];
    
    ArtPieceDetailController *childController = [[ArtPieceDetailController alloc] initWithStyle:UITableViewStyleGrouped];
    childController.title = theArt.title;
    childController.theArt = theArt;
    
    [self.navigationController pushViewController:childController animated:YES];
    [childController release];
    
}
@end
