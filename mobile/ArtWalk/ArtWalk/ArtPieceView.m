//
//  ArtPieceView.m
//  ArtWalk
//
//  Created by cubes on 1/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ArtPieceView.h"


@implementation ArtPieceView

@synthesize title;
@synthesize latitudeString;
@synthesize longitudeString;
@synthesize media;

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        // Initialization code
    }
    return self;
}

- (id)initWithTitle:(NSString *)title latitudeString:(NSString *)latitudeString longitudeString:(NSString *)longitudeString media:(NSArray *)media frame:(CGRect)frame
{
    if( self = [super initWithFrame:frame] )
	{
        CGFloat offset = 10;
        CGFloat y_offset = 0;
        CGFloat width = self.frame.size.width - (offset * 2);
        CGFloat labelHeight = 21;
		self.title = [[UILabel alloc] initWithFrame:CGRectMake(offset, offset, width, labelHeight)];
		self.title.text = title;
		self.latitudeString = [[UILabel alloc] initWithFrame:CGRectMake(offset, offset + self.title.frame.origin.y + self.title.frame.size.height, width, labelHeight)];
		self.latitudeString.text = latitudeString;
		self.longitudeString = [[UILabel alloc] initWithFrame:CGRectMake(offset, offset + self.latitudeString.frame.origin.y + self.latitudeString.frame.size.height, width, labelHeight)];
		self.longitudeString.text = longitudeString;
		
        [self addSubview:self.title];
        [self addSubview:self.latitudeString];
        [self addSubview:self.longitudeString];
        
        y_offset = self.longitudeString.frame.origin.y + self.longitudeString.frame.size.height;
        self.media = media;
        for (NSDictionary *medium in self.media) {
            NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[medium objectForKey:@"url"]]];
            UIImageView *v = [[UIImageView alloc] initWithImage:[UIImage imageWithData:imageData]];
            CGRect newFrame = v.frame;
            newFrame.origin.y = y_offset;
            v.frame = newFrame;
            y_offset += v.frame.size.height;
            [self addSubview:v];
        }
	}
	
	return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)dealloc {
    [super dealloc];
}


@end
