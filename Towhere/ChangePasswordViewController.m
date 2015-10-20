//
//  ChangePasswordViewController.m
//  Towhere
//
//  Created by apple on 15/8/17.
//  Copyright (c) 2015年 elephant. All rights reserved.
//

#import "ChangePasswordViewController.h"
#import "SBJsonParser.h"
#import "XMUtils.h"
#import "AppDelegate.h"

@interface ChangePasswordViewController ()

@end

@implementation ChangePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(IBAction)back:(id)sender{
    UIViewController *next = [[self storyboard]instantiateViewControllerWithIdentifier:@"MineViewController"];
    [self.navigationController pushViewController:next animated:NO];
}

-(IBAction)finish:(id)sender{
    
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    if ([oldPassword.text isEqualToString:appDelegate.password]) {
        NSString *strPageUrl = [NSString stringWithFormat:@"http://120.26.74.234/index.php?c=user&a=changepassword&token=%@&password=%@&oldpassword=%@",appDelegate.token,password.text,oldPassword.text];
        
        HttpClient *http = [HttpClient httpClientWithDelegate:self];
        http.needTipsNetError = YES;
        [http LoadDataFromNet:strPageUrl code:HttpRequestPathForActivityList];
        
        UIViewController *next = [[self storyboard]instantiateViewControllerWithIdentifier:@"MineViewController"];
        [self.navigationController pushViewController:next animated:NO];
    }
    else{
        UIAlertView *warning3;
        warning3 = [[UIAlertView alloc]
                    initWithTitle:@"提醒"
                    message:@"原密码错误，请重新输入"
                    delegate:self
                    cancelButtonTitle:@"确定"
                    otherButtonTitles: nil];
        
        [warning3 show];
    }
    
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
    UIAlertView *warning2;
    warning2 = [[UIAlertView alloc]
                initWithTitle:@"提醒"
                message:@"修改成功"
                delegate:self
                cancelButtonTitle:@"确定"
                otherButtonTitles: nil];
    
    [warning2 show];
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
