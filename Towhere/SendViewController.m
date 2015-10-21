//
//  SendViewController.m
//  Towhere
//
//  Created by apple on 15/7/16.
//  Copyright (c) 2015年 elephant. All rights reserved.
//

#import "SendViewController.h"
#import "WaitSendCell.h"
#import "WaitSend.h"
#import "SBJsonParser.h"
#import "ListBean1.h"
#import "XMUtils.h"
#import "AppDelegate.h"
#import "MJRefresh.h"
@interface SendViewController ()

@end

@implementation SendViewController
@synthesize tableView1;
@synthesize mutarrDataList = _mutarrDataList;
@synthesize myWaitSendViewController;

- (void)loadView {
    
    [super loadView];
    [self loadDataFromNet];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    appDelegate.addcityid = @"";
    appDelegate.addid = @"";
    appDelegate.postid = @"";
    appDelegate.postcityid = @"";
    appDelegate.companyid = @"";
    appDelegate.companyname = @"";
    appDelegate.weight = @"";
    appDelegate.edit2 = @"";

    tableView1.header=[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [tableView1.header beginRefreshing];
        [self loadDataFromNet];
        [tableView1.header endRefreshing];
    }];
  
//    tableView1.tableView.addLegendHeaderWithRefreshingBlock({[weak self] () -> Void in
//        //nzz此处写从服务器拉取数据代码
//        print("开始拉取")
//        self?.requiredHistoyOfMsg()
//        print("结束拉取")
//    })
}

//*******************************************点击侧滑，手势写在navigation里面
#pragma mark - Configuring the view’s layout behavior

- (BOOL)prefersStatusBarHidden
{
    return NO;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

#pragma mark - ICSDrawerControllerPresenting

- (void)drawerControllerWillOpen:(ICSDrawerController *)drawerController
{
    self.view.userInteractionEnabled = NO;
}

- (void)drawerControllerDidClose:(ICSDrawerController *)drawerController
{
    self.view.userInteractionEnabled = YES;
}

-(IBAction)myself:(id)sender{
    [self.drawer open];
}

//************************************************************************

-(IBAction)wantsend:(id)sender{
    UIViewController *next = [[self storyboard]instantiateViewControllerWithIdentifier:@"WantSendViewController"];
    [self.navigationController pushViewController:next animated:NO];
}

-(IBAction)waitsend:(id)sender{
    [self.waitsend setBackgroundImage:[UIImage imageNamed:@"待寄11.png"] forState:UIControlStateNormal];
    [self.alreadysend setBackgroundImage:[UIImage imageNamed:@"已寄22.png"] forState:UIControlStateNormal];
}

-(IBAction)alreadysend:(id)sender{
    UIViewController *next = [[self storyboard]instantiateViewControllerWithIdentifier:@"AlreadySendViewController"];
    [self.navigationController pushViewController:next animated:NO];
}

//tableview长度。
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_mutarrDataList count];
}

