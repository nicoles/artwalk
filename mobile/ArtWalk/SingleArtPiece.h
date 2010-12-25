//
//  SingleArtPiece.h
//  ArtWalk
//
//  Created by Nicole Aptekar on 10/12/24.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SingleArtPiece : UIViewController {
	UIImageView *artPieceImageView;
	UILabel *latitudeString;
	UILabel *longitudeString;
	UILabel *artPieceTitle;
	NSMutableData *responseData;

}

@property (nonatomic, retain) IBOutlet UILabel *latitudeString;
@property (nonatomic, retain) IBOutlet UILabel *longitudeString;
@property (nonatomic, retain) IBOutlet UIImageView *artPieceImageView;
@property (nonatomic, retain) IBOutlet UILabel *artPieceTitle;

@end
