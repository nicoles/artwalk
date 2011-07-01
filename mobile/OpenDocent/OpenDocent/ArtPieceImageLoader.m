//
//  ArtPieceImageLoader.m
//  OpenDocent
//
//  Created by Nicole Aptekar on 11/06/10.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ArtPieceImageLoader.h"
#import "ArtPieceTableViewCell.h"

@interface ArtPieceImageLoader ()

@property (nonatomic, retain, readwrite) NSURL *imageURL;
@property (nonatomic, retain, readwrite) ArtPieceTableViewCell *relatedCell;

@end

@implementation ArtPieceImageLoader

@synthesize imageURL = imageURL_;
@synthesize relatedCell = relatedCell_;

- (id)initWithTableViewCell:(ArtPieceTableViewCell *)cell URL:(NSURL *)url{
    self = [super init];
    self.imageURL = url;
    self.relatedCell = cell;
    NSLog(@"existing image size:%@",self.relatedCell.artImage.image);
    return self;
}

- (void)dealloc {
    [relatedCell_ release];
    [imageURL_ release];
    [super dealloc];
}

- (void)main{
    NSData *data = [[[NSData alloc] initWithContentsOfURL:self.imageURL] autorelease];
    

    UIImage *fetchedImage = [[[UIImage alloc] initWithData:data] autorelease] ;
    UIImageView *newImageView = [[[UIImageView alloc] initWithImage:fetchedImage]autorelease];
    NSLog(@"Got an image from %@ and turned it into a uiimage", self.imageURL);
    NSLog(@"image for %@ is %@", self.relatedCell.title, self.relatedCell.artImage.image);
    [self.relatedCell setArtImage:newImageView];
    NSLog(@"image for %@ is %@", self.relatedCell.title, self.relatedCell.artImage.image);
    [self.relatedCell setNeedsDisplay];
}
@end
