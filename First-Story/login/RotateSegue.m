//
//  RotateSegue.m
//  login
//
//  Created by Yanbo Li on 12/2/15.
//  Copyright © 2015 liudan.xiao. All rights reserved.
//

#import "RotateSegue.h"

@implementation RotateSegue


-(void)perform {
    UIViewController *source = self.sourceViewController;
    UIViewController *destination = self.destinationViewController;
    
    [source.view addSubview:destination.view];
    destination.view.transform = CGAffineTransformMakeRotation(M_2_PI);
    
    [UIView animateWithDuration:0.5 animations:^{
        destination.view.transform = CGAffineTransformMakeRotation(0);
    }completion:^(BOOL finished) {
        [destination.view removeFromSuperview];
        [source presentViewController:destination animated:NO completion:NULL];
    }
     ];
}

@end
