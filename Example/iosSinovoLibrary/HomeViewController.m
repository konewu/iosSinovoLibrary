//
//  HomeViewController.m
//  onlytestfw
//
//  Created by Rongkun Wu on 2021/6/10.
//

#import "HomeViewController.h"
#import "ViewController.h"
#import "GWViewController.h"
//#import "MQTTViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    float screenW = self.view.bounds.size.width;
    float btn1W = 200.0f;
    float btn1H = 50.0f;
    float btn1X = (screenW - btn1W)/2;
    float btn1Y = 100.f;
    
    [self setTitleBar :@"SinovoLib"];
    
    UIColor *ViewBackgroundColor = [UIColor colorWithRed:(236)/255.0 green:(238)/255.0 blue:(240)/255.0 alpha:1.0];
    self.view.backgroundColor = ViewBackgroundColor;
    
    UIButton *gotoBle = [[UIButton alloc] initWithFrame:CGRectMake(btn1X, btn1Y, btn1W, btn1H)];
    [gotoBle setTitle:@"BLE Lib" forState:UIControlStateNormal];
    [gotoBle setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    gotoBle.backgroundColor = [UIColor lightGrayColor];
    gotoBle.userInteractionEnabled = YES;
    [gotoBle addTarget:self action:@selector(gotoble) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview :gotoBle];
    
    float btn2Y = btn1Y + btn1H + 30;
    UIButton *gotogw = [[UIButton alloc] initWithFrame:CGRectMake(btn1X, btn2Y, btn1W, btn1H)];
    [gotogw setTitle:@"Gateway configure" forState:UIControlStateNormal];
    [gotogw setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    gotogw.backgroundColor = [UIColor lightGrayColor];
    gotogw.userInteractionEnabled = YES;
    [gotogw addTarget:self action:@selector(gotogw) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview :gotogw];
    
    float btn3Y = btn2Y + btn1H + 30;
    UIButton *gotomqtt = [[UIButton alloc] initWithFrame:CGRectMake(btn1X, btn3Y, btn1W, btn1H)];
    [gotomqtt setTitle:@"Http、MQTT" forState:UIControlStateNormal];
    [gotomqtt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    gotomqtt.backgroundColor = [UIColor lightGrayColor];
    gotomqtt.userInteractionEnabled = YES;
    [gotomqtt addTarget:self action:@selector(gotomqtt) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview :gotomqtt];
}

-(void) gotogw {
    UIViewController *viewController = [[GWViewController alloc] init];
    UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] init];
    temporaryBarButtonItem.title = @" ";
    self.navigationItem.backBarButtonItem = temporaryBarButtonItem;
    viewController.hidesBottomBarWhenPushed = YES;   //切换时，隐藏底部导航栏的按钮
    [self.navigationController pushViewController:viewController animated:YES];
}

////跳转到 其他页面
-(void) gotoble {
    UIViewController *viewController = [[ViewController alloc] init];
    UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] init];
    temporaryBarButtonItem.title = @" ";
    self.navigationItem.backBarButtonItem = temporaryBarButtonItem;
    viewController.hidesBottomBarWhenPushed = YES;   //切换时，隐藏底部导航栏的按钮
    [self.navigationController pushViewController:viewController animated:YES];

}

////跳转到 其他页面
-(void) gotomqtt {
//    UIViewController *viewController = [[MQTTViewController alloc] init];
//    UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] init];
//    temporaryBarButtonItem.title = @" ";
//    self.navigationItem.backBarButtonItem = temporaryBarButtonItem;
//    viewController.hidesBottomBarWhenPushed = YES;   //切换时，隐藏底部导航栏的按钮
//    [self.navigationController pushViewController:viewController animated:YES];

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
