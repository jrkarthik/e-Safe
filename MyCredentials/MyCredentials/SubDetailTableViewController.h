//
//  SubDetailTableViewController.h
//  MyCredentials
//
//  Created by Karthik on 8/16/13.
//  Copyright (c) 2013 JRKKarthik. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "DetailTableViewController.h"
#import "ModelClass.h"
#import "QuestionsTableCell.h"
#import "CardDetailsTableCell.h"


@interface SubDetailTableViewController : UITableViewController
{
    AppDelegate *appDelObj;
    NSString *dataBasePath;
    sqlite3 *sqliteObject;
    
    DetailTableViewController *dTVC;

    NSMutableArray *subTempArray,*SubDetailArray,*displayArray;
    NSString *retrvSQL;
    ModelClass *model;
}

@property (nonatomic,strong) NSString *selectedCell;
@property (nonatomic,strong) NSString *selectedDBTable,*cardKind;
@end
