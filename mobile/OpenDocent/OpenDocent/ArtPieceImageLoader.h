//
//  ArtPieceImageLoader.h
//  OpenDocent
//
//  Created by Nicole Aptekar on 11/06/10.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ArtPieceTableViewCell;

@interface ArtPieceImageLoader : NSOperation

@property (nonatomic, retain, readonly) NSURL *imageURL;
@property (nonatomic, retain, readonly) ArtPieceTableViewCell *relatedCell;

- (id)initWithTableViewCell:(ArtPieceTableViewCell *)cell URL:(NSURL *)url;
@end
