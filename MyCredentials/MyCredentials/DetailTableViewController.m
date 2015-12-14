//
//  DetailTableViewController.m
//  MyCredentials
//
//  Created by Karthik on 8/16/13.
//  Copyright (c) 2013 JRKKarthik. All rights reserved.
//

#import "DetailTableViewController.h"
#import <sqlite3.h>
#import "AppDelegate.h"
#import "SubDetailTableViewController.h"

@interface DetailTableViewController ()

@end

@implementation DetailTableViewController
@synthesize detailIDNo,selectedItem;



NSArray *temp;


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    searchBaar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    
    searchBaar.showsCancelButton=YES;
    searchBaar.delegate=self;


    
    self.tableView.tableHeaderView = searchBaar;
    self.tableView.backgroundColor = [UIColor blackColor];
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.tableView.tableHeaderView=searchBaar;
        filteredArray = [[NSMutableArray alloc]init];
    temp = [[NSArray alloc]init];
    
    subDetailTVC=[[SubDetailTableViewController alloc]init];
    
    appDelObj=(AppDelegate*)[[UIApplication sharedApplication]delegate];
    dataBasePath = [appDelObj getDBPathFromBundleDirectory];
    NSLog(@"dataBasePath:%@",dataBasePath);
    

}
-(void)viewWillAppear:(BOOL)animated
{
    [searchBaar setText:@""];
    [super viewWillAppear:YES];
    [self selectedDetail:detailIDNo];
    self.navigationItem.title=selectedItem;
    [self.tableView reloadData];
    [filteredArray removeAllObjects];
}
-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:YES];
    tempArray=nil;
}
-(void)selectedDetail:(NSInteger)detail
{
    tempArray =[[NSMutableArray alloc]init];
    
    switch (detail)
    {
        
        case 1:
            NSLog(@"%d",detailIDNo);
            subDetailTVC.selectedDBTable =@"SocialNetworking";
            const char *dbpath = [dataBasePath UTF8String];
            sqlite3_stmt *stmt;
            if(sqlite3_open(dbpath, &sqliteObject) == SQLITE_OK)
            {
                NSString *selectSQL = [NSString stringWithFormat: @"SELECT DISTINCT lower(FirstItem) from SocialNetworking  "];
                const char *select_stmt = [selectSQL UTF8String];
                if(sqlite3_prepare_v2(sqliteObject, select_stmt, -1, &stmt, NULL) == SQLITE_OK)
                {
                    while(sqlite3_step(stmt) == SQLITE_ROW)
                    {
                        [tempArray addObject:[NSString stringWithFormat:@"%s",(char *) sqlite3_column_text(stmt, 0)]];
                    }
                    sqlite3_finalize(stmt);
                }
            }
            sqlite3_close(sqliteObject);
            break;
        case 2:
            NSLog(@"%d",detailIDNo);
            subDetailTVC.selectedDBTable =@"BankAccountDetails";
            sqlite3_stmt *stmt2;
            dbpath = [dataBasePath UTF8String];
            if(sqlite3_open(dbpath, &sqliteObject) == SQLITE_OK)
            {
                NSString *selectSQL = [NSString stringWithFormat: @"SELECT DISTINCT lower(FirstItem) from BankAccountDetails"];
                const char *select_stmt = [selectSQL UTF8String];
                if(sqlite3_prepare_v2(sqliteObject, select_stmt, -1, &stmt2, NULL) == SQLITE_OK)
                {
                    while(sqlite3_step(stmt2) == SQLITE_ROW)
                    {
                        [tempArray addObject:[NSString stringWithFormat:@"%s",(char *) sqlite3_column_text(stmt2, 0)]];
                    }
                    sqlite3_finalize(stmt2);
                }
            }
            sqlite3_close(sqliteObject);
            break;
        case 3:
            NSLog(@"%d",detailIDNo);
            
            break;
        case 4:
            NSLog(@"%d",detailIDNo);
            subDetailTVC.selectedDBTable =@"BankLockerDetails";
            dbpath = [dataBasePath UTF8String];
            sqlite3_stmt *stmt4;
            if(sqlite3_open(dbpath, &sqliteObject) == SQLITE_OK)
            {
                NSString *selectSQL = [NSString stringWithFormat: @"SELECT DISTINCT lower(FirstItem) from BankLockerDetails"];
                const char *select_stmt = [selectSQL UTF8String];
                if(sqlite3_prepare_v2(sqliteObject, select_stmt, -1, &stmt4, NULL) == SQLITE_OK)
                {
                    while(sqlite3_step(stmt4) == SQLITE_ROW)
                    {
                        [tempArray addObject:[NSString stringWithFormat:@"%s",(char *) sqlite3_column_text(stmt4, 0)]];
                    }
                    sqlite3_finalize(stmt4);
                }
            }
            sqlite3_close(sqliteObject);
            break;
        case 5:
            NSLog(@"%d",detailIDNo);
            subDetailTVC.selectedDBTable =@"IdentityProofDetails";
            dbpath = [dataBasePath UTF8String];
            sqlite3_stmt *stmt5;
            if(sqlite3_open(dbpath, &sqliteObject) == SQLITE_OK)
            {
                NSString *selectSQL = [NSString stringWithFormat: @"SELECT DISTINCT lower(FirstItem) from IdentityProofDetails"];
                const char *select_stmt = [selectSQL UTF8String];
                if(sqlite3_prepare_v2(sqliteObject, select_stmt, -1, &stmt5, NULL) == SQLITE_OK)
                {
                    while(sqlite3_step(stmt5) == SQLITE_ROW)
                    {
                        [tempArray addObject:[NSString stringWithFormat:@"%s",(char *) sqlite3_column_text(stmt5, 0)]];
                    }
                    sqlite3_finalize(stmt5);
                }
            }
            sqlite3_close(sqliteObject);
            break;
        case 6:
            NSLog(@"%d",detailIDNo);
            subDetailTVC.selectedDBTable =@"OnlineBankingDetails";
            dbpath = [dataBasePath UTF8String];
            sqlite3_stmt *stmt6;
            if(sqlite3_open(dbpath, &sqliteObject) == SQLITE_OK)
            {
                NSString *selectSQL = [NSString stringWithFormat: @"SELECT DISTINCT lower(FirstItem) from OnlineBankingDetails"];
                const char *select_stmt = [selectSQL UTF8String];
                if(sqlite3_prepare_v2(sqliteObject, select_stmt, -1, &stmt6, NULL) == SQLITE_OK)
                {
                    while(sqlite3_step(stmt6) == SQLITE_ROW)
                    {
                        [tempArray addObject:[NSString stringWithFormat:@"%s",(char *) sqlite3_column_text(stmt6, 0)]];
                    }
                    sqlite3_finalize(stmt6);
                }
            }
            sqlite3_close(sqliteObject);
            break;
        case 7:
            NSLog(@"%d",detailIDNo);
            subDetailTVC.selectedDBTable =@"SecurityQuestions";
            dbpath = [dataBasePath UTF8String];
            sqlite3_stmt *stmt7;
            if(sqlite3_open(dbpath, &sqliteObject) == SQLITE_OK)
            {
                NSString *selectSQL = [NSString stringWithFormat: @"SELECT DISTINCT lower(FirstItem) from SecurityQuestions"];
                const char *select_stmt = [selectSQL UTF8String];
                if(sqlite3_prepare_v2(sqliteObject, select_stmt, -1, &stmt7, NULL) == SQLITE_OK)
                {
                    while(sqlite3_step(stmt7) == SQLITE_ROW)
                    {
                        [tempArray addObject:[NSString stringWithFormat:@"%s",(char *) sqlite3_column_text(stmt7, 0)]];
                    }
                    sqlite3_finalize(stmt7);
                }
            }
            sqlite3_close(sqliteObject);
            break;
 
        default:
            break;
        case 9:
            NSLog(@"%d",detailIDNo);
            subDetailTVC.selectedDBTable =@"CreditOrDebitCardDetails";
            subDetailTVC.cardKind=@"Credit";
            dbpath = [dataBasePath UTF8String];
            sqlite3_stmt *stmt9;
            if(sqlite3_open(dbpath, &sqliteObject) == SQLITE_OK)
            {
                NSString *selectSQL = [NSString stringWithFormat: @"select  distinct lower(Firstitem) from CreditOrDebitCardDetails Where card='Credit'"];
                const char *select_stmt = [selectSQL UTF8String];
                if(sqlite3_prepare_v2(sqliteObject, select_stmt, -1, &stmt9, NULL) == SQLITE_OK)
                {
                    while(sqlite3_step(stmt9) == SQLITE_ROW)
                    {
                        [tempArray addObject:[NSString stringWithFormat:@"%s",(char *) sqlite3_column_text(stmt9, 0)]];
                    }
                    sqlite3_finalize(stmt9);
                }
            }
            sqlite3_close(sqliteObject);

            
            break;
        case 10:
            NSLog(@"%d",detailIDNo);
            subDetailTVC.selectedDBTable =@"CreditOrDebitCardDetails";
            subDetailTVC.cardKind=@"Debit";
            dbpath = [dataBasePath UTF8String];
            sqlite3_stmt *stmt10;
            if(sqlite3_open(dbpath, &sqliteObject) == SQLITE_OK)
            {
                NSString *selectSQL = [NSString stringWithFormat: @"select  distinct lower(Firstitem) from CreditOrDebitCardDetails Where card='Debit'"];
                const char *select_stmt = [selectSQL UTF8String];
                if(sqlite3_prepare_v2(sqliteObject, select_stmt, -1, &stmt10, NULL) == SQLITE_OK)
                {
                    while(sqlite3_step(stmt10) == SQLITE_ROW)
                    {
                        [tempArray addObject:[NSString stringWithFormat:@"%s",(char *) sqlite3_column_text(stmt10, 0)]];
                    }
                    sqlite3_finalize(stmt10);
                }
            }
            sqlite3_close(sqliteObject);            
            break;
    }
        [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if([filteredArray count]>0)
    {
          return [filteredArray count];
    }
    else
    {
         return [tempArray count];
    }

    // Return the number of rows in the section.
   
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    if ([filteredArray count]> 0)
    {
        
        cell.textLabel.text=[filteredArray objectAtIndex:indexPath.row];
        cell.textLabel.font = [UIFont systemFontOfSize:16];
        cell.textLabel.textColor = [UIColor blackColor];
        cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    }
    else
    {
        cell.textLabel.text=[tempArray objectAtIndex:indexPath.row];
        cell.textLabel.font = [UIFont systemFontOfSize:16];
        cell.textLabel.textColor = [UIColor blackColor];
        cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    }
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
 
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    NSLog(@"%@",filteredArray);
    [filteredArray removeAllObjects];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF contains[c] %@",searchText];
    filteredArray = [NSMutableArray arrayWithArray:[tempArray filteredArrayUsingPredicate:predicate]];
    [self.tableView reloadData];
}


//- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
//{
//    [self filterContentForSearchText:searchString
//                               scope:[[self.searchDisplayController.searchBar scopeButtonTitles]
//                       objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
//    [controller.searchResultsTableView setBackgroundColor:[UIColor blackColor]];
//    controller.searchResultsTableView.bounces=FALSE;
//    return YES;
//}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   if([filteredArray count]>0)
   {
       subDetailTVC.selectedCell=[filteredArray objectAtIndex:indexPath.row];
   }
   else
   {
       subDetailTVC.selectedCell=[tempArray objectAtIndex:indexPath.row];
   }
    [self.navigationController pushViewController:subDetailTVC animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar
{
    [searchBar resignFirstResponder];
}

@end
