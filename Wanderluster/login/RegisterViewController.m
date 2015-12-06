//
//  RegisterViewController.m
//  login
//
//  Created by liudan.xiao on 9/23/15.
//  Copyright © 2015 liudan.xiao. All rights reserved.
//

#import "RegisterViewController.h"
#import "ViewController.h"
#define DBNAME    @"userinfo.sqlite"
#define NAME      @"username"
#define PWD       @"password"
#define TABLENAME @"USERINFO"

@interface RegisterViewController ()
@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UITextField *repassword;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documents = [paths objectAtIndex:0];
    NSString *database_path = [documents stringByAppendingPathComponent:DBNAME];
    
    if (sqlite3_open([database_path UTF8String], &db) != SQLITE_OK) {
        sqlite3_close(db);
        NSLog(@"database open failed");
    }
    NSString *sqlCreateTable = @"CREATE TABLE IF NOT EXISTS USERINFO (ID INTEGER PRIMARY KEY AUTOINCREMENT, username TEXT, password TEXT)";
    self.username.placeholder = @"User Name";
    self.password.placeholder = @"Password";
    self.repassword.placeholder = @"Re-enter Password";
    self.password.secureTextEntry=YES;
    self.repassword.secureTextEntry=YES;
}

- (IBAction)mysignup:(id)sender {
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
