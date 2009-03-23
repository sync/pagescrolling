//
//  PageScrollingAppDelegate.m
//  PageScrolling
//
//  Created by Anthony Mittaz on 23/03/09.
//  Copyright Anthony Mittaz 2009. All rights reserved.
//

#import "PageScrollingAppDelegate.h"


@implementation PageScrollingAppDelegate

@synthesize window=_window;
@synthesize navigationController=_navigationController;
@synthesize userDefaults=_userDefaults;
@synthesize savedLocation=_savedLocation;
@synthesize content=_content;

#pragma mark -
#pragma mark Setup your appliation here:

- (void)applicationDidFinishLaunching:(UIApplication *)application {
	// Configure and show the window
	[self.window addSubview:[self.navigationController view]];
	[self.window makeKeyAndVisible];
	// Populate table content array with fake data
	[self loadTableContent:self];
	// Last known user location
	[self loadUserDefaults:self];
	[self loadLastSavedLocation:self];
}

#pragma mark -
#pragma mark Load Application Delegate:

- (void)loadTableContent:(id)sender
{
	if (!self.content) {
		self.content = [NSArray arrayWithObjects:@"Page 1", @"Page 2", @"Page 3", @"Page 4", @"Page 5", nil ];
	}
}

#pragma mark -
#pragma mark User defaults:

- (void)loadUserDefaults:(id)sender
{
	self.userDefaults = [NSUserDefaults standardUserDefaults];
}

#pragma mark -
#pragma mark Last Saved Location:

- (void)loadLastSavedLocation:(id)sender
{
	// load the stored preference of the user's last location from a previous launch
	NSMutableArray *tempMutableCopy = [[self.userDefaults objectForKey:RestoreLocation] mutableCopy];
	self.savedLocation = tempMutableCopy;
	[tempMutableCopy release];
	
	if (self.savedLocation == nil) {
		// user has not launched this app nor navigated to a particular level yet, start at level 1, with no selection
		
		self.savedLocation = [NSMutableArray arrayWithObjects:
							  @"-1",
							  nil];
	}
	
	[self restoreLevelWithSelectionArray:self.savedLocation];
}

#pragma mark -
#pragma mark Restore Last Known User Location:

- (void)restoreLevelWithSelectionArray:(NSArray *)selectionArray
{
	NSInteger item = [[selectionArray objectAtIndex:0]integerValue];
	if (item != -1) {
		[self.navigationController.visibleViewController performSelector:@selector(restoreLevelWithSelectionArray:) withObject:selectionArray];
	}
}

#pragma mark -
#pragma mark Save what's required before quitting:

- (void)applicationWillTerminate:(UIApplication *)application {
	// Save data if appropriate
	// remember the user last location
	[self.userDefaults setObject:self.savedLocation forKey:RestoreLocation];
}

#pragma mark -
#pragma mark Dealloc:

- (void)dealloc {
	[_content release];
	[_userDefaults release];
	[_savedLocation release];
	[_navigationController release];
	[_window release];
	[super dealloc];
}

@end
