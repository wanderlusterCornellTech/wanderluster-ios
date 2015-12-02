//
//  ViewController.m
//  login
//
//  Created by liudan.xiao on 9/22/15.
//  Copyright © 2015 liudan.xiao. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"
#define DBNAME    @"userinfo.sqlite"
#define NAME      @"name"
#define PWD       @"password"
#define TABLENAME @"USERINFO"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *LoginUsername;
@property (weak, nonatomic) IBOutlet UITextField *LoginPassword;
@property (weak, nonatomic) IBOutlet UIButton *LoginButton;
@property (weak, nonatomic) IBOutlet UIButton *SignupButton;
@property (weak, nonatomic) IBOutlet UILabel *Welcome;
@property (weak, nonatomic) IBOutlet UIImageView *myImageView;
@end

@implementation ViewController {
    NSString *ServerIP;
    AFHTTPRequestOperationManager *AFmanager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view insertSubview:_myImageView atIndex:0];
        
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documents = [paths objectAtIndex:0];
    NSString *database_path = [documents stringByAppendingPathComponent:DBNAME];
    //NSLog(database_path);
    AFmanager = [AFHTTPRequestOperationManager manager];
    ServerIP = @"http://54.86.181.199:80/api/";
    if (sqlite3_open([database_path UTF8String], &db) != SQLITE_OK) {
        sqlite3_close(db);
        NSLog(@"database open failed");
    }
    NSString *sqlCreateTable = @"CREATE TABLE IF NOT EXISTS USERINFO (name TEXT PRIMARY KEY, password TEXT)";
    [self execSql:sqlCreateTable];
    self.LoginUsername.placeholder = @"User Name";
    self.LoginPassword.placeholder = @"Password";
    self.LoginUsername.tintColor = [UIColor blackColor];
    self.LoginPassword.tintColor = [UIColor blackColor];
    self.LoginPassword.secureTextEntry=YES;
    //[self.myImageView endEditing:YES];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)Login:(id)sender {
    NSString *username1 = self.LoginUsername.text;
    NSString *password1 = self.LoginPassword.text;
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM USERINFO WHERE name='%@' and password='%@';", username1, password1];
    NSLog(@"%@",sql);
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    //NSString *sql = [NSString stringWithFormat:@"SELECT * FROM '%@';", TABLENAME];
    //NSString *sql2 = [NSString stringWithFormat:@"INSERT INTO '%@' VALUES ('%@', '%@');",TABLENAME,username, password];
    //NSString *sql3 = [NSString stringWithFormat:@"DELETE FROM '%@' WHERE '%@'='%@';",TABLENAME, NAME, username];
    if ([self.LoginUsername.text isEqualToString:@""] || [self.LoginPassword.text isEqualToString:@""]) {
        self.Welcome.text = @"Please put userid or password";
    }
    else {
        int rownum = 0;
        sqlite3_stmt *result = [self execQueryWithSQL:sql];
        while (sqlite3_step(result) == SQLITE_ROW)
            rownum++;
        NSLog(@"%d",rownum);
        if (rownum > 0) {
        //char *err;
        //if (sqlite3_exec(db, [sql2 UTF8String], NULL, NULL, &err) != SQLITE_OK) {
        //    sqlite3_close(db);
        //    NSLog(@"Operation failed");
            //NSLog(@"%@", [GlobalVariables sharedInstance].UserName);
            //[GlobalVariables sharedInstance].UserName = username1;
            //NSLog(@"%@", username1);
            //NSLog(@"%@", [GlobalVariables sharedInstance].UserName);
            [userDefaults setObject:username1 forKey:@"UserName"];
            [self performSegueWithIdentifier: @"signin" sender:nil ];
        }
        else {
         //   if (sqlite3_exec(db, [sql3 UTF8String], NULL, NULL, &err) != SQLITE_OK) {
         //       sqlite3_close(db);
         //       NSLog(@"Operation failed");
         //   }
            NSMutableString *URLConstruction = [NSMutableString string];
            [URLConstruction appendString:[ServerIP stringByAppendingString: @"login/"]];
            [URLConstruction appendString:username1];
            [URLConstruction appendString:@"/"];
            [URLConstruction appendString:password1];
            [AFmanager GET:URLConstruction
                parameters:nil
                   success:^(AFHTTPRequestOperation *operation, id responseObject) {
                        
                       NSDictionary *responseDict = responseObject;
                       //NSLog(@"%@", responseDict);
                       NSString *responseArray = [responseDict valueForKey:@"message"];
                       NSLog(@"%@", responseArray);
                       if ([responseArray isEqualToString: @"Login Success!"]) {
                           NSString *sql2 = [NSString stringWithFormat:@"INSERT INTO '%@' VALUES ('%@', '%@');",TABLENAME, username1, password1];
                           [self execSql:sql2];
                           
                           [userDefaults setObject:username1 forKey:@"UserName"];
                           //[[GlobalVariables sharedInstance].UserName appendString:username1];
                           [self performSegueWithIdentifier: @"signin" sender:nil ];
                       }
                       else {
                           self.Welcome.text = @"Invalid UserID or Password";
                       }
                        
                    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                        NSLog(@"Error: %@", error);
                        self.Welcome.text = @"Invalid UserID or Password";
                    }];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
