//
//  IGRDockIndicator.m
//  IGRDockIndicator
//
//  Created by Parovishnik Vitaly (Korich) on 27.05.12.
//  Copyright (c) 2012 IGR Software. All rights reserved.
//

#import "IGRDockIndicator.h"

#define DEFAULT_MAX_VALUE		100.0
#define DEFAULT_MIN_VALUE		0.0
#define DEFAULT_CURRENT_VALUE	0.0

#define DOCK_ICON_SIZE NSMakeSize(128, 128)
#define DOCK_PROGRESS_RECT NSMakeRect(8.0, 0.0, 112.0, 16.0)
#define DEFAULT_ICON [NSImage imageNamed: @"NSApplicationIcon"]

@interface IGRDockIndicator ()
- (void) updateProgress;
@end

@implementation IGRDockIndicator

@synthesize minValue = _minValue;
@synthesize current  = _current;
@synthesize maxValue = _maxValue;
@synthesize color = _color;

- (id) init {
	if (!(self = [super init])) 
	{
		return nil;
	}
	
	_minValue = DEFAULT_MIN_VALUE;
	_maxValue = DEFAULT_MAX_VALUE;
	_current  = DEFAULT_CURRENT_VALUE;
	
	_color = [NSColor colorWithCalibratedRed:75.0/255 green:145.0/255 blue:215.0/255 alpha:1.0];
#if !__has_feature(objc_arc)
	[_color retain];
#endif
    return self;
}

- (void) dealloc
{
	_minValue = DEFAULT_MIN_VALUE;
	_maxValue = DEFAULT_MAX_VALUE;
	_current  = DEFAULT_CURRENT_VALUE;
#if !__has_feature(objc_arc)
	[_color release];
#endif
	[super dealloc];
}

// set Value for progress indicator on dock icon
- (void) setDoubleValue:(double) value
{
	self.current = value;
	
	if (value > self.minValue && value < self.maxValue) {
		[self updateProgress];
	}
	else {
		[self hide];
	}
}

- (void) setProgressColor:(NSColor*)newColor
{
	_color = newColor;
	
	[self setDoubleValue:self.current];	
}

// display progress on dock icon anyway
- (void) display
{
    [self updateProgress];
}

// hide progress on dock icon anyway
- (void) hide
{
	[NSApp setApplicationIconImage: DEFAULT_ICON];
}

// private method
// draw progress indicator on the dock
-(void) updateProgress
{
#if __has_feature(objc_arc)
	NSImage *dockIcon = [[NSImage alloc] initWithSize: DOCK_ICON_SIZE];
#else
	NSImage *dockIcon = [[[NSImage alloc] initWithSize: DOCK_ICON_SIZE] autorelease];
#endif
	[dockIcon lockFocus];
    {
		NSRect box = DOCK_PROGRESS_RECT;

		// Application icon
		[DEFAULT_ICON dissolveToPoint: NSZeroPoint fraction: 1.0];

		// bg
		NSBezierPath* backgroundRectanglePath = [NSBezierPath bezierPathWithRoundedRect:box xRadius: 8 yRadius: 8];
		[backgroundRectanglePath appendBezierPathWithRoundedRect:box xRadius:8.0 yRadius:8.0];
		[[NSColor colorWithSRGBRed:1 green:1 blue:1 alpha:0.75] set];
		[backgroundRectanglePath fill];

		// new size
		box = NSInsetRect( box, 2.0, 2.0 );
		box.size.width = (box.size.width / (self.maxValue - self.minValue)) * (self.current - self.minValue);

		//Progress line
		NSGradient *gradient = [[NSGradient alloc] initWithStartingColor:self.color 
															 endingColor:[self.color shadowWithLevel:0.4]];
		NSBezierPath* progressRectanglePath = [NSBezierPath bezierPathWithRoundedRect:box xRadius: 8 yRadius: 8];
		[gradient drawInBezierPath: progressRectanglePath angle: -90];

	}
	[dockIcon unlockFocus];

	[NSApp setApplicationIconImage: dockIcon];
}

@end
