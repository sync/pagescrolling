//
//  PageScrollingAppDelegate.h
//  PageScrolling
//
//  Created by Anthony Mittaz on 23/03/09.
//  Copyright Anthony Mittaz 2009. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PageScrollingAppDelegate : NSObject <UIApplicationDelegate> {
    // Load user interface
    UIWindow *_window;
    UINavigationController *_navigationController;
	// Remember last saved location
	NSUserDefaults *_userDefaults;
	NSMutableArray *_savedLocation;
	// Content Array
	NSArray *_content;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;

@property (nonatomic, retain) NSUserDefaults *userDefaults;
@property (nonatomic, retain) NSMutableArray *savedLocation;

@property (nonatomic, retain) NSArray *content;

- (void)loadUserDefaults:(id)sender;
- (void)loadLastSavedLocation:(id)sender;

- (void)restoreLevelWithSelectionArray:(NSArray *)selectionArray;

- (void)loadTableContent:(id)sender;

@end

