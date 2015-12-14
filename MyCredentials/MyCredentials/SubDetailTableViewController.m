//
//  SubDetailTableViewController.m
//  MyCredentials
//
//  Created by Karthik on 8/16/13.
//  Copyright (c) 2013 JRKKarthik. All rights reserved.
//

#import "SubDetailTableViewController.h"
#import "DetailTableViewController.h"
#import <sqlite3.h>
#import "AppDelegate.h"


@interface SubDetailTableViewController ()

@end

@implementation SubDetailTableViewController
@synthesize selectedCell,selectedDBTable,cardKind;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self)
    {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
   
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.navigationItem.hidesBackButton = NO;
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    
    self.tableView.backgroundColor = [UIColor blackColor];
    
    appDelObj=(AppDelegate*)[[UIApplication sharedApplication]delegate];
    dataBasePath = [appDelObj getDBPathFromBundleDirectory];
    
}
-(void)viewWillAppear:(BOOL)animated
{
   
    [super viewWillAppear:YES];
    [self fillArraysWithData];
    self.tableView=[[UITableView alloc ]initWithFrame:CGRectMake(0, 0, 320, 568) style:UITableViewStylePlain];
    [self.tableView setBackgroundColor:[UIColor blackColor]];
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
}

-(void)fillArraysWithData
{
//    subTempArray =[[NSMutableArray alloc]init];
//    SubDetailArray=[[NSMutableArray alloc]init];
    displayArray = [[NSMutableArray alloc]init];
    sqlite3 *sqliteObj;
    const char *dbpath = [dataBasePath UTF8String];
    sqlite3_stmt *stmt;
    
    if(sqlite3_open(dbpath, &sqliteObj) == SQLITE_OK)
    {
        if ([selectedDBTable isEqualToString:@"CreditOrDebitCardDetails"]&&[cardKind isEqualToString:@"Credit"])
        {
          retrvSQL = [NSString stringWithFormat: @"SELECT *from %@  where FirstItem like '%@' and card ='Credit' ",selectedDBTable,selectedCell];
        }
        if ([selectedDBTable isEqualToString:@"CreditOrDebitCardDetails"]&&[cardKind isEqualToString:@"Debit"])
        {
            retrvSQL = [NSString stringWithFormat: @"SELECT *from %@  where FirstItem like '%@' and card ='Debit' ",selectedDBTable,selectedCell];
        }
        if(![selectedDBTable isEqualToString:@"CreditOrDebitCardDetails"])
        {
            retrvSQL = [NSString stringWithFormat: @"SELECT *from %@  where FirstItem like '%@' ",selectedDBTable,selectedCell];
        }
        NSLog(@"%@",selectedDBTable);
        const char *insert_stmt=[retrvSQL UTF8String];
        
        if(sqlite3_prepare_v2(sqliteObj, insert_stmt, -1, &stmt, NULL)==SQLITE_OK)
            {
                
                while(sqlite3_step(stmt) == SQLITE_ROW)
                {
                    
                    model = [[ModelClass alloc]init];
                    [model setFirstString:[NSString stringWithFormat:@"%s",(char *) sqlite3_column_text(stmt, 1)]];
                    [model setSecondString:[NSString stringWithFormat:@"%s",(char *) sqlite3_column_text(stmt, 2)]];
                    [model setThirdString:[NSString stringWithFormat:@"%s",(char *) sqlite3_column_text(stmt, 3)]];
                    [model setFourthString:[NSString stringWithFormat:@"%s",(char *) sqlite3_column_text(stmt, 5)]];
                    [model setFifthString:[NSString stringWithFormat:@"%s",(char *) sqlite3_column_text(stmt, 4)]];
                    [model setSixthString:[NSString stringWithFormat:@"%s",(char *) sqlite3_column_text(stmt, 6)]];
                   
                    model.secondString = [model.secondString stringByReplacingOccurrencesOfString:@"//" withString:@"'"];
                    model.thirdString =[model.thirdString stringByReplacingOccurrencesOfString:@"//" withString:@"'"];
                    [displayArray addObject:model];
                }
            }
            sqlite3_finalize(stmt);
    }
    sqlite3_close(sqliteObj);
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [displayArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
     ModelClass *current=[displayArray objectAtIndex:indexPath.row];
    NSLog(@"display array %@",displayArray);
    
    if(!([selectedDBTable isEqualToString:@"SecurityQuestions"]||[selectedDBTable isEqualToString:@"CreditOrDebitCardDetails"]))
    {
        static NSString *CellIdentifier = @"Cell";
        
       UITableViewCell *oCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
       
        if (oCell == nil)
        {
            oCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        }

        oCell.textLabel.numberOfLines =2;
        oCell.detailTextLabel.numberOfLines =2;
        if([selectedDBTable isEqualToString:@"BankAccountDetails"])
        {
            oCell.textLabel.text = [NSString stringWithFormat:@"Account number : %@",current.firstString];
            oCell.detailTextLabel.text = [NSString stringWithFormat:@"IFSC Code : %@",current.secondString];
        }
       else if([selectedDBTable isEqualToString:@"BankLockerDetails"])
        {
            oCell.textLabel.text = [NSString stringWithFormat:@"Branch : %@",current.firstString];
            oCell.detailTextLabel.text = [NSString stringWithFormat:@"Locker number : %@",current.secondString];
        }
        else if([selectedDBTable isEqualToString:@"IdentityProofDetails"])
        {
            oCell.textLabel.text = [NSString stringWithFormat:@"Number : %@",current.firstString];
            oCell.detailTextLabel.text = [NSString stringWithFormat:@"Validity : %@",current.secondString];
        }
        else
        {
            oCell.textLabel.text = [NSString stringWithFormat:@"User Name : %@",current.firstString];
            oCell.detailTextLabel.text = [NSString stringWithFormat:@"Password : %@",current.secondString];
        }
        
        oCell.textLabel.font = [UIFont systemFontOfSize:16];
        oCell.textLabel.textColor = [UIColor whiteColor];
       
        return oCell;
    }
    
   else if([selectedDBTable isEqualToString:@"SecurityQuestions"])
    {
        static NSString *CellIdentifier = @"Cell";
        
        QuestionsTableCell *qCell = (QuestionsTableCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (qCell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"QuestionsTableCell" owner:self options:nil];
            qCell = [nib objectAtIndex:0];
        }
        qCell.userNameLabel.text=[current firstString];
        qCell.questionLabel.text=[current secondString];
        qCell.answerLabel.text=[current thirdString];
        
        return qCell;
    }
    else if([selectedDBTable isEqualToString:@"CreditOrDebitCardDetails"])
    {
        static NSString *CellIdentifier = @"Cell";
        
        CardDetailsTableCell *cCell = (CardDetailsTableCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cCell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CardDetailsTableCell" owner:self options:nil];
            cCell = [nib objectAtIndex:0];
        }
        if([current.firstString length]>0)
        {
            cCell.cardNameLabel.text=[current firstString];
            cCell.CardTypeLabel.text=[current secondString];
            cCell.numberLabel.text=[current thirdString];
            cCell.validityLabel.text=[current fourthString];
            cCell.cvvLabel.text=[current fifthString];
            cCell.nameLabel.text=[current sixthString];
            
            
            
//            NSLog(@"%@ current.first",[current firstString]);
//            NSLog(@"%@ current.first",[current secondString]);
//            NSLog(@"%@ current.first",[current thirdString]);
//            NSLog(@"%@ current.first",[current fourthString]);
//            NSLog(@"%@ current.first",[current fifthString]);
//            NSLog(@"%@ current.first",[current sixthString]);
        }
        return cCell;
    }
     return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([selectedDBTable isEqualToString:@"CardDetailsTableCell"])
    {
        return 264;
    }
    if([selectedDBTable isEqualToString:@"SecurityQuestions"])
    {
        return 123.0;
    }
    else
    {
        return 264;
    }
    
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
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[DetailViewController alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
