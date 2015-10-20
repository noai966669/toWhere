//
//  ExpressViewController.m
//  Towhere
//
//  Created by apple on 15/8/12.
//  Copyright (c) 2015年 elephant. All rights reserved.
//

#import "ExpressViewController.h"
#import "ExpressCell.h"
#import "Express.h"
#import "AppDelegate.h"
#import "SBJsonParser.h"
#import "XMUtils.h"
#import "ListBean1.h"

@interface ExpressViewController ()

@end

@implementation ExpressViewController
@synthesize tableView1;
@synthesize mutarrDataList = _mutarrDataList;
@synthesize myWantSendViewController = _myWantSendViewController;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadDataFromNet];
}

-(IBAction)back:(id)sender{
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    if ([appDelegate.kdback isEqualToString:@"1"]) {
        UIViewController *next = [[self storyboard]instantiateViewControllerWithIdentifier:@"QueryViewController"];
        [self.navigationController pushViewController:next animated:NO];
    }
    else if ([appDelegate.kdback isEqualToString:@"2"]){
        UIViewController *next = [[self storyboard]instantiateViewControllerWithIdentifier:@"WantSendViewController"];
        [self.navigationController pushViewController:next animated:NO];
    }
    
}

//tableview长度。
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_mutarrDataList count];
}

//行高。
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ExpressIdentifier=@"ExpressCell";
    ExpressCell *cell=[tableView dequeueReusableCellWithIdentifier:ExpressIdentifier];
    if (cell==nil) {
        NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"ExpressCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    //调用数据,传给cell。
    ListBean1 *lsBean = [_mutarrDataList objectAtIndex:indexPath.row];
    cell.companyname.text = lsBean.companyname;
    cell.companyid.text = lsBean.companyid;
    cell.code.text = lsBean.code;
//    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
//    appDelegate.companyid = lsBean.companyid;
//    appDelegate.companyname = lsBean.companyname;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    myWantSendViewController = [story instantiateViewControllerWithIdentifier:@"WantSendViewController"];
    ExpressCell *cell = (ExpressCell *)[tableView cellForRowAtIndexPath:indexPath];
    
    if ([appDelegate.back isEqualToString:@"1"]) {
        appDelegate.code = cell.code.text;
        appDelegate.comname = cell.companyname.text;
        UIViewController *next = [[self storyboard]instantiateViewControllerWithIdentifier:@"QueryViewController"];
        [self.navigationController pushViewController:next animated:NO];
    }
    else{
        Express *express1 = [Express new];
        express1.companyname = cell.companyname.text;
        express1.companyid = cell.companyid.text;
        myWantSendViewController.expres = express1;
        appDelegate.companyid = cell.companyid.text;
        appDelegate.companyname = cell.companyname.text;
        
        [self.navigationController pushViewController:myWantSendViewController animated:YES];
    }
}

- (void)loadDataFromNet
{
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    if ([appDelegate.back isEqualToString:@"1"]) {
        NSString *strPageUrl = [NSString stringWithFormat:@"http://120.26.74.234/index.php?c=area&a=getcheckcompany"];
        
        HttpClient *http = [HttpClient httpClientWithDelegate:self];
        http.needTipsNetError = YES;
        [http LoadDataFromNet:strPageUrl code:HttpRequestPathForActivityList];
    }else{
        NSString *strPageUrl = [NSString stringWithFormat:@"http://120.26.74.234/index.php?c=area&a=getcompany"];
        
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
            
            bean.companyid = [item2 objectForKey:@"id"];
            bean.companyname = [item2 objectForKey:@"name"];
            bean.code = [item2 objectForKey:@"code"];
            
            [_mutarrDataList addObject:bean];
        }
        [self.tableView1 reloadData];
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
