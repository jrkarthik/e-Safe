//
//  ListViewController.h
//  MyCredentials
//
//  Created by Karthik on 8/12/13.
//  Copyright (c) 2013 JRKKarthik. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import <sqlite3.h>
#import "AddViewController.h"
#import "TableViewController.h"
#import "SecurityQuestionsViewController.h"
#import "CardsViewController.h"

@class DetailTableViewController;

@interface ListViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate,UITextFieldDelegate>
{
    UITableView *listTable;
    AppDelegate * appDelObj;
    sqlite3 * sqliteObject;
    NSMutableArray *listArray;
    NSString * dataBasePath;
    sqlite3 * sqliteObject2;
    
    AddViewController *aVCObject;
    TableViewController *tVCObject;
    DetailTableViewController *dVCObject;
    SecurityQuestionsViewController *sQVCObject;
    CardsViewController *cVCObject;
    
    
    UITextField *textField1;
    UITextField *textField2;
    UITextField *textField3;
}

-(IBAction)useOptions:(id)sender;

@end
