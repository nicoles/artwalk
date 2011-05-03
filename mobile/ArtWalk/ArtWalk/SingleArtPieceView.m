//
//  SingleArtPieceView.m
//  ArtWalk
//
//  Created by Nicole Aptekar on 11/03/06.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SingleArtPieceView.h"


@implementation SingleArtPieceView

@synthesize _data;
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

- (id)initWithDictionary:(NSDictionary *)data {
	self = [super init];
	
	if (self) {
		self._data = data;
        self.title = [_data objectForKey:@"title"];
	}
	
	return self;
}

- (void) loadView{
    [super loadView];
    
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,0,320, 460)];
	[self.view addSubview:scrollView];
	scrollView.contentSize = CGSizeMake(320, 600);
    
    self.artPieceTitle = [[UILabel alloc] initWithFrame:CGRectMake(10,10, 300, 30)];
    artPieceTitle.text = [_data objectForKey:@"title"];

    
    self.artPieceArtist = [[UILabel alloc] initWithFrame:CGRectMake(10 , 40, 300, 30)];
    NSArray *artists = [_data objectForKey:@"artists"];
    artPieceArtist.text = [[artists objectAtIndex:0] objectForKey:@"name"];
    NSLog(@"%@", artPieceArtist.text);
    
    
                          
    
    NSArray *media = [_data objectForKey:@"media"];
    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[[media objectAtIndex:0] objectForKey:@"url"]]];
    artPieceImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 80, 300, 300)];
    artPieceImageView.image = [UIImage imageWithData:imageData];
    artPieceImageView.contentMode = UIViewContentModeScaleAspectFit;
    
    
    NSNumber *foo = [_data objectForKey:@"latitude"];
    NSNumber *bar = [_data objectForKey:@"longitude"]; 
    CLLocationCoordinate2D artPieceLocation = CLLocationCoordinate2DMake([foo doubleValue], [bar doubleValue]);
    MKCoordinateSpan artPieceSpan = MKCoordinateSpanMake(.001, .001);
    artPieceMapView = [[MKMapView alloc] initWithFrame:CGRectMake(10, 390, 300, 100)];
    artPieceMapView.region = MKCoordinateRegionMake(artPieceLocation, artPieceSpan);
                
    MKPointAnnotation *artPiecePoint = [[MKPointAnnotation alloc] init];
    artPiecePoint.coordinate = artPieceLocation;
    
    [artPieceMapView addAnnotation:artPiecePoint];
    

    
    // artPieceImageView.image = [UIImage imageWithData:imageData];
    // latitudeString.text = [NSString stringWithFormat:@"%@", [artPiece objectForKey:@"latitude"]];
    // longitudeString.text = [NSString stringWithFormat:@"%@", [artPiece objectForKey:@"longitude"]];    [scrollView addSubview:artPieceArtist];
	
    [scrollView addSubview:artPieceTitle];
    [scrollView addSubview:artPieceArtist];
    [scrollView addSubview:artPieceImageView];
    [scrollView addSubview:artPieceMapView];
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
