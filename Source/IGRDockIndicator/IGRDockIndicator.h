//
//  IGRDockIndicator.h
//  IGRDockIndicator
//
//  Created by Parovishnik Vitaly (Korich) on 27.05.12.
//  Copyright (c) 2012 IGR Software. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface IGRDockIndicator : NSObject {
	
@private
	
	double				_minValue;
    double				_current;
    double				_maxValue;
	
	NSColor				*_color;
}

@property (nonatomic , assign) double minValue;
@property (nonatomic , assign) double current;
@property (nonatomic , assign) double maxValue;
@property (readonly , retain) NSColor *color;

- (void) setDoubleValue: (double)mn;
- (void) setProgressColor:(NSColor*)newColor;

- (void) display;
- (void) hide;

@end
