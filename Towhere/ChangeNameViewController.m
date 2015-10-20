//
//  ChangeNameViewController.m
//  Towhere
//
//  Created by apple on 15/8/14.
//  Copyright (c) 2015年 elephant. All rights reserved.
//

#import "ChangeNameViewController.h"
#import "AppDelegate.h"
#import "SBJsonParser.h"
#import "XMUtils.h"

@interface ChangeNameViewController ()

@end

@implementation ChangeNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    name.placeholder = appDelegate.username;
}

-(IBAction)back:(id)sender{
    UIViewController *next = [[self storyboard]instantiateViewControllerWithIdentifier:@"MineViewController"];
    [self.navigationController pushViewController:next animated:NO];
}

-(IBAction)finish:(id)sender{
    
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    NSString *a = [name.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"zxqk===%@",a);
    
    NSString *strPageUrl = [NSString stringWithFormat:@"http://120.26.74.234/index.php?c=user&a=changename&token=%@&name=%@",appDelegate.token,a];
    
    HttpClient *http = [HttpClient httpClientWithDelegate:self];
    http.needTipsNetError = YES;
    [http LoadDataFromNet:strPageUrl code:HttpRequestPathForActivityList];
    
    UIViewController *next = [[self storyboard]instantiateViewControllerWithIdentifier:@"MineViewController"];
    [self.navigationController pushViewController:next animated:NO];
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
