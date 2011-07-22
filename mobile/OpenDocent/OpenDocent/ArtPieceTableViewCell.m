//
//  ArtPieceTableViewCell.m
//  OpenDocent
//
//  Created by Nicole Aptekar on 11/05/24.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
//  

#import "ArtPieceTableViewCell.h"



@implementation ArtPieceTableViewCell

@synthesize imageLoader = imageLoader_;

- (void)prepareForReuse{
    [self.imageLoader cancel];
    self.imageLoader = nil;
}

- (void) dealloc{
    [super dealloc];
}

@end
