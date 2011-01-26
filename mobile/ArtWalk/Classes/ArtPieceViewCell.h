//
//  ArtPieceViewCell.h
//  ArtWalk
//
//  Created by Nicole Aptekar on 11/01/25.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ArtPieceViewCell : UITableViewCell {
	IBOutlet UIImageView *artPieceImageView;
	IBOutlet UILabel *latitudeString;
	IBOutlet UILabel *longitudeString;
	IBOutlet UILabel *artPieceTitle;
}

@property (nonatomic, retain) IBOutlet UIImageView *artPieceImageView;
@property (nonatomic, retain) IBOutlet UILabel *latitudeString;
@property (nonatomic, retain) IBOutlet UILabel *longitudeString;
@property (nonatomic, retain) IBOutlet UILabel *artPieceTitle;

@end
