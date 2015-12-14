//
//  QuestionsTableCell.h
//  MyCredentials
//
//  Created by Karthik on 8/27/13.
//  Copyright (c) 2013 JRKKarthik. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuestionsTableCell : UITableViewCell
@property (nonatomic, weak) IBOutlet UILabel *userNameLabel;
@property (nonatomic, weak) IBOutlet UILabel *questionLabel;
@property (nonatomic, weak) IBOutlet UILabel *answerLabel;

@end
