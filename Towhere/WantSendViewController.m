//
//  WantSendViewController.m
//  Towhere
//
//  Created by apple on 15/8/11.
//  Copyright (c) 2015年 elephant. All rights reserved.
//

#import "WantSendViewController.h"
#import "AppDelegate.h"
#import "SBJsonParser.h"
#import "XMUtils.h"
#import "ACETelPrompt.h"

@interface WantSendViewController (){
    int c;
    int f;  //用来判断提交还是计算价格。
    NSString *message;
}

@end

@implementation WantSendViewController
@synthesize addname = _addname;
@synthesize postname = _postname;
@synthesize weight = _weight;
@synthesize express = _express;
@synthesize price = _price;
@synthesize expres;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    f = 0;
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    appDelegate.addpsid = @"1";   //新增收寄件人跳转。
    
    c = [appDelegate.weight intValue];
    int a = [appDelegate.addid intValue];
    int b = [appDelegate.postid intValue];
    int d = [appDelegate.companyid intValue];
    int e = [appDelegate.weight intValue];
    if (a != 0) {
        self.addname.text = appDelegate.addname;
    }
    if (b != 0) {
        self.postname.text = appDelegate.postname;
    }
    if (d != 0) {
        self.express.text = appDelegate.companyname;
    }
    if (e == 0) {
        self.weight.text = @"0";
    }else{
        self.weight.text = appDelegate.weight;
    }

    
    [self loadDataFromNet];

}

-(IBAction)back:(id)sender{
    UIViewController *next = [[self storyboard]instantiateViewControllerWithIdentifier:@"SendViewController"];
    [self.navigationController pushViewController:next animated:NO];
}

-(IBAction)addressee:(id)sender{
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    appDelegate.sendid = @"1";
    appDelegate.personnel = @"1";
    
    UIViewController *next = [[self storyboard]instantiateViewControllerWithIdentifier:@"SaveAddViewController"];
    [self.navigationController pushViewController:next animated:NO];
}

-(IBAction)post:(id)sender{
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    appDelegate.sendid = @"2";
    appDelegate.personnel = @"2";
    
    UIViewController *next = [[self storyboard]instantiateViewControllerWithIdentifier:@"SaveAddViewController"];
    [self.navigationController pushViewController:next animated:NO];
}

-(IBAction)plus:(id)sender{
    c++;
    
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSString *stringInt = [NSString stringWithFormat:@"%d",c];    //int转NSString.
    appDelegate.weight = stringInt;
    self.weight.text = appDelegate.weight;
    
    [self loadDataFromNet];
}

-(IBAction)subtraction:(id)sender{
    c--;
    
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSString *stringInt = [NSString stringWithFormat:@"%d",c];    //int转NSString.
    appDelegate.weight = stringInt;
    self.weight.text = appDelegate.weight;
    
    [self loadDataFromNet];
}

-(IBAction)express:(id)sender{
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    appDelegate.kdback = @"2";
    
    UIViewController *next = [[self storyboard]instantiateViewControllerWithIdentifier:@"ExpressViewController"];
    [self.navigationController pushViewController:next animated:NO];
}

-(IBAction)call:(id)sender{
    [ACETelPrompt callPhoneNumber:@"057428837800"
                             call:^(NSTimeInterval duration) {
                                 NSLog(@"Use madea a call of %.1f seconds", duration);
                             } cancel:^{
                                 NSLog(@"User cancelled the call");
                             }];

}

