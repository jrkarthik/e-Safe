//
//  TableViewController.m
//  MyCredentials
//
//  Created by Karthik on 8/13/13.
//  Copyright (c) 2013 JRKKarthik. All rights reserved.
//

#import "TableViewController.h"
#import "AddViewController.h"
@interface TableViewController ()

@end

@implementation TableViewController

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
    appDelObj=(AppDelegate*)[[UIApplication sharedApplication]delegate];
    dataBasePath = [appDelObj getDBPathFromBundleDirectory];
    self.navigationItem.title=@"Personal Notes";
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.tableView.backgroundColor=[UIColor blackColor];

    textLblArray =[[NSMutableArray alloc]init];
    detailArray =[[NSMutableArray alloc]init];
    
    sqlite3_stmt *stmt;
    const char *dbpath = [dataBasePath UTF8String];
    if(sqlite3_open(dbpath, &sqliteObj) == SQLITE_OK)
    {
        NSString *selectSQL = [NSString stringWithFormat: @"select * from PersonalNotes"];
        const char *select_stmt = [selectSQL UTF8String];
        if(sqlite3_prepare_v2(sqliteObj, select_stmt, -1, &stmt, NULL) == SQLITE_OK)
        {
            while(sqlite3_step(stmt) == SQLITE_ROW)
            {
                NSString *toBeDisplayed=[NSString stringWithFormat:@"%s",(char *) sqlite3_column_text(stmt, 1)];
                toBeDisplayed=[toBeDisplayed stringByReplacingOccurrencesOfString:@"//" withString:@"'"];
                [textLblArray addObject:[NSString stringWithFormat:@"%s",(char *) sqlite3_column_text(stmt, 0)]];
                [detailArray addObject:toBeDisplayed];
            }
            sqlite3_finalize(stmt);
        }
    }
    sqlite3_close(sqliteObj);
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [textLblArray count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    
    
    cell.textLabel.text= [[detailArray objectAtIndex:indexPath.row] stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    cell.detailTextLabel.text=[textLblArray objectAtIndex:indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:16];
    cell.textLabel.textColor=[UIColor blackColor];
    cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
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

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AddViewController *addObject =[[AddViewController alloc]init];
    
    [addObject setTestVal:@"ShowSaveBtn"];
    [addObject setDateStr:[textLblArray objectAtIndex:indexPath.row]];
    [addObject setNotesStr:[detailArray objectAtIndex:indexPath.row]];
    
    [self.navigationController pushViewController:addObject animated:YES];
}

@end
