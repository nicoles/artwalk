//
//  MapViewController.m
//  OpenDocent
//
//  Created by Nicole Aptekar on 11/07/29.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MapViewController.h"
#import "OpenDocentAppDelegate.h"
#import "ArtPiece.h"
#import "ArtPieceAnnotation.h"
#import "UIImageView+WebCache.h"

@implementation MapViewController

@synthesize mapView = mapView_;

@synthesize artPieceDetailController = artPieceDetailController_;

@synthesize artPieces;
@synthesize artPiecesContext;

- (id) init{
    if ((self = [super init])) {
        self.title =@"Nearby Pieces";
    }
    return self;
}

- (id) initWithArtPieces:(NSArray *)listArtPieces{
  
    [super init];
    
    self.artPieces = listArtPieces;
    return self;
    
}

- (void) viewDidLoad {

     
    //drop pins for artpieces in the coredata store.
    for (int i = 0; i <self.artPieces.count; i++) {
        ArtPiece *theArt = [[self.artPieces objectAtIndex:i] autorelease];
        
        ArtPieceAnnotation *artPiecePin = [[[ArtPieceAnnotation alloc] initWithArtPiece:theArt] autorelease];        
        NSLog(@"up here");
        UIImageView *tempImage = [[[UIImageView alloc] init] autorelease];
        [tempImage setImageWithURL:[NSURL URLWithString:theArt.thumbImageUrl]];
        artPiecePin.image = tempImage.image;
        
        [self.mapView addAnnotation:artPiecePin];
        

    }
    
    //sets the region to north america
    MKCoordinateRegion newRegion;
    newRegion.center.latitude = 37.37;
    newRegion.center.longitude = -96.24;
    newRegion.span.latitudeDelta = 28.49;
    newRegion.span.longitudeDelta = 31.025;
    
    [self.mapView setRegion:newRegion animated:YES];

    [super viewDidLoad];
}


- (void) viewDidUnload{
    self.mapView = nil;
}

- (void)dealloc {
    [mapView_ release];
    [super dealloc];
}



#pragma mark Map View Delegate methods
- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
    
}
- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control{
    ArtPieceAnnotation *thisArt = view.annotation;
    
    ArtPieceDetailController *childController = [[ArtPieceDetailController alloc] initWithStyle:UITableViewStyleGrouped];
    childController.title = thisArt.artPiece.title;
    childController.theArt = thisArt.artPiece;
    
    [self.navigationController pushViewController:childController animated:YES];
    [childController release];
    
    [self.navigationController pushViewController:self.artPieceDetailController animated:YES];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{

    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
    if ([annotation isKindOfClass:[ArtPieceAnnotation class]]) {

        static NSString* ArtPieceAnnotationIdentifier = @"artPieceAnnotationIdentifier";
        MKPinAnnotationView* pinView = (MKPinAnnotationView *) [mapView dequeueReusableAnnotationViewWithIdentifier:ArtPieceAnnotationIdentifier];
        if (!pinView) {
            MKPinAnnotationView* customPinView = [[[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:ArtPieceAnnotationIdentifier] autorelease];
            customPinView.animatesDrop = YES;            
            customPinView.canShowCallout = YES;
            
            ArtPieceAnnotation *thisArt = annotation;
            
            
            UIImageView *thumbImage = [[[UIImageView alloc] initWithImage:thisArt.image] autorelease];

            
            thumbImage.frame = CGRectMake( thumbImage.frame.origin.x, thumbImage.frame.origin.y, 40, 30);
            thumbImage.contentMode =UIViewContentModeScaleAspectFit;
            thumbImage.clipsToBounds = YES;

            [customPinView sizeToFit];
            customPinView.leftCalloutAccessoryView = thumbImage;

            
            UIButton* rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
            customPinView.rightCalloutAccessoryView = rightButton;

            return customPinView;
            
        }
        else{
            pinView.annotation = annotation;
        }
        return pinView;
    }
    
    return nil;
    
}
@end
