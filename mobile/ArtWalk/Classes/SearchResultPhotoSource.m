//
//  SearchResultPhotoSource.m
//  ArtWalk
//
//  Created by Nicole Aptekar on 10/12/24.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "SearchResultPhotoSource.h"


@implementation SearchResultPhotoSource

@synthesize title = _title;
@synthesize photos = _photos;

- (id) initWithTitle:(NSString *)title photos:(NSArray *)photos {
	if ((self = [super init])) {
		self.title = title;
		self.photos = photos;
		for (int i=0; i < _photos.count; i++) {
			SearchResultPhoto *photo = [_photos objectAtIndex:i];
			photo.photoSource = self;
			photo.index = i;
		}
	}
	return self;
}

- (void) dealloc {
	self.title = nil;
	self.photos = nil;
	[super dealloc];
}

#pragma mark TTModel

- (BOOL)isLoading {
	return FALSE;
}

- (BOOL)isLoaded {
	return TRUE;
}

#pragma mark TTPhotoSource

- (NSInteger)numberOfPhotos {
	return _photos.count;
}

- (NSInteger)maxPhotoIndex {
	return _photos.count-1;
}

- (id<TTPhoto>)photoAtIndex:(NSInteger)photoIndex {
	if (photoIndex < _photos.count) {
		return [_photos objectAtIndex:photoIndex];
	} else {
		return nil;
	}
}

@end

@implementation SearchResultPhoto

@synthesize caption = _caption;
//@synthesize urlLarge = _urlLarge;
@synthesize urlSmall = _urlSmall;
//@synthesize urlThumb = _urlThumb;
@synthesize photoSource = _photoSource;
@synthesize size = _size;
@synthesize index = _index;

- (id)initWithCaption:(NSString *)caption /*urlLarge:(NSString *)urlLarge*/ urlSmall:(NSString *)urlSmall /*urlThumb:(NSString *)urlThumb*/ size:(CGSize)size {
    if ((self = [super init])) {
        self.caption = caption;
        //self.urlLarge = urlLarge;
        self.urlSmall = urlSmall;
        //self.urlThumb = urlThumb;
        self.size = size;
        self.index = NSIntegerMax;
        self.photoSource = nil;
    }
    return self;
}

- (void) dealloc {
    self.caption = nil;
    //self.urlLarge = nil;
    self.urlSmall = nil;
    //self.urlThumb = nil;    
    [super dealloc];
}

#pragma mark TTPhoto

- (NSString*)URLForVersion:(TTPhotoVersion)version {
    switch (version) {
        case TTPhotoVersionLarge:
            return _urlSmall;
        case TTPhotoVersionMedium:
            return _urlSmall;
        case TTPhotoVersionSmall:
            return _urlSmall;
        case TTPhotoVersionThumbnail:
            return _urlSmall;
        default:
            return nil;
    }
}

@end
