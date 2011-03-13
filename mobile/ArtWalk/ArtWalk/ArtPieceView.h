//
//  ArtPieceView.h
//  ArtWalk
//
//  Created by cubes on 1/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ArtPieceView : UIView {
	UILabel *latitudeString;
	UILabel *longitudeString;
	UILabel *title;
    NSArray *media;
}

@property (nonatomic, retain) UILabel *latitudeString;
@property (nonatomic, retain) UILabel *longitudeString;
@property (nonatomic, retain) UILabel *title;
@property (nonatomic, retain) NSArray *media;

- (id)initWithTitle:(NSString *)title latitudeString:(NSString *)latitudeString longitudeString:(NSString *)longitudeString media:(NSArray *)media frame:(CGRect)frame;

@end
