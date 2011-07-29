//
//  ArtPiecesViewController.m
//  ArtWalk
//
//  Created by Nicole Aptekar on 11/05/13.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ArtPiecesViewController.h"
#import "ArtPieceDetailController.h"
#import "ArtPieceImageLoader.h"
#import "OpenDocentAppDelegate.h"
#import "ArtPiece.h"
#import "ASIHTTPRequest.h"
#import "JSON.h"
#import "ArtPieceTableViewCell.h"
#import <QuartzCore/QuartzCore.h>
#import "UIImageView+WebCache.h"

@implementation ArtPiecesViewController
@synthesize artPiecesOnParade = artPiecesOnParade_;
@synthesize artPiecesContext = artPiecesContext_;
@synthesize imageLoadingQueue = imageLoadingQueue_;


- (void)viewDidLoad
{
    //coredata setup
    //pick up a reference to the app delegate, pull the context from the app delegate, pull the entity description from that context, make a request, tell the request to look for that entity. prep an error and an array, then figure out if there's objects. Soon following... do some stuff with those objects!
    // while we're at it, lets hang on to that context for later.
    OpenDocentAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    self.artPiecesContext = context;
    
    //setup the image loading nsoperationqueue
    self.imageLoadingQueue = [[NSOperationQueue alloc] init] ;
    
    
    //make, add to the view, and then destroy a refresh button
    UIBarButtonItem *refreshButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(syncDatabase)];
    self.navigationItem.rightBarButtonItem = refreshButton;
    [refreshButton release];
    
    //now that the screen is all set up, bug the network dealio for new data.
    [self syncDatabase];

    
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.tableView reloadData];
    [self.tableView setRowHeight:60];
    
    [super viewWillAppear:animated];
}

- (void)syncDatabase{
    //fire off a request using magic. the url goes to amazon. then make the magic know to let THIS code know, and do it's business asynchronously.
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:@"http://75.101.166.190/recent/?mode=json"]];
	[request setDelegate:self];
    [request startAsynchronous];
}

- (void)refreshParade{
    //this checks out the coredata dealiebob and figures out how many things exist in it. then, it puts that into artpieces on parade, and refreshes the table (parade!)

    NSEntityDescription *allArtPieces = [NSEntityDescription entityForName:@"ArtPiece" inManagedObjectContext:self.artPiecesContext];
    
    NSFetchRequest *request = [[[NSFetchRequest alloc] init] autorelease];
    [request setEntity:allArtPieces];
    
    NSError *error;
    NSArray *objects = [self.artPiecesContext executeFetchRequest:request error:&error];
    if (objects == nil) {
        NSLog(@"There was an error!");
        //might want some error handling here...
    }
    NSLog(@"objects count: %u", [objects count]);
    self.artPiecesOnParade = objects;
    NSLog(@"objects count: %u", [self.artPiecesOnParade count]);
    
    [self.tableView reloadData];

}

- (void)dealloc
{
    [artPiecesContext_ release];
    [artPiecesOnParade_ release];
    [imageLoadingQueue_ release];
    [super dealloc];
}

#pragma mark -
#pragma mark Table Data Source Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //count the number of objects in the array. 
    return [self.artPiecesOnParade count];  
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ArtPieceListCellIdentifier = @"ArtPieceListCellIdentifier";
    
    //using a standard tableview cell here. wish me luck!
    ArtPieceTableViewCell *cell = (ArtPieceTableViewCell*) [tableView dequeueReusableCellWithIdentifier:ArtPieceListCellIdentifier];
    if (cell == nil) {
        //make a new cell
        cell = [[[ArtPieceTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ArtPieceListCellIdentifier] autorelease];

    }
    
    NSUInteger row = [indexPath row];
    //pull an art matching the indexpath #
    ArtPiece *theArt = [self.artPiecesOnParade objectAtIndex:row];
    
    //display the proper stuff in the cell
    cell.textLabel.text = theArt.title;
    cell.detailTextLabel.text = theArt.artist;
    
    //NSLog(@"=============> %@", cell.contentView.subviews);
    
    
    
    //drop a loading graphic on the image
    cell.imageView.image = [UIImage imageNamed:@"provisionalloading.png"];

    //check to see if the artpiece has an image online
    if (theArt.mainImageUrl != nil) {
        
        //this is some library i found, it almost works.
        [cell.imageView setImageWithURL:[NSURL URLWithString:theArt.thumbImageUrl]];
        
        
        
        //this is the way i've been writing with Adam, next up I need to write 
        //an imageprovider to handle caching and stuff. i'll come back to this 
        //in the future.
        /*
        //pick up the main image's url
        NSURL *mediaUrl = [[NSURL alloc] initWithString: theArt.thumbImageUrl];
        //NSLog(@"grabbed an imageurl: %@", mediaUrl);
        
        //tell the imageloader to load an image for that url
        ArtPieceImageLoader *imageLoader = [[ArtPieceImageLoader alloc] initWithTableViewCell:cell URL:mediaUrl];
        [self.imageLoadingQueue addOperation:imageLoader];
        
        NSLog(@"Added an imageloader operation to the queue");
        cell.imageLoader = imageLoader;
        [imageLoader release];
        [mediaUrl release];
         */
        
    }
     
    
    //NSLog(@"made a cell for row %u", row);
    return cell;
}


