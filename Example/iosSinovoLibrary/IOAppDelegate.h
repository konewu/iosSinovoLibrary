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
@property (strong, nonatomic) UILabel      *bluestatusLb_dfu;
@property (strong, nonatomic) UILabel      *blestatusLb;
@property (strong, nonatomic) UILabel      *blestatusLb_dfu;
@property (strong, nonatomic) UILabel      *mqttstatusLb;
@property (strong, nonatomic) UITextView   *resultTV;

@property BOOL bleIsOn;  //mqtt init ok ?
@property BOOL isMqttLoginOk;  //mqtt init ok ?
@property BOOL isDFUMode;
@property BOOL bleConnected;

@property (nonatomic,copy) NSString *lockSno;
@property (nonatomic,copy) NSString *dfuFilePath;
@property (nonatomic,copy) NSString *firmwareVersion;
@property (nonatomic,copy) NSString *locktype;

@property (nonatomic,strong) NSMutableArray *lockTypeArray;

@end
