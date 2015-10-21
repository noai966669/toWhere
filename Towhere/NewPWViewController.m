//
//  NewPWViewController.m
//  Towhere
//
//  Created by apple on 15/9/10.
//  Copyright (c) 2015年 elephant. All rights reserved.
//

#import "NewPWViewController.h"
#import "AppDelegate.h"
#import "SBJsonParser.h"
#import "XMUtils.h"

@interface NewPWViewController ()

@end

@implementation NewPWViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(IBAction)back:(id)sender{
    UIViewController *next = [[self storyboard]instantiateViewControllerWithIdentifier:@"LoginViewController"];
    [self presentViewController:next animated:NO completion:nil];
}

-(IBAction)tijiao:(id)sender{
    if ([password.text isEqualToString:againPW.text]) {
        [self loadDataFromNet];
    }
    else{
        UIAlertView *b = [[UIAlertView alloc]initWithTitle:@"提交失败"
                                                   message:@"两次输入的密码不一样请重新输入。"
                                                  delegate:nil
                                         cancelButtonTitle:@"确定"
                                         otherButtonTitles: nil];
        [b show];
    }
}

- (void)loadDataFromNet{
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    NSString *strPageUrl = [NSString stringWithFormat:@"http://120.26.74.234/index.php?c=user&a=forgetchangepw&token=%@&password=%@",appDelegate.token,password.text];
    
    
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
    UIAlertView *a = [[UIAlertView alloc]initWithTitle:@"提交成功"
                                               message:@"新密码设置成功。"
                                              delegate:nil
                                     cancelButtonTitle:@"确定"
                                     otherButtonTitles: nil];
    [a show];
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
