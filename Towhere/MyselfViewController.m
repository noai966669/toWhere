//
//  MyselfViewController.m
//  Towhere
//
//  Created by apple on 15/7/15.
//  Copyright (c) 2015年 elephant. All rights reserved.
//

#import "MyselfViewController.h"

@interface MyselfViewController ()

@end

@implementation MyselfViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(IBAction)back:(id)sender{
    UIViewController *next = [[self storyboard]instantiateViewControllerWithIdentifier:@"ReceiveViewController"];
    [self.navigationController pushViewController:next animated:YES];
}

-(IBAction)myself:(id)sender{
    UIViewController *next = [[self storyboard]instantiateViewControllerWithIdentifier:@"MineViewController"];
    [self.navigationController pushViewController:next animated:YES];
}

-(IBAction)addpost:(id)sender{
    UIViewController *next = [[self storyboard]instantiateViewControllerWithIdentifier:@"PersonnelViewController"];
    [self.navigationController pushViewController:next animated:YES];
}

-(IBAction)advice:(id)sender{
    UIViewController *next = [[self storyboard]instantiateViewControllerWithIdentifier:@"ContentViewController"];
    [self.navigationController pushViewController:next animated:YES];
}

-(IBAction)recommend:(id)sender{
    
}

-(IBAction)about:(id)sender{
    UIViewController *next = [[self storyboard]instantiateViewControllerWithIdentifier:@"AboutViewController"];
    [self.navigationController pushViewController:next animated:YES];
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
