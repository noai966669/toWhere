//
//  PersonnelViewController.m
//  Towhere
//
//  Created by apple on 15/8/17.
//  Copyright (c) 2015年 elephant. All rights reserved.
//

#import "PersonnelViewController.h"
#import "AppDelegate.h"
#import "SBJsonParser.h"
#import "XMUtils.h"
#import "ListBean1.h"
#import "SaveAddCell.h"
#import "Receive.h"



@interface PersonnelViewController ()

@end

@implementation PersonnelViewController
@synthesize tableView1;
@synthesize mutarrDataList = _mutarrDataList;
@synthesize myEditViewController;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    appDelegate.personnel = @"1";
    appDelegate.sfid = @"0";
    appDelegate.addpsid = @"2";   //新增收寄件人。
    appDelegate.edit = @"0";
    appDelegate.sfid = @"0";
    appDelegate.sqid= @"0";
    
    [self loadDataFromNet];
}

-(IBAction)back:(id)sender{
    UIViewController *next = [[self storyboard]instantiateViewControllerWithIdentifier:@"MyselfViewController"];
    [self.navigationController pushViewController:next animated:NO];
}

-(IBAction)addressee:(id)sender{
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    appDelegate.personnel = @"1";
    
    [self.addressee setBackgroundImage:[UIImage imageNamed:@"收件人11.png"] forState:UIControlStateNormal];
    [self.post setBackgroundImage:[UIImage imageNamed:@"寄件人22.png"] forState:UIControlStateNormal];
    [self loadDataFromNet];
}

-(IBAction)post:(id)sender{
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    appDelegate.personnel = @"2";
    
    [self.addressee setBackgroundImage:[UIImage imageNamed:@"收件人22.png"] forState:UIControlStateNormal];
    [self.post setBackgroundImage:[UIImage imageNamed:@"寄件人11.png"] forState:UIControlStateNormal];
    [self loadDataFromNet];
}

-(IBAction)add:(id)sender{
    UIViewController *next = [[self storyboard]instantiateViewControllerWithIdentifier:@"AddPersonnelViewController"];
    [self.navigationController pushViewController:next animated:NO];
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
    myEditViewController = [story instantiateViewControllerWithIdentifier:@"EditViewController"];
    SaveAddCell *cell = (SaveAddCell *)[tableView cellForRowAtIndexPath:indexPath];
    Receive *receive1 = [Receive new];
    receive1.name = cell.name.text;
    receive1.addID = cell.addID.text;
    receive1.phone = cell.phone.text;
    receive1.provincename = cell.provincename.text;
    receive1.cityname = cell.cityname.text;
    receive1.cityid = cell.cityid.text;
    receive1.address = cell.address.text;
    myEditViewController.receive = receive1;
    
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    appDelegate.editname = receive1.name;
    appDelegate.editid = receive1.addID;
    appDelegate.editphone = receive1.phone;
    appDelegate.editaddress = receive1.address;
    appDelegate.sqid = receive1.cityid;
    [self.navigationController pushViewController:myEditViewController animated:YES];
}

- (void)loadDataFromNet
{
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    if([appDelegate.personnel isEqualToString:@"1"]) {
        
        NSString *strPageUrl = [NSString stringWithFormat:@"http://120.26.74.234/index.php?c=deliveryaddress&a=getlist&token=%@&page=1",appDelegate.token];
        NSLog(@"token==%@",appDelegate.token);
        
        HttpClient *http = [HttpClient httpClientWithDelegate:self];
        http.needTipsNetError = YES;
        [http LoadDataFromNet:strPageUrl code:HttpRequestPathForActivityList];
    }
    else if ([appDelegate.personnel isEqualToString:@"2"]){
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
            
            bean.addID = [item2 objectForKey:@"id"];
            bean.name = [item2 objectForKey:@"name"];
            bean.phone = [item2 objectForKey:@"phone"];
            bean.address = [item2 objectForKey:@"address"];
            bean.cityid = [item2 objectForKey:@"cityid"];
            bean.cityname = [item2 objectForKey:@"cityname"];
            bean.provincename = [item2 objectForKey:@"provincename"];
            AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
            if ([appDelegate.personnel isEqualToString:@"2"]) {
                bean.cityname = @"宁波市";
                bean.provincename = @"浙江省";
            }
            
            [_mutarrDataList addObject:bean];
        }
        [self.tableView1 reloadData];
    }
}

//删除单行cell。
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    ListBean1 *lsBean = [_mutarrDataList objectAtIndex:indexPath.row];
    if ([appDelegate.personnel isEqualToString:@"1"]) {
        NSString *strPageUrl = [NSString stringWithFormat:@"http://120.26.74.234/index.php?c=deliveryaddress&a=delete&id=%@&token=%@",lsBean.addID,appDelegate.token];
        
        NSLog(@"http://121.42.12.154/index.php?c=deliveryaddress&a=delete&id=%@&token=%@",lsBean.addID,appDelegate.token);
        
        HttpClient *http = [HttpClient httpClientWithDelegate:self];
        http.needTipsNetError = YES;
        [http LoadDataFromNet:strPageUrl code:HttpRequestPathForActivityList];
    }
    else if ([appDelegate.personnel isEqualToString:@"2"]){
        NSString *strPageUrl = [NSString stringWithFormat:@"http://120.26.74.234/index.php?c=postaddress&a=delete&id=%@&token=%@",lsBean.addID,appDelegate.token];
        
        NSLog(@"http://121.42.12.154/index.php?c=deliveryaddress&a=delete&id=%@&token=%@",lsBean.addID,appDelegate.token);
        
        HttpClient *http = [HttpClient httpClientWithDelegate:self];
        http.needTipsNetError = YES;
        [http LoadDataFromNet:strPageUrl code:HttpRequestPathForActivityList];
    }
    
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
