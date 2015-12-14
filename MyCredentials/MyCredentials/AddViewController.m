//
//  AddViewController.m
//  MyCredentials
//
//  Created by Karthik on 8/13/13.
//  Copyright (c) 2013 JRKKarthik. All rights reserved.
//

#import "AddViewController.h"
#import "ListViewController.h"

@interface AddViewController ()
@end

@implementation AddViewController
@synthesize testVal;
@synthesize dateStr,notesStr;
UIBarButtonItem *saveButton;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    notesText =[[UITextView alloc]initWithFrame:CGRectMake(0, 60, 320, 230)];
    notesText.backgroundColor=[UIColor blackColor];
    [notesText setText:@"Enter Personal Notes"];
    //notesText.textColor = [UIColor whiteColor];
    
    [notesText setFont:[UIFont fontWithName:@"Noteworthy" size:18]];
    
    [self.view addSubview:notesText];
    [notesText setTextColor:[UIColor lightGrayColor]];
    self.view.backgroundColor = [UIColor blackColor];
    notesText.delegate=self;
    
    appDelObj=(AppDelegate*)[[UIApplication sharedApplication]delegate];
    dataBasePath = [appDelObj getDBPathFromBundleDirectory];
    
  
    if (![testVal isEqualToString:@"ShowSaveBtn"])
    {
       saveButton=[[UIBarButtonItem alloc]initWithTitle:@"Save" style:UIBarButtonItemStyleBordered target:self action:@selector(saveToDB:)];
        self.navigationItem.rightBarButtonItem = saveButton;
        saveButton.enabled=NO;
    }
    else
    {
        notesText.editable=NO;
        [notesText setFrame:CGRectMake(0, 0, 320, 560)];
        notesText.text =notesStr;
       self.navigationItem.title =dateStr;
    }
    // Do any additional setup after loading the view from its nib.
}

-(BOOL) textViewShouldBeginEditing:(UITextView *)textView
{
    if (notesText.textColor == [UIColor lightGrayColor])
    {
        notesText.text = @"";
        notesText.textColor = [UIColor whiteColor];
        [notesText setFont:[UIFont fontWithName:@"Noteworthy" size:18]];
    }
    return YES;
}

-(IBAction)saveToDB:(id)sender
{
    if (![notesText.text isEqualToString:@""])
    {
        NSDateFormatter *dateformatter= [[NSDateFormatter alloc]init];
        [dateformatter setDateFormat:@"EEE, d MMM yyyy HH:mm"];
        NSString *time= [dateformatter stringFromDate:[NSDate date]];
        const char *dbpath = [dataBasePath UTF8String];
        sqlite3_stmt *stmt;
        if(sqlite3_open(dbpath, &sqliteObj) == SQLITE_OK)
        {
            notesText.text =  [notesText.text stringByReplacingOccurrencesOfString:@"'" withString:@"//"];
            NSString *insertSQL = [NSString stringWithFormat: @"INSERT INTO PersonalNotes values ('%@','%@')",time,notesText.text];
            const char *insert_stmt=[insertSQL UTF8String];
            if(sqlite3_prepare_v2(sqliteObj, insert_stmt, -1, &stmt, NULL)==SQLITE_OK)
            {
                while(sqlite3_step(stmt) == SQLITE_DONE)
                {
                    NSLog(@"INSERTION DONE");
                }
            }
            sqlite3_finalize(stmt);
        }
        sqlite3_close(sqliteObj);
        notesText.text=@"";
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"Your note has been saved." delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
        [alert show];
        alert.tag=01;
    }
    else
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"Please enter some text inorder to save." delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
        [alert show];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (alertView.tag)
    {
        case 01:
            lvc =[[ListViewController alloc]init];
            [self.navigationController pushViewController:lvc animated:YES];
            break;
            
        default:
            break;
    }
}
- (void)textViewDidBeginEditing:(UITextView *)textView
{
  saveButton.enabled=YES;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
