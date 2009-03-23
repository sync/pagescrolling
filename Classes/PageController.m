//
//  PageController.m
//  PageScrolling
//
//  Created by Anthony Mittaz on 23/03/09.
//  Copyright 2009 Anthony Mittaz. All rights reserved.
//

#import "PageController.h"

@implementation PageController

@synthesize label=_label;
@synthesize pageNumber=_pageNumber;


// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initializations
		self.pageNumber = -1;
    }
    return self;
}

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	if (self.pageNumber >= 0) {
		[self loadContent:self];
	}
}

- (void)loadContent:(id)sender
{
	NSInteger count = [self.appDelegate.content count];
	if (self.pageNumber < count) {
		self.label.text = [self.appDelegate.content objectAtIndex:self.pageNumber];
	}
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

#pragma mark -
#pragma mark Memory Warning:

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
	DLog(@"Oups, time to release memory");
}


- (void)dealloc {
	[_label release];
	
    [super dealloc];
}


@end
