//
//  RegisterdViewController.m
//  Towhere
//
//  Created by apple on 15/7/15.
//  Copyright (c) 2015年 elephant. All rights reserved.
//

#import "RegisterdViewController.h"
#import "University.h"
#import "HttpClient.h"
#import "XMUtils.h"
#import "SBJsonParser.h"
#import "AppDelegate.h"

#import <SMS_SDK/SMS_SDK.h>
#import <SMS_SDK/CountryAndAreaCode.h>

@interface RegisterdViewController (){
    NSString *message;
}
@property (strong, nonatomic) IBOutlet UIButton *btnOfYzm;
@property NSTimer  *timerShowYzmSec;
@property int secYzm;
@end

@implementation RegisterdViewController
@synthesize university;
@synthesize timerShowYzmSec;
@synthesize secYzm;
//-(void)viewDidDisappear:(BOOL)animated{
//    
//    if (timerShowYzmSec!=nil){
//        [timerShowYzmSec invalidate];
//        timerShowYzmSec=nil;
//    }
//    
//}
-(void)setBtn
{
    _btnOfYzm.layer.masksToBounds=true;
    _btnOfYzm.layer.borderWidth=1;
    _btnOfYzm.layer.cornerRadius=4;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 228.0 / 255.0, 179.0 / 255.0, 22.0 / 255.0, 1 });
    [_btnOfYzm.layer setBorderColor:colorref];
    //(__bridge CGColorRef _Nullable)([UIColor colorWithRed:228.0 / 255.0 green:179.0 / 255.0 blue:22.0 / 255.0 alpha:1]);
    _btnOfYzm.titleLabel.text=@"获取验证码";
    _btnOfYzm.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    
}
-(void)changeSec{
    if (secYzm){
        _btnOfYzm.titleLabel.text=[NSString stringWithFormat:@"     %d秒", secYzm--];
    }else{
        if (timerShowYzmSec!=nil){
            [timerShowYzmSec invalidate];
            timerShowYzmSec=nil;
        }
        _btnOfYzm.titleLabel.text=@"获取验证码";
        _btnOfYzm.userInteractionEnabled=true;
    }
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    secYzm=-1;

    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    appDelegate.login = @"2";  //修改学校用到。2-说明未登录。
    
    universityName.text = university.name;
    universityName.enabled = NO;
    NSLog(@"uid==%@",university.uid);
    [self  setBtn];
//    if (secYzm>=0){
//        _btnOfYzm.userInteractionEnabled=true;
//        timerShowYzmSec = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(changeSec) userInfo:nil repeats:true ];
//    }
}

-(IBAction)back:(id)sender{
    UIViewController *next = [[self storyboard]instantiateViewControllerWithIdentifier:@"ViewController"];
    [self presentViewController:next animated:NO completion:nil];
}

-(IBAction)agreement:(id)sender{
    UIViewController *next = [[self storyboard]instantiateViewControllerWithIdentifier:@"AgreementViewController"];
    [self presentViewController:next animated:NO completion:nil];
}

-(IBAction)huoqu:(id)sender{
    if(!(secYzm>0)){
        [SMS_SDK getVerificationCodeBySMSWithPhone:iphone.text
                                              zone:@"86"
                                            result:^(SMS_SDKError *error)
         
         {
             if (!error)
             {
                 UIAlertView *warning2;
                 warning2 = [[UIAlertView alloc]
                             initWithTitle:@"提醒"
                             message:@"验证码发送成功"
                             delegate:self
                             cancelButtonTitle:@"确定"
                             otherButtonTitles: nil];
                 
                 [warning2 show];
                 NSLog(@"验证码发送成功");
                 if (timerShowYzmSec!=nil){
                     [timerShowYzmSec invalidate];
                     timerShowYzmSec=nil;
                 }
                 _btnOfYzm.userInteractionEnabled=false;
                 timerShowYzmSec = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(changeSec) userInfo:nil repeats:true ];
                 secYzm=60;
             }
             
             else
             {
                 UIAlertView* alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"验证码发送失败", nil)
                                                                 message:[NSString stringWithFormat:@"状态码：%zi ,错误描述：%@",error.errorCode,error.errorDescription]
                                                                delegate:self
                                                       cancelButtonTitle:NSLocalizedString(@"确定", nil)
                                                       otherButtonTitles:nil, nil];
                 [alert show];
             }
             
         }];
    }
}

-(IBAction)registerd:(id)sender{
    NSInteger a = [iphone.text integerValue];
    if ([iphone.text isEqual: @""]||[password.text isEqualToString:@""]||[universityName.text isEqualToString:@""]||[name.text isEqualToString:@""]) {
        UIAlertView *warning1;
        warning1 = [[UIAlertView alloc]
                    initWithTitle:@"提醒"
                    message:@"请填写全部内容"
                    delegate:self
                    cancelButtonTitle:@"确定"
                    otherButtonTitles: nil];
        
        [warning1 show];
    }else if (a > 19999999999|| a < 10000000000 ){
        UIAlertView *warning2;
        warning2 = [[UIAlertView alloc]
                    initWithTitle:@"提醒"
                    message:@"请填写有效手机号码"
                    delegate:self
                    cancelButtonTitle:@"确定"
                    otherButtonTitles: nil];
        
        [warning2 show];
    }
    else{
        [SMS_SDK commitVerifyCode:verification.text result:^(enum SMS_ResponseState state) {
            if (1 == state)
            {
                NSLog(@"验证成功");
                
                [self loadDataFromNet];
            }
            else if(0 == state)
            {
                NSLog(@"验证失败");
                UIAlertView* alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"提示", nil)
                                                                message:@"验证失败，请核对验证码。"
                                                               delegate:self
                                                      cancelButtonTitle:NSLocalizedString(@"确定", nil)
                                                      otherButtonTitles:nil, nil];
                [alert show];
            }
        }];
    }
}

- (void)loadDataFromNet{
    
    NSString *a = [name.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"zxqk===%@",a);
    
    NSString *b = [password.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"zxqk===%@",b);
    
    NSString *strPageUrl = [NSString stringWithFormat:@"http://120.26.74.234/index.php?c=user&a=reg&phone=%@&password=%@&uid=%@&name=%@",iphone.text,b,university.uid,a];
    
    NSLog(@"http://121.42.12.154/index.php?c=user&a=reg&phone=%@&password=%@&uid=%@&name=%@",iphone.text,b,university.uid,a);
    
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
        message = [dicData objectForKey:@"message"];
        NSLog(@"message===%@",message);
    }
    UIAlertView *warning3;
    warning3 = [[UIAlertView alloc]
                initWithTitle:@"提醒"
                message:message
                delegate:self
                cancelButtonTitle:@"确定"
                otherButtonTitles: nil];
    
    [warning3 show];
    
    UIViewController *next = [[self storyboard]instantiateViewControllerWithIdentifier:@"LoginViewController"];
    [self presentViewController:next animated:NO completion:nil];
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
