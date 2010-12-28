//
//  SingleArtPiece.m
//  ArtWalk
//
//  Created by Nicole Aptekar on 10/12/24.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "SingleArtPiece.h"
#import "JSON.h"

@implementation SingleArtPiece

@synthesize artPieceImageView;
@synthesize latitudeString;
@synthesize longitudeString;
@synthesize artPieceTitle;

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	
	responseData = [[NSMutableData data] retain];
	NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://75.101.166.190/recent/?mode=json"]];
	[[NSURLConnection alloc] initWithRequest:request delegate:self];
	
    [super viewDidLoad];
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

#pragma mark JSON UrlConnection
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
	[responseData setLength:0];
	NSLog(@"didrecieveresponse");
	
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
	[responseData appendData:data];
	NSLog(@"didrecievedata");
	
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
	//	label.text = [NSString stringWithFormat:@"Connection failed: %@", [error description]];
	
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection 
{
	
	NSLog(@"DidFinishLoading: %@", responseData);
	// Store incoming data into a string
	NSString *jsonString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
	
	// Create a dictionary from the JSON string
	NSArray *results = [jsonString JSONValue];
	
	NSDictionary *artPiece = [results objectAtIndex:results.count-1];
	artPieceTitle.text = [artPiece objectForKey:@"title"];
	latitudeString.text = [NSString stringWithFormat:@"%@", [artPiece objectForKey:@"lat"]];
	longitudeString.text = [NSString stringWithFormat:@"%@", [artPiece objectForKey:@"lon"]];
	
	NSArray *media = [artPiece objectForKey:@"media"];
	
	for (NSDictionary *medium in media)
	{
		//TODO: make this a carousel of the available images, and have it click to embiggen
		NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[medium objectForKey:@"url"]]];
	
		artPieceImageView.image = [UIImage imageWithData:imageData];

	}

	
	NSLog(@"objectforkey: %@", [artPiece objectForKey:@"title"]);
	//[[results objectAtIndex:0] artPieceTitle.text = [NSString objectForKey:@"title"]];
	
	/*// Loop through each entry in the array...
	for (NSDictionary *artPiece in results[0])
	{
		// Get title of the image
		NSString *title = [artPiece	objectForKey:@"title"];
		
		// Save the title to the photo titles array
		artPieceTitle.string = *title;
		
		//NSArray *media = [artPiece objectForKey:@"media"];
		
		/*for (NSDictionary *medium in media)
		{
			NSString *photoURLString = [medium objectForKey:@"url"];
			[photoImage addObject:[NSData dataWithContentsOfURL:[NSURL URLWithString:photoURLString]]];
			NSLog(@"photoURLString: %@", photoURLString);
		}
		
	} */
	[jsonString release];



//TODO: this leaks memory. fix it.
//	[results release];
//	[imageData release];

	
}

- (void)dealloc {
	[responseData release];
    [super dealloc];
}


@end
