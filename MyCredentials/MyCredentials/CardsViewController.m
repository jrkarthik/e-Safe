//
//  CardsViewController.m
//  MyCredentials
//
//  Created by Karthik on 8/26/13.
//  Copyright (c) 2013 JRKKarthik. All rights reserved.
//

#import "CardsViewController.h"
#import "ListViewController.h"

@interface CardsViewController ()

@end

@implementation CardsViewController

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
    //scrollView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"00029.jpg"]];
    
    cardTypeArray= [[NSMutableArray alloc]initWithObjects:@"Visa",@"Master",@"Maestro", nil];
    
    bankLbl     =[[UILabel alloc]initWithFrame:CGRectMake(20, 10, 56, 27)];
    [bankLbl setBackgroundColor:[UIColor clearColor]];
    bankLbl.text=@"Bank";
    bankLbl.textColor = [UIColor colorWithRed:188 green:149 blue:88 alpha:1.0];
    cardLbl     =[[UILabel alloc]initWithFrame:CGRectMake(20, 52, 89, 25)];
    [cardLbl setBackgroundColor:[UIColor clearColor]];
    cardLbl.text=@"Card";
    cardLbl.textColor = [UIColor colorWithRed:188 green:149 blue:88 alpha:1.0];
    cardTypeLbl =[[UILabel alloc]initWithFrame:CGRectMake(20, 92, 99, 27)];
    cardTypeLbl.text=@"Card Type";
    cardTypeLbl.textColor = [UIColor colorWithRed:188 green:149 blue:88 alpha:1.0];
    [cardTypeLbl setBackgroundColor:[UIColor clearColor]];
    numberLbl   =[[UILabel alloc]initWithFrame:CGRectMake(20, 139, 99, 27)];
    numberLbl.text=@"Number";
    numberLbl.textColor = [UIColor colorWithRed:188 green:149 blue:88 alpha:1.0];
    [numberLbl setBackgroundColor:[UIColor clearColor]];
    cvvLbl =[[UILabel alloc]initWithFrame:CGRectMake(20, 195, 65, 27)];
    cvvLbl.text=@"CVV";
    cvvLbl.textColor = [UIColor colorWithRed:188 green:149 blue:88 alpha:1.0];
    [cvvLbl setBackgroundColor:[UIColor clearColor]];
    validityLbl =[[UILabel alloc]initWithFrame:CGRectMake(20, 263, 65, 27)];
    validityLbl.text=@"Validity";
    validityLbl.textColor = [UIColor colorWithRed:188 green:149 blue:88 alpha:1.0];
    [validityLbl setBackgroundColor:[UIColor clearColor]];
    name        =[[UILabel alloc]initWithFrame:CGRectMake(20, 314, 65, 27)];
    name.text=@"Name";
    name.textColor = [UIColor colorWithRed:188 green:149 blue:88 alpha:1.0];
    [name setBackgroundColor:[UIColor clearColor]];
    
    pickerLbl   =[[UILabel alloc]initWithFrame:CGRectMake(127, 92, 122, 27)];
    pickerLbl.textColor = [UIColor colorWithRed:188 green:149 blue:88 alpha:1.0];
    [pickerLbl setBackgroundColor:[UIColor clearColor]];
    
    datePickerLbl   =[[UILabel alloc]initWithFrame:CGRectMake(127, 263, 122, 27)];
    datePickerLbl.textColor = [UIColor colorWithRed:188 green:149 blue:88 alpha:1.0];
    [datePickerLbl setBackgroundColor:[UIColor clearColor]];

    pickerBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    pickerBtn.frame=CGRectMake(273, 88, 27, 30);
    [pickerBtn addTarget:self action:@selector(pickerAction:) forControlEvents:UIControlEventTouchUpInside];
 
    NSArray *segmentArray=[[NSArray alloc] initWithObjects:@"Credit",@"Debit", nil];
    card=[[UISegmentedControl alloc]initWithItems:segmentArray];
    card.frame=CGRectMake(127, 45, 173, 30);
    card.selectedSegmentIndex = 0;
    
    bank =[[UITextField alloc]initWithFrame:CGRectMake(124, 7, 176, 30)];
    cardNumber =[[UITextField alloc]initWithFrame:CGRectMake(124, 135, 176, 30)];
    cvv =[[UITextField alloc]initWithFrame:CGRectMake(124, 191, 176, 30)];
    cardHolderName =[[UITextField alloc]initWithFrame:CGRectMake(124, 310, 176, 30)];
    validity =[[UITextField alloc]initWithFrame:CGRectMake(124, 263, 176, 30)];
    validity.borderStyle=UITextBorderStyleRoundedRect;
    bank.borderStyle = UITextBorderStyleRoundedRect;
    cardNumber.borderStyle = UITextBorderStyleRoundedRect;
    cvv.borderStyle = UITextBorderStyleRoundedRect;
    cardHolderName.borderStyle = UITextBorderStyleRoundedRect;
    bank.delegate=self;
    cardNumber.delegate=self;
    cvv.delegate=self;
    validity.delegate=self;
    cardHolderName.delegate=self;
    

    saveButton =[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [saveButton setFrame:CGRectMake(110, 413, 100, 40)];
    [saveButton setBackgroundImage:[UIImage imageNamed:@"save.png"] forState:UIControlStateNormal];
    [saveButton addTarget:self action:@selector(saveAction:) forControlEvents:UIControlEventTouchUpInside];

    
    [scrollView addSubview:backgroundView];
    [scrollView addSubview:bankLbl];
    [scrollView addSubview:cardLbl];
    [scrollView addSubview:cardTypeLbl];
    [scrollView addSubview:numberLbl];
    [scrollView addSubview:cvvLbl];
    [scrollView addSubview:validityLbl];
    [scrollView addSubview:pickerLbl];
    [scrollView addSubview:name];
    [scrollView addSubview:pickerBtn];
    [scrollView addSubview:validity];
    [scrollView addSubview:card];
    [scrollView addSubview:bank];
    [scrollView addSubview:cardNumber];
    [scrollView addSubview:cvv];
    [scrollView addSubview:cardHolderName];
    [scrollView addSubview:saveButton];
    [self.view addSubview:scrollView];
    
}

