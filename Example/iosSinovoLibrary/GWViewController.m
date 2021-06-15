//
//  GWViewController.m
//  onlytestfw
//
//  Created by Rongkun Wu on 2021/6/11.
//

#import "GWViewController.h"
#import <iosSinovoLib/iosSinovoLib.h>

#import <CoreLocation/CoreLocation.h>
#import <SystemConfiguration/SystemConfiguration.h>
#import <SystemConfiguration/CaptiveNetwork.h>

@interface EspTouchDelegateImpl : NSObject<ESPTouchDelegate>
@end

@interface GWViewController ()<CLLocationManagerDelegate>
@property(nonatomic,strong)CLLocationManager *locManager;
@property (nonatomic, strong) EspTouchDelegateImpl *_esptouchDelegate;

@end

UITextField *passTF;
UILabel *wifiSSIDLb;
UILabel *wifiBSSIDLb;
UITextView *resultTV;

NSString *wifiBSSID = @"";
NSString *wifiSSID = @"";
NSString *wifiPass = @"";

@implementation GWViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //进行网关配网
    [self getLocation];
    
    float blueLbX = 20.0f;
    float blueLbY = 70.0f;
    float blueLbW = 150.0f;
    float blueLbH = 30.0f;
    UILabel *blueLb = [[UILabel alloc] initWithFrame:CGRectMake(blueLbX, blueLbY, blueLbW, blueLbH)];
    blueLb.text = @"WIFI SSID:";
    [self.view addSubview :blueLb];
    
    wifiSSIDLb = [[UILabel alloc] initWithFrame:CGRectMake(blueLbX + 100, blueLbY, 200, blueLbH)];
    [self.view addSubview:wifiSSIDLb];
    
    UILabel *connstatusLb = [[UILabel alloc] initWithFrame:CGRectMake(blueLbX, blueLbY + 30, 200, blueLbH)];
    connstatusLb.text = @"WIFI BSSID:";
    connstatusLb.textColor = [UIColor darkTextColor];
    [self.view addSubview:connstatusLb];
    
    wifiBSSIDLb = [[UILabel alloc] initWithFrame:CGRectMake(blueLbX + 100, blueLbY + 30, 150, blueLbH)];
    [self.view addSubview:wifiBSSIDLb];
    
    
    float line1y = connstatusLb.frame.origin.y + connstatusLb.frame.size.height + 10;
    float line1_qrLabelx = 20.0f;
    UILabel *qrcodeLabel = [[UILabel alloc] initWithFrame:CGRectMake(line1_qrLabelx, line1y, 120.0f, 30.0f)];
    qrcodeLabel.text = @"Wifi password:";
    [self.view addSubview:qrcodeLabel];
    
    float line1_qrTextfX = line1_qrLabelx + 120;
    passTF = [[UITextField alloc] initWithFrame:CGRectMake(line1_qrTextfX, line1y, 180, 30)];
    [self addToolBar:passTF];
    [self.view addSubview:passTF];
    
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(line1_qrTextfX, line1y+31, 180, 1)];
    line1.backgroundColor = [UIColor blueColor];
    [self.view addSubview:line1];
    
    float btnqry = qrcodeLabel.frame.origin.y + qrcodeLabel.frame.size.height +20;

    UIButton *connQRBtn = [[UIButton alloc] initWithFrame:CGRectMake(line1_qrLabelx, btnqry, line1_qrTextfX + 180, 50)];
    
    [connQRBtn setTitle:@"Configure" forState:UIControlStateNormal];
    [connQRBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    connQRBtn.backgroundColor = [UIColor lightGrayColor];
    connQRBtn.userInteractionEnabled = YES;
    [connQRBtn addTarget:self action:@selector(startSmartconfig) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:connQRBtn];
    
    //显示 输出结果
    float screenW = self.view.bounds.size.width;
    float tvY = connQRBtn.frame.origin.y + connQRBtn.frame.size.height + 20;
    float tvW = screenW - 40;
    float tvH =  [[UIScreen mainScreen]bounds].size.height - tvY - 20;
    
    resultTV = [[UITextView alloc] initWithFrame:CGRectMake(20, tvY, tvW, tvH)];
    [self.view addSubview: resultTV];
    
    [self setTitleBar :@"Gateway Configure"];
    
    UIColor *ViewBackgroundColor = [UIColor colorWithRed:(236)/255.0 green:(238)/255.0 blue:(240)/255.0 alpha:1.0];
    self.view.backgroundColor = ViewBackgroundColor;
    
   
    [ESP_NetUtil tryOpenNetworkPermission];
}

#pragma mark - 定位授权代理方法
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    if (status == kCLAuthorizationStatusAuthorizedWhenInUse ||
        status == kCLAuthorizationStatusAuthorizedAlways) {
        //再重新获取ssid
        [self getSSID];
    }
}