-(IBAction)submit:(id)sender{
    f = 1;
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    int h = [appDelegate.addid intValue];
    int i = [appDelegate.postid intValue];
    int j = [appDelegate.companyid intValue];
    int k = [appDelegate.weight intValue];
    if (h == 0 || i == 0 || j == 0 || k == 0) {
        UIAlertView *b = [[UIAlertView alloc]initWithTitle:@"提示"
                                                   message:@"请填写完整信息"
                                                  delegate:nil
                                         cancelButtonTitle:@"确定"
                                         otherButtonTitles: nil];
        [b show];
    }
    else if(h !=0 && i != 0 && j != 0 && k !=0)
    {
        if ([appDelegate.edit2 isEqualToString:@"1"]) {
            NSString *strPageUrl = [NSString stringWithFormat:@"http://120.26.74.234/index.php?c=post&a=update&token=%@&id=%@&post_address_id=%@&delivery_address_id=%@&company=%@&weight=%@",appDelegate.token,appDelegate.waitsendID,appDelegate.postid,appDelegate.addid,appDelegate.companyid,appDelegate.weight];
            
            NSLog(@"http://120.26.74.234/index.php?c=post&a=update&token=%@&id=%@&post_address_id=%@&delivery_address_id=%@&company=%@&weight=%@",appDelegate.token,appDelegate.waitsendID,appDelegate.postid,appDelegate.addid,appDelegate.companyid,appDelegate.weight);
            
            HttpClient *http = [HttpClient httpClientWithDelegate:self];
            http.needTipsNetError = YES;
            [http LoadDataFromNet:strPageUrl code:HttpRequestPathForActivityList];
        }
        else{
            
        NSString *strPageUrl = [NSString stringWithFormat:@"http://120.26.74.234/index.php?c=post&a=addnew&token=%@&post_address_id=%@&delivery_address_id=%@&company=%@&weight=%@",appDelegate.token,appDelegate.postid,appDelegate.addid,appDelegate.companyid,appDelegate.weight];
    
        NSLog(@"http://120.26.74.234/index.php?c=post&a=addnew&token=%@&post_address_id=%@&delivery_address_id=%@&company=%@&weight=%@",appDelegate.token,appDelegate.postid,appDelegate.addid,appDelegate.companyid,appDelegate.weight);
    
        HttpClient *http = [HttpClient httpClientWithDelegate:self];
        http.needTipsNetError = YES;
        [http LoadDataFromNet:strPageUrl code:HttpRequestPathForActivityList];
        }
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadDataFromNet
{
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSString *strPageUrl = [NSString stringWithFormat:@"http://120.26.74.234/index.php?c=area&a=getPrice&cityid=%@&company_id=%@&weight=%@",appDelegate.addcityid,appDelegate.companyid,appDelegate.weight];
    
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
    
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    if (jsonContent.length > 0&&[appDelegate.edit2 isEqualToString:@"1"]&&f==1) {
        UIAlertView *b = [[UIAlertView alloc]initWithTitle:@"提示"
                                                   message:@"修改添加,请等待快递员处理"
                                                  delegate:nil
                                         cancelButtonTitle:@"确定"
                                         otherButtonTitles: nil];
        [b show];
        appDelegate.edit2 = @"0";
        UIViewController *next = [[self storyboard]instantiateViewControllerWithIdentifier:@"SendViewController"];
        [self.navigationController pushViewController:next animated:NO];
    }
    else{
    if (jsonContent.length > 0)
    {
        SBJsonParser *pause = [[SBJsonParser alloc] init];
        NSDictionary *dicData = [pause objectWithString:jsonContent];
        NSDictionary *array = [dicData objectForKey:@"result"];
        appDelegate.price = [array objectForKey:@"price"];
    }
    if (f == 0) {
        NSLog(@"price======%@",appDelegate.price);
        NSNumberFormatter* numberFormatter = [[NSNumberFormatter alloc] init];     //NSnumber转化为NSstring。
        self.price.text = [numberFormatter stringFromNumber:appDelegate.price];
    }
    else if (f == 1){
        UIAlertView *b = [[UIAlertView alloc]initWithTitle:@"提示"
                                                   message:@"成功添加,请等待快递员处理"
                                                  delegate:nil
                                         cancelButtonTitle:@"确定"
                                         otherButtonTitles: nil];
        [b show];
        
        UIViewController *next = [[self storyboard]instantiateViewControllerWithIdentifier:@"SendViewController"];
        [self.navigationController pushViewController:next animated:NO];
    }
    }
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
