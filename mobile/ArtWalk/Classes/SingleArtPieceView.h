//
//  SingleArtPieceView.h
//  ArtWalk
//
//  Created by Nicole Aptekar on 11/03/06.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "ArtPieceViewCell.h"

@interface SingleArtPieceView : UIViewController {
	NSDictionary *data;
	IBOutlet UIImageView *artPieceImageView;
	IBOutlet UILabel *artPieceTitle;
	IBOutlet UILabel *artPieceArtist;
	IBOutlet MKMapView *artPieceMapView;
	IBOutlet UITextView *artPieceDescription;
	IBOutlet UILabel *artPieceTags;
}

@property (nonatomic, retain) NSDictionary *data;
@property (nonatomic, retain) IBOutlet UILabel *artPieceTitle;
@property (nonatomic, retain) IBOutlet UILabel *artPieceArtist;
@property (nonatomic, retain) IBOutlet UILabel *artPieceTags;
@property (nonatomic, retain) IBOutlet UITextView *artPieceDescription;
@property (nonatomic, retain) IBOutlet UIImageView *artPieceImageView;
@property (nonatomic, retain) IBOutlet MKMapView *artPieceMapView;

- (id)initWithData:(NSDictionary *)data;


@end
