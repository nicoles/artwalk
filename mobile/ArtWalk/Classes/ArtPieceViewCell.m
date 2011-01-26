//
//  ArtPieceViewCell.m
//  ArtWalk
//
//  Created by Nicole Aptekar on 11/01/25.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ArtPieceViewCell.h"


@implementation ArtPieceViewCell

@synthesize artPieceImageView;
@synthesize latitudeString;
@synthesize longitudeString;
@synthesize artPieceTitle;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code.
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state.
}


- (void)dealloc {
    [super dealloc];
}


@end
