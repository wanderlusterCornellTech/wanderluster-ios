//
//  ViewController.h
//  login
//
//  Created by liudan.xiao on 9/22/15.
//  Copyright © 2015 liudan.xiao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>

@interface ViewController : UIViewController
{
    sqlite3 *db;
}
@end

