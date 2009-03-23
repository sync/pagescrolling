//
//  PageScrollContainer.m
//  PageScrolling
//
//  Created by Anthony Mittaz on 23/03/09.
//  Copyright 2009 Anthony Mittaz. All rights reserved.
//

#import "PageScrollContainer.h"
#import "PageController.h"


@implementation PageScrollContainer

@synthesize pageControl=_pageControl;
@synthesize scrollView=_scrollView;
@synthesize initialPosition=_initialPosition;
@synthesize lastScrolledXPosition=_lastScrolledXPosition;
@synthesize firstController=_firstController;
@synthesize secondController=_secondController;


// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
		self.initialPosition = 0;
		self.lastScrolledXPosition = 0.0;
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
	
	// Set navigation title
	self.navigationItem.title = @"Scroll Left or Right";
	
	// init second view
	[self.scrollView addSubview:self.secondController.view];
	self.secondController.view.frame = CGRectMake(self.scrollView.frame.origin.x, self.scrollView.frame.size.height, self.scrollView.frame.size.width, self.scrollView.frame.size.height);
	// init first view
	self.firstController.view.frame = self.scrollView.frame;
	[self.scrollView addSubview:self.firstController.view];
	
	// check the number of favorites
	NSInteger count = [self.appDelegate.content count];
	// should update page control
	self.pageControl.numberOfPages = count;
	// update frame size width according to the number of favorites
	self.scrollView.contentSize = CGSizeMake(count * 320.0, self.scrollView.frame.size.height);
	// get the location position
	//NSInteger position = [self.appDelegate.userdb intForQuery:@"select position from location where location_id = ?", self.location_id];
	NSInteger position = self.initialPosition;
	// scroll to first view
	CGRect viewFrame = self.scrollView.frame;
	if (position != 0) {
		[self.scrollView scrollRectToVisible:CGRectMake(position * viewFrame.size.width, self.scrollView.frame.origin.x, viewFrame.size.width, viewFrame.size.height) animated:FALSE];
	} else {
		self.firstController.pageNumber = position;
		[self.firstController loadContent:self];
		CGRect firstFrame = self.scrollView.frame;
		self.firstController.view.frame = CGRectMake(position * firstFrame.size.width, 0.0, firstFrame.size.width, firstFrame.size.height);
		
		self.lastScrolledXPosition = 0.0;
	}
	
	// Setup the page contol
	self.pageControl.currentPage = position;
}

