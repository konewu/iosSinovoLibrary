//
//  IODFUViewController.m
//  iosSinovoLibrary_Example
//
//  Created by Rongkun Wu on 2021/6/17.
//  Copyright © 2021 konewu. All rights reserved.
//

#import "IOAppDelegate.h"
#import "IODFUViewController.h"
#import "SinovoBleCallBack.h"
#import "SYIToast+SYCategory.h"
#import "httpCallback.h"
#import <iosSinovoLib/iosSinovoLib.h>

@interface IODFUViewController ()

@end

extern IOAppDelegate *myDelegate;
UITextField *locktypeTF;
UITextField *qrcode2TF;
UITextField *macTF;
UITextField *snoTF;

@implementation IODFUViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //初始化蓝牙
    if (!myDelegate.bleConnected) {
        [[SinovoBleCallBack sharedBleCallBack] InitBle];
    }
    
    float blueLbX = 20.0f;
    float blueLbY = 70.0f;
    float blueLbW = 150.0f;
    float blueLbH = 30.0f;
    UILabel *blueLb = [[UILabel alloc] initWithFrame:CGRectMake(blueLbX, blueLbY, blueLbW, blueLbH)];
    blueLb.text = @"Bluetooth status:";
    [self.view addSubview :blueLb];
    
    myDelegate.bluestatusLb_dfu = [[UILabel alloc] initWithFrame:CGRectMake(blueLbX + 150, blueLbY, 60, blueLbH)];
    if (myDelegate.bleIsOn) {
        myDelegate.bluestatusLb_dfu.text = @"ON";
        myDelegate.bluestatusLb_dfu.textColor = [UIColor blueColor];
    }else {
        myDelegate.bluestatusLb_dfu.text = @"OFF";
        myDelegate.bluestatusLb_dfu.textColor = [UIColor darkTextColor];
    }
    [self.view addSubview:myDelegate.bluestatusLb_dfu];
    
    UILabel *connstatusLb = [[UILabel alloc] initWithFrame:CGRectMake(blueLbX, blueLbY + 30, 100, blueLbH)];
    connstatusLb.text = @"Connect:";
    connstatusLb.textColor = [UIColor darkTextColor];
    [self.view addSubview:connstatusLb];
    
    myDelegate.blestatusLb_dfu = [[UILabel alloc] initWithFrame:CGRectMake(blueLbX + 100, blueLbY + 30, 150, blueLbH)];
    if (myDelegate.bleConnected) {
        myDelegate.blestatusLb_dfu.text = @"Connected";
        myDelegate.blestatusLb_dfu.textColor = [UIColor blueColor];
    }else {
        myDelegate.blestatusLb_dfu.text = @"disconnected";
        myDelegate.blestatusLb_dfu.textColor = [UIColor darkTextColor];
    }
    [self.view addSubview:myDelegate.blestatusLb_dfu];
    
    float screenW =  [[UIScreen mainScreen]bounds].size.width;
    float line2w = 400.0f;
    float line1x = (screenW - line2w)/2;
    
    //connect via mac、sno
    float line2y = connstatusLb.frame.origin.y + connstatusLb.frame.size.height + 10;
    UILabel *conMAC = [[UILabel alloc] initWithFrame:CGRectMake(line1x, line2y, line2w, 30.0f)];
    conMAC.text = @"1、Connect via mac adderss and sno";
    conMAC.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:conMAC];
    
    //mac label
    float line2macx = 20.0f;
    float line2macy = line2y + 40.0f;
    UILabel *macLabel = [[UILabel alloc] initWithFrame:CGRectMake(line2macx, line2macy, 80.0f, 30.0f)];
    macLabel.text = @"Mac:";
    [self.view addSubview:macLabel];
    
    float line2macTfx = line2macx + 80;
    macTF = [[UITextField alloc] initWithFrame:CGRectMake(line2macTfx, line2macy, 180, 30)];
    macTF.placeholder = @"lock's mac address";
    [self addToolBar:macTF];
    [self.view addSubview:macTF];
    
    UIView *line3 = [[UIView alloc] initWithFrame:CGRectMake(line2macTfx, line2macy+31, 180, 1)];
    line3.backgroundColor = [UIColor blueColor];
    [self.view addSubview:line3];
    
    //sno label
    float line2snox = 20.0f;
    float line2snoy = macLabel.frame.origin.y + macLabel.frame.size.height + 10;
    UILabel *snoLabel = [[UILabel alloc] initWithFrame:CGRectMake(line2snox, line2snoy, 80.0f, 30.0f)];
    snoLabel.text = @"SNO:";
    [self.view addSubview:snoLabel];

    float line2snoTFX = line2snox + 80;
    snoTF = [[UITextField alloc] initWithFrame:CGRectMake(line2snoTFX, line2snoy, 180, 30)];
    snoTF.placeholder = @"lock's SNO";
    [self addToolBar:snoTF];
    [self.view addSubview:snoTF];

    UIView *line4 = [[UIView alloc] initWithFrame:CGRectMake(line2snoTFX, line2snoy+31, 180, 1)];
    line4.backgroundColor = [UIColor blueColor];
    [self.view addSubview:line4];
    
    //qrcode label
    float line2qrx = 20.0f;
    float line2qry = snoLabel.frame.origin.y + snoLabel.frame.size.height + 10;
    UILabel *qrLabel = [[UILabel alloc] initWithFrame:CGRectMake(line2qrx, line2qry, 80.0f, 30.0f)];
    qrLabel.text = @"QRcode:";
    [self.view addSubview:qrLabel];

    float line2qrTFX = line2qrx + 80;
    qrcode2TF = [[UITextField alloc] initWithFrame:CGRectMake(line2qrTFX, line2qry, 180, 30)];
    qrcode2TF.placeholder = @"lock's qrcode";
    [self addToolBar:qrcode2TF];
    [self.view addSubview:qrcode2TF];

    UIView *line5 = [[UIView alloc] initWithFrame:CGRectMake(line2qrTFX, line2qry+31, 180, 1)];
    line5.backgroundColor = [UIColor blueColor];
    [self.view addSubview:line5];
    
    float btnMACy = qrLabel.frame.origin.y + qrLabel.frame.size.height +10;

    UIButton *connMACBtn = [[UIButton alloc] initWithFrame:CGRectMake(line2qrTFX, btnMACy, 180, 30)];
    [connMACBtn setTitle:@"Connect" forState:UIControlStateNormal];
    [connMACBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    connMACBtn.backgroundColor = [UIColor lightGrayColor];
    connMACBtn.userInteractionEnabled = YES;

    [connMACBtn addTarget:self action:@selector(connViaMacSno) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:connMACBtn];
    
    //下载升级包
    
    float downloady = connMACBtn.frame.origin.y + connMACBtn.frame.size.height + 10;
    float line1w = 300.0f;
    UILabel *conQRc = [[UILabel alloc] initWithFrame:CGRectMake(line1x, downloady, line1w, 30.0f)];
    conQRc.text = @"2、download DFU file";
    conQRc.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:conQRc];
    
    float btnqry = conQRc.frame.origin.y + conQRc.frame.size.height +10;
    float btnw   = 180.0f;
    float btnx   = (self.view.bounds.size.width - btnw)/2;
    
    UIButton *connQRBtn = [[UIButton alloc] initWithFrame:CGRectMake(btnx, btnqry, 180, 30)];
    [connQRBtn setTitle:@"Check DFU" forState:UIControlStateNormal];
    [connQRBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    connQRBtn.backgroundColor = [UIColor lightGrayColor];
    connQRBtn.userInteractionEnabled = YES;
    [connQRBtn addTarget:self action:@selector(downloadFile) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:connQRBtn];
    
    float dfuy = connQRBtn.frame.origin.y + connQRBtn.frame.size.height + 10;
    float dfu1w = 300.0f;
    UILabel *dfulb = [[UILabel alloc] initWithFrame:CGRectMake(line1x, dfuy, dfu1w, 30.0f)];
    dfulb.text = @"3、start to DFU";
    dfulb.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:dfulb];
    
    float btndfuy = dfulb.frame.origin.y + dfulb.frame.size.height +10;
    float btndfuw   = 180.0f;
    float btndfux   = (self.view.bounds.size.width - btndfuw)/2;
    
    UIButton *dfuBtn = [[UIButton alloc] initWithFrame:CGRectMake(btndfux, btndfuy, btndfuw, 30)];
    [dfuBtn setTitle:@"start to DFU" forState:UIControlStateNormal];
    [dfuBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    dfuBtn.backgroundColor = [UIColor lightGrayColor];
    dfuBtn.userInteractionEnabled = YES;
    [dfuBtn addTarget:self action:@selector(startDFU) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:dfuBtn];
    
    //显示 输出结果
    float tvY = dfuBtn.frame.origin.y + dfuBtn.frame.size.height + 20;
    float tvW = screenW - 40;
    float tvH =  [[UIScreen mainScreen]bounds].size.height - tvY - 20;
    
    myDelegate.resultTV = [[UITextView alloc] initWithFrame:CGRectMake(20, tvY, tvW, tvH)];
    myDelegate.resultTV.layoutManager.allowsNonContiguousLayout = NO;
    [self.view addSubview: myDelegate.resultTV];
    
    [self setTitleBar :@"BLe Lib"];
    
    UIColor *ViewBackgroundColor = [UIColor colorWithRed:(236)/255.0 green:(238)/255.0 blue:(240)/255.0 alpha:1.0];
    self.view.backgroundColor = ViewBackgroundColor;
}


