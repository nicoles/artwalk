//
//  SingleArtPieceView.m
//  ArtWalk
//
//  Created by Nicole Aptekar on 11/03/06.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SingleArtPieceView.h"


@implementation SingleArtPieceView

@synthesize data;
@synthesize artPieceTitle;
@synthesize	artPieceArtist;
@synthesize artPieceImageView;
@synthesize artPieceMapView;
@synthesize artPieceDescription;
@synthesize artPieceTags;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
 - (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
 self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
 if (self) {
 // Custom initialization.
 }
 return self;
 }
 */

- (id)initWithData:(NSDictionary *)data {
	self = [super init];
	
	if (self) {
		self.data = data;
		self.artPieceTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, 50)];
		artPieceTitle.text = [data objectForKey:@"title"];
		// latitudeString.text = [NSString stringWithFormat:@"%@", [artPiece objectForKey:@"latitude"]];
		// longitudeString.text = [NSString stringWithFormat:@"%@", [artPiece objectForKey:@"longitude"]];
		NSArray *media = [data objectForKey:@"media"];
		NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[[media objectAtIndex:0] objectForKey:@"url"]]];
		// artPieceImageView.image = [UIImage imageWithData:imageData];
	}
	
	return self;
}

- (void) loadView{
	[super loadView];

	[self.view addSubview:artPieceTitle];
}

/*
- (void) setArtPieceTitle:(UILabel *)l {
	NSLog(l.text);
}
*/
/*
 // Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
 - (void)viewDidLoad {
 NSLog(self.artPieceTitle.text);
 [super viewDidLoad];
 
 
 }
 */

/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations.
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
