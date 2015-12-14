//
//  AddViewController.h
//  MyCredentials
//
//  Created by Karthik on 8/13/13.
//  Copyright (c) 2013 JRKKarthik. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>
#import "AppDelegate.h"
@class ListViewController;
@interface AddViewController : UIViewController<UITextViewDelegate>
{
    UITextView *notesText;

    NSMutableString *typedData;
    
    AppDelegate *appDelObj;
    NSString * dataBasePath;
    
    sqlite3 * sqliteObj;
    
    ListViewController *lvc;
    
}

@property(nonatomic,strong)NSString * dateStr, *notesStr;
@property(nonatomic,strong)NSString * testVal;
-(IBAction)saveToDB:(id)sender;
@end
