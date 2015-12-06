//
//  SignupViewController.m
//  login
//
//  Created by liudan.xiao on 11/30/15.
//  Copyright © 2015 liudan.xiao. All rights reserved.
//

#import "SignupViewController.h"
//#import "AFNetworking.h"
#define DBNAME    @"userinfo.sqlite"
#define NAME      @"name"
#define PWD       @"password"
#define TABLENAME @"USERINFO"

@interface SignupViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *myImageView1;
@property (weak, nonatomic) IBOutlet UIButton *myback;
@property (weak, nonatomic) IBOutlet UIButton *SignupButton;
@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UITextField *repassword;
@property (weak, nonatomic) IBOutlet UILabel *messgae;
@end

@implementation SignupViewController{
    NSString *ServerIP;
    AFHTTPRequestOperationManager *AFmanager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view insertSubview:_myImageView1 atIndex:0];
    self.username.placeholder = @"User Name";
    self.password.placeholder = @"Password";
    self.repassword.placeholder = @"Re-enter Password";
    self.username.tintColor = [UIColor blackColor];
    self.password.tintColor = [UIColor blackColor];
    self.repassword.tintColor = [UIColor blackColor];
    self.password.secureTextEntry=YES;
    self.repassword.secureTextEntry=YES;
    AFmanager = [AFHTTPRequestOperationManager manager];
    ServerIP = @"http://54.86.181.199:80/api/";
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)mysignup:(id)sender {
    NSString *username2 = self.username.text;
    NSString *password2 = self.password.text;
    NSString *sql1 = [NSString stringWithFormat:@"SELECT * FROM USERINFO where name='%@';", username2];
    if ([self.username.text isEqualToString:@""] || [self.password.text isEqualToString:@""] || [self.repassword.text isEqualToString:@""]) {
        self.messgae.text = @"Please check your Registration Information";
    }
    else if (![self.password.text isEqualToString:self.repassword.text]) {
        self.messgae.text = @"Re-enter Password unequal";
    }
    else {
        int rownum = 0;
        sqlite3_stmt *result = [self execQueryWithSQL:sql1];
        while (sqlite3_step(result) == SQLITE_ROW)
            rownum++;
        NSLog(@"%d",rownum);
        if (rownum == 0) {
            //char *err;
            //if (sqlite3_exec(db, [sql2 UTF8String], NULL, NULL, &err) == SQLITE_OK) {
            //sqlite3_close(db);
            NSMutableString *URLConstruction = [NSMutableString string];
            [URLConstruction appendString:[ServerIP stringByAppendingString: @"register/"]];
            [URLConstruction appendString:username2];
            [URLConstruction appendString:@"/"];
            [URLConstruction appendString:password2];
            [AFmanager POST:URLConstruction
                parameters:nil
                   success:^(AFHTTPRequestOperation *operation, id responseObject) {
                       
                       NSDictionary *responseDict = responseObject;
                       //NSLog(@"%@", responseDict);
                       NSString *responseArray = [responseDict valueForKey:@"message"];
                       NSLog(@"%@", responseArray);
                       if ([responseArray isEqualToString: @"Success!"]) {
                           NSString *sql2 = [NSString stringWithFormat:@"INSERT INTO '%@' VALUES ('%@', '%@');",TABLENAME, username2, password2];
                           [self execSql:sql2];
                           [self performSegueWithIdentifier: @"register" sender:nil ];
                       }
                       else {
                           self.messgae.text = @"Username exists try another";
                       }
                       
                   } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                       NSLog(@"Error: %@", error);
                       self.messgae.text = @"Username exists try another";
                   }];
        }
        else {
            self.messgae.text = @"Username exists try another";
        }
    }
}

-(void)execSql:(NSString *)sql
{
    char *err;
    if (sqlite3_exec(db, [sql UTF8String], NULL, NULL, &err) != SQLITE_OK) {
        sqlite3_close(db);
        NSLog(@"Operation failed");
    }
}

-(sqlite3_stmt *)execQueryWithSQL:(NSString*)sql
{
    sqlite3_stmt *stmt;
    int pre_res = sqlite3_prepare(db, [sql UTF8String], -1, &stmt, NULL);
    if (pre_res == SQLITE_OK) {
        return stmt;
    }
    NSLog(@"Operation failed");
    return NULL;
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
