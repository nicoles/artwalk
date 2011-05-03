    //
//  MapView.m
//  ArtWalk
//
//  Created by Nicole Aptekar on 11/02/08.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MapView.h"
#import "ArtPieceAnnotation.h"
#import "ASIHTTPRequest.h"

@implementation MapView

@synthesize mapView;
@synthesize artPieces;
@synthesize responseData;

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

- (id)init{
	if ((self = [super init])) {
		self.title = @"Nearby Pieces";
		self.tabBarItem.image = [UIImage imageNamed:@"103-map.png"];
	}
	
	return self;
}

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
	mapView = [[MKMapView alloc] initWithFrame:self.view.bounds];
	mapView.mapType = MKMapTypeStandard;
	//mapView.frame = CGRectMake(0, 0, self.view.frame.size.width, 300);
	[self.view insertSubview:mapView atIndex:0];
	

}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    
   
    
	mapView = [[MKMapView alloc] initWithFrame:self.view.bounds];
	mapView.mapType = MKMapTypeStandard;
	mapView.showsUserLocation = YES;

    

    
    mapView.delegate = self;
    
    CLLocationManager *locationManager=[[CLLocationManager alloc] init];
    locationManager.delegate=self;
    locationManager.desiredAccuracy=kCLLocationAccuracyNearestTenMeters;
    
    [locationManager startUpdatingLocation];
    
 
    //mapView.frame = CGRectMake(0, 0, self.view.frame.size.width, 300);
	[self.view insertSubview:mapView atIndex:0];
    
}

- (void)viewWillAppear:(BOOL) animated
{
	responseData = [[NSMutableData data] retain];
	ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:@"http://75.101.166.190/recent/?mode=json"]];
	[request setDelegate:self];
    [request startAsynchronous];
    mapLocationUpdate = TRUE;
    
	[super viewWillAppear:animated];
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

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


#pragma mark ASIHTTPRequest
- (void)requestFinished:(ASIHTTPRequest *)request { 

	
	//NSLog(@"DidFinishLoading: %@", *responseData);
	// Store incoming data into a string
	NSString *jsonString = [[NSString alloc] initWithData:[request responseData] encoding:NSUTF8StringEncoding];
	
	// Create a dictionary from the JSON string
	self.artPieces = [jsonString JSONValue];

	for (int i =0; i < self.artPieces.count; i++) {
		ArtPieceAnnotation *artPieceLocation = [[ArtPieceAnnotation alloc] initWithDictionary:[self.artPieces objectAtIndex:i]];
		[self.mapView addAnnotation:artPieceLocation];
	}
	 
	[jsonString release];
	
}

#pragma mark CLLocationManager
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {

    
    span.latitudeDelta= 0.02 / 10; //zoom level
    span.longitudeDelta= 0.02 / 10;
    
    location = newLocation.coordinate;
    region.center = location;
    
   
    
    region.span = span;
    region.center = location;
    
    NSLog(@"%f, %f", mapView.userLocation.location.coordinate.latitude,
          mapView.userLocation.location.coordinate.longitude);
    
    if (mapLocationUpdate == TRUE) {
        [mapView setCenterCoordinate:location animated:YES];
        [mapView regionThatFits:region];
        [mapView setRegion:region animated:TRUE];

        mapLocationUpdate = FALSE;
    }

    
}

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
	[responseData dealloc];
    [super dealloc];
}


@end