-(void)connViaMacSno {
    [self hideKey];
    if (myDelegate.bleConnected) {
        NSString *message = @"Bluetooth is connected";
        [SYIToast alertWithTitle:message];
        return;
    }
    NSString *mac = macTF.text;
    NSString *sno   = snoTF.text;
    NSString *qrcode   = qrcode2TF.text;
    
    mac = [mac stringByReplacingOccurrencesOfString:@":" withString:@""];
    
    if (mac.length != 12 || sno.length != 6 || qrcode.length != 12) {
        NSString *message = @"Incorrect input parameters";
        [SYIToast alertWithTitle:message];
        return;
    }
    
    //ble connect list
    BleLock *mylock = [[BleLock alloc] init];
    mylock.SNO = sno;
    mylock.lockmac = mac;
    mylock.qrCode = qrcode;
    
    NSMutableArray *connectList = [[NSMutableArray alloc] init];
    [connectList addObject:mylock];

    myDelegate.lockSno = sno;
    [[SinovoBle sharedBLE] connectLockViaMacSno :connectList];
}

-(void) downloadFile {
    [self hideKey];
    
    if ([myDelegate.firmwareVersion isEqualToString:@""] || [myDelegate.locktype isEqualToString:@""] ||
        !myDelegate.bleConnected) {
        NSString *message = @"The hardware information of the lock is not obtained";
        [SYIToast alertWithTitle:message];
        return;
    }
    
    [[httpCallback sharedHttpCallback] getDfuInfo];
}

