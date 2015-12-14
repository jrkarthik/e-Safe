//
//  AppDelegate.m
//  MyCredentials
//
//  Created by Karthik on 8/12/13.
//  Copyright (c) 2013 JRKKarthik. All rights reserved.
//

#import "AppDelegate.h"

#import <sqlite3.h>

#import "ListViewController.h"

#import "KKPasscodeLock.h"

@implementation AppDelegate
@synthesize navObj;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    [[KKPasscodeLock sharedLock] setDefaultSettings];
    [KKPasscodeLock sharedLock].eraseOption = NO;
   
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    [self moveDatabase];
    
    self.viewController = [[ListViewController alloc] initWithNibName:@"ListViewController" bundle:nil];
    navObj = [[UINavigationController alloc]initWithRootViewController:self.viewController];
    //navObj.navigationBar.translucent = YES;
    self.window.rootViewController = self.navObj;
    
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    if ([[KKPasscodeLock sharedLock] isPasscodeRequired]) {
        KKPasscodeViewController *vc = [[KKPasscodeViewController alloc] initWithNibName:nil bundle:nil];
        vc.mode = KKPasscodeModeEnter;
        vc.delegate = self;
        
        dispatch_async(dispatch_get_main_queue(),^ {
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
            
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
            {
                nav.modalPresentationStyle = UIModalPresentationFormSheet;
                nav.navigationBar.barStyle = UIBarStyleBlack;
                nav.navigationBar.opaque = NO;
            }
            else
            {
                nav.navigationBar.tintColor = navObj.navigationBar.tintColor;
                nav.navigationBar.translucent = navObj.navigationBar.translucent;
                nav.navigationBar.opaque = navObj.navigationBar.opaque;
                nav.navigationBar.barStyle = navObj.navigationBar.barStyle;
            }
            
            [navObj presentModalViewController:nav animated:NO];
        });
        
    }
// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
- (void) moveDatabase
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    NSString *dbPath = [self getDBPathFromBundleDirectory];
	BOOL success = [fileManager fileExistsAtPath:dbPath];
   // NSLog(@"dbPath : %@",dbPath);
    
    if(!success)
    {
        NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"MyCredentialsDB.sqlite"];
       // NSLog(@"defaultDBPath : %@",defaultDBPath);
        [fileManager removeItemAtPath:dbPath error: &error];
		success = [fileManager copyItemAtPath:defaultDBPath toPath:dbPath error:&error];
       //NSLog(@"dbPath : %@",dbPath);
		
		if (!success)
            NSAssert1(0, @"Failed to create writable database file with message '%@'.", [error localizedDescription]);
	}
}
- (NSString *)getDBPathFromBundleDirectory
{
    NSArray * paths =NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString * docsDir = [paths objectAtIndex:0];
    return [docsDir stringByAppendingPathComponent:@"MyCredentialsDB.sqlite"];
}

- (void)shouldEraseApplicationData:(KKPasscodeViewController*)viewController
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"You have entered an incorrect passcode too many times. All account data in this app has been deleted." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

- (void)didPasscodeEnteredIncorrectly:(KKPasscodeViewController*)viewController
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"You have entered an incorrect passcode too many times." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

@end