-(IBAction)pickerAction:(id)sender
{
    Viewpicker =[[UIView alloc]initWithFrame:CGRectMake(20, 179, 280, 259)];
    cardType =[[UIPickerView alloc]initWithFrame:CGRectMake(0, 44, 280, 216)];
    cardType.showsSelectionIndicator =YES;
    cardType.delegate=self;
    cardType.dataSource=self;
    UIToolbar *toolBar=[[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 280, 44)];
    UIBarButtonItem *barButton=[[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelAction:)];
    NSMutableArray *buttons = [[NSMutableArray alloc ]init];
    [buttons addObject:barButton];
    [toolBar setItems:buttons animated:NO];
    [Viewpicker addSubview:cardType];
    [Viewpicker addSubview:toolBar];
    [self.view addSubview:Viewpicker];
}

-(IBAction)cancelAction:(id)sender
{
    [Viewpicker removeFromSuperview];
}
-(IBAction)saveAction:(id)sender
{
   NSLog(@"%@", [card titleForSegmentAtIndex:card.selectedSegmentIndex]);
    
    if(!([bank.text length]==0||[cardNumber.text length]==0||[cardNumber.text length]==0||[cvv.text length]==0||[validity.text length]==0||[cardHolderName.text length]==0||[card titleForSegmentAtIndex:card.selectedSegmentIndex].length==0))
    {
        sqlite3 *sqliteObj;
        const char *dbpath = [dataBasePath UTF8String];
        sqlite3_stmt *stmt=nil;
        if(sqlite3_open(dbpath, &sqliteObj) == SQLITE_OK)
        {
            NSString *insertSQL = [NSString stringWithFormat: @"INSERT INTO CreditOrDebitCardDetails values ('%@','%@','%@','%@','%@','%@','%@')",bank.text,[card titleForSegmentAtIndex:card.selectedSegmentIndex],pickerLbl.text,cardNumber.text,cvv.text,validity.text,cardHolderName.text];
            const char *insertstmt=[insertSQL UTF8String];
            NSLog(@"%d",sqlite3_prepare_v2(sqliteObj, insertstmt, -1, &stmt, NULL));
            if(sqlite3_prepare_v2(sqliteObj, insertstmt, -1, &stmt, NULL)==SQLITE_OK)
            {
                while(sqlite3_step(stmt) == SQLITE_DONE)
                {
                    NSLog(@"Credentials INSERTION DONE");
                }
            }
            sqlite3_finalize(stmt);
        }
        sqlite3_close(sqliteObj);
        
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

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [cardTypeArray count];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    if(pickerView == cardType)
    {
        return 1;
    }
    else
    {
        return 2;
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [cardTypeArray objectAtIndex:row];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == bank)
    {
        [bank resignFirstResponder];
        [cardNumber becomeFirstResponder];
    }
    else if (textField == cardNumber)
    {
        [cardNumber resignFirstResponder];
        [cvv becomeFirstResponder];
    }
    else if(textField == cvv)
    {
        [cvv resignFirstResponder];
        [validity becomeFirstResponder];
    }
    else if (textField == validity)
    {
        [validity resignFirstResponder];
        [cardHolderName becomeFirstResponder];
    }
    else if (textField == cardHolderName)
    {
        [cardHolderName resignFirstResponder];
        [scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    }
    return YES;
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    [pickerLbl setText:[cardTypeArray objectAtIndex:row]];
    [self performSelector:@selector(cancelAction:) withObject:nil afterDelay:0.2];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [Viewpicker removeFromSuperview];
    if (textField == cardHolderName)
    {
        [scrollView setContentOffset:CGPointMake(0, 100) animated:YES];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
