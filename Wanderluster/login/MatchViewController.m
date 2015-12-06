//
//  MatchViewController.m
//  login
//
//  Created by liudan.xiao on 11/30/15.
//  Copyright © 2015 liudan.xiao. All rights reserved.
//

#import "MatchViewController.h"
//#import "AFNetworking.h"
#import "TableViewCell.h"

@interface MatchViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *matchtableview;

@end

@implementation MatchViewController{
    NSString *ServerIP;
    AFHTTPRequestOperationManager *AFmanager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    AFmanager = [AFHTTPRequestOperationManager manager];
    ServerIP = @"http://54.86.181.199:80/api/";
    // Table View
    [self.matchtableview setDataSource:self];
    [self.matchtableview setDelegate:self];
    // Do any additional setup after loading the view.
    //NSMutableString *URLConstruction = [NSMutableString string];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSLog(@"%@", [userDefaults arrayForKey:@"matchedRequestSet"]);

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

/*
 DELEGATES
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentifier = @"CellIdentifier";
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    
    //    if (cell == nil) {
    //        cell = [[TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    //    }
    
    /*
     *Configure Cell
     */
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults]; 
    NSArray *matched = [userDefaults arrayForKey:@"matchedRequestSet"];
    NSDictionary *matchedRequest = matched[indexPath.row];
    NSString *touristusername = [matchedRequest valueForKey:@"username"];
    NSString *touristphone = [matchedRequest valueForKey:@"phonenumber"];
    NSString *touristemail = [matchedRequest valueForKey:@"email"];
    NSString *id1 = [matchedRequest valueForKey:@"_id"];
    //[GlobalVariables sharedInstance].touristphone = touristphone;
    //[GlobalVariables sharedInstance].touristemailaddress = touristemail;
    [userDefaults setObject:touristphone forKey:@"touristphone"];
    [userDefaults setObject:touristemail forKey:@"touristemailaddress"];
    [userDefaults setObject:id1 forKey:@"id"];
    NSString *touristcity = [matchedRequest valueForKey:@"city"];
    NSString *touristdate = [matchedRequest valueForKey:@"date"];
    NSString *touristsubmitdate = [matchedRequest valueForKey:@"submitdate"];
    NSString *touristneedcar = [matchedRequest valueForKey:@"hasCar"];
    cell.name.text = touristusername;
    NSString *Tdate = [touristdate componentsSeparatedByString:@"T"][0];
    cell.date.text = Tdate;
    NSString *TSdate = [touristsubmitdate componentsSeparatedByString:@"T"][0];
    cell.submitdate.text = TSdate;
    cell.city.text = touristcity;
    if (touristneedcar) {
        cell.needcar.text = @"need car";
    }
    else {
        cell.needcar.text = @"don't need car";
    }
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *emailaddress = [userDefaults stringForKey:@"touristemailaddress"];
    NSString *id1 = [userDefaults stringForKey:@"id"];
    NSMutableString *URLConstruction = [NSMutableString string];
    [URLConstruction appendString:[ServerIP stringByAppendingString: @"matched/"]];
    [URLConstruction appendString:id1];
    [URLConstruction appendString:@"/"];
    [URLConstruction appendString:emailaddress];
    NSLog(@"%@", URLConstruction);
    [AFmanager PUT:URLConstruction
        parameters:nil
           success:^(AFHTTPRequestOperation *operation, id responseObject) {
              [self performSegueWithIdentifier: @"success_matched" sender:nil ];
           } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
               NSLog(@"Error: %@", error);
           }];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //NSLog(@"%lu", [[GlobalVariables sharedInstance].matchedRequestSet count]);
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSArray *matched = [userDefaults arrayForKey:@"matchedRequestSet"];
    //NSLog(@"%@", [userDefaults arrayForKey:@"matchedRequestSet"]);
    //NSLog(@"%@", matched);
    return [matched count];
}


@end
