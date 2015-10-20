//
//  LoginViewController.m
//  Towhere
//
//  Created by apple on 15/7/15.
//  Copyright (c) 2015年 elephant. All rights reserved.
//

#import "LoginViewController.h"
#import "SBJsonParser.h"
#import "XMUtils.h"
#import "AppDelegate.h"
#import "ListBean1.h"
#import "MyKeyChainHelper.h"


@interface LoginViewController ()

@end

@implementation LoginViewController
@synthesize mutarrDataList = _mutarrDataList;

NSString * const KEY_USERNAME = @"com.company.app.username";
NSString * const KEY_PASSWORD = @"com.company.app.password";


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    //调用记住的密码。
    phone.text = [MyKeyChainHelper getUserNameWithService:KEY_USERNAME];
    password.text = [MyKeyChainHelper getPasswordWithService:KEY_PASSWORD];

 //   [MyKeyChainHelper deleteWithUserNameService:KEY_USERNAME psaawordService:KEY_PASSWORD];
    
    int a =[phone.text intValue];
    if (a != 0&&[appDelegate.logout isEqualToString:@"0"]) {
        [self login];
    }
    else{
        
        phone.text = @"";
        password.text = @"";
        
    }
}

-(IBAction)back:(id)sender{
    UIViewController *next = [[self storyboard]
                              instantiateViewControllerWithIdentifier:@"ViewController"];
    //将needAutoLogin设置成0,手动回撤到ViewController则不需要再设置自动登陆
    [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"needAutoLogin"];
    
    [self presentViewController:next animated:NO completion:nil];

}

-(IBAction)password:(id)sender{
    UIViewController *next = [[self storyboard]instantiateViewControllerWithIdentifier:@"PasswordViewController"];
    [self presentViewController:next animated:NO completion:nil];
}

-(IBAction)login:(id)sender{
    if ([phone.text isEqualToString:@""] || [password.text isEqualToString:@""] || phone.text == nil || password.text == nil) {
        UIAlertView *b = [[UIAlertView alloc]initWithTitle:@"登入失败"
                                                   message:@"用户名和密码不能为空！"
                                                  delegate:nil
                                         cancelButtonTitle:@"重新登入"
                                         otherButtonTitles: nil];
        [b show];
        //将needAutoLogin设置成0
        [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"needAutoLogin"];
    }
    else
    {
        [self login];
    }
}

-(void) login
{
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    appDelegate.password = password.text;  //修改密码的时候用。
    //保存密码到本地。
    NSString* userName = phone.text;
    NSString* pwd = password.text;
    [MyKeyChainHelper saveUserName:userName userNameService:KEY_USERNAME psaaword:pwd psaawordService:KEY_PASSWORD];
    
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    NSString *name = phone.text;
    [defaults setObject:name forKey:@"zhanghao"];
    
    NSString *strPageUrl = [NSString stringWithFormat:@"http://120.26.74.234/index.php?c=user&a=login&phone=%@&password=%@",phone.text,password.text];
    NSLog(@"http://121.42.12.154/index.php?c=user&a=login&phone=%@&password=%@",phone.text,password.text);
        
    HttpClient *http = [HttpClient httpClientWithDelegate:self];
    http.needTipsNetError = YES;
    [http LoadDataFromNet:strPageUrl code:HttpRequestPathForActivityList];
}

- (void)dataStartLoad:(HttpRequestPath)requestPath
{
    [XMUtils hiddenTips:self.view];
    
    if (requestPath == HttpRequestPathForActivityList)
    {
        
        [XMUtils addWaitingView:self.view withText:@"登录中，请稍候..."];
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
        AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
        SBJsonParser *pause = [[SBJsonParser alloc] init];
        NSDictionary *dicData = [pause objectWithString:jsonContent];
        NSDictionary *item = [dicData objectForKey:@"result"];
        appDelegate.token = [item objectForKey:@"token"];
        
        NSLog(@"token====%@",appDelegate.token);

        
        if ([dicData objectForKey:@"result"]==nil || [[dicData objectForKey:@"result"] isKindOfClass:[NSNull class]]) {
            
            UIAlertView *b = [[UIAlertView alloc]initWithTitle:@"登入失败"
                                                       message:@"用户名或者密码错误。"
                                                      delegate:nil
                                             cancelButtonTitle:@"重新登入"
                                             otherButtonTitles: nil];
            [b show];
            //将needAutoLogin设置成0
            [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"needAutoLogin"];
            
        }
        else
        {
            [self performSegueWithIdentifier:@"login" sender:self];
            //将needAutoLogin设置成1
            [[NSUserDefaults standardUserDefaults] setInteger:1 forKey:@"needAutoLogin"];
        }
    }
    else
    {
        UIAlertView *b = [[UIAlertView alloc]initWithTitle:@"登入失败"
                                                   message:@"登录失败了。再是一次。"
                                                  delegate:nil
                                         cancelButtonTitle:@"重新登入"
                                         otherButtonTitles: nil];
        [b show];
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
