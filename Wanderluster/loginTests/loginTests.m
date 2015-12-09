//
//  loginTests.m
//  loginTests
//
//  Created by liudan.xiao on 9/22/15.
//  Copyright © 2015 liudan.xiao. All rights reserved.
//

#import <XCTest/XCTest.h>
//#import <OCMock/OCMock.h>

@interface loginTests : XCTestCase

@end

@implementation loginTests
{
    UIViewController *viewController;
    UIViewController *WelcomeviewController;
    UIViewController *SignupviewController;
    UIViewController *TouristviewController;
}

- (void)setUp {
    [super setUp];
//     Put setup code here. This method is called before the invocation of each test method in the class.
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName: @"Main" bundle:nil];
    viewController = [storyboard instantiateViewControllerWithIdentifier: @"ViewController"];
    [viewController view];
    WelcomeviewController = [storyboard instantiateViewControllerWithIdentifier: @"WelcomeViewController"];
    [WelcomeviewController view];
    SignupviewController = [storyboard instantiateViewControllerWithIdentifier: @"SignupViewController"];
    [SignupviewController view];
    TouristviewController = [storyboard instantiateViewControllerWithIdentifier: @"TouristViewController"];
    [TouristviewController view];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}


-(void)testViewControllerViewExists {
    XCTAssertNotNil([viewController view], @"ViewController should contain a view");
    XCTAssertNotNil([WelcomeviewController view], @"Welcome ViewController should contain a view");
    XCTAssertNotNil([SignupviewController view], @"Signup ViewController should contain a view");
    XCTAssertNotNil([TouristviewController view], @"Tourist ViewController should contain a view");
}


- (void)testLogin {
//    
//    id mock =  [OCMockObject partialMockForObject:mainView];
//    
//    //testButtonPressed IBAction should be triggered
//    [[mock expect] testButtonPressed:[OCMArg any]];
//    
//    //simulate button press
//    [mainView.testButton sendActionsForControlEvents: UIControlEventTouchUpInside];
//    
//    [mock verify];
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
