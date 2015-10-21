//
//  ContentViewController.m
//  Towhere
//
//  Created by apple on 15/8/17.
//  Copyright (c) 2015年 elephant. All rights reserved.
//

#import "ContentViewController.h"
#import "AppDelegate.h"
#import "SBJsonParser.h"
#import "XMUtils.h"

@interface ContentViewController ()

@end

@implementation ContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(IBAction)back:(id)sender{
    UIViewController *next = [[self storyboard]instantiateViewControllerWithIdentifier:@"MyselfViewController"];
    [self.navigationController pushViewController:next animated:NO];
}

-(IBAction)finish:(id)sender{
    
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    NSString *a = [self.content.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"zxqk===%@",a);
    
    NSString *strPageUrl = [NSString stringWithFormat:@"http://120.26.74.234/index.php?c=advice&a=add&token=%@&content=%@",appDelegate.token,a];
    
    HttpClient *http = [HttpClient httpClientWithDelegate:self];
    http.needTipsNetError = YES;
    [http LoadDataFromNet:strPageUrl code:HttpRequestPathForActivityList];
    
//    UIViewController *next = [[self storyboard]instantiateViewControllerWithIdentifier:@"ReceiveViewController"];
//    [self.navigationController pushViewController:next animated:NO];
    [self performSegueWithIdentifier:@"go" sender:self];
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
    UIAlertView *warning;
    warning = [[UIAlertView alloc]
               initWithTitle:nil
               message:@"提交成功，感谢您的宝贵建议！"
               delegate:self
               cancelButtonTitle:@"确定"
               otherButtonTitles:nil, nil];
    
    [warning show];
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
