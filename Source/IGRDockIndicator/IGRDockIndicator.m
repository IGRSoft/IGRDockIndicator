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

- (id) init {
	if (!(self = [super init])) 
	{
		return nil;
	}
	
	_minValue = DEFAULT_MIN_VALUE;
	_maxValue = DEFAULT_MAX_VALUE;
	_current  = DEFAULT_CURRENT_VALUE;
	
    return self;
}

- (void) dealloc
{
	_minValue = DEFAULT_MIN_VALUE;
	_maxValue = DEFAULT_MAX_VALUE;
	_current  = DEFAULT_CURRENT_VALUE;
	
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
#if __has_feature(objc_arc)
		NSBezierPath *bPath = [[NSBezierPath alloc] init];
#else
		NSBezierPath *bPath = [[[NSBezierPath alloc] init] autorelease];
#endif
		
		[bPath appendBezierPathWithRoundedRect:box xRadius:8.0 yRadius:8.0];
		[[NSColor colorWithSRGBRed:1 green:1 blue:1 alpha:0.75] set];
		[bPath fill];

		// new size
		box = NSInsetRect( box, 2.0, 2.0 );
		box.size.width = (box.size.width / (self.maxValue - self.minValue)) * (self.current - self.minValue);

		//Progress line
#if __has_feature(objc_arc)
		NSBezierPath *pPath = [[NSBezierPath alloc] init];
#else
		NSBezierPath *pPath = [[[NSBezierPath alloc] init] autorelease];
#endif
		[pPath appendBezierPathWithRoundedRect:box xRadius:8.0 yRadius:8.0];
		[[NSColor colorWithPatternImage:[NSImage imageNamed:@"progress"]] set];
		[pPath fill];
	}
	[dockIcon unlockFocus];

	[NSApp setApplicationIconImage: dockIcon];
}

@end