#pragma mark -
#pragma mark Table Delegate methods
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger row = [indexPath row];
    ArtPiece *theArt = [self.artPiecesOnParade objectAtIndex:row];
    
    ArtPieceDetailController *childController = [[ArtPieceDetailController alloc] initWithStyle:UITableViewStyleGrouped];
    childController.title = theArt.title;
    childController.theArt = theArt;
    
    [self.navigationController pushViewController:childController animated:YES];
    [childController release];
    
}


#pragma mark -
#pragma mark NSURLConnection & ASIHTTPRequest

- (void)requestFinished:(ASIHTTPRequest *)request{
    //Make a json string full of the response data that asihttprequest so kindly provided
    NSString *jsonString = [[NSString alloc] initWithData:[request responseData] encoding:NSUTF8StringEncoding];
    
    //make an array, cause json value returns an array, and then put the parsed json into it using JSONValue.
    NSArray *artPieces = [[[NSArray alloc] init] autorelease];
    artPieces = [jsonString JSONValue];
    
    [jsonString release];
    
    //this error is used for the coredata save thing
    NSError *error;
    
    //my json is an array full of dictionaries, so i parse them one by one. here.
    for (NSDictionary *artPiece in artPieces) {
        // maybe later 
        ArtPiece *theArt;
        
        NSFetchRequest *localRequest = [[NSFetchRequest alloc] init];
        
        NSEntityDescription *entityDescripton = [NSEntityDescription entityForName:@"ArtPiece" inManagedObjectContext:self.artPiecesContext];
        [localRequest setEntity:entityDescripton];
        
        //using a predicate! to filter my coredata
        NSPredicate *idFilter = [NSPredicate predicateWithFormat:@"(serverId = %@)", [artPiece objectForKey:@"id"]];
        [localRequest setPredicate:idFilter];

        NSArray *zeroOrMoreArtPieces = [self.artPiecesContext executeFetchRequest:localRequest error:&error];
  

        if ([zeroOrMoreArtPieces count] == 0) {
            //put a new thing in the core data store
            theArt = [[[ArtPiece alloc] initWithEntity:entityDescripton insertIntoManagedObjectContext:self.artPiecesContext]autorelease];
            
            theArt.serverId = [artPiece objectForKey:@"id"];

        }else if (zeroOrMoreArtPieces == nil){
            NSLog(@"shit just got real (broken)");
            return;
        }else{
            //update the first entry in zeroOrMoreArtPieces, which is a stupid name.
            theArt = [zeroOrMoreArtPieces objectAtIndex:0];

            
        }
        
        theArt.title = [artPiece objectForKey:@"title"];
        theArt.latitude = [artPiece objectForKey:@"latitude"];
        theArt.longitude = [artPiece objectForKey:@"longitude"];
        NSArray *artists = [artPiece objectForKey:@"artists"];
        theArt.artist = [[artists objectAtIndex:0] objectForKey:@"name"];
        NSArray *media = [artPiece objectForKey:@"media"];
        theArt.mainImageUrl = [[media objectAtIndex:0] objectForKey:@"full"];
        theArt.thumbImageUrl = [[media objectAtIndex:0] objectForKey:@"thumb"];
        
        [localRequest release];
        
    }
    
    [self.artPiecesContext save:&error];

    [self refreshParade];
}

- (void)requestFailed:(ASIHTTPRequest *)request{
    NSLog(@"Holy shit something about that request just failed. Seriously");
}
@end
