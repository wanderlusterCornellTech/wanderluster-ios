//
//  ViewController.m
//  login
//
//  Created by liudan.xiao on 9/22/15.
//  Copyright © 2015 liudan.xiao. All rights reserved.
//

#import "ViewController.h"
#define DBNAME    @"userinfo.sqlite"
#define NAME      @"name"
#define PWD       @"password"
#define TABLENAME @"USERINFO"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *LoginUsername;
@property (weak, nonatomic) IBOutlet UITextField *LoginPassword;
@property (weak, nonatomic) IBOutlet UIButton *LoginButton;
@property (weak, nonatomic) IBOutlet UIButton *SignupButton;
@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UITextField *repassword;
@property (weak, nonatomic) IBOutlet UILabel *messgae;
@property (weak, nonatomic) IBOutlet UILabel *Welcome;
@property (weak, nonatomic) IBOutlet UIImageView *myImageView;
@property (weak, nonatomic) IBOutlet UIImageView *myImageView1;
@property (weak, nonatomic) IBOutlet UIButton *myback;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view insertSubview:_myImageView atIndex:0];
    [self.view insertSubview:_myImageView1 atIndex:0];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documents = [paths objectAtIndex:0];
    NSString *database_path = [documents stringByAppendingPathComponent:DBNAME];
    NSLog(database_path);
    
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
    self.username.placeholder = @"User Name";
    self.password.placeholder = @"Password";
    self.repassword.placeholder = @"Re-enter Password";
    self.username.tintColor = [UIColor blackColor];
    self.password.tintColor = [UIColor blackColor];
    self.repassword.tintColor = [UIColor blackColor];
    self.password.secureTextEntry=YES;
    self.repassword.secureTextEntry=YES;
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)Login:(id)sender {
    NSString *username = self.LoginUsername.text;
    NSString *password = self.LoginPassword.text;
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM USERINFO WHERE name='%@' and password='%@';", username, password];
    NSLog(@"%@",sql);
    //NSString *sql = [NSString stringWithFormat:@"SELECT * FROM '%@';", TABLENAME];
    //NSString *sql2 = [NSString stringWithFormat:@"INSERT INTO '%@' VALUES ('%@', '%@');",TABLENAME,username, password];
    //NSString *sql3 = [NSString stringWithFormat:@"DELETE FROM '%@' WHERE '%@'='%@';",TABLENAME, NAME, username];
    if ([self.LoginUsername.text isEqualToString:@""] || [self.LoginPassword.text isEqualToString:@""]) {
        self.Welcome.text = @"Please put userid&password";
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
            [self performSegueWithIdentifier: @"signin" sender:nil ];
        }
        else {
         //   if (sqlite3_exec(db, [sql3 UTF8String], NULL, NULL, &err) != SQLITE_OK) {
         //       sqlite3_close(db);
         //       NSLog(@"Operation failed");
         //   }
            self.Welcome.text = @"Invalid UserID or Password";
        }
    }
    
}

- (IBAction)mysignup:(id)sender {
    NSString *username = self.username.text;
    NSString *password = self.password.text;
    NSString *sql1 = [NSString stringWithFormat:@"SELECT * FROM USERINFO where name='%@';", username];
    NSString *sql2 = [NSString stringWithFormat:@"INSERT INTO '%@' VALUES ('%@', '%@');",TABLENAME, username, password];
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
            [self execSql:sql2];
            [self performSegueWithIdentifier: @"register" sender:nil ];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