//获取位置信息，用来获取wifi
- (void)getLocation {
    if (!self.locManager) {
        self.locManager = [[CLLocationManager alloc] init];
    }
    
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //这句代码会在app的设置中开启位置授权的选项，只有用户选择了允许一次，下次用户调用这个方法才会弹出询问框，选择不允许或是使用期间允许，下次调用这个方法都不会弹出询问框
        [self.locManager requestAlwaysAuthorization];
    }
    
    self.locManager.delegate = self;
    //如果用户第一次拒绝了，弹出提示框，跳到设置界面，要用户打开位置权限
    //如果用户跳到设置界面选择了下次询问，再回到app,[CLLocationManager authorizationStatus]的值会是nil,所以要||后面的判断
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied || ![CLLocationManager authorizationStatus]) {
        [self alertMy];
    }else {
        [self getSSID];
    }
}

- (void)alertMy{
    //1.创建UIAlertControler
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Request Access" message:@"The app needs location information to access WiFi" preferredStyle:UIAlertControllerStyleAlert];
     
    UIAlertAction *conform = [UIAlertAction actionWithTitle:@"Setting" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIApplication *application = [UIApplication sharedApplication];
        [application openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{} completionHandler:nil];

        //[[UIApplication sharedApplication] openURL:options:completionHandler:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
        NSLog(@"点击了确认按钮");
    }];
    //2.2 取消按钮
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击了取消按钮");
    }];
    
    //3.将动作按钮 添加到控制器中
    [alert addAction:conform];
    [alert addAction:cancel];
       
    //4.显示弹框
    [self presentViewController:alert animated:YES completion:nil];
}

//获取wifi的信息
- (void)getSSID{
    id ssidStr = [self fetchSSIDInfo][@"SSID"];
    id bssidStr = [self fetchSSIDInfo][@"BSSID"];
    NSLog(@"获取到的wifi ssid :%@ %@", ssidStr , bssidStr);
    
    //获取到的wifi ssid :sinovotec fc:37:2b:fc:2d:13
    wifiBSSID  = [NSString stringWithFormat:@"%@", bssidStr];
    wifiSSID  = [NSString stringWithFormat:@"%@", ssidStr];
    
    wifiSSIDLb.text = wifiSSID;
    wifiBSSIDLb.text = wifiBSSID;
}

- (id)fetchSSIDInfo {
    NSArray *ifs = (__bridge_transfer id)CNCopySupportedInterfaces();
    id info = nil;
    for (NSString *ifnam in ifs) {
        info = (__bridge_transfer id)CNCopyCurrentNetworkInfo((__bridge CFStringRef)ifnam);
        
        if (info && [info count]) {
            break;
        }
    }
    return info;
}


-(void)startSmartconfig {
    [self hideKey];
    NSString *pass   = passTF.text;
    resultTV.text = @"Gateway Configuring network...";
    
    dispatch_queue_t seriaQueue = dispatch_queue_create("并行", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(seriaQueue, ^{
        ESPTouchTask *esptouchTask = [[ESPTouchTask alloc]initWithApSsid: wifiSSID andApBssid:wifiBSSID andApPwd:pass];
        [esptouchTask setEsptouchDelegate:self._esptouchDelegate];
        [esptouchTask setPackageBroadcast:  YES];

        NSLog(@"wifissid:%@ ,bssid:%@", wifiSSID, wifiBSSID);

        NSArray *results = [esptouchTask executeForResults:1];

        NSLog(@"配网的结果是：%@", results);
        
        ESPTouchResult *first = [results objectAtIndex:0];
        NSLog(@"配网的结果是 first：%@", first);
        if (first.isCancelled) {
            NSLog(@"用户取消了配网");
            NSString *results = [NSString stringWithFormat:@"%@", @"Canceled configuration"];
            dispatch_queue_t mainQueue = dispatch_get_main_queue();
            dispatch_async(mainQueue, ^{
                resultTV.text = results;
            });
           
            return;
        }

        if (first.isSuc) {
            NSString *gwID = [first.bssid uppercaseString];
            NSString *resultf = [NSString stringWithFormat:@"%@", first];
            
            NSLog(@"配网成功 bssid：%@ ", gwID);
            NSString *results = [NSString stringWithFormat:@"%@%@%@%@", @"Gateway configure success \n\n",resultf, @"\n\nGateway‘s BSSID: ",gwID];
            
            dispatch_queue_t mainQueue = dispatch_get_main_queue();
            dispatch_async(mainQueue, ^{
                resultTV.text = results;
            });
        }

        //配网失败的情况
        if (!first.isSuc && !first.isCancelled) {
             NSLog(@"配网超时失败了");
            NSString *results = [NSString stringWithFormat:@"%@", @"Gateway configure timeout "];
            
            dispatch_queue_t mainQueue = dispatch_get_main_queue();
            dispatch_async(mainQueue, ^{
                resultTV.text = results;
            });
        }
    });
}




//点击按钮，将键盘退出
-(void) hideKey {
    NSLog(@"点击确定，退出键盘");
    [passTF resignFirstResponder];
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
