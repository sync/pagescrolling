//
//  PageScrollContainer.h
//  PageScrolling
//
//  Created by Anthony Mittaz on 23/03/09.
//  Copyright 2009 Anthony Mittaz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@class PageController;

@interface PageScrollContainer : BaseViewController <UIScrollViewDelegate>{
	UIPageControl *_pageControl;
	UIScrollView *_scrollView;
	NSInteger _initialPosition;
	CGFloat _lastScrolledXPosition;
	
	PageController *_firstController;
	PageController *_secondController;
}

@property (nonatomic, retain) IBOutlet UIPageControl *pageControl;
@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;
@property (nonatomic) NSInteger initialPosition;
@property (nonatomic) CGFloat lastScrolledXPosition;

@property (nonatomic, retain) IBOutlet PageController *firstController;
@property (nonatomic, retain) IBOutlet PageController *secondController;

- (IBAction)loadPage:(id)sender;

@end
