//
//  IGRAppDelegate.h
//  IGRDockIndicator
//
//  Created by Parovishnik Vitaly (Korich) on 27.05.12.
//  Copyright (c) 2012 IGR Software. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "IGRDockIndicator.h"

@interface IGRAppDelegate : NSObject <NSApplicationDelegate> {
	IGRDockIndicator *dockIndicator;
	int pos;
}

@property (assign) IBOutlet NSWindow *window;
@property (nonatomic, assign) int pos;


- (IBAction)hide:(id)sender;
- (IBAction)display:(id)sender;

@end
