//
//  SecurityQuestionsViewController.h
//  MyCredentials
//
//  Created by Karthik on 8/22/13.
//  Copyright (c) 2013 JRKKarthik. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>
#import "AppDelegate.h"
#import <QuartzCore/QuartzCore.h>
@class ListViewController;

@interface SecurityQuestionsViewController : UIViewController<UITextFieldDelegate,UITextViewDelegate,UIScrollViewDelegate>
{
    UITextField *siteField,*userIDField;
    UITextView *questionField,*answerField;
    UIButton *saveButton;
    UILabel *qLabel,*ansLabel;
    UIView *backgroundView;
    UIScrollView *scrollView;
    
    AppDelegate *appDelObj;
    NSString *dataBasePath;
    sqlite3 *sqliteObject;
    
    ListViewController *lVC;
}

@end
