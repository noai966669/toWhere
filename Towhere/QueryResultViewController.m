//
//  QueryResultViewController.m
//  Towhere
//
//  Created by apple on 15/7/16.
//  Copyright (c) 2015年 elephant. All rights reserved.
//

#import "QueryResultViewController.h"

@interface QueryResultViewController ()

@end

@implementation QueryResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(IBAction)back:(id)sender{
    UIViewController *next = [[self storyboard]instantiateViewControllerWithIdentifier:@"QueryViewController"];
    [self.navigationController pushViewController:next animated:NO];
}

-(IBAction)receive:(id)sender{
    UIViewController *next = [[self storyboard]instantiateViewControllerWithIdentifier:@"ReceiveViewController"];
    [self.navigationController pushViewController:next animated:NO];
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
