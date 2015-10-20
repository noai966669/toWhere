//
//  SfSqViewController.m
//  Towhere
//
//  Created by apple on 15/8/17.
//  Copyright (c) 2015年 elephant. All rights reserved.
//

#import "SfSqViewController.h"
#import "UniversityCell.h"
#import "SBJsonParser.h"
#import "AppDelegate.h"
#import "XMUtils.h"
#import "ListBean1.h"
#import "University.h"

@interface SfSqViewController ()

@end

@implementation SfSqViewController
@synthesize tabelView1;
@synthesize mutarrDataList = _mutarrDataList;
@synthesize myAddPersonnnelViewController;
@synthesize myEditViewController;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadDataFromNet];
}

-(IBAction)back:(id)sender{
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    if ([appDelegate.edit isEqualToString:@"1"]) {
        UIViewController *next = [[self storyboard]instantiateViewControllerWithIdentifier:@"EditViewController"];
        [self.navigationController pushViewController:next animated:NO];
    }
    else if ([appDelegate.edit isEqualToString:@"2"]){
        UIViewController *next = [[self storyboard]instantiateViewControllerWithIdentifier:@"AddPersonnelViewController"];
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
    static NSString *UniversityIdentifier=@"UniversityCell";
    UniversityCell *cell=[tableView dequeueReusableCellWithIdentifier:UniversityIdentifier];
    if (cell==nil) {
        NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"UniversityCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    //调用数据,传给cell。
    ListBean1 *lsBean = [_mutarrDataList objectAtIndex:indexPath.row];
    cell.nameLabel.text = lsBean.name;
    cell.uidLabel.text = lsBean.uid;

    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    if ([appDelegate.edit isEqualToString:@"1"]) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        UniversityCell *cell = (UniversityCell *)[tableView cellForRowAtIndexPath:indexPath];
        University *university1 = [University new];
        university1.name = cell.nameLabel.text;
        university1.uid = cell.uidLabel.text;
        appDelegate.sfname = cell.nameLabel.text;
        appDelegate.sfid = cell.uidLabel.text;
        myEditViewController.university = university1;
        
        UIViewController *next = [[self storyboard]instantiateViewControllerWithIdentifier:@"EditViewController"];
        [self.navigationController pushViewController:next animated:NO];
        UIAlertView *warning2;
        warning2 = [[UIAlertView alloc]
                    initWithTitle:@"提醒"
                    message:@"请选择市区"
                    delegate:self
                    cancelButtonTitle:@"确定"
                    otherButtonTitles: nil];
        
        [warning2 show];

    }
    else if ([appDelegate.edit isEqualToString:@"2"]){
        UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        myAddPersonnnelViewController = [story instantiateViewControllerWithIdentifier:@"AddPersonnelViewController"];
        UniversityCell *cell = (UniversityCell *)[tableView cellForRowAtIndexPath:indexPath];
        University *university1 = [University new];
        university1.name = cell.nameLabel.text;
        university1.uid = cell.uidLabel.text;
        appDelegate.sfname = cell.nameLabel.text;
        appDelegate.sfid = cell.uidLabel.text;
        myAddPersonnnelViewController.university = university1;
        [self.navigationController pushViewController:myAddPersonnnelViewController animated:YES];
    }
    
}

- (void)loadDataFromNet
{
    NSString *strPageUrl = [NSString stringWithFormat:@"http://120.26.74.234/index.php?c=area&a=getprovinces"];
    
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
            
            bean.name = [item2 objectForKey:@"name"];
            bean.uid = [item2 objectForKey:@"id"];
            
            NSLog(@"name==%@",bean.name);
            
            [_mutarrDataList addObject:bean];
        }
        [self.tabelView1 reloadData];
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
