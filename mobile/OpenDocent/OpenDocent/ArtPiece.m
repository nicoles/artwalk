//
//  ArtPiece.m
//  OpenDocent
//
//  Created by Nicole Aptekar on 11/05/24.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ArtPiece.h"
#import "PieceImage.h"


@implementation ArtPiece
@dynamic artist;
@dynamic details;
@dynamic longitude;
@dynamic history;
@dynamic serverId;
@dynamic title;
@dynamic needsSync;
@dynamic latitude;
@dynamic mainImageUrl;
@dynamic images;

- (void)addImagesObject:(PieceImage *)value {    
    NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
    [self willChangeValueForKey:@"images" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
    [[self primitiveValueForKey:@"images"] addObject:value];
    [self didChangeValueForKey:@"images" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
    [changedObjects release];
}

- (void)removeImagesObject:(PieceImage *)value {
    NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
    [self willChangeValueForKey:@"images" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
    [[self primitiveValueForKey:@"images"] removeObject:value];
    [self didChangeValueForKey:@"images" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
    [changedObjects release];
}

- (void)addImages:(NSSet *)value {    
    [self willChangeValueForKey:@"images" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
    [[self primitiveValueForKey:@"images"] unionSet:value];
    [self didChangeValueForKey:@"images" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
}

- (void)removeImages:(NSSet *)value {
    [self willChangeValueForKey:@"images" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
    [[self primitiveValueForKey:@"images"] minusSet:value];
    [self didChangeValueForKey:@"images" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
}


@end
