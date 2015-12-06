//
//  SuccessViewController.m
//  login
//
//  Created by liudan.xiao on 12/1/15.
//  Copyright © 2015 liudan.xiao. All rights reserved.
//

#import "SuccessViewController.h"

@interface SuccessViewController ()
@property (weak, nonatomic) IBOutlet UILabel *mail;
@property (weak, nonatomic) IBOutlet UILabel *phone;

@end

@implementation SuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    self.phone.text = [userDefaults stringForKey:@"touristphone"];
    self.mail.text = [userDefaults stringForKey:@"touristemailaddress"];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
