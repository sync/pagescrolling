//
//  PageController.h
//  PageScrolling
//
//  Created by Anthony Mittaz on 23/03/09.
//  Copyright 2009 Anthony Mittaz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface PageController : BaseViewController {
	UILabel *_label;
	
	NSInteger _pageNumber;
}

@property (nonatomic, retain) IBOutlet UILabel *label;
@property (nonatomic) NSInteger pageNumber;

- (void)loadContent:(id)sender;

@end
