//
//  PasswordViewController.m
//  Towhere
//
//  Created by apple on 15/7/15.
//  Copyright (c) 2015年 elephant. All rights reserved.
//

#import "PasswordViewController.h"
#import "AppDelegate.h"
#import "SBJsonParser.h"
#import "XMUtils.h"

#import <SMS_SDK/SMS_SDK.h>
#import <SMS_SDK/CountryAndAreaCode.h>

@interface PasswordViewController ()
@property (strong, nonatomic) IBOutlet UIButton *btnOfYzm;
@property int secYzm;
@property NSTimer  *timerShowYzmSec;
@end

@implementation PasswordViewController
@synthesize timerShowYzmSec;
@synthesize secYzm;
- (void)viewDidLoad {
    [super viewDidLoad];
    [self  setBtn];
    secYzm=-1;
//    if (secYzm>=0){
//        _btnOfYzm.userInteractionEnabled=true;
//        timerShowYzmSec = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(changeSec) userInfo:nil repeats:true ];
//    }
    // Do any additional setup after loading the view.
}
-(void)viewDidDisappear:(BOOL)animated{
    if (timerShowYzmSec!=nil){
        [timerShowYzmSec invalidate];
        timerShowYzmSec=nil;
    }

}
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
-(IBAction)back:(id)sender{
    UIViewController *next = [[self storyboard]instantiateViewControllerWithIdentifier:@"LoginViewController"];
    [self presentViewController:next animated:NO completion:nil];
}

-(IBAction)yzm:(id)sender{
    if(!(secYzm>0)){
    [SMS_SDK getVerificationCodeBySMSWithPhone:phone.text
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
-(IBAction)tijiao:(id)sender{
    [SMS_SDK commitVerifyCode:yanzhengma.text result:^(enum SMS_ResponseState state) {
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

- (void)loadDataFromNet{
    
    NSString *strPageUrl = [NSString stringWithFormat:@"http://120.26.74.234/index.php?c=user&a=isuser&phone=%@",phone.text];
    
    
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
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    NSLog(@"%@",jsonContent);
    if (jsonContent.length > 0)
    {
        SBJsonParser *pause = [[SBJsonParser alloc] init];
        NSDictionary *dicData = [pause objectWithString:jsonContent];
        NSDictionary *array = [dicData objectForKey:@"result"];
        appDelegate.token = [array objectForKey:@"token"];
        NSLog(@"token===%@",appDelegate.token);
    }
    UIViewController *next = [[self storyboard]instantiateViewControllerWithIdentifier:@"NewPWViewController"];
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
