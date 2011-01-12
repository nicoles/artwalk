    //
//  MultipleArtPiece.m
//  ArtWalk
//
//  Created by Nicole Aptekar on 11/01/09.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MultipleArtPiece.h"
#import "ArtPiece.h"
#import "JSON.h"

@implementation MultipleArtPiece

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/


// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
	[super loadView];
	NSLog(@"done!");
	
	scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,0,320, 460)];
	[self.view addSubview:scrollView];
	scrollView.contentSize= CGSizeMake(320, 400);
	

	
	responseData = [[NSMutableData data] retain];
	NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://75.101.166.190/recent/?mode=json"]];
	[[NSURLConnection alloc] initWithRequest:request delegate:self];
	
}


/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

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
	NSMutableArray *subviews = [[NSMutableArray alloc] init];
	
	for (int i = 0; i < results.count; i++) {
		NSDictionary *data = [results objectAtIndex:i];
		ArtPiece *artPiece = [[ArtPiece alloc] initWithTitle:[data objectForKey:@"title"]
											  latitudeString:[NSString stringWithFormat:@"%@", [data objectForKey:@"latitude"]]
											 longitudeString:[NSString stringWithFormat:@"%@", [data objectForKey:@"longitude"]]
													   media:[data objectForKey:@"media"]
							  ];

		UIView *subview = [[UIView alloc] init];
		[subview addSubview: artPiece.title];
		[subview addSubview: artPiece.latitudeString];
		[subview addSubview: artPiece.longitudeString];
		[subviews addObject:subview];
	}
	NSLog(@"DidFinishLoading: created a bunch of ArtPieces");
	
	NSDictionary *artPiece = [results objectAtIndex:results.count-1];
	
	//UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
	//label1.text = @"yexy";
	for (int i = 0; i < subviews.count; i++) {
		[scrollView addSubview:[subviews objectAtIndex:i]];
	}
	//[scrollView addSubview:label1];
	
	/*
	artPieceTitle.text = [artPiece objectForKey:@"title"];
	latitudeString.text = [NSString stringWithFormat:@"%@", [artPiece objectForKey:@"latitude"]];
	longitudeString.text = [NSString stringWithFormat:@"%@", [artPiece objectForKey:@"longitude"]];
	*/
	NSArray *media = [artPiece objectForKey:@"media"];
	
	for (NSDictionary *medium in media)
	{
		//TODO: make this a carousel of the available images, and have it click to embiggen
		NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[medium objectForKey:@"url"]]];
		
		// artPieceImageView.image = [UIImage imageWithData:imageData];
		
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
