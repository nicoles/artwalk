//
//  ArtPiece.m
//  ArtWalk
//
//  Created by Nicole Aptekar on 11/01/09.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ArtPiece.h"


@implementation ArtPiece

@synthesize title;
@synthesize latitudeString;
@synthesize longitudeString;

- (id)initWithTitle:(NSString *)title latitudeString:(NSString *)lat longitudeString:(NSString *)lon media:(NSArray *)media
{
	if( self = [super init] )
	{
		self.title = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, 50)];
		self.title.text = title;
		self.latitudeString = [[UILabel alloc] initWithFrame:CGRectMake(10, 50, 100, 50)];
		self.latitudeString.text = lat;
		self.longitudeString = [[UILabel alloc] initWithFrame:CGRectMake(10, 150, 100, 50)];
		self.longitudeString.text = lon;		
	}
	
	return self;
}


@end