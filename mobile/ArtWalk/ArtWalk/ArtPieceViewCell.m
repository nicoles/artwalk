//
//  ArtPieceViewCell.m
//  ArtWalk
//
//  Created by Nicole Aptekar on 11/01/25.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ArtPieceViewCell.h"


@implementation ArtPieceViewCell

@synthesize _data;
@synthesize artPieceImageView;
@synthesize latitudeString;
@synthesize longitudeString;
@synthesize artPieceTitle;


- (id)initWithData:(NSDictionary *)data {
    _data = data;

    artPieceTitle.text = [data objectForKey:@"title"];
    latitudeString.text = [NSString stringWithFormat:@"%@", [data objectForKey:@"latitude"]];
    longitudeString.text = [NSString stringWithFormat:@"%@", [data objectForKey:@"longitude"]];
    NSArray *media = [data objectForKey:@"media"];
    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[[media objectAtIndex:0] objectForKey:@"url"]]];
    artPieceImageView.image = [UIImage imageWithData:imageData];
    
    return self;
}


- (void)dealloc {
    [super dealloc];
}

- (NSString*)description
{
    return [NSString stringWithFormat:@"%@ %@", [super description], self._data ];
}


@end
