//
//  ArtPieceTableViewCell.h
//  OpenDocent
//
//  Created by Nicole Aptekar on 11/05/24.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ArtPieceTableViewCell : UITableViewCell

@property (nonatomic, assign) NSOperation* imageLoader;

- (void)prepareForReuse;

@end
