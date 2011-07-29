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
    //NSLog(@"existing image size:%@",self.relatedCell.imageView.image);
    return self;
}

- (void)dealloc {
    [relatedCell_ release];
    [imageURL_ release];
    [super dealloc];
}

- (void)main{
    //grab the image data from the url.
    NSData *data = [[[NSData alloc] initWithContentsOfURL:self.imageURL] autorelease];
    
    //make a new uiimage with that data
    UIImage *fetchedImage = [[[UIImage alloc] initWithData:data] autorelease] ;
   
    NSLog(@"Got an image from %@ and turned it into a uiimage", self.imageURL);
    //NSLog(@"image for %@ is %@", self.relatedCell.title, self.relatedCell.artImage.image);
    
    //set the cell's image to the image from the url
    self.relatedCell.imageView.image = fetchedImage;
    [self.relatedCell setNeedsLayout];
    self.relatedCell.imageLoader = nil;
    //NSLog(@"image for %@ is %@", self.relatedCell.title, self.relatedCell.artImage.image);
}
@end
