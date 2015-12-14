//
//  QuestionsTableCell.m
//  MyCredentials
//
//  Created by Karthik on 8/27/13.
//  Copyright (c) 2013 JRKKarthik. All rights reserved.
//

#import "QuestionsTableCell.h"

@implementation QuestionsTableCell
@synthesize userNameLabel,questionLabel,answerLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
