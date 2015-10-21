//
//  EditViewController.m
//  Towhere
//
//  Created by apple on 15/9/15.
//  Copyright (c) 2015年 elephant. All rights reserved.
//

#import "EditViewController.h"
#import "AppDelegate.h"
#import "SBJsonParser.h"
#import "XMUtils.h"

@interface EditViewController ()

@end

@implementation EditViewController
@synthesize university;
@synthesize expres;
@synthesize receive;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    appDelegate.edit = @"1";   //编辑。
    
    if ([appDelegate.personnel isEqualToString:@"1"]&&[appDelegate.sfid isEqualToString:@"0"]) {
        [self.sf setTitle:receive.provincename forState:UIControlStateNormal];
        [self.sq setTitle:receive.cityname forState:UIControlStateNormal];
    }
    else if ([appDelegate.personnel isEqualToString:@"2"]){
        [self.sf setTitle:@"浙江省" forState:UIControlStateNormal];
        [self.sq setTitle:@"宁波市" forState:UIControlStateNormal];
        _sf.enabled = NO;
        _sq.enabled = NO;
    }
    else{
        int a = [appDelegate.sfid intValue];
        int b = [appDelegate.sqid intValue];
        if (a != 0 ) {
            [self.sf setTitle:appDelegate.sfname forState:UIControlStateNormal];
        }
        if (b != 0 ) {
            [self.sq setTitle:appDelegate.sqname forState:UIControlStateNormal];
        }
    }
    name.text = appDelegate.editname;
    phone.text = appDelegate.editphone;
    address.text = appDelegate.editaddress;
}

-(IBAction)back:(id)sender{
    UIViewController *next = [[self storyboard]instantiateViewControllerWithIdentifier:@"PersonnelViewController"];
    [self.navigationController pushViewController:next animated:NO];
}

-(IBAction)sf:(id)sender{
    UIViewController *next = [[self storyboard]instantiateViewControllerWithIdentifier:@"SfSqViewController"];
    [self.navigationController pushViewController:next animated:NO];
}

-(IBAction)sq:(id)sender{
    UIViewController *next = [[self storyboard]instantiateViewControllerWithIdentifier:@"ShiquViewController"];
    [self.navigationController pushViewController:next animated:NO];
}

-(IBAction)edit:(id)sender{
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    NSString *a = [name.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *b = [address.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    if ([appDelegate.personnel isEqualToString:@"1"]) {
        
        NSString *strPageUrl = [NSString stringWithFormat:@"http://120.26.74.234/index.php?c=deliveryaddress&a=edit&token=%@&cityid=%@&phone=%@&id=%@&name=%@&address=%@",appDelegate.token,appDelegate.sqid,appDelegate.editphone,appDelegate.editid,a,b];
        NSLog(@"http://120.26.74.234/index.php?c=deliveryaddress&a=edit&token=%@&cityid=%@&phone=%@&id=%@&name=%@&address=%@",appDelegate.token,appDelegate.sqid,appDelegate.editphone,appDelegate.editid,a,b);
        
        HttpClient *http = [HttpClient httpClientWithDelegate:self];
        http.needTipsNetError = YES;
        [http LoadDataFromNet:strPageUrl code:HttpRequestPathForActivityList];
    }
    else if ([appDelegate.personnel isEqualToString:@"2"]){
        NSString *strPageUrl = [NSString stringWithFormat:@"http://120.26.74.234/index.php?c=postaddress&a=edit&token=%@&phone=%@&id=%@&name=%@",appDelegate.token,appDelegate.editphone,appDelegate.editid,a];
        NSLog(@"http://120.26.74.234/index.php?c=postaddress&a=edit&token=%@&phone=%@&id=%@&name=%@",appDelegate.token,appDelegate.editphone,appDelegate.editid,a);
        
        HttpClient *http = [HttpClient httpClientWithDelegate:self];
        http.needTipsNetError = YES;
        [http LoadDataFromNet:strPageUrl code:HttpRequestPathForActivityList];
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
    
    UIViewController *next = [[self storyboard]instantiateViewControllerWithIdentifier:@"PersonnelViewController"];
    [self.navigationController pushViewController:next animated:NO];
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
