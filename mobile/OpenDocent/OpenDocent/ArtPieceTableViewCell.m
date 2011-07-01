//
//  ArtPieceTableViewCell.m
//  OpenDocent
//
//  Created by Nicole Aptekar on 11/05/24.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
//  Following ABTableViewCell pretty closely here. Not quite sure how this works, I'll comment it when I have a clue.

#import "ArtPieceTableViewCell.h"


@implementation ArtPieceTableViewCell

@synthesize title = title_;
@synthesize artist = artist_;
@synthesize artImage = artImage_;

- (void) dealloc{
    [title_ release];
    [artist_ release];
    [artImage_ release];
    [super dealloc];
}

// setters go here.
/*- (void) setTitle:(NSString *)title{
    [title retain];
    [title_ release];
    title_ = title;
    NSLog(@"Title: %@, Title: %@", title, title_);
    [self setNeedsDisplay];
}*/

- (void)setArtist:(NSString *)artist{
    [artist retain];
    [artist_ release];
    artist_ = artist;
    [self setNeedsDisplay];
}

/*- (void)setArtImage:(UIImageView *)artImage{
    [artImage retain];
    [artImage_ release];
    artImage_.image = artImage.image;
    [self setNeedsDisplay];
}*/


@end
