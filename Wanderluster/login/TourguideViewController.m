//
//  TourguideViewController.m
//  login
//
//  Created by liudan.xiao on 11/30/15.
//  Copyright © 2015 liudan.xiao. All rights reserved.
//

#import "TourguideViewController.h"
//#import "AFNetworking.h"

@interface TourguideViewController ()
@property (weak, nonatomic) IBOutlet UITextField *mobile;
@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UITextField *city;
@property (weak, nonatomic) IBOutlet UISwitch *car;
@end

@implementation TourguideViewController{
    NSString *ServerIP;
    AFHTTPRequestOperationManager *AFmanager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.mobile.placeholder = @"mobile";
    self.email.placeholder = @"xxx@xxx.com";
    self.city.placeholder = @"New York City";
    AFmanager = [AFHTTPRequestOperationManager manager];
    ServerIP = @"http://54.86.181.199:80/api/";
    //[self.view endEditing:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)post:(id)sender {
    NSString *phonenumber = self.mobile.text;
    NSString *emailaddress = self.email.text;
    NSString *ccity = self.city.text;
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:phonenumber forKey:@"Phone"];
    [userDefaults setObject:emailaddress forKey:@"emailaddress"];
    
    NSMutableString *URLConstruction = [NSMutableString string];
    [URLConstruction appendString:[ServerIP stringByAppendingString: @"match/"]];
    if (self.car.isOn) {
        [URLConstruction appendString:@"true/"];
    }
    else {
        [URLConstruction appendString:@"false/"];
    }
    [URLConstruction appendString:ccity];
    NSLog(@"%@", URLConstruction);
    [AFmanager GET:URLConstruction
         parameters:nil
            success:^(AFHTTPRequestOperation *operation, id responseObject) {
                NSArray *responseArray = responseObject;
                NSLog(@"%@", responseArray);
                //[GlobalVariables sharedInstance].matchedRequestSet = responseArray;
                [userDefaults setObject:responseArray forKey:@"matchedRequestSet"];
                //NSLog(@"%lu", [[GlobalVariables sharedInstance].matchedRequestSet count]);
                //[GlobalVariables sharedInstance].x = [responseArray count];
                [self performSegueWithIdentifier: @"post2" sender:nil ];
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                NSLog(@"Error: %@", error);
            }];

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
