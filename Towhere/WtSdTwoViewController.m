//
//  WtSdTwoViewController.m
//  Towhere
//
//  Created by apple on 15/8/10.
//  Copyright (c) 2015年 elephant. All rights reserved.
//

#import "WtSdTwoViewController.h"
#import "AppDelegate.h"
#import "XMUtils.h"
#import "ListBean1.h"
#import "SBJsonParser.h"
#import "Order.h"
#import "DataSigner.h"
#import <AlipaySDK/AlipaySDK.h>


@interface WtSdTwoViewController (){
    NSString *kdid;   //快递编号。
}

@end

@implementation WtSdTwoViewController
@synthesize kdnumber = _kdnumber;
@synthesize daname = _daname;
@synthesize daphone = _daphone;
@synthesize daaddress = _daaddress;
@synthesize paname = _paname;
@synthesize paphone = _paphone;
@synthesize weight = _weight;
@synthesize cname = _cname;
@synthesize price = _price;
@synthesize zfbImage;
@synthesize wxImage;
@synthesize yhkImage;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadDataFromNet];
}

-(IBAction)back:(id)sender{
    UIViewController *next = [[self storyboard]instantiateViewControllerWithIdentifier:@"SendViewController"];
    [self.navigationController pushViewController:next animated:NO];
}

- (void)loadDataFromNet{
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];

    NSString *strPageUrl = [NSString stringWithFormat:@"http://120.26.74.234/index.php?c=post&a=get&pid=%@&token=%@",appDelegate.waitsendID,appDelegate.token];
    
    NSLog(@"http://121.42.12.154/index.php?c=post&a=get&pid=%@&token=%@",appDelegate.waitsendID,appDelegate.token);
    
    HttpClient *http = [HttpClient httpClientWithDelegate:self];
    http.needTipsNetError = YES;
    [http LoadDataFromNet:strPageUrl code:HttpRequestPathForActivityList];
}

- (void)dataStartLoad:(HttpRequestPath)requestPath
{
    [XMUtils hiddenTips:self.view];
    
    if (requestPath == HttpRequestPathForActivityList)
    {
        
        [XMUtils addWaitingView:self.view withText:@"加载中，请稍候..."];
    }
}
- (void)dataLoadDone:(HttpRequestPath)requestPath withObj:(NSString*)jsonData
{
    if (requestPath == HttpRequestPathForActivityList)
    {
        [self decodingJson:jsonData];
        [XMUtils removeWaitingView:self.view];
    }
}

- (void)decodingJson:(NSString *)jsonContent
{
    NSLog(@"%@",jsonContent);
    if (jsonContent.length > 0)
    {
        SBJsonParser *pause = [[SBJsonParser alloc] init];
        NSDictionary *dicData = [pause objectWithString:jsonContent];
        NSDictionary *array = [dicData objectForKey:@"result"];
        self.kdnumber.text = [array objectForKey:@"no"];
        self.daname.text = [array objectForKey:@"daname"];
        self.daphone.text = [array objectForKey:@"daphone"];
        self.daaddress.text = [array objectForKey:@"daaddress"];
        self.paname.text = [array objectForKey:@"paname"];
        self.paphone.text = [array objectForKey:@"paphone"];
        self.weight.text = [array objectForKey:@"weight"];
        self.cname.text = [array objectForKey:@"cname"];
        self.price.text = [array objectForKey:@"price"];
        kdid = [array objectForKeyedSubscript:@"id"];
    }
}

-(IBAction)zfb:(id)sender{
    zfbImage.image = [UIImage imageNamed:@"02.png"];
    wxImage.image = [UIImage imageNamed:@"01.png"];
    yhkImage.image = [UIImage imageNamed:@""];
}

-(IBAction)wx:(id)sender{
    zfbImage.image = [UIImage imageNamed:@"01.png"];
    wxImage.image = [UIImage imageNamed:@"02.png"];
    yhkImage.image = [UIImage imageNamed:@""];
    
    UIAlertView *warning2;
    warning2 = [[UIAlertView alloc]
                initWithTitle:@"提醒"
                message:@"微信支付暂不开放。"
                delegate:self
                cancelButtonTitle:@"确定"
                otherButtonTitles:nil, nil];
    
    [warning2 show];
}

-(IBAction)yhk:(id)sender{
    zfbImage.image = [UIImage imageNamed:@""];
    wxImage.image = [UIImage imageNamed:@""];
    yhkImage.image = [UIImage imageNamed:@"13.png"];
}

