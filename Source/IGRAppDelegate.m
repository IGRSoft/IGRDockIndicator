//
//  IGRAppDelegate.m
//  IGRDockIndicator
//
//  Created by Parovishnik Vitaly (Korich) on 27.05.12.
//  Copyright (c) 2012 IGR Software. All rights reserved.
//

#import "IGRAppDelegate.h"

@implementation IGRAppDelegate

@synthesize window = _window;
@synthesize colorWell = _colorWell;
@synthesize pos;

- (void)dealloc
{
    [super dealloc];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
	pos = 0;
	
	dockIndicator = [[IGRDockIndicator alloc] init];
	[dockIndicator setDoubleValue:pos];
}

-(void) setPos:(int)_pos
{
	[dockIndicator setDoubleValue:_pos];
}

- (IBAction)hide:(id)sender
{
	[dockIndicator hide];
}

- (IBAction)display:(id)sender
{
	[dockIndicator display];
}

- (IBAction)color:(id)sender
{
	NSColor *color = [self.colorWell color];
	[dockIndicator setProgressColor:color];
}

@end
