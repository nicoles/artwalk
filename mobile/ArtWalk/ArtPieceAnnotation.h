//
//  ArtPieceAnnotation.h
//  ArtWalk
//
//  Created by Nicole Aptekar on 11/02/08.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface ArtPieceAnnotation : NSObject <MKAnnotation> {
	NSDictionary *artPiece;
}

@property (nonatomic, retain) NSDictionary *artPiece;

- (id) initWithDictionary:(NSDictionary *)data;

@end
