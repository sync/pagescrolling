//
//  BaseTableViewController.h
//  PageScrolling
//
//  Created by Anthony Mittaz on 23/03/09.
//  Copyright 2009 Anthony Mittaz. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface BaseTableViewController : UITableViewController {
	// App Delegate
	PageScrollingAppDelegate *_appDelegate;
}

@property (nonatomic, retain) PageScrollingAppDelegate *appDelegate;

- (void)loadAppDelegate:(id)sender;
- (void)restoreLevelWithSelectionArray:(NSArray *)selectionArray;

@end
