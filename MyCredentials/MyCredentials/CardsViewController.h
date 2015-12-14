//
//  CardsViewController.h
//  MyCredentials
//
//  Created by Karthik on 8/26/13.
//  Copyright (c) 2013 JRKKarthik. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import <sqlite3.h>
@class ListViewController;

@interface CardsViewController : UIViewController<UIPickerViewDataSource,UIPickerViewDelegate,UITextFieldDelegate,UIScrollViewDelegate>
{
    UILabel *bankLbl,*cardLbl,*cardTypeLbl,*numberLbl,*cvvLbl,*validityLbl,*name,*pickerLbl,*datePickerLbl;
    UIPickerView *cardType;
    UITextField *bank,*cardNumber,*cvv,*cardHolderName,*validity;
    UISegmentedControl *card;
    UIButton *saveButton,*updateBtn,*pickerBtn;
    
    UIView *backgroundView;
    UIView *Viewpicker;
    
    UIScrollView *scrollView;
    NSArray *cardTypeArray;
    
    AppDelegate *appDelObj;
    NSString *dataBasePath;
    sqlite3 *sqliteObject;
    
    ListViewController *lVC;
}

@end
