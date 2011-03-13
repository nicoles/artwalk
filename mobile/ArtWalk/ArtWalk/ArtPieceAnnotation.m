//
//  ArtPieceAnnotation.m
//  ArtWalk
//
//  Created by Nicole Aptekar on 11/02/08.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ArtPieceAnnotation.h"


@implementation ArtPieceAnnotation

@synthesize artPiece;

- (id) initWithDictionary:(NSDictionary *)data{
	self = [super init];
	if(self){
		self.artPiece = data;
	}
	return self;
}

- (CLLocationCoordinate2D) coordinate {
	CLLocationCoordinate2D coord;
	coord.latitude = [[self.artPiece objectForKey:@"latitude"] doubleValue];
	coord.longitude = [[self.artPiece objectForKey:@"longitude"] doubleValue];
	return coord;
}

- (NSString *) title {
	return [self.artPiece objectForKey:@"title"];
}

- (NSString *) subtitle{
	return [self.artPiece objectForKey:@"title"];
}
@end
