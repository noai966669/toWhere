//
//  SaveAddViewController.m
//  Towhere
//
//  Created by apple on 15/8/11.
//  Copyright (c) 2015年 elephant. All rights reserved.
//

#import "SaveAddViewController.h"
#import "AddresseeViewController.h"
#import "SaveAddCell.h"
#import "SaveAdd.h"
#import "AppDelegate.h"
#import "SBJsonParser.h"
#import "ListBean1.h"
#import "XMUtils.h"

@interface SaveAddViewController (){
    int a;
}

@end

@implementation SaveAddViewController
@synthesize tableView1;
@synthesize mutarrDataList = _mutarrDataList;
@synthesize myAddresseeViewController = _myAddresseeViewController;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadDataFromNet];
}

//tableview长度。
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_mutarrDataList count];
}

//行高。
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 88;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *SaveAddIdentifier=@"SaveAddCell";
    SaveAddCell *cell=[tableView dequeueReusableCellWithIdentifier:SaveAddIdentifier];
    if (cell==nil) {
        NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"SaveAddCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    //调用数据,传给cell。
    ListBean1 *lsBean = [_mutarrDataList objectAtIndex:indexPath.row];
    cell.name.text = lsBean.name;
    cell.addID.text = lsBean.addID;
    cell.phone.text = lsBean.phone;
    cell.provincename.text = lsBean.provincename;
    cell.cityname.text = lsBean.cityname;
    cell.cityid.text = lsBean.cityid;
    cell.address.text = lsBean.address;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    myAddresseeViewCOntroller = [story instantiateViewControllerWithIdentifier:@"AddresseeViewController"];
    SaveAddCell *cell = (SaveAddCell *)[tableView cellForRowAtIndexPath:indexPath];
    SaveAdd *saveAdd1 = [SaveAdd new];
    saveAdd1.name = cell.name.text;
    saveAdd1.phone = cell.phone.text;
    saveAdd1.addID = cell.addID.text;
    saveAdd1.provincename = cell.provincename.text;
    saveAdd1.cityname = cell.cityname.text;
    saveAdd1.cityid = cell.cityid.text;
    saveAdd1.address = cell.address.text;
    myAddresseeViewCOntroller.saveAdd = saveAdd1;
    [self.navigationController pushViewController:myAddresseeViewCOntroller animated:YES];
}

- (void)loadDataFromNet
{
    a = 0;
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    if([appDelegate.sendid isEqualToString:@"1"]) {
        
        NSString *strPageUrl = [NSString stringWithFormat:@"http://120.26.74.234/index.php?c=deliveryaddress&a=getlist&token=%@&page=1",appDelegate.token];
        NSLog(@"token==%@",appDelegate.token);
        
        HttpClient *http = [HttpClient httpClientWithDelegate:self];
        http.needTipsNetError = YES;
        [http LoadDataFromNet:strPageUrl code:HttpRequestPathForActivityList];
    }
    else if ([appDelegate.sendid isEqualToString:@"2"]){
        NSString *strPageUrl = [NSString stringWithFormat:@"http://120.26.74.234/index.php?c=postaddress&a=getlist&token=%@&page=1",appDelegate.token];
        NSLog(@"token==%@",appDelegate.token);
    
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
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
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
            
            bean.addID = [item2 objectForKey:@"id"];
            bean.name = [item2 objectForKey:@"name"];
            bean.phone = [item2 objectForKey:@"phone"];
            bean.address = [item2 objectForKey:@"address"];
            bean.cityid = [item2 objectForKey:@"cityid"];
            bean.cityname = [item2 objectForKey:@"cityname"];
            bean.provincename = [item2 objectForKey:@"provincename"];
            if ([appDelegate.sendid isEqualToString:@"2"]) {
                bean.cityname = @"宁波市";
                bean.provincename = @"浙江省";
            }
            [_mutarrDataList addObject:bean];
        }
        [self.tableView1 reloadData];
    }
}


-(IBAction)back:(id)sender{
    UIViewController *next = [[self storyboard]instantiateViewControllerWithIdentifier:@"WantSendViewController"];
    [self.navigationController pushViewController:next animated:NO];
}

-(IBAction)add:(id)sender{
    UIViewController *next = [[self storyboard]instantiateViewControllerWithIdentifier:@"AddPersonnelViewController"];
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
