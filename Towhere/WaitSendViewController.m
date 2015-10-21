//
//  WaitSendViewController.m
//  Towhere
//
//  Created by apple on 15/7/28.
//  Copyright (c) 2015年 elephant. All rights reserved.
//

#import "WaitSendViewController.h"
#import "AppDelegate.h"
#import "XMUtils.h"
#import "SBJsonParser.h"

@interface WaitSendViewController (){
    int b;   //b=1,解析信息接口；b=2，解析删除接口。
}

@end

@implementation WaitSendViewController
@synthesize waitSend;
@synthesize daname = _daname;
@synthesize daaddress = _daaddress;
@synthesize paname = _paname;
@synthesize weight = _weight;
@synthesize companyname = _companyname;
@synthesize price = _price;
@synthesize paphone = _paphone;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.daname.text = waitSend.daname;
    self.daaddress.text = waitSend.daaddress;
    self.paname.text = waitSend.paname;
    self.weight.text = waitSend.weight;
    self.companyname.text = waitSend.companyname;
    self.price.text = waitSend.price;
    self.paphone.text = waitSend.paphone;
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    appDelegate.waitsendID = waitSend.waitsendID;
    appDelegate.status = waitSend.status;
    int a = [waitSend.status intValue];
    if (a == 0) {
        [self.sure setBackgroundImage:[UIImage imageNamed:@"待接单.png"] forState:UIControlStateNormal];
        //self.sure.enabled = NO;
    }
    else if (a == 1){
        [self.sure setBackgroundImage:[UIImage imageNamed:@"待揽件.png"] forState:UIControlStateNormal];
        //self.sure.enabled = NO;
    }
    else if (a == 2){
        [self.sure setBackgroundImage:[UIImage imageNamed:@"支付.png"] forState:UIControlStateNormal];
    }
    NSLog(@"a===%d",a);
    [self loadDataFromNet];
}

-(IBAction)back:(id)sender{
    UIViewController *next = [[self storyboard]instantiateViewControllerWithIdentifier:@"SendViewController"];
    [self.navigationController pushViewController:next animated:NO];
}

-(IBAction)edit:(id)sender{
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    appDelegate.postname = self.paname.text;
    appDelegate.postid = waitSend.paid;
    appDelegate.addname = self.daname.text;
    appDelegate.addid = waitSend.daid;
    appDelegate.weight = self.weight.text;
    appDelegate.companyname = self.companyname.text;
//    appDelegate.price = self.price.text;
    appDelegate.edit2 = @"1";
    
    UIViewController *next = [[self storyboard]instantiateViewControllerWithIdentifier:@"WantSendViewController"];
    [self.navigationController pushViewController:next animated:NO];
}

-(IBAction)deleteid:(id)sender{
    
    UIAlertView *warning2;
    warning2 = [[UIAlertView alloc]
                initWithTitle:@"提醒"
                message:@"是否确定删除？"
                delegate:self
                cancelButtonTitle:@"确定"
                otherButtonTitles:@"取消", nil];
    
    [warning2 show];
    
}

- (void)loadDataFromNet
{
    b = 1;
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSString *strPageUrl = [NSString stringWithFormat:@"http://120.26.74.234/index.php?c=post&a=get&token=%@&pid=%@",appDelegate.token,waitSend.waitsendID];
    NSLog(@"http://120.26.74.234/index.php?c=post&a=getunpostlist&page=1&token=%@",appDelegate.token);
    
    HttpClient *http = [HttpClient httpClientWithDelegate:self];
    http.needTipsNetError = YES;
    [http LoadDataFromNet:strPageUrl code:HttpRequestPathForActivityList];
    
}

//确定删除。
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex==0){
        b=2;
        AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
        NSString *strPageUrl = [NSString stringWithFormat:@"http://120.26.74.234/index.php?c=post&a=delete&id=%@&token=%@",waitSend.waitsendID,appDelegate.token];
        
        NSLog(@"http://121.42.12.154/index.php?c=post&a=delete&id=%@&token=%@",waitSend.waitsendID,appDelegate.token);
        
        HttpClient *http = [HttpClient httpClientWithDelegate:self];
        http.needTipsNetError = YES;
        [http LoadDataFromNet:strPageUrl code:HttpRequestPathForActivityList];
        
        UIViewController *next = [[self storyboard]instantiateViewControllerWithIdentifier:@"SendViewController"];
        [self.navigationController pushViewController:next animated:NO];
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
    
    if (b==1) {
        SBJsonParser *pause = [[SBJsonParser alloc] init];
        NSDictionary *dicData = [pause objectWithString:jsonContent];
        NSDictionary *array = [dicData objectForKey:@"result"];
        appDelegate.companyid = [array objectForKey:@"company"];
        appDelegate.addcityid = [array objectForKey:@"cityid"];
    }
}

-(IBAction)sure:(id)sender{
//    int a = [waitSend.kdnumber intValue];
//    NSLog(@"a===%d",a);
//    
//    if (a == 0) {
//        UIAlertView *b = [[UIAlertView alloc]initWithTitle:@"提示"
//                                                   message:@"此快递尚未被揽件，请等待快递员揽件。"
//                                                  delegate:nil
//                                         cancelButtonTitle:@"确定"
//                                         otherButtonTitles: nil];
//        [b show];
//    }
//    else{
//        UIViewController *next = [[self storyboard]instantiateViewControllerWithIdentifier:@"WtSdTwoViewController"];
//        [self.navigationController pushViewController:next animated:NO];
//    }
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
