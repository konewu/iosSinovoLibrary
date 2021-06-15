//
//  MQTTViewController.m
//  onlytestfw
//
//  Created by Rongkun Wu on 2021/6/11.
//

#import "IOAppDelegate.h"
#import "mqttCallBack.h"
#import "MQTTViewController.h"
#import <iosSinovoLib/iosSinovoLib.h>

@interface MQTTViewController ()

@end

extern IOAppDelegate *myDelegate;
UITextField *accountTF;
UITextField *passTF;
UITextField *lockmacTF;
UITextField *locksnoTF;
UITextField *gatewayIDTF;

@implementation MQTTViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始化Mqtt
    float blueLbX = 20.0f;
    float blueLbY = 70.0f;
    float blueLbW = 150.0f;
    float blueLbH = 30.0f;
    UILabel *blueLb = [[UILabel alloc] initWithFrame:CGRectMake(blueLbX, blueLbY, blueLbW, blueLbH)];
    blueLb.text = @"MQTT status:";
    [self.view addSubview :blueLb];
    
    myDelegate.mqttstatusLb = [[UILabel alloc] initWithFrame:CGRectMake(blueLbX + 150, blueLbY, 60, blueLbH)];
    myDelegate.mqttstatusLb.text = @"disconnected";
    myDelegate.mqttstatusLb.textColor = [UIColor darkTextColor];
    [self.view addSubview:myDelegate.mqttstatusLb];
    
    float line1y = blueLb.frame.origin.y + blueLb.frame.size.height + 10;
    float line1w = 300.0f;
    float screenW =  [[UIScreen mainScreen]bounds].size.width;

    float line1x = (screenW - line1w)/2;
    UILabel *conQRc = [[UILabel alloc] initWithFrame:CGRectMake(line1x, line1y, line1w, 30.0f)];
    conQRc.text = @"Register user via Http";
    conQRc.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:conQRc];
    
    //qrcode label
    float line1_qrLabelx = 20.0f;
    float line1_qrLabely = line1y + 40.0f;
    UILabel *qrcodeLabel = [[UILabel alloc] initWithFrame:CGRectMake(line1_qrLabelx, line1_qrLabely, 80.0f, 30.0f)];
    qrcodeLabel.text = @"Account:";
    [self.view addSubview:qrcodeLabel];
    
    float line1_qrTextfX = line1_qrLabelx + 80;
    accountTF = [[UITextField alloc] initWithFrame:CGRectMake(line1_qrTextfX, line1_qrLabely, 180, 30)];
    accountTF.placeholder = @"User's account";
    [self addToolBar:accountTF];
    [self.view addSubview:accountTF];
    
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(line1_qrTextfX, line1_qrLabely+31, 180, 1)];
    line1.backgroundColor = [UIColor blueColor];
    [self.view addSubview:line1];
    
    //imei label
    float line2_imeix = 20.0f;
    float line2_imeiy = qrcodeLabel.frame.origin.y + qrcodeLabel.frame.size.height + 10;
    UILabel *imeiLabel = [[UILabel alloc] initWithFrame:CGRectMake(line2_imeix, line2_imeiy, 80.0f, 30.0f)];
    imeiLabel.text = @"Password:";
    [self.view addSubview:imeiLabel];

    float line2_qrTextfX = line2_imeix + 80;
    passTF = [[UITextField alloc] initWithFrame:CGRectMake(line2_qrTextfX, line2_imeiy, 180, 30)];
    [self addToolBar:passTF];
    [self.view addSubview:passTF];

    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(line2_qrTextfX, line2_imeiy+31, 180, 1)];
    line2.backgroundColor = [UIColor blueColor];
    [self.view addSubview:line2];
    
    float btnqry = imeiLabel.frame.origin.y + imeiLabel.frame.size.height +10;

    UIButton *connQRBtn = [[UIButton alloc] initWithFrame:CGRectMake(line2_qrTextfX, btnqry, 180, 30)];
    [connQRBtn setTitle:@"Register mqtt" forState:UIControlStateNormal];
    [connQRBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    connQRBtn.backgroundColor = [UIColor lightGrayColor];
    connQRBtn.userInteractionEnabled = YES;
    [connQRBtn addTarget:self action:@selector(connViaQrc) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:connQRBtn];
    
    //connect via mac、sno
    float line2w = 400.0f;
    float line2x = (screenW - line2w)/2;
    float line2y = connQRBtn.frame.origin.y + connQRBtn.frame.size.height + 20;
    UILabel *conMAC = [[UILabel alloc] initWithFrame:CGRectMake(line2x, line2y, line2w, 30.0f)];
    conMAC.text = @"Check lock battery via mqtt";
    conMAC.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:conMAC];
    
    //mac label
    float line2macx = 20.0f;
    float line2macy = line2y + 40.0f;
    UILabel *macLabel = [[UILabel alloc] initWithFrame:CGRectMake(line2macx, line2macy, 80.0f, 30.0f)];
    macLabel.text = @"Lock Mac:";
    [self.view addSubview:macLabel];
    
    float line2macTfx = line2macx + 80;
    lockmacTF = [[UITextField alloc] initWithFrame:CGRectMake(line2macTfx, line2macy, 180, 30)];
    lockmacTF.placeholder = @"lock's mac address";
    [self addToolBar:lockmacTF];
    [self.view addSubview:lockmacTF];
    
    UIView *line3 = [[UIView alloc] initWithFrame:CGRectMake(line2macTfx, line2macy+31, 180, 1)];
    line3.backgroundColor = [UIColor blueColor];
    [self.view addSubview:line3];
    
    //sno label
    float line2snox = 20.0f;
    float line2snoy = macLabel.frame.origin.y + macLabel.frame.size.height + 10;
    UILabel *snoLabel = [[UILabel alloc] initWithFrame:CGRectMake(line2snox, line2snoy, 80.0f, 30.0f)];
    snoLabel.text = @"Lock SNO:";
    [self.view addSubview:snoLabel];

    float line2snoTFX = line2snox + 80;
    locksnoTF = [[UITextField alloc] initWithFrame:CGRectMake(line2snoTFX, line2snoy, 180, 30)];
    locksnoTF.placeholder = @"lock's SNO";
    [self addToolBar:locksnoTF];
    [self.view addSubview:locksnoTF];

    UIView *line4 = [[UIView alloc] initWithFrame:CGRectMake(line2snoTFX, line2snoy+31, 180, 1)];
    line4.backgroundColor = [UIColor blueColor];
    [self.view addSubview:line4];
    
    //qrcode label
    float line2qrx = 20.0f;
    float line2qry = snoLabel.frame.origin.y + snoLabel.frame.size.height + 10;
    UILabel *qrLabel = [[UILabel alloc] initWithFrame:CGRectMake(line2qrx, line2qry, 80.0f, 30.0f)];
    qrLabel.text = @"Gateway ID:";
    [self.view addSubview:qrLabel];

    float line2qrTFX = line2qrx + 80;
    gatewayIDTF = [[UITextField alloc] initWithFrame:CGRectMake(line2qrTFX, line2qry, 180, 30)];
    gatewayIDTF.placeholder = @"Gateway's ID";
    [self addToolBar:gatewayIDTF];
    [self.view addSubview:gatewayIDTF];

    UIView *line5 = [[UIView alloc] initWithFrame:CGRectMake(line2qrTFX, line2qry+31, 180, 1)];
    line5.backgroundColor = [UIColor blueColor];
    [self.view addSubview:line5];
    
    float btnMACy = qrLabel.frame.origin.y + qrLabel.frame.size.height +10;

    UIButton *connMACBtn = [[UIButton alloc] initWithFrame:CGRectMake(line2qrTFX, btnMACy, 180, 30)];
    [connMACBtn setTitle:@"Send Data" forState:UIControlStateNormal];
    [connMACBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    connMACBtn.backgroundColor = [UIColor lightGrayColor];
    connMACBtn.userInteractionEnabled = YES;

    [connMACBtn addTarget:self action:@selector(connViaMacSno) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:connMACBtn];
    
    //显示 输出结果
    float tvY = connMACBtn.frame.origin.y + connMACBtn.frame.size.height + 20;
    float tvW = screenW - 40;
    float tvH =  [[UIScreen mainScreen]bounds].size.height - tvY - 20;
    
    myDelegate.resultTV = [[UITextView alloc] initWithFrame:CGRectMake(20, tvY, tvW, tvH)];
    [self.view addSubview: myDelegate.resultTV];
    
    [self setTitleBar :@"BLe Lib"];
    
    UIColor *ViewBackgroundColor = [UIColor colorWithRed:(236)/255.0 green:(238)/255.0 blue:(240)/255.0 alpha:1.0];
    self.view.backgroundColor = ViewBackgroundColor;
}


