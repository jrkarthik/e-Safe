//
//  DetailTableViewController.h
//  MyCredentials
//
//  Created by Karthik on 8/16/13.
//  Copyright (c) 2013 JRKKarthik. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListViewController.h"
@class SubDetailTableViewController;

@interface DetailTableViewController : UITableViewController<UISearchDisplayDelegate,UISearchBarDelegate>

{
    AppDelegate *appDelObj;
    NSString *dataBasePath;
    sqlite3 *sqliteObject;
    NSMutableArray *tempArray;
    NSMutableArray *filteredArray;
    
    SubDetailTableViewController *subDetailTVC;
    
    UISearchBar *searchBaar;
    
}
@property (nonatomic,assign) NSInteger detailIDNo;
@property (nonatomic,strong) NSString *selectedItem;
//@property (strong,nonatomic) NSMutableArray *filteredArray;
@end