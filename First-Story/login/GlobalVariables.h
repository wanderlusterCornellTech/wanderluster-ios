//
//  GlobalVariables.h
//  login
//
//  Created by liudan.xiao on 12/1/15.
//  Copyright © 2015 liudan.xiao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GlobalVariables : NSObject
{
        NSMutableString *UserName;
        NSMutableString *Phone;
        NSMutableString *emailaddress;
        NSMutableString *touristphone;
        NSMutableString *touristemailaddress;
        NSMutableArray *matchedRequestSet;
}
@property(nonatomic,assign) NSMutableString *UserName;
@property(nonatomic,assign) NSMutableString *Phone;
@property(nonatomic,assign) NSMutableString *emailaddress;
@property(nonatomic,assign) NSMutableString *touristphone;
@property(nonatomic,assign) NSMutableString *touristemailaddress;
@property(nonatomic,assign) NSMutableArray *matchedRequestSet;
+(GlobalVariables *)sharedInstance;
@end

