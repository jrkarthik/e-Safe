//
//  CardDetailsTableCell.h
//  MyCredentials
//
//  Created by Karthik on 8/29/13.
//  Copyright (c) 2013 JRKKarthik. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CardDetailsTableCell : UITableViewCell
@property (nonatomic, weak) IBOutlet UILabel *cardNameLabel;
@property (nonatomic, weak) IBOutlet UILabel *CardTypeLabel;
@property (nonatomic, weak) IBOutlet UILabel *numberLabel;
@property (nonatomic, weak) IBOutlet UILabel *validityLabel;
@property (nonatomic, weak) IBOutlet UILabel *cvvLabel;
@property (nonatomic, weak) IBOutlet UILabel *nameLabel;

@end
