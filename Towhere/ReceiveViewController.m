//
//  ReceiveViewController.m
//  Towhere
//
//  Created by apple on 15/7/15.
//  Copyright (c) 2015年 elephant. All rights reserved.
//

#import "ReceiveViewController.h"
#import "ListBean1.h"
#import "ReceiveCell.h"
#import "SBJsonParser.h"
#import "Receive.h"
#import "XMUtils.h"
#import "AppDelegate.h"
#import "NavigationController.h"

@interface ReceiveViewController (){
    int a;
}

@end

@implementation ReceiveViewController
@synthesize tableView1;
@synthesize mutarrDataList = _mutarrDataList;
@synthesize myReceiveDetailViewController;

-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden=true;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    appDelegate.cellhight = @"1";
    a=0;
    [self loadDataFromNet];
}

//tableview长度。
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_mutarrDataList count];
}

//行高。
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ReceiveIdentifier=@"ReceiveCell";
    ReceiveCell *cell=[tableView dequeueReusableCellWithIdentifier:ReceiveIdentifier];
    if (cell==nil) {
        NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"ReceiveCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    //调用数据,传给cell。
    ListBean1 *lsBean = [_mutarrDataList objectAtIndex:indexPath.row];
    cell.detailLabel.text = lsBean.detail;

    //时间戳转换为时间。
    NSDateFormatter *formatter = [[[NSDateFormatter alloc] init] autorelease];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[lsBean.time doubleValue]];
    NSLog(@"confromTimesp  = %@",confromTimesp);
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    NSLog(@"confromTimespStr =  %@",confromTimespStr);
    
    cell.timeLabel.text = confromTimespStr;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    myReceiveDetailViewController = [story instantiateViewControllerWithIdentifier:@"ReceiveDetailViewController"];
    ReceiveCell *cell = (ReceiveCell *)[tableView cellForRowAtIndexPath:indexPath];
    Receive *receive1 = [Receive new];
    receive1.detail = cell.detailLabel.text;
    receive1.time = cell.timeLabel.text;
    myReceiveDetailViewController.receive = receive1;
    [self.navigationController pushViewController:myReceiveDetailViewController animated:YES];
}

- (void)loadDataFromNet
{
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSString *strPageUrl = [NSString stringWithFormat:@"http://120.26.74.234/index.php?c=delivery&a=getlist&token=%@&page=1",appDelegate.token];
    
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
    if (jsonContent.length > 0&& a != 1 )
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
            
            bean.detail = [item2 objectForKey:@"message"];
            bean.time = [item2 objectForKey:@"createtime"];
            bean.uid = [item2 objectForKey:@"id"];
            
//            NSLog(@"name==%@",bean.time);
            
            [_mutarrDataList addObject:bean];
        }
        [self.tableView1 reloadData];
    }
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
//***********************************************************************

-(IBAction)query:(id)sender{
    UIViewController *next = [[self storyboard]instantiateViewControllerWithIdentifier:@"QueryViewController"];
    [self.navigationController pushViewController:next animated:NO];
}

-(IBAction)send:(id)sender{
    UIViewController *next = [[self storyboard]instantiateViewControllerWithIdentifier:@"SendViewController"];
   // [self presentViewController:next animated:NO completion:nil];
    [self.navigationController pushViewController:next animated:NO];
}

//删除单行cell。
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    ListBean1 *lsBean = [_mutarrDataList objectAtIndex:indexPath.row];
    a=1;
    NSString *strPageUrl = [NSString stringWithFormat:@"http://120.26.74.234/index.php?c=delivery&a=delete&id=%@&token=%@",lsBean.uid,appDelegate.token];
    
    NSLog(@"http://120.26.74.234/index.php?c=delivery&a=delete&id=%@&token=%@",lsBean.uid,appDelegate.token);
    
    HttpClient *http = [HttpClient httpClientWithDelegate:self];
    http.needTipsNetError = YES;
    [http LoadDataFromNet:strPageUrl code:HttpRequestPathForActivityList];

    
    [self viewDidLoad];
    [self viewDidLoad];
    
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