//行高。
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 65;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *WaitSendIdentifier=@"WaitSendCell";
    WaitSendCell *cell=[tableView dequeueReusableCellWithIdentifier:WaitSendIdentifier];
    if (cell==nil) {
        NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"WaitSendCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
   // AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    //调用数据,传给cell。
    ListBean1 *lsBean = [_mutarrDataList objectAtIndex:indexPath.row];
    cell.daname.text = lsBean.daname;
    
    //时间戳转换为时间。
    NSDateFormatter *formatter = [[[NSDateFormatter alloc] init] autorelease];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[lsBean.waittime doubleValue]];
    NSLog(@"confromTimesp  = %@",confromTimesp);
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    NSLog(@"confromTimespStr =  %@",confromTimespStr);
    
    cell.time.text = confromTimespStr;
    cell.paname.text = lsBean.paname;
    cell.daaddress.text = lsBean.daaddress;
    cell.weight.text = lsBean.weight;
    cell.companyname.text = lsBean.companyname;
    cell.price.text = lsBean.price;
    cell.paphone.text = lsBean.paphone;
    cell.waitsendID.text = lsBean.waitsendID;
    cell.kdnumber.text = lsBean.kdnumber;
    cell.statusid.text = lsBean.status;
    cell.daid.text = lsBean.daid;
    cell.paid.text = lsBean.paid;
    int a = [lsBean.status intValue];
    if (a == 0) {
        cell.status.text = @"（未接单）";
    }
    else if (a == 1){
        cell.status.text = @"（已接单，未揽收）";
    }
    else if (a == 2){
        cell.status.text = @"（待付款）";
        cell.status.textColor = [UIColor redColor];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    myWaitSendViewController = [story instantiateViewControllerWithIdentifier:@"WaitSendViewController"];
    WaitSendCell *cell = (WaitSendCell *)[tableView cellForRowAtIndexPath:indexPath];
    WaitSend *waitSend1 = [WaitSend new];
    waitSend1.daname = cell.daname.text;
    waitSend1.waittime = cell.time.text;
    waitSend1.paname = cell.paname.text;
    waitSend1.daaddress = cell.daaddress.text;
    waitSend1.weight = cell.weight.text;
    waitSend1.companyname = cell.companyname.text;
    waitSend1.price = cell.price.text;
    waitSend1.paphone = cell.paphone.text;
    waitSend1.waitsendID = cell.waitsendID.text;
    waitSend1.kdnumber = cell.kdnumber.text;
    waitSend1.status = cell.statusid.text;
    waitSend1.daid = cell.daid.text;
    waitSend1.paid = cell.paid.text;
    myWaitSendViewController.waitSend = waitSend1;
    if ([waitSend1.status isEqualToString:@"2"]) {
        appDelegate.waitsendID = waitSend1.waitsendID;
        UIViewController *next = [[self storyboard]instantiateViewControllerWithIdentifier:@"WtSdTwoViewController"];
        [self.navigationController pushViewController:next animated:YES];
    }
    else{
        [self.navigationController pushViewController:myWaitSendViewController animated:YES];
    }
    NSLog(@"status===%@",waitSend1.status);
}

- (void)loadDataFromNet
{
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSString *strPageUrl = [NSString stringWithFormat:@"http://120.26.74.234/index.php?c=post&a=getunpostlist&page=1&token=%@",appDelegate.token];
    NSLog(@"http://120.26.74.234/index.php?c=post&a=getunpostlist&page=1&token=%@",appDelegate.token);
    
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
    if (jsonContent.length > 0)
    {
        SBJsonParser *pause = [[SBJsonParser alloc] init];
        NSDictionary *dicData = [pause objectWithString:jsonContent];
        NSArray *array = [dicData objectForKey:@"result"];
        _mutarrDataList =[[NSMutableArray alloc] init];
        
        NSLog(@"array.count=======%lu",(unsigned long)array.count);
        
        for (int i = 0; i<array.count; i++)
        {
            id item2 = [array objectAtIndex:i];
            
            ListBean1 *bean = [[ListBean1 alloc]init];
            
            bean.daname = [item2 objectForKey:@"daname"];
            bean.daaddress = [item2 objectForKey:@"daaddress"];
            bean.waittime = [item2 objectForKey:@"createtime"];
            bean.paname = [item2 objectForKey:@"paname"];
            bean.weight = [item2 objectForKey:@"weight"];
            bean.companyname = [item2 objectForKey:@"companyname"];
            bean.price = [item2 objectForKey:@"price"];
            bean.paphone = [item2 objectForKey:@"paphone"];
            bean.waitsendID = [item2 objectForKey:@"id"];
            bean.kdnumber = [item2 objectForKey:@"no"];
            bean.status = [item2 objectForKey:@"status"];
            bean.daid = [item2 objectForKey:@"daid"];
            bean.paid = [item2 objectForKey:@"paid"];
                        
            [_mutarrDataList addObject:bean];
        }
        [self.tableView1 reloadData];
    }
}

-(IBAction)receive:(id)sender{
//    UIViewController *next = [[self storyboard]instantiateViewControllerWithIdentifier:@"ReceiveViewController"];
//    [self presentViewController:next animated:NO completion:nil];
//    [self.navigationController pushViewController:myReceiverViewController animated:NO];
}

-(IBAction)query:(id)sender{
    UIViewController *next = [[self storyboard]instantiateViewControllerWithIdentifier:@"QueryViewController"];
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
