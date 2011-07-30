//
//  ArtPieceAnnotation.m
//  OpenDocent
//
//  Created by Nicole Aptekar on 11/07/29.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ArtPieceAnnotation.h"

@implementation ArtPieceAnnotation

@synthesize artPiece = artPiece_;
@synthesize image;

-(id)initWithArtPiece:(ArtPiece *)piece{
    self = [super init];
    if (self) {
        self.artPiece = piece;
    }
    return self;
}

-(CLLocationCoordinate2D) coordinate {
    CLLocationCoordinate2D coord;
    coord.latitude = [self.artPiece.latitude doubleValue];
    coord.longitude = [self.artPiece.longitude doubleValue];
    return coord;
}

-(NSString *)title{
    return self.artPiece.title;
}

-(NSString *)subtitle{
    return self.artPiece.artist;
}

- (void)dealloc
{
    [super dealloc];
}

@end