//
//  AddPersonnelViewController.m
//  Towhere
//
//  Created by apple on 15/8/17.
//  Copyright (c) 2015年 elephant. All rights reserved.
//

#import "AddPersonnelViewController.h"
#import "AppDelegate.h"
#import "HttpClient.h"
#import "XMUtils.h"

@interface AddPersonnelViewController ()

@end

@implementation AddPersonnelViewController
@synthesize titleLabel = _titleLabel;
@synthesize university;
@synthesize expres;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    appDelegate.edit = @"2";   //新增。
    
    if ([appDelegate.personnel isEqualToString:@"1"]&&[appDelegate.sfid isEqualToString:@"0"]) {
        self.titleLabel.text = @"添加收件人";
        [self.sf setTitle:@"选择省份" forState:UIControlStateNormal];
        [self.sq setTitle:@"选择市区" forState:UIControlStateNormal];
    }
    else if ([appDelegate.personnel isEqualToString:@"2"]){
        self.titleLabel.text = @"添加寄件人";
        [self.sf setTitle:@"浙江省" forState:UIControlStateNormal];
        [self.sq setTitle:@"宁波市" forState:UIControlStateNormal];
        _sf.enabled = NO;
        _sq.enabled = NO;
    }
    else{
    int a = [appDelegate.sfid intValue];
    int b = [expres.companyid intValue];
    if (a != 0 ) {
        [self.sf setTitle:appDelegate.sfname forState:UIControlStateNormal];
        //appDelegate.sfid = university.uid;
    }
    if (b != 0 ) {
        [self.sq setTitle:expres.companyname forState:UIControlStateNormal];
    }
    NSLog(@"sfid===%@",appDelegate.sfid);
    }
    
}

-(IBAction)back:(id)sender{
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    if ([appDelegate.addpsid isEqualToString:@"1"]) {
        UIViewController *next = [[self storyboard]instantiateViewControllerWithIdentifier:@"SaveAddViewController"];
        [self.navigationController pushViewController:next animated:NO];
    }
    else if ([appDelegate.addpsid isEqualToString:@"2"]){
        UIViewController *next = [[self storyboard]instantiateViewControllerWithIdentifier:@"PersonnelViewController"];
        [self.navigationController pushViewController:next animated:NO];
    }
}

-(IBAction)sf:(id)sender{
    UIViewController *next = [[self storyboard]instantiateViewControllerWithIdentifier:@"SfSqViewController"];
    [self.navigationController pushViewController:next animated:NO];
}

-(IBAction)sq:(id)sender{
    UIViewController *next = [[self storyboard]instantiateViewControllerWithIdentifier:@"ShiquViewController"];
    [self.navigationController pushViewController:next animated:NO];
}

-(IBAction)add:(id)sender{
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    NSString *a = [name.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];  //名字转化为utf-8。
    NSString *b = [address.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];  //名字转化为utf-8。
    int n = [expres.companyid intValue];
    if([appDelegate.personnel isEqualToString:@"1"]&& n!=0 ) {
        
        NSString *strPageUrl = [NSString stringWithFormat:@"http://120.26.74.234/index.php?c=deliveryaddress&a=add&token=%@&cityid=%@&phone=%@&name=%@&address=%@",appDelegate.token,expres.companyid,phone.text,a,b];
        NSLog(@"token==%@",appDelegate.token);
        
        HttpClient *http = [HttpClient httpClientWithDelegate:self];
        http.needTipsNetError = YES;
        [http LoadDataFromNet:strPageUrl code:HttpRequestPathForActivityList];
    }
    else if ([appDelegate.personnel isEqualToString:@"2"]){
        NSString *strPageUrl = [NSString stringWithFormat:@"http://120.26.74.234/index.php?c=postaddress&a=add&token=%@&phone=%@&name=%@&address=%@",appDelegate.token,phone.text,a,b];
        NSLog(@"token==%@",appDelegate.token);
        
        HttpClient *http = [HttpClient httpClientWithDelegate:self];
        http.needTipsNetError = YES;
        [http LoadDataFromNet:strPageUrl code:HttpRequestPathForActivityList];
    }
    else if (n == 0){
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"提示", nil)
                                                        message:@"请选择省份市区。"
                                                       delegate:self
                                              cancelButtonTitle:NSLocalizedString(@"确定", nil)
                                              otherButtonTitles:nil, nil];
        [alert show];
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
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    if ([appDelegate.addpsid isEqualToString:@"1"]) {
        UIViewController *next = [[self storyboard]instantiateViewControllerWithIdentifier:@"SaveAddViewController"];
        [self.navigationController pushViewController:next animated:NO];
    }
    else if ([appDelegate.addpsid isEqualToString:@"2"]){
        UIViewController *next = [[self storyboard]instantiateViewControllerWithIdentifier:@"PersonnelViewController"];
        [self.navigationController pushViewController:next animated:NO];
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
