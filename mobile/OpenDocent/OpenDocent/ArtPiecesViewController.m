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
    //reload the tableview. just fucking do it. it's probably too early, but whatever, do it.
    //[self refreshParade];
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
    //this is apparently just for the sheer giddy thrill of logging. these variables.
    //for (NSManagedObject *oneObject in self.artPiecesOnParade){
        //NSString *artPieceTitle = [oneObject valueForKey:@"title"];
        //NSString *artPieceArtist = [oneObject valueForKey:@"artist"];
        
        //NSLog(@"Title:%@ Artist:%@", artPieceTitle, artPieceArtist);
        //
        //[artPieceArtist release];
        //[artPieceTitle release];
    //}
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
    //NSLog(@"Members of parade: %u", artPiecesOnParade.count);
    return [self.artPiecesOnParade count];  
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ArtPieceListCellIdentifier = @"ArtPieceListCellIdentifier";
    const NSInteger ARTIST_TAG = 1001;
    const NSInteger TITLE_TAG = 1002;
    const NSInteger IMAGE_TAG = 1003;
    UIImageView *artImage;
    UILabel *title;
    UILabel *artist;
    
    //using a standard tableview cell here. wish me luck!
    ArtPieceTableViewCell *cell = (ArtPieceTableViewCell *)[tableView dequeueReusableCellWithIdentifier:ArtPieceListCellIdentifier];
    if (cell == nil) {
        //make a new cell
        cell = [[[ArtPieceTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ArtPieceListCellIdentifier] autorelease];
        
        //Drop artImage on the contentView
        UIImageView *artImage = [[[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 50, 50)] autorelease];
        artImage.layer.cornerRadius = 5.0;
        artImage.layer.masksToBounds = YES;
        artImage.tag = IMAGE_TAG;
        artImage.image = [UIImage imageNamed:@"provisionalloading.png"];
        NSLog(@"existing image size:%@",artImage.image);
        [cell.contentView addSubview:artImage];

        
        //set up the text labels
        UILabel *title = [[[UILabel alloc] initWithFrame:CGRectMake(60, 0, 260, 40 )]autorelease];
        title.tag = TITLE_TAG;
        title.font = [UIFont boldSystemFontOfSize:18];
        title.adjustsFontSizeToFitWidth = YES;
        title.minimumFontSize = 15;
        title.backgroundColor = [UIColor clearColor];
        [cell.contentView addSubview:title];
        
        UILabel *artist = [[[UILabel alloc] initWithFrame:CGRectMake(60, 30, 260, 20)]autorelease];
        artist.tag = ARTIST_TAG;
        artist.font = [UIFont systemFontOfSize:15];
        artist.adjustsFontSizeToFitWidth = YES;
        artist.minimumFontSize = 10;
        artist.backgroundColor = [UIColor clearColor];
        [cell.contentView addSubview:artist];


    }
    NSUInteger row = [indexPath row];
    //pull an art matching the indexpath #
    ArtPiece *theArt = [self.artPiecesOnParade objectAtIndex:row];
    
    //display the proper stuff in the cell
    artImage = (UIImageView *)[cell viewWithTag:IMAGE_TAG];
    title = (UILabel *)[cell viewWithTag:TITLE_TAG];
    artist = (UILabel *)[cell viewWithTag:ARTIST_TAG];
    
    artist.text = theArt.artist;
    title.text = theArt.title;
    
    [cell setTitle:title.text];
    [cell setArtist:artist.text];
    [cell setArtImage:artImage];
    //NSLog(@"existing image size:%@",cell.artImage.image.size.width);
    

    //NSLog(@"=============> %@", cell.contentView.subviews);
    
    if(cell.artImage.image == [UIImage imageNamed:@"provisionalloading.png"]){
        NSLog(@"could load an image for %@", cell.title);
        NSURL *mediaUrl = [[NSURL alloc] initWithString: theArt.mainImageUrl];
        NSLog(@"grabbed an imageurl: %@", mediaUrl);
        ArtPieceImageLoader *imageLoader = [[ArtPieceImageLoader alloc] initWithTableViewCell:cell URL:mediaUrl];
        [self.imageLoadingQueue addOperation:imageLoader];
        NSLog(@"Added an imageloader operation to the queue");
        [imageLoader release];
        [mediaUrl release];
    }
//    
    
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

/*- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    //NSUInteger row = [indexPath row];
    //ArtPieceTableViewCell *theCell = [self.artPiecesOnParade
    
    //NSLog(@"Height %@", theCell.contentView.frame.size);
    CGFloat height = 50;
    return height;
}
*/
#pragma mark -
#pragma mark NSURLConnection & ASIHTTPRequest
//These next three may do nothing.
/*- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    //clear out responsedata so that the data coming in is like, sensible and new and shit. no old data. fuck that old data.
    [responseData setLength:0];
    NSLog(@"motherfucking response happened");
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    //put that data on the cleared out responsedata
    [responseData appendData:data];
    NSLog(@"data acquired!");
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    //TODO: Error handling or something.
    NSLog(@"Whoa shit something broke. on the nsurlconnection. omg");
}
*/
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
        //NSLog(@"%@", [artPiece objectForKey:@"id"]);
        NSPredicate *idFilter = [NSPredicate predicateWithFormat:@"(serverId = %@)", [artPiece objectForKey:@"id"]];
        [localRequest setPredicate:idFilter];
        //NSLog(@"Predicate: %@, %@", [artPiece objectForKey:@"title"], [artPiece objectForKey:@"id"]);

        NSArray *zeroOrMoreArtPieces = [self.artPiecesContext executeFetchRequest:localRequest error:&error];
        //NSLog(@"objects in this fetch: %@", [zeroOrMoreArtPieces count]);

        if ([zeroOrMoreArtPieces count] == 0) {
            //put a new thing in the core data store
            theArt = [[[ArtPiece alloc] initWithEntity:entityDescripton insertIntoManagedObjectContext:self.artPiecesContext]autorelease];
            //NSLog(@"new: %@", [artPiece objectForKey:@"title"]);
            //NSLog(@"count: %@", [zeroOrMoreArtPieces count]);
            theArt.serverId = [artPiece objectForKey:@"id"];
            //NSLog(@"serverID: %@, localID: %@", [artPiece objectForKey:@"id"], theArt.serverId);
        }else if (zeroOrMoreArtPieces == nil){
            NSLog(@"shit just got real (broken)");
            return;
        }else{
            //update the first entry in zeroOrMoreArtPieces, which is a stupid name.
            theArt = [zeroOrMoreArtPieces objectAtIndex:0];
            //NSLog(@"object at index0: %@", [artPiece objectForKey:@"title"]);
            //NSLog(@"replace: %@", [artPiece objectForKey:@"title"]);
            //NSLog(@"serverID: %@, localID: %@", [artPiece objectForKey:@"id"], theArt.serverId);
            
        }
        
        //
        theArt.title = [artPiece objectForKey:@"title"];
        theArt.latitude = [artPiece objectForKey:@"latitude"];
        theArt.longitude = [artPiece objectForKey:@"longitude"];
        NSArray *artists = [artPiece objectForKey:@"artists"];
        theArt.artist = [[artists objectAtIndex:0] objectForKey:@"name"];
        NSArray *media = [artPiece objectForKey:@"media"];
        theArt.mainImageUrl = [[media objectAtIndex:0] objectForKey:@"url"];
        
        [localRequest release];
        
    }
    
    [self.artPiecesContext save:&error];
    /*
    - (id)initWithData:(NSDictionary *)data {
        _data = data;
        
        artPieceTitle.text = [data objectForKey:@"title"];
        latitudeString.text = [NSString stringWithFormat:@"%@", [data objectForKey:@"latitude"]];
        longitudeString.text = [NSString stringWithFormat:@"%@", [data objectForKey:@"longitude"]];
        NSArray *media = [data objectForKey:@"media"];
        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[[media objectAtIndex:0] objectForKey:@"url"]]];
        artPieceImageView.image = [UIImage imageWithData:imageData];
        
        return self;
    }
    */
    [self refreshParade];
}

- (void)requestFailed:(ASIHTTPRequest *)request{
    NSLog(@"Holy shit something about that request just failed. Seriously");
}
@end
