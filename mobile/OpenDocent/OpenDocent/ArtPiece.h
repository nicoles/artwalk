//
//  ArtPiece.h
//  OpenDocent
//
//  Created by Nicole Aptekar on 11/05/18.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface ArtPiece : NSManagedObject {
@private
}
@property (nonatomic, retain) NSNumber * latitude;
@property (nonatomic, retain) NSString * artist;
@property (nonatomic, retain) NSNumber * longitude;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSNumber * needsSync;

@end
