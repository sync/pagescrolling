//
//  BaseViewController.m
//  PageScrolling
//
//  Created by Anthony Mittaz on 23/03/09.
//  Copyright 2009 Anthony Mittaz. All rights reserved.
//

#import "BaseViewController.h"


@implementation BaseViewController

@synthesize appDelegate=_appDelegate;

/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/

#pragma mark -
#pragma mark View Setup:

- (void)viewDidLoad {
    [super viewDidLoad];
	
	// Make sure the application delegate is loaded
    [self loadAppDelegate:self];
}

#pragma mark -
#pragma mark Load Application Delegate:

- (void)loadAppDelegate:(id)sender
{
	if (!self.appDelegate) {
		self.appDelegate = (PageScrollingAppDelegate *)[[UIApplication sharedApplication]delegate];
	}
}

#pragma mark -
#pragma mark Restore to last known user location:

- (void)restoreLevelWithSelectionArray:(NSArray *)selectionArray
{
	// noting
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
	DLog(@"Oups, time to release memory");
}


- (void)dealloc {
	[_appDelegate release];
	
    [super dealloc];
}


@end
