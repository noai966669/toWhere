//
//  QueryViewController.m
//  Towhere
//
//  Created by apple on 15/7/16.
//  Copyright (c) 2015年 elephant. All rights reserved.
//

#import "QueryViewController.h"
#import "AppDelegate.h"
#import "ReceiveCell.h"
#import "SBJsonParser.h"
#import "XMUtils.h"
#import "ListBean1.h"
#import  "Towhere-Swift.h"

@interface QueryViewController ()

@end

@implementation QueryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    if ([appDelegate.back isEqualToString:@"1"]) {
        comname.text = appDelegate.comname;
        number.text = appDelegate.kddh;
    }else{
        comname.text = @"";
        number.text = @"";
    }
    //comname.text = appDelegate.comname;
    comname.enabled = NO;
    //number.text = appDelegate.kddh;
    
    int a = [appDelegate.mailNo intValue];
    if (a != 0 ) {
        comname.text = appDelegate.expTextName;
        number.text = appDelegate.mailNo;
        appDelegate.code = appDelegate.expSpellName;
        [self loadDataFromNet];
    }
    NSLog(@"code==%@",appDelegate.code);
    appDelegate.mailNo = @"";
    appDelegate.expSpellName = @"";
    appDelegate.expTextName = @"";
    
    appDelegate.back = @"0";
    appDelegate.cellhight = @"2";
}

-(IBAction)close:(id)sender{
    [number resignFirstResponder];
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

-(IBAction)com:(id)sender{
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    appDelegate.back = @"1";
    appDelegate.kddh = number.text;
    appDelegate.kdback = @"1";
    
    UIViewController *next = [[self storyboard]instantiateViewControllerWithIdentifier:@"ExpressViewController"];
    [self.navigationController pushViewController:next animated:NO];
}

-(IBAction)query:(id)sender{
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSString *strPageUrl = [NSString stringWithFormat:@"http://api.ickd.cn/?id=112019&secret=9782958124314b20176452f95c11f731&com=%@&nu=%@&type=&encode=&ord=&lang=",appDelegate.code,number.text];
    
    HttpClient *http = [HttpClient httpClientWithDelegate:self];
    http.needTipsNetError = YES;
    [http LoadDataFromNet:strPageUrl code:HttpRequestPathForActivityList];
}

-(void)loadDataFromNet{
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSString *strPageUrl = [NSString stringWithFormat:@"http://api.ickd.cn/?id=112019&secret=9782958124314b20176452f95c11f731&com=%@&nu=%@&type=&encode=&ord=&lang=",appDelegate.code,number.text];
    
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
        NSArray *array = [dicData objectForKey:@"data"];
        _mutarrDataList =[[NSMutableArray alloc] init];
        
        NSLog(@"array.count=======%lu",(unsigned long)array.count);
        if (array.count == 0) {
            UIAlertView *warning1;
            warning1 = [[UIAlertView alloc]
                        initWithTitle:@"提醒"
                        message:@"请核对输入信息。"
                        delegate:self
                        cancelButtonTitle:@"重新输入"
                        otherButtonTitles: nil];
            
            [warning1 show];
        }
        else{
            for (int i = 0; i<array.count; i++)
            {
                id item2 = [array objectAtIndex:i];
            
                ListBean1 *bean = [[ListBean1 alloc]init];
               
                bean.detail = [item2 objectForKey:@"context"];
                bean.time = [item2 objectForKey:@"time"];
            
                [_mutarrDataList addObject:bean];
                
                if (i==0)
                {
                    //    将数据保存到数据库
                    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
                    MDeliveryHistory *aMDeliveryHistory=[[MDeliveryHistory alloc] initMDeliveryHistory:number.text aTime:bean.time aCode:appDelegate.code];
                    NSArray *arrMDeliveryHistory=[[NSArray alloc] initWithObjects:aMDeliveryHistory, nil];
                    [DatabaseDelivery saveDeliveryHistroy:arrMDeliveryHistory];
                }
            }
            NSString *expTextName = [dicData objectForKey:@"expTextName"];
            NSString *update = [dicData objectForKey:@"update"];
            NSString *expSpellName = [dicData objectForKey:@"expSpellName"];
            
            NSLog(@"====%@",expSpellName);
            //保存数据到本地。
            NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
            [defaults setObject:number.text forKey:@"mailNo"];         //快递单号。
            [defaults setObject:expTextName forKey:@"expTextName"];    //快递名称。
            [defaults setObject:update forKey:@"update"];              //时间戳。
            [defaults setObject:expSpellName forKey:@"expSpellName"];   //快递拼音。
            //弹出详情页面
            DetailDeliveryViewController *aDetailDeliveryViewController=[[DetailDeliveryViewController alloc] initWithNibName:@"DetailDeliveryViewController" bundle:nil];
            
            AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
            
            aDetailDeliveryViewController.aMDeliveryHistory=[[MDeliveryHistory alloc] initMDeliveryHistory:number.text aTime:@"" aCode:appDelegate.code];
            [self.navigationController pushViewController:aDetailDeliveryViewController animated:true];
            
            
            
            aDetailDeliveryViewController.aMDeliveryHistory = [[MDeliveryHistory alloc] initMDeliveryHistory:number.text aTime:@"未知" aCode:appDelegate.code];
            
            aDetailDeliveryViewController._mutarrDataList=_mutarrDataList;
        }
        self.tableView1.hidden=true;
//        [self.tableView1 reloadData];
    }
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
    cell.timeLabel.text = lsBean.time;
    return cell;
}

-(IBAction)record:(id)sender{
    DeliveryHistoryListViewController *aDeliveryHistoryListTableViewController=[[DeliveryHistoryListViewController alloc] initWithNibName:@"DeliveryHistoryListViewController" bundle:nil];
    
    [self.navigationController pushViewController:aDeliveryHistoryListTableViewController animated:true];
//    UIViewController *next = [[self storyboard]instantiateViewControllerWithIdentifier:@"RecordViewController"];
//    [self.navigationController pushViewController:next animated:NO];
}

-(IBAction)receive:(id)sender{
    UIViewController *next = [[self storyboard]instantiateViewControllerWithIdentifier:@"ReceiveViewController"];
    [self presentViewController:next animated:NO completion:nil];
}

-(IBAction)send:(id)sender{
    UIViewController *next = [[self storyboard]instantiateViewControllerWithIdentifier:@"SendViewController"];
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
