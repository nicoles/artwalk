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
	NSDictionary *_data;
	UIImageView *artPieceImageView;
    UILabel *artPieceTitle;
	UILabel *artPieceArtist;
    MKMapView *artPieceMapView;
    UITextView *artPieceDescription;
    UILabel *artPieceTags;
    UIScrollView *scrollView;
}

@property (nonatomic, retain) NSDictionary *_data;
@property (nonatomic, retain) UILabel *artPieceTitle;
@property (nonatomic, retain) UILabel *artPieceArtist;
@property (nonatomic, retain) UILabel *artPieceTags;
@property (nonatomic, retain) UITextView *artPieceDescription;
@property (nonatomic, retain) UIImageView *artPieceImageView;
@property (nonatomic, retain) MKMapView *artPieceMapView;
@property (nonatomic, retain) UIScrollView *scrollView;

- (id)initWithDictionary:(NSDictionary *)data;


@end
