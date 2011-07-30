//
//  ArtPieceAnnotation.h
//  OpenDocent
//
//  Created by Nicole Aptekar on 11/07/29.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "ArtPiece.h"

@interface ArtPieceAnnotation : NSObject <MKAnnotation>

@property (nonatomic, retain) ArtPiece *artPiece;
@property (nonatomic, retain) UIImage *image;

-(id) initWithArtPiece:(ArtPiece *)piece;

@end