-(void)connViaMacSno {
    [self hideKey];
//    NSString *mac = macTF.text;
//    NSString *sno   = snoTF.text;
//    NSString *qrcode   = qrcode2TF.text;
//
//    mac = [mac stringByReplacingOccurrencesOfString:@":" withString:@""];
//    BleLock *mylock = [[BleLock alloc] init];
//    mylock.SNO = sno;
//    mylock.lockmac = mac;
//    mylock.qrCode = qrcode;
////        mylock.SNO = @"d0e3c3";
////        mylock.lockmac = @"FC510BC5DD51";
////        mylock.qrCode = @"221234567890";
//
//    NSMutableArray *connectList = [[NSMutableArray alloc] init];
//    [connectList addObject:mylock];
//
//    [[SinovoBle sharedBLE] connectLockViaMacSno :connectList];
}

-(void) connViaQrc {
    [self hideKey];
//    NSString *qrcode = qrcodeTF.text;
//    NSString *imei   = imeiTF.text;
//    [[SinovoBle sharedBLE] connectLockViaQRCode :qrcode :imei];
}


//点击按钮，将键盘退出
-(void) hideKey {
    NSLog(@"点击确定，退出键盘");
    
    [accountTF resignFirstResponder];
    [passTF resignFirstResponder];
    [lockmacTF resignFirstResponder];
    [locksnoTF resignFirstResponder];
    [gatewayIDTF resignFirstResponder];
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

