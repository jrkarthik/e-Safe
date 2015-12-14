//
//  SecurityQuestionsViewController.m
//  MyCredentials
//
//  Created by Karthik on 8/22/13.
//  Copyright (c) 2013 JRKKarthik. All rights reserved.
//

#import "SecurityQuestionsViewController.h"
#import "ListViewController.h"
@interface SecurityQuestionsViewController ()

@end

@implementation SecurityQuestionsViewController

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
    
    appDelObj=(AppDelegate*)[[UIApplication sharedApplication]delegate];
    dataBasePath = [appDelObj getDBPathFromBundleDirectory];
    
    scrollView =[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, 560)];
    scrollView.contentSize = CGSizeMake(320, 600);
    scrollView.delegate = self;
    scrollView.showsVerticalScrollIndicator=YES;
    scrollView.scrollEnabled=YES;
    scrollView.userInteractionEnabled=YES;
    
    self.navigationItem.title=@"Security Questions";
    siteField =[[UITextField alloc]initWithFrame:CGRectMake(20, 20, 245, 30)];
    siteField.borderStyle = UITextBorderStyleRoundedRect;
    siteField.placeholder = @"Enter Site *";
    siteField.delegate=self;
    
    userIDField=[[UITextField alloc]initWithFrame:CGRectMake(20, 64, 245, 30)];
    userIDField.borderStyle = UITextBorderStyleRoundedRect;
    userIDField.placeholder = @"Enter Username *";
    userIDField.delegate=self;
    
    questionField =[[UITextView alloc]initWithFrame:CGRectMake(20, 140, 245, 95)];
    answerField =[[UITextView alloc]initWithFrame:CGRectMake(20, 285, 245, 95)];
    questionField.layer.borderWidth = 1.0f;
    questionField.layer.borderColor = [[UIColor blackColor] CGColor];
    questionField.layer.cornerRadius = 18;
    questionField.delegate=self;
    answerField.layer.borderWidth = 1.0f;
    answerField.layer.borderColor = [[UIColor blackColor] CGColor];
    answerField.layer.cornerRadius = 18;
    answerField.delegate=self;

    
    qLabel =[[UILabel alloc]initWithFrame:CGRectMake(25, 111, 240, 21)];
    [qLabel setBackgroundColor:[UIColor clearColor]];
    qLabel.text = @"Enter the Question :";
    
    ansLabel =[[UILabel alloc]initWithFrame:CGRectMake(25, 256, 240, 21)];
    [ansLabel setBackgroundColor:[UIColor clearColor]];
    ansLabel.text = @"Enter the Answer :";

    saveButton =[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [saveButton setFrame:CGRectMake(110, 413, 100, 40)];
    [saveButton setBackgroundImage:[UIImage imageNamed:@"save.png"] forState:UIControlStateNormal];
    [saveButton addTarget:self action:@selector(saveAction:) forControlEvents:UIControlEventTouchUpInside];
    
//    CGRect frame = CGRectMake(0.0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
//    backgroundView = [[UIView alloc] initWithFrame:frame];
//    [backgroundView setBackgroundColor:[[UIColor alloc] initWithRed:204./255 green:213./255 blue:216./255 alpha:0.5]];

    [scrollView addSubview:backgroundView];
    [scrollView addSubview:siteField];
    [scrollView addSubview:userIDField];
    [scrollView addSubview:questionField];
    [scrollView addSubview:answerField];
    [scrollView addSubview:qLabel];
    [scrollView addSubview:ansLabel];
    [scrollView addSubview:saveButton];
    [self.view addSubview:scrollView];
}

-(IBAction)saveAction:(id)sender
{
    
    NSLog(@" site %@",siteField.text);
    if (!([siteField.text isEqualToString:@""]||[userIDField.text isEqualToString:@""]||[questionField.text isEqualToString:@""]||[answerField.text isEqualToString:@""]))
    {
        sqlite3 *sqliteObj;
        const char *dbpath = [dataBasePath UTF8String];
        sqlite3_stmt *stmt;
        if(sqlite3_open(dbpath, &sqliteObj) == SQLITE_OK)
        {
            questionField.text =  [questionField.text stringByReplacingOccurrencesOfString:@"'" withString:@"//"];
            answerField.text =  [answerField.text stringByReplacingOccurrencesOfString:@"'" withString:@"//"];
            NSString *insertSQL = [NSString stringWithFormat: @"INSERT INTO SecurityQuestions values ('%@','%@','%@','%@')",siteField.text,userIDField.text,questionField.text,answerField.text];
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
        questionField.text =@"";
        answerField.text=@"";
        siteField.text=@"";
        userIDField.text=@"";
        UIAlertView *alert =[[UIAlertView alloc]initWithTitle:nil message:@"Successfully saved" delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
        [alert show];
        alert.tag=1;
    }
    else
    {
        UIAlertView *alert =[[UIAlertView alloc]initWithTitle:nil message:@"It is mandatory to enter all fields, so as to save." delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
        [alert show];
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == siteField)
    {
        [siteField resignFirstResponder];
        [userIDField becomeFirstResponder];
    }
    else if (textField == userIDField)
    {
        [userIDField resignFirstResponder];
        [questionField becomeFirstResponder];
    }
    return YES;
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if(textView == answerField)
    {
        [scrollView setContentOffset:CGPointMake(0, 100) animated:YES];
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if(textView == questionField)
    {
        if([text isEqualToString:@"\n"])
        {
            [questionField resignFirstResponder];
            [answerField becomeFirstResponder];
        }
    }
    if(textView == answerField)
    {
        if([text isEqualToString:@"\n"])
        {
            [answerField resignFirstResponder];
            [scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        }
    }
    return YES;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(alertView.tag==1)
    {
        if (buttonIndex == 0)
        {
            lVC =[[ListViewController alloc]init];
            [self.navigationController pushViewController:lVC animated:YES];
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
