//
//  AlreadySendViewController.m
//  Towhere
//
//  Created by apple on 15/8/10.
//  Copyright (c) 2015年 elephant. All rights reserved.
//

#import "AlreadySendViewController.h"
#import "AlreadySendCell.h"
#import "AlreadySend.h"
#import "SBJsonParser.h"
#import "XMUtils.h"
#import "ListBean1.h"
#import "AppDelegate.h"
#import "MJRefresh.h"
#import "Towhere-SWIFT.h"
@interface AlreadySendViewController (){
    int a;
}
@property (strong, nonatomic) IBOutlet UIButton *btnPortrait;

@end

@implementation AlreadySendViewController
@synthesize tableView1;
@synthesize mutarrDataList = _mutarrDataList;
@synthesize myAlreadyTwoViewController;
@synthesize btnPortrait;
- (void)viewDidLoad {
    [super viewDidLoad];
    btnPortrait.layer.masksToBounds=true;
    btnPortrait.layer.cornerRadius=btnPortrait.frame.size.width/2;
    [btnPortrait setImage:[DatabaseDelivery getUserPortrait] forState:UIControlStateNormal];
    // Do any additional setup after loading the view.
    tableView1.header=[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [tableView1.header beginRefreshing];
        [self loadDataFromNet];
        [tableView1.header endRefreshing];
    }];
    [self loadDataFromNet];
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

-(IBAction)waitsend:(id)sender{
    UIViewController *next = [[self storyboard]instantiateViewControllerWithIdentifier:@"SendViewController"];
    [self.navigationController pushViewController:next animated:NO];
}

-(IBAction)wantsend:(id)sender{
    UIViewController *next = [[self storyboard]instantiateViewControllerWithIdentifier:@"WantSendViewController"];
    [self.navigationController pushViewController:next animated:NO];
}

-(IBAction)query:(id)sender{
    UIViewController *next = [[self storyboard]instantiateViewControllerWithIdentifier:@"QueryViewController"];
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
    static NSString *AlreadySendIdentifier=@"AlreadySendCell";
    AlreadySendCell *cell=[tableView dequeueReusableCellWithIdentifier:AlreadySendIdentifier];
    if (cell==nil) {
        NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"AlreadySendCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
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
    cell.kdnumber.text = lsBean.kdnumber;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    myAlreadyTwoViewController = [story instantiateViewControllerWithIdentifier:@"AlreadyTwoViewController"];
    AlreadySendCell *cell = (AlreadySendCell *)[tableView cellForRowAtIndexPath:indexPath];
    AlreadySend *alreadySend1 = [AlreadySend new];
    alreadySend1.daname = cell.daname.text;
    alreadySend1.waittime = cell.time.text;
    alreadySend1.paname = cell.paname.text;
    alreadySend1.daaddress = cell.daaddress.text;
    alreadySend1.weight = cell.weight.text;
    alreadySend1.companyname = cell.companyname.text;
    alreadySend1.price = cell.price.text;
    alreadySend1.paphone = cell.paphone.text;
    alreadySend1.kdnumber = cell.kdnumber.text;
    myAlreadyTwoViewController.alreadySend = alreadySend1;
    [self.navigationController pushViewController:myAlreadyTwoViewController animated:YES];
}

- (void)loadDataFromNet
{
    a = 0;
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSString *strPageUrl = [NSString stringWithFormat:@"http://120.26.74.234/index.php?c=post&a=getpostlist&token=%@&page=1",appDelegate.token];
    NSLog(@"token==%@",appDelegate.token);
    
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
    if (jsonContent.length > 0 && a !=1)
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
            bean.kdnumber = [item2 objectForKey:@"no"];
            bean.waitsendID = [item2 objectForKey:@"id"];
            
            [_mutarrDataList addObject:bean];
        }
        [self.tableView1 reloadData];
    }
}

//删除单行cell。
//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
//    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
//
//    ListBean1 *lsBean = [_mutarrDataList objectAtIndex:indexPath.row];
//    NSString *strPageUrl = [NSString stringWithFormat:@"http://121.42.12.154/index.php?c=post&a=delete&id=%@&token=%@",lsBean.waitsendID,appDelegate.token];
//    
//    NSLog(@"http://121.42.12.154/index.php?c=post&a=delete&id=%@&token=%@",lsBean.waitsendID,appDelegate.token);
//    a = 1;
//    HttpClient *http = [HttpClient httpClientWithDelegate:self];
//    http.needTipsNetError = YES;
//    [http LoadDataFromNet:strPageUrl code:HttpRequestPathForActivityList];
//    
//    [self viewDidLoad];
//    UIViewController *next = [[self storyboard]instantiateViewControllerWithIdentifier:@"AlreadySendViewController"];
//    [self.navigationController pushViewController:next animated:NO];
//
//}

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
