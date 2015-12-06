//
//  GlobalVariables.m
//  login
//
//  Created by liudan.xiao on 12/1/15.
//  Copyright © 2015 liudan.xiao. All rights reserved.
//

#import "GlobalVariables.h"

@implementation GlobalVariables

static GlobalVariables *shareData;
//NSMutableString *UserName;

+(GlobalVariables *) sharedInstance{
    @synchronized(self){
        if (!shareData) {
            shareData = [[GlobalVariables alloc]init];
        }
        return shareData;
    }
}

//-(id)init{
//    if (self = [super init]) {
//        UserName = [NSMutableString stringWithString:@""];
//    }
//    return self;
//}

@end
