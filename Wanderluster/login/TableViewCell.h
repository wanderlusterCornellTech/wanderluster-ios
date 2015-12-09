//
//  TableViewCell.h
//  login
//
//  Created by liudan.xiao on 12/1/15.
//  Copyright © 2015 liudan.xiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (nonatomic, weak) IBOutlet UILabel *city;
@property (nonatomic, weak) IBOutlet UILabel *date;
@property (nonatomic, weak) IBOutlet UILabel *submitdate;
@property (nonatomic, weak) IBOutlet UILabel *needcar;

@end
