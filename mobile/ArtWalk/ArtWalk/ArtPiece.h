//
//  ArtPiece.h
//  ArtWalk
//
//  Created by Nicole Aptekar on 11/01/09.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>


@interface ArtPiece : NSObject <MKAnnotation> {
	// UIImageView *artPieceImageView;
	UILabel *latitudeString;
	UILabel *longitudeString;
	UILabel *title;
}

@property (nonatomic, retain) UILabel *latitudeString;
@property (nonatomic, retain) UILabel *longitudeString;
// @property (nonatomic, retain) IBOutlet UIImageView *artPieceImageView;
@property (nonatomic, retain) UILabel *title;

- (id)initWithTitle:(NSString *)title latitudeString:(NSString *)latitudeString longitudeString:(NSString *)longitudeString media:(NSArray *)media;


@end
