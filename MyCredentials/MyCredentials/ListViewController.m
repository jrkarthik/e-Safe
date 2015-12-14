//
//  ListViewController.m
//  MyCredentials
//
//  Created by Karthik on 8/12/13.
//  Copyright (c) 2013 JRKKarthik. All rights reserved.
//

#import "ListViewController.h"
#import "DetailTableViewController.h"

#import "SettingsViewController.h"
@class AppDelegate;

@interface ListViewController ()

@end

@implementation ListViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    dVCObject=[[DetailTableViewController alloc]init];
    
    textField1 = [[UITextField alloc] initWithFrame:CGRectMake(16,53,252,30)];
    textField1.borderStyle = UITextBorderStyleRoundedRect;
    textField1.keyboardAppearance = UIKeyboardAppearanceAlert;
    textField1.delegate = self;
    
    textField2 = [[UITextField alloc] initWithFrame:CGRectMake(16,88,252,30)];
    textField2.borderStyle = UITextBorderStyleRoundedRect;
    textField2.keyboardAppearance = UIKeyboardAppearanceAlert;
    textField2.delegate = self;
    
    textField3 = [[UITextField alloc] initWithFrame:CGRectMake(16,123,252,30)];
    textField3.borderStyle = UITextBorderStyleRoundedRect;
    textField3.keyboardAppearance = UIKeyboardAppearanceAlert;
    textField3.delegate = self;
    
    self.navigationController.navigationBar.tintColor= [UIColor blackColor];
    //[self.navigationController.navigationBar setTranslucent:YES];

    
    UIBarButtonItem *settingsButton=[[UIBarButtonItem alloc]initWithTitle:@"Options" style:UIBarButtonItemStyleBordered target:self action:@selector(useOptions:)];
    self.navigationItem.rightBarButtonItem = settingsButton;
    
    
    listArray =[[NSMutableArray alloc]init];
    appDelObj=(AppDelegate*)[[UIApplication sharedApplication]delegate];
    dataBasePath = [appDelObj getDBPathFromBundleDirectory];
    self.navigationItem.title=@"List";
    listTable =[[UITableView alloc]initWithFrame:CGRectMake(0, 60, 320, 568) style:UITableViewStylePlain];
    listTable.delegate=self;
    listTable.dataSource=self;
    [listTable setBackgroundColor:[UIColor blackColor]];
    listTable.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.view addSubview:listTable];
    
    sqlite3_stmt *stmt2;
    const char *dbpath = [dataBasePath UTF8String];
    if(sqlite3_open(dbpath, &sqliteObject2) == SQLITE_OK)
    {
        NSString *selectSQL = [NSString stringWithFormat: @"select * from MainList"];
        const char *select_stmt = [selectSQL UTF8String];
        if(sqlite3_prepare_v2(sqliteObject2, select_stmt, -1, &stmt2, NULL) == SQLITE_OK)
        {
            while(sqlite3_step(stmt2) == SQLITE_ROW)
            {
                [listArray addObject:[NSString stringWithFormat:@"%s",(char *) sqlite3_column_text(stmt2, 0)]];
            }
            sqlite3_finalize(stmt2);
        }
    }
    sqlite3_close(sqliteObject2);
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.navigationItem.hidesBackButton=YES;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [listArray count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 54;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text=[listArray objectAtIndex:indexPath.row];
    cell.textLabel.font = [UIFont fontWithName:@"ArialMT" size:16];
    cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    //cell.textLabel.font = [UIFont systemFontOfSize:16];
    cell.textLabel.textColor = [UIColor blackColor];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIAlertView *alert;
    dVCObject.selectedItem=[listArray objectAtIndex:indexPath.row];
    textField1.text=@"";
    textField2.text=@"";
    textField3.text=@"";
    [listTable deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row)
    {
        case 0:
            alert = [[UIAlertView alloc]initWithTitle:@"Social Networking Site Details" message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Add",@"View", nil];
            alert.tag = 00;
            [alert show];
            break;
        case 1:
            alert = [[UIAlertView alloc]initWithTitle:@"Bank Account Details" message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Add",@"View", nil];
            alert.tag = 01;
            [alert show];
            break;
        case 2:
            alert = [[UIAlertView alloc]initWithTitle:@"Credit/Debit Card Details" message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Add",@"View", nil];
            alert.tag = 02;
            [alert show];
            break;
        case 3:
            alert = [[UIAlertView alloc]initWithTitle:@"Bank Locker Details" message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Add",@"View", nil];
            alert.tag = 03;
            [alert show];
            break;
        case 4:
            alert = [[UIAlertView alloc]initWithTitle:@"Identity Proof Details" message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Add",@"View", nil];
            alert.tag = 04;
            [alert show];
            break;
        case 5:
            alert = [[UIAlertView alloc]initWithTitle:@"Online Banking Details" message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Add",@"View", nil];
            alert.tag = 05;
            [alert show];
            break;
        case 6:
            alert = [[UIAlertView alloc]initWithTitle:@"Security Questions Details" message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Add",@"View", nil];
            alert.tag = 06;
            [alert show];
            break;
        case 7:
            alert = [[UIAlertView alloc]initWithTitle:@"Personal Notes" message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Add",@"View", nil];
            alert.tag = 07;
            [alert show];
            break;
            
        default:
            break;
    
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    UIAlertView *message;
    
    
    switch (alertView.tag)
    {
        case 00:
        {
            if (buttonIndex == 1)
            {
                message = [[UIAlertView alloc] initWithTitle:@"Social site details"
                                                     message:@"\n\n\n\n\n"
                                                    delegate:self
                                           cancelButtonTitle:@"Cancel"
                                           otherButtonTitles:@"OK", nil];
                
                textField1.placeholder = @"Site *";
                [message addSubview:textField1];
                
                textField2.placeholder = @"UserName *";
                [message addSubview:textField2];
                
                textField3.placeholder = @"Password *";
                [message addSubview:textField3];
                message.tag=0010;
            }
            if(buttonIndex == 2)
            {
                dVCObject.detailIDNo=1;
                
                [self.navigationController pushViewController:dVCObject animated:YES];
                //View Code goes here
            }
        }
            break;
            
        case 01:
        {
            if (buttonIndex == 1)
            {
                message = [[UIAlertView alloc] initWithTitle:@"Bank account details"
                                                     message:@"\n\n\n\n\n"
                                                    delegate:self
                                           cancelButtonTitle:@"Cancel"
                                           otherButtonTitles:@"OK", nil];
                
                textField1.placeholder = @"Bank Name *";
                [message addSubview:textField1];
                
                textField2.placeholder = @"A/C No *";
                [message addSubview:textField2];
                
                textField3.placeholder = @"IFSC Code";
                [message addSubview:textField3];
                message.tag=0011;
            }
            if(buttonIndex == 2)
            {
                dVCObject. detailIDNo=2;
                [self.navigationController pushViewController:dVCObject animated:YES];
                //View Code goes here
            }
        }
            break;
            
        case 02:
        {
            if (buttonIndex == 1)
            {
                cVCObject =[[CardsViewController alloc]init];
                [self.navigationController pushViewController:cVCObject animated:YES];
            }
            if(buttonIndex == 2)
            {
                message = [[UIAlertView alloc] initWithTitle:@"Select Card"
                                                     message:nil
                                                    delegate:self
                                           cancelButtonTitle:@"Cancel"
                                           otherButtonTitles:@"Credit",@"Debit", nil];
                message.tag=0012;
               /* dVCObject.detailIDNo=3;
                [self.navigationController pushViewController:dVCObject animated:YES];*/
            }
        }
            break;
            
        case 03:
        {
            if (buttonIndex == 1)
            {
                message = [[UIAlertView alloc] initWithTitle:@"Bank Locker Details"
                                                     message:@"\n\n\n\n\n"
                                                    delegate:self
                                           cancelButtonTitle:@"Cancel"
                                           otherButtonTitles:@"OK", nil];
                
                textField1.placeholder = @"Bank Name *";
                [message addSubview:textField1];
                
                textField2.placeholder = @"Branch";
                [message addSubview:textField2];
                
                textField3.placeholder = @"Locker Number *";
                [message addSubview:textField3];
                
                message.tag=0013;
                
            }
            if(buttonIndex == 2)
            {
                dVCObject.detailIDNo=4;
                [self.navigationController pushViewController:dVCObject animated:YES];
                
                //View Code goes here
            }
        }
            break;
            
        case 04:
        {
            if (buttonIndex == 1)
            {
                message = [[UIAlertView alloc] initWithTitle:@"Identity Proof details"
                                                     message:@"\n\n\n\n\n"
                                                    delegate:self
                                           cancelButtonTitle:@"Cancel"
                                           otherButtonTitles:@"OK", nil];
                
                textField1.placeholder = @"Identity Type *";
                [message addSubview:textField1];
                
                textField2.placeholder = @"Number *";
                [message addSubview:textField2];
                
                textField3.placeholder = @"Validity";
                [message addSubview:textField3];
                
                message.tag=0014;
                
            }
            if(buttonIndex == 2)
            {
                dVCObject.detailIDNo=5;
                [self.navigationController pushViewController:dVCObject animated:YES];
                
                //View Code goes here
            }
        }
            break;
            
        case 05:
        {
            if (buttonIndex == 1)
            {
                message = [[UIAlertView alloc] initWithTitle:@"Online Banking details"
                                                     message:@"\n\n\n\n\n"
                                                    delegate:self
                                           cancelButtonTitle:@"Cancel"
                                           otherButtonTitles:@"OK", nil];
                
                textField1.placeholder = @"Bank *";
                [message addSubview:textField1];
                
                textField2.placeholder = @"UserName *";
                [message addSubview:textField2];
                
                textField3.placeholder = @"Password *";
                [message addSubview:textField3];
                
                message.tag=0015;
            }
            if(buttonIndex == 2)
            {
                dVCObject.detailIDNo=6;
                [self.navigationController pushViewController:dVCObject animated:YES];
                
                //View Code goes here
            }
        }
            break;
            
        case 06:
        {
            if (buttonIndex == 1)
            {
                sQVCObject=[[SecurityQuestionsViewController alloc]init];
                [self.navigationController pushViewController:sQVCObject animated:YES];
            }
            if(buttonIndex == 2)
            {
                dVCObject.detailIDNo=7;
                [self.navigationController pushViewController:dVCObject animated:YES];
            }
        }
            break;
        case 07:
        {
            if (buttonIndex == 1)
            {
                aVCObject=[[AddViewController alloc]init];
                [self.navigationController pushViewController:aVCObject animated:YES];
            }
            if(buttonIndex == 2)
            {
                tVCObject=[[TableViewController alloc]init];
                [self.navigationController pushViewController:tVCObject animated:YES];
            }
        }
            break;
        case 0010:
        {
            if (!([textField1.text isEqualToString:@""]||[textField2.text isEqualToString:@""]||[textField3.text isEqualToString:@""]))
            {
                if (buttonIndex == 1)
                {
                    sqlite3 *sqliteObj;
                    const char *dbpath = [dataBasePath UTF8String];
                    sqlite3_stmt *stmt;
                    if(sqlite3_open(dbpath, &sqliteObj) == SQLITE_OK)
                    {
                        NSString *insertSQL = [NSString stringWithFormat: @"INSERT INTO SocialNetworking values ('%@','%@','%@')",textField1.text,textField2.text,textField3.text];
                        const char *insert_stmt=[insertSQL UTF8String];
                        if(sqlite3_prepare_v2(sqliteObj, insert_stmt, -1, &stmt, NULL)==SQLITE_OK)
                        {
                            while(sqlite3_step(stmt) == SQLITE_DONE)
                            {
                                NSLog(@"Credentials INSERTION DONE");
                            }
                        }
                        sqlite3_finalize(stmt);
                    }
                    sqlite3_close(sqliteObj);
                }
            }
            else
            {
                if (buttonIndex == 1)
                {
                    message = [[UIAlertView alloc]initWithTitle:nil message:@"The * Fields are mandatory" delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
                    message.tag=0100;
                }
            }
        }
            break;
        case 0011:
        {
            if (!([textField1.text isEqualToString:@""]||[textField2.text isEqualToString:@""]||[textField3.text isEqualToString:@""]))
            {
                if (buttonIndex == 1)
                {
                    sqlite3 *sqliteObj;
                    const char *dbpath = [dataBasePath UTF8String];
                    sqlite3_stmt *stmt;
                    if(sqlite3_open(dbpath, &sqliteObj) == SQLITE_OK)
                    {
                        NSString *insertSQL = [NSString stringWithFormat: @"INSERT INTO BankAccountDetails values ('%@','%@','%@')",textField1.text,textField2.text,textField3.text];
                        NSLog(@"insertSQL %@",insertSQL);
                        const char *insert_stmt=[insertSQL UTF8String];
                        if(sqlite3_prepare_v2(sqliteObj, insert_stmt, -1, &stmt, NULL)==SQLITE_OK)
                        {
                            while(sqlite3_step(stmt) == SQLITE_DONE)
                            {
                                NSLog(@"Credentials INSERTION DONE");
                            }
                        }
                        sqlite3_finalize(stmt);
                    }
                    sqlite3_close(sqliteObj);
                }
            }
            else
            {
                if (buttonIndex == 1)
                {
                    message = [[UIAlertView alloc]initWithTitle:nil message:@"The * Fields are mandatory" delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
                    message.tag=0100;
                }
            }
        }
            break;
        case 0012:
        {
            if (buttonIndex==1)
            {
                NSLog(@"Credit card tapped");
                dVCObject.detailIDNo=9;
                [self.navigationController pushViewController:dVCObject animated:YES];
            }
            if(buttonIndex ==2)
            {
                NSLog(@"Debit card tapped");
                dVCObject.detailIDNo=10;
                [self.navigationController pushViewController:dVCObject animated:YES];
            }
        }
            break;
        case 0013:
        {
            if (!([textField1.text isEqualToString:@""]||[textField2.text isEqualToString:@""]||[textField3.text isEqualToString:@""]))
            {
                if (buttonIndex == 1)
                {
                    sqlite3 *sqliteObj;
                    const char *dbpath = [dataBasePath UTF8String];
                    sqlite3_stmt *stmt;
                    if(sqlite3_open(dbpath, &sqliteObj) == SQLITE_OK)
                    {
                        NSString *insertSQL = [NSString stringWithFormat: @"INSERT INTO BankLockerDetails values ('%@','%@','%@')",textField1.text,textField2.text,textField3.text];
                        const char *insert_stmt=[insertSQL UTF8String];
                        if(sqlite3_prepare_v2(sqliteObj, insert_stmt, -1, &stmt, NULL)==SQLITE_OK)
                        {
                            while(sqlite3_step(stmt) == SQLITE_DONE)
                            {
                                NSLog(@"Credentials INSERTION DONE");
                            }
                        }
                        sqlite3_finalize(stmt);
                    }
                    sqlite3_close(sqliteObj);
                }
            }
            else
            {
                if (buttonIndex == 1)
                {
                    message = [[UIAlertView alloc]initWithTitle:nil message:@"The * Fields are mandatory" delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
                    message.tag=0100;
                }
            }
        }
            break;
        case 0014:
        {
            if (!([textField1.text isEqualToString:@""]||[textField2.text isEqualToString:@""]||[textField3.text isEqualToString:@""]))
            {
                if (buttonIndex == 1)
                {
                    sqlite3 *sqliteObj;
                    const char *dbpath = [dataBasePath UTF8String];
                    sqlite3_stmt *stmt;
                    if(sqlite3_open(dbpath, &sqliteObj) == SQLITE_OK)
                    {
                        NSString *insertSQL = [NSString stringWithFormat: @"INSERT INTO IdentityProofDetails values ('%@','%@','%@')",textField1.text,textField2.text,textField3.text];
                        const char *insert_stmt=[insertSQL UTF8String];
                        if(sqlite3_prepare_v2(sqliteObj, insert_stmt, -1, &stmt, NULL)==SQLITE_OK)
                        {
                            while(sqlite3_step(stmt) == SQLITE_DONE)
                            {
                                NSLog(@"Credentials INSERTION DONE");
                            }
                        }
                        sqlite3_finalize(stmt);
                    }
                    sqlite3_close(sqliteObj);
                }
            }
            else
            {
                if (buttonIndex == 1)
                {
                    message = [[UIAlertView alloc]initWithTitle:nil message:@"The * Fields are mandatory" delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
                    message.tag=0100;
                }
            }
        }
            break;
        case 0015:
        {
            if (!([textField1.text isEqualToString:@""]||[textField2.text isEqualToString:@""]||[textField3.text isEqualToString:@""]))
            {
                if (buttonIndex == 1)
                {
                    sqlite3 *sqliteObj;
                    const char *dbpath = [dataBasePath UTF8String];
                    sqlite3_stmt *stmt;
                    if(sqlite3_open(dbpath, &sqliteObj) == SQLITE_OK)
                    {
                        NSString *insertSQL = [NSString stringWithFormat: @"INSERT INTO OnlineBankingDetails values ('%@','%@','%@')",textField1.text,textField2.text,textField3.text];
                        const char *insert_stmt=[insertSQL UTF8String];
                        if(sqlite3_prepare_v2(sqliteObj, insert_stmt, -1, &stmt, NULL)==SQLITE_OK)
                        {
                            while(sqlite3_step(stmt) == SQLITE_DONE)
                            {
                                NSLog(@"Credentials INSERTION DONE");
                            }
                        }
                        sqlite3_finalize(stmt);
                    }
                    sqlite3_close(sqliteObj);
                }
            }
            else
            {
                if (buttonIndex == 1)
                {
                    message = [[UIAlertView alloc]initWithTitle:nil message:@"The * Fields are mandatory" delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
                    message.tag=0100;
                }
            }
        }
            break;
      }
    [message show];
}
-(IBAction)useOptions:(id)sender
{
   //[self  presentModalViewController:navController animated:YES];
}
/*
 textField1 = [[UITextField alloc] initWithFrame:CGRectMake(16,53,252,30)];
 textField1.placeholder = @"Site";
 textField1.borderStyle = UITextBorderStyleRoundedRect;
 textField1.keyboardAppearance = UIKeyboardAppearanceAlert;
 textField1.delegate = self;
 [message addSubview:textField1];
 
 textField2 = [[UITextField alloc] initWithFrame:CGRectMake(16,88,252,30)];
 textField2.placeholder = @"UserName";
 textField2.borderStyle = UITextBorderStyleRoundedRect;
 textField2.keyboardAppearance = UIKeyboardAppearanceAlert;
 textField2.delegate = self;
 [message addSubview:textField2];
 
 textField3 = [[UITextField alloc] initWithFrame:CGRectMake(16,123,252,30)];
 textField3.placeholder = @"Password";
 textField3.borderStyle = UITextBorderStyleRoundedRect;
 textField3.keyboardAppearance = UIKeyboardAppearanceAlert;
 textField3.delegate = self;
 [message addSubview:textField3];
 */
@end