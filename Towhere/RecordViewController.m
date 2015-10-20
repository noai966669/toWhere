//
//  RecordViewController.m
//  Towhere
//
//  Created by apple on 15/7/17.
//  Copyright (c) 2015年 elephant. All rights reserved.
//

#import "RecordViewController.h"
#import "AppDelegate.h"

@interface RecordViewController ()

@end

@implementation RecordViewController
@synthesize mailNo = _mailNo;
@synthesize expTextName = _expTextName;
@synthesize update = _update;
@synthesize danhao = _danhao;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _second.enabled = NO;
    
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    self.expTextName.text = [defaults objectForKey:@"expTextName"];//根据键值取出expTextName。
    self.mailNo.text = [defaults objectForKey:@"mailNo"];
    NSString *update = [defaults objectForKey:@"update"];
    NSLog(@"update===%@",update);
    
    //时间戳转换为时间。
    NSDateFormatter *formatter = [[[NSDateFormatter alloc] init] autorelease];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[update doubleValue]];
    NSLog(@"confromTimesp  = %@",confromTimesp);
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    NSLog(@"confromTimespStr =  %@",confromTimespStr);
    
    self.update.text = confromTimespStr;
    int a = [update intValue];
    if (a == 0) {
        self.update.text = @"";
        self.danhao.text = @"";
    }
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    appDelegate.mailNo = self.mailNo.text;
    appDelegate.expTextName = self.expTextName.text;
    appDelegate.expSpellName = [defaults objectForKey:@"expSpellName"];
    
    
}

-(IBAction)back:(id)sender{
    UIViewController *next = [[self storyboard]instantiateViewControllerWithIdentifier:@"QueryViewController"];
    [self.navigationController pushViewController:next animated:NO];
}

-(IBAction)second:(id)sender{
    
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