-(IBAction)pay:(id)sender{
    /*============================================================================*/
    /*=======================需要填写商户app申请的===================================*/
    /*============================================================================*/
    NSString *partner = @"2088911950469972";
    NSString *seller = @"nbsuda@163.com";
    NSString *privateKey = @"MIICeAIBADANBgkqhkiG9w0BAQEFAASCAmIwggJeAgEAAoGBANGEjEHPYZsCpq+A4560NV8cdUKF/GEcFJS4ox1JORcJLlXgK5JsnIt5wLb0Dj8Z3w7+qOxmvtmNA7XHK2y4XANBjfAsQobJa93h4gADBPEEAiPcpc+Mm0EYPlOcu2AeuX91+tRU6bEEhWamUIcRNr4hbZP4/X6h+a6EWo6q5oTVAgMBAAECgYEAnt5g8+3qVv3VorKa5lZDOhF8IKs0SfZe7L5sgOJq9bqydc97epX8xg3WQWQiAVr+toIHWOo3wQKaU5XoqZHJwhcHRPOGhUK220bmjwRNhCY+URkW6w83/GrvxeVoX8F6l2pTCZIEURW7qorYVyeLVysuJ691/6266SjE7B6wRMECQQDrfQFPHfx59x4knfUjcVv+yKozGhezz1CnTqCL7EvgTx2HLEwiZCZRzd2suDF7xEPE3X8CVIIIuabnqhCGNGNZAkEA48Rxe1vyMJEfptY+RVZGz6gSVgTRygwuPpLydEs271kezcCSaZzXdKMc7Jkt3bh2hA7TWwtdXcchDU0oCu+p3QJBAKHWlz+4a/umSaEAraheD8taPR5BoGiC4fsZnlyLWNofhTuQxgIcsfkmcmJxdBCLIcf6MX94dKVqcbpktlaFSoECQQCJdKFD4D5uHvbqGbuk3qeHZJgEP45YEDfMXaRimI3DrpYPd9skT5obcuDezKbIey1TDxtwg5BKKwWAYIL87pwlAkBYxm4I7dHnxnPvKMJM5jGyfu7dip0rnkG14y2tkW/yreR3csopQpqol0wHLh9FYfjIW/Be0GFx5/AqKjVKoVkd";
    /*============================================================================*/
    /*============================================================================*/
    /*============================================================================*/
    
    //partner和seller获取失败,提示
    if ([partner length] == 0 ||
        [seller length] == 0 ||
        [privateKey length] == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"缺少partner或者seller或者私钥。"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    /*
     *生成订单信息及签名
     */
    //将商品信息赋予AlixPayOrder的成员变量
    Order *order = [[Order alloc] init];
    order.partner = partner;
    order.seller = seller;
    order.tradeNO = kdid; //订单ID（由商家自行制定）
    order.productName = self.cname.text; //商品标题
    order.productDescription = self.weight.text; //商品描述
    double a = [self.price.text doubleValue];
    //double a = 0.01;
    order.amount = [NSString stringWithFormat:@"%.2f",a]; //商品价格
    order.notifyURL =  @"http://120.26.74.234/core/alipay/notify_url.php"; //回调URL
    
    order.service = @"mobile.securitypay.pay";
    order.paymentType = @"1";
    order.inputCharset = @"utf-8";
    order.itBPay = @"30m";
    order.showUrl = @"m.alipay.com";
    
    //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
    NSString *appScheme = @"alisdkdemo";
    
    //将商品信息拼接成字符串
    NSString *orderSpec = [order description];
    NSLog(@"orderSpec = %@",orderSpec);
    
    //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
    id<DataSigner> signer = CreateRSADataSigner(privateKey);
    NSString *signedString = [signer signString:orderSpec];
    
    //将签名成功字符串格式化为订单字符串,请严格按照该格式
    NSString *orderString = nil;
    if (signedString != nil) {
        orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                       orderSpec, signedString, @"RSA"];
        
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            NSLog(@"reslut = %@",resultDic);
            id len = [resultDic objectForKey:@"resultStatus"];
            NSLog(@"len===%@",len);
            int a = [len intValue];
            if (a == 9000) {
                UIViewController *next = [[self storyboard]instantiateViewControllerWithIdentifier:@"AlreadySendViewController"];
                [self.navigationController pushViewController:next animated:NO];
            }
        }];

    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
