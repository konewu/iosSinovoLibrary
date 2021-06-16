//
//  IOAppDelegate.h
//  iosSinovoLibrary
//
//  Created by konewu on 06/14/2021.
//  Copyright (c) 2021 konewu. All rights reserved.
//

@import UIKit;

@interface IOAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow     *window;
@property (strong, nonatomic) UILabel      *bluestatusLb;
@property (strong, nonatomic) UILabel      *blestatusLb;
@property (strong, nonatomic) UILabel      *mqttstatusLb;
@property (strong, nonatomic) UITextView   *resultTV;

@property (nonatomic,assign) BOOL isMqttLoginOk;  //mqtt init ok ?
@property (nonatomic,assign) NSString *lockSno;

@end
