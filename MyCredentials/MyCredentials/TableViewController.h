//
//  TableViewController.h
//  MyCredentials
//
//  Created by Karthik on 8/13/13.
//  Copyright (c) 2013 JRKKarthik. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>
#import "AppDelegate.h"

@interface TableViewController : UITableViewController
{
    NSMutableArray *textLblArray, *detailArray;
    AppDelegate *appDelObj;
    NSString * dataBasePath;
    
    sqlite3 * sqliteObj;

}

@end
