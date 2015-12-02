//
//  RequestViewController.m
//  
//
//  Created by liudan.xiao on 12/1/15.
//
//

#import "RequestViewController.h"
#import "AFNetworking.h"


@interface RequestViewController ()
@property (weak, nonatomic) IBOutlet UITextField *mobile;
@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UITextField *city;
@property (weak, nonatomic) IBOutlet UISwitch *car;
@property (weak, nonatomic) IBOutlet UIDatePicker *date;
@end

@implementation RequestViewController{
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
    //sqlite3_close(db);
    NSString *phonenumber = self.mobile.text;
    NSString *emailaddress = self.email.text;
    NSString *ccity = self.city.text;
    NSDate * date1 = [NSDate date];
    NSTimeInterval sec = [date1 timeIntervalSinceNow];
    NSDate * currentDate = [[NSDate alloc] initWithTimeIntervalSinceNow:sec];
    NSDate * datepicker = [self.date date];
    NSDateFormatter * df = [[NSDateFormatter alloc] init ];
    [df setDateFormat:@"yyyy-MM-dd"];
    NSString * na = [df stringFromDate:currentDate];
    NSString * na1 = [df stringFromDate:datepicker];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    NSMutableString *URLConstruction = [NSMutableString string];
    [URLConstruction appendString:[ServerIP stringByAppendingString: @"request/"]];
    //NSString *immutableString4 = [NSString stringWithFormat:@"%@", [GlobalVariables sharedInstance].UserName];
    [URLConstruction appendString:[userDefaults stringForKey:@"UserName"]];NSLog(@"yes");
    [URLConstruction appendString:@"/"];
    [URLConstruction appendString:phonenumber];
    [URLConstruction appendString:@"/"];
    [URLConstruction appendString:emailaddress];
    [URLConstruction appendString:@"/"];
    [URLConstruction appendString:na1];
    if (self.car.isOn) {
        [URLConstruction appendString:@"/true"];
    }
    else {
        [URLConstruction appendString:@"/false"];
    }
    [URLConstruction appendString:@"/"];
    [URLConstruction appendString:ccity];
    [URLConstruction appendString:@"/"];
    [URLConstruction appendString:na];
    [URLConstruction appendString:@"/false/false"];
    NSLog(@"%@", URLConstruction);
    [AFmanager POST:URLConstruction
         parameters:nil
            success:^(AFHTTPRequestOperation *operation, id responseObject) {
                [self performSegueWithIdentifier: @"post1" sender:nil ];
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
