//
//  MapViewController.h
//  OpenDocent
//
//  Created by Nicole Aptekar on 11/07/29.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import <Foundation/Foundation.h>
#import "ArtPieceDetailController.h"

@interface MapViewController : UIViewController <MKMapViewDelegate>

@property (nonatomic, retain) IBOutlet MKMapView *mapView;


@property (nonatomic, retain) IBOutlet ArtPieceDetailController *artPieceDetailController;

@property (nonatomic, assign) NSArray *artPieces;
@property (nonatomic, retain) NSManagedObjectContext *artPiecesContext;

- (id) initWithArtPieces:(NSArray *)listArtPieces;

@end