- (void)scrollViewDidScroll:(UIScrollView *)sender
{	
	CGFloat newScrolledXPosition = self.scrollView.contentOffset.x;
	
	BOOL scrollRight = FALSE;
	BOOL scrollLeft = FALSE;
	CGFloat diff = 0;
	if (newScrolledXPosition > self.lastScrolledXPosition) {
		scrollRight = TRUE;
		diff = (newScrolledXPosition - self.lastScrolledXPosition);
	} else if (newScrolledXPosition < self.lastScrolledXPosition) {
		scrollLeft = TRUE;
		diff = (self.lastScrolledXPosition - newScrolledXPosition);
	}
	
	CGFloat ratio = diff / 320.0;
	if (ratio < 1.04) {
		ratio = 1.0;
	}
	NSInteger roundedRatio = ceil(ratio);
	
	BOOL shouldLoad = TRUE;
	if (diff > 0.0 && diff > (319.0 * roundedRatio)) {
		shouldLoad = FALSE;
	}
	
	if (shouldLoad || self.initialPosition >= 0) {
		self.initialPosition = -1;
		CGFloat pageWidth = self.scrollView.frame.size.width;
		float fractionalPage = (self.scrollView.contentOffset.x / pageWidth);
		
		NSInteger firstPageIndex = self.firstController.pageNumber;
		NSInteger secondPageIndex = self.secondController.pageNumber;
		
		NSInteger currentPageIndex = lround(fractionalPage);
		
		BOOL firstControllerUsed = TRUE;
		
		if (firstPageIndex == currentPageIndex) {
			// first controller used
			firstControllerUsed = TRUE;
		} else if (secondPageIndex == currentPageIndex) {
			// second controller used
			firstControllerUsed = FALSE;
		} else {
			// use first controller
			firstControllerUsed = FALSE;
		}
		
		NSInteger lowerNumber = floor(fractionalPage);
		NSInteger upperNumber = lowerNumber + 1;
		
		NSInteger nextPage = 0;
		NSInteger currentPage = 0;
		if (firstControllerUsed) {
			nextPage = self.secondController.view.frame.origin.x / 320.0;
			currentPage = self.firstController.view.frame.origin.x / 320.0;
		} else {
			nextPage = self.firstController.view.frame.origin.x / 320.0;
			currentPage = self.secondController.view.frame.origin.x / 320.0;
		}
		
		NSInteger currentIndexToUse = -1;
		NSInteger nextIndexToUse = -1;
		
		if (lowerNumber == currentPage) {
			if (upperNumber != nextPage) {
				nextIndexToUse = upperNumber;
			}
		} else if (upperNumber == currentPage) {
			if (lowerNumber != nextPage) {
				nextIndexToUse = lowerNumber;
			}
		} else {
			if (lowerNumber == nextPage) {
				currentIndexToUse = upperNumber;
			} else if (upperNumber == nextPage) {
				currentIndexToUse = lowerNumber;
			} else {
				currentIndexToUse = lowerNumber;
				nextIndexToUse = upperNumber;
			}
		}
		
		if (nextIndexToUse != -1) {
			DLog(@"nextIndexToUse: %d", nextIndexToUse);
			CGFloat yPosition = self.scrollView.frame.size.height;
			NSInteger pagesCount = [self.appDelegate.content count];
			if (nextIndexToUse < pagesCount) {
				yPosition = 0.0;
			}
			if (firstControllerUsed) {
				self.secondController.pageNumber = nextIndexToUse;
				[self.secondController loadContent:self];
				CGRect firstFrame = self.scrollView.frame;
				self.secondController.view.frame = CGRectMake(nextIndexToUse * firstFrame.size.width, yPosition, firstFrame.size.width, firstFrame.size.height);
			} else {
				self.firstController.pageNumber = nextIndexToUse;
				[self.firstController loadContent:self];
				CGRect firstFrame = self.scrollView.frame;
				self.firstController.view.frame = CGRectMake(nextIndexToUse * firstFrame.size.width, yPosition, firstFrame.size.width, firstFrame.size.height);
			}
		}
		
		if (currentIndexToUse != -1) {	
			DLog(@"currentIndexToUse: %d", currentIndexToUse);
			NSInteger count = [self.appDelegate.content count];
			if (currentIndexToUse< count) {
				if (firstControllerUsed) {
					self.firstController.pageNumber = currentIndexToUse;
					[self.firstController loadContent:self];
					CGRect firstFrame = self.scrollView.frame;
					self.firstController.view.frame = CGRectMake(currentIndexToUse * firstFrame.size.width, 0.0, firstFrame.size.width, firstFrame.size.height);
				} else {
					self.secondController.pageNumber = currentIndexToUse;
					[self.secondController loadContent:self];
					CGRect firstFrame = self.scrollView.frame;
					self.secondController.view.frame = CGRectMake(currentIndexToUse * firstFrame.size.width, 0.0, firstFrame.size.width, firstFrame.size.height);
				}
			}
		}
	}
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
	self.lastScrolledXPosition = self.scrollView.contentOffset.x;
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)newScrollView
{
	//    CGFloat pageWidth = self.scrollView.frame.size.width;
	//    float fractionalPage = self.scrollView.contentOffset.x / pageWidth;
	//	NSInteger nearestNumber = lround(fractionalPage);
	//	DLog(@"nearestNumber: %d", nearestNumber);
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)newScrollView
{
	[self scrollViewDidEndScrollingAnimation:newScrollView];
	
	CGFloat pageWidth = self.scrollView.frame.size.width;
    float fractionalPage = self.scrollView.contentOffset.x / pageWidth;
	NSInteger nearestNumber = lround(fractionalPage);
	self.pageControl.currentPage = nearestNumber;
	
	[self.appDelegate.savedLocation replaceObjectAtIndex:0 withObject:[NSString stringWithFormat:@"%d", nearestNumber]];
}


- (IBAction)loadPage:(id)sender
{
	NSInteger index = self.pageControl.currentPage;
	[self.appDelegate.savedLocation replaceObjectAtIndex:0 withObject:[NSString stringWithFormat:@"%d", index]];
	
	DLog(@"tapped index: %d", index);
	CGRect rectToScrollTo = CGRectMake(index * self.scrollView.frame.size.width, 0.0, self.scrollView.frame.size.width, self.scrollView.frame.size.height);
	
	self.lastScrolledXPosition = self.scrollView.contentOffset.x;
	[self.scrollView scrollRectToVisible:rectToScrollTo animated:TRUE];
	
	[self.appDelegate.savedLocation replaceObjectAtIndex:0 withObject:[NSString stringWithFormat:@"%d", index]];
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
}


- (void)dealloc {
	[_secondController release];
	[_firstController release];
	[_scrollView release];
	[_pageControl release];
	
    [super dealloc];
}


@end
