//
//  MapView.h
//  ArtWalk
//
//  Created by Nicole Aptekar on 11/02/08.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h> 

#import <CoreLocation/CoreLocation.h>


@interface MapView : UIViewController <CLLocationManagerDelegate, MKMapViewDelegate>{
	MKMapView *mapView;
	NSArray *artPieces;
    CLLocationCoordinate2D location;
//    CLLocationManager *locationManager;
    MKCoordinateRegion region;
    MKCoordinateSpan span;
	NSMutableData *responseData;
    Boolean mapLocationUpdate;
}

@property (nonatomic, retain) NSArray *artPieces;
@property (nonatomic, retain) MKMapView *mapView;
@property (nonatomic, retain) NSMutableData *responseData;

@end
