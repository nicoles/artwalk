//
//  SearchResultPhotoSource.h
//  ArtWalk
//
//  Created by Nicole Aptekar on 10/12/24.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Three20/Three20.h>

@interface SearchResultPhotoSource : TTURLRequestModel <TTPhotoSource> {
	NSString* _title;
	NSMutableArray* _photos;
	
}

@property (nonatomic, copy) NSString *title;
@property (nonatomic, retain) NSArray *photos;

+ (SearchResultPhotoSource *)sampleSearchResultPhotoSource;

@end

@interface SearchResultPhoto : NSObject <TTPhoto> {
	NSString *_caption;
//    NSString *_urlLarge;
    NSString *_urlSmall;
//    NSString *_urlThumb;
    id <TTPhotoSource> _photoSource;
    CGSize _size;
    NSInteger _index;
}

@property (nonatomic, copy) NSString *caption;
//@property (nonatomic, copy) NSString *urlLarge;
@property (nonatomic, copy) NSString *urlSmall;
//@property (nonatomic, copy) NSString *urlThumb;
@property (nonatomic, assign) id <TTPhotoSource> photoSource;
@property (nonatomic) CGSize size;
@property (nonatomic) NSInteger index;

- (id)initWithCaption:(NSString *)caption /*urlLarge:(NSString *)urlLarge*/ urlSmall:(NSString *)urlSmall /*urlThumb:(NSString *)urlThumb*/ size:(CGSize)size;

@end
