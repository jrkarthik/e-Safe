//
// Copyright 2011-2012 Kosher Penguin LLC
// Created by Adar Porat (https://github.com/aporat) on 1/16/2012.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//

#import "SettingsViewController.h"
#import "KKPasscodeSettingsViewController.h"
#import "KKPasscodeLock.h"


@implementation SettingsViewController

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) || (toInterfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)doneButtonPressed:(id)sender {
    //[self dismissModalViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = NSLocalizedString(@"Options", nil);
    
    [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneButtonPressed:)];
    
    self.navigationItem.rightBarButtonItem = doneButton;
}

#pragma mark - Table view data source

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    return @"";
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
     return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    
    if (indexPath.section == 0)
    {
        cell.textLabel.text = NSLocalizedString(@"Passcode Lock", nil);
        if ([[KKPasscodeLock sharedLock] isPasscodeRequired])
        {
            cell.detailTextLabel.text = NSLocalizedString(@"On", nil);
        } else
        {
            cell.detailTextLabel.text = NSLocalizedString(@"Off", nil);
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    else
    {
        cell.textLabel.text = NSLocalizedString(@"Tell a Friend", nil); 
    }
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0)
    {
        KKPasscodeSettingsViewController *vc = [[KKPasscodeSettingsViewController alloc] initWithStyle:UITableViewStyleGrouped];
        vc.delegate = self;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else
    {
        UIActionSheet * actionSheet = [[UIActionSheet alloc]initWithTitle:@"Tell a friend about this App via" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Mail", nil];
        [actionSheet showInView:self.view];

        NSLog(@" Tell A friend");
    }
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex)
    {
        case 0:
        {
            NSString *theMessage =@"Try the e-Safe App. It can store all your passwords efficiently.";
            if ([MFMailComposeViewController canSendMail])
            {
                MFMailComposeViewController* mailController = [[MFMailComposeViewController alloc] init];
                mailController.mailComposeDelegate = self;
                [mailController setSubject:@"Hi!"];
                [mailController setMessageBody:theMessage isHTML:NO];
                [self presentViewController:mailController animated:YES completion:nil];
            }
            else
            {
                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Alert" message:@"You have not configured your mail in the device." delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
                [alert show];
            }
            break;
        }
        case 1:
        {
            NSLog(@"Meassage");
            break;
        
            
        default:
            break;
    }
  }
}
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    [self dismissViewControllerAnimated:YES completion:nil];
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Mail sent" delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
    [alert show];
}
- (void)didSettingsChanged:(KKPasscodeSettingsViewController*)viewController
{
    [self.tableView reloadData];
}

@end
