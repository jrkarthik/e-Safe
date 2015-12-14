//
//  AppDelegate.h
//  MyCredentials
//
//  Created by Karthik on 8/12/13.
//  Copyright (c) 2013 JRKKarthik. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "KKPasscodeLock.h"

@class ListViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate,KKPasscodeViewControllerDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) ListViewController *viewController;

@property (strong, nonatomic) UINavigationController * navObj;

- (void) moveDatabase;

- (NSString *)getDBPathFromBundleDirectory;
@end
