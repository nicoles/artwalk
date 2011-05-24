//
//  ArtPiece.h
//  OpenDocent
//
//  Created by Nicole Aptekar on 11/05/22.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class PieceImage;

@interface ArtPiece : NSManagedObject {
@private
}
@property (nonatomic, retain) NSString * artist;
@property (nonatomic, retain) NSString * details;
@property (nonatomic, retain) NSNumber * longitude;
@property (nonatomic, retain) NSString * history;
@property (nonatomic, retain) NSNumber * serverId;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSNumber * needsSync;
@property (nonatomic, retain) NSNumber * latitude;
@property (nonatomic, retain) NSSet* images;

@end