-(void) startDFU {
    [self hideKey];
    
    if ([myDelegate.firmwareVersion isEqualToString:@""] || [myDelegate.locktype isEqualToString:@""] ||
        !myDelegate.bleConnected || [myDelegate.dfuFilePath isEqualToString:@""]) {
        NSString *message = @"Ble disconnected or dfu file not found";
        [SYIToast alertWithTitle:message];
        return;
    }
    
    [[SinovoBle sharedBLE] setLockInfo :7 :@"" :myDelegate.lockSno];
}


- (void)initAlertController {
    NSString *alterTile = @"Select locke type";
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:alterTile preferredStyle:UIAlertControllerStyleActionSheet];
    
    for (NSString *locktype in myDelegate.lockTypeArray) {
        [alertController addAction:[UIAlertAction actionWithTitle:locktype style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"有效期的类型你选中的是 %@", action.title);
            locktypeTF.text = locktype;
        }]];
    }

    [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
     }]];
    
    [self presentViewController:alertController animated:true completion:nil];
    
}



//点击按钮，将键盘退出
-(void) hideKey {
    NSLog(@"点击确定，退出键盘");
    [macTF resignFirstResponder];
    [snoTF resignFirstResponder];
    [qrcode2TF resignFirstResponder];
}

// 创建工具条， 在弹出来键盘上 添加了工具条，增加了按钮
- (void) addToolBar :(UITextField *)inputTF{
    float screenW =  [[UIScreen mainScreen]bounds].size.width;
    UIToolbar *toolBar = [[UIToolbar alloc] init];
    toolBar.frame = CGRectMake(0, 0, screenW, 40);
    
    UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:self action:nil];
    spaceItem.width = screenW - 100;
    UIBarButtonItem *sureItem = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(hideKey)];
    
    toolBar.tintColor = [UIColor blackColor];
    toolBar.items = @[spaceItem, sureItem];
    
    inputTF.inputAccessoryView = toolBar;
}

/*
 *  设置标题栏
 */
- (void)setTitleBar :(NSString *)titleText {

    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
    [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];
    self.navigationItem.title = titleText;       //设置当前view的标题
 
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];  //背景色为纯色
    //设置标题的字体大小以及字体的颜色
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"Helvetica" size:18],NSForegroundColorAttributeName:[UIColor blackColor]}];
    
    //通过设置setShadowImage，设置标题栏的底部边框线
    [self.navigationController.navigationBar setShadowImage:[self createImageWithColor:[UIColor clearColor]]];
    
}

//通过颜色来创建图片
- (UIImage *)createImageWithColor:(UIColor *)color{
    CGRect rect = CGRectMake(0.0f,0.0f,1.0f,1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context =UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage =UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}


@end

