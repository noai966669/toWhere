//
//  NGthreeViewController.m
//  Towhere
//
//  Created by apple on 15/9/20.
//  Copyright (c) 2015年 elephant. All rights reserved.
//

#import "NGthreeViewController.h"
#import "ICSDrawerController.h"
#import "MyselfViewController.h"
#import "SendViewController.h"

@interface NGthreeViewController ()

@end

@implementation NGthreeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    SendViewController *SendVC = [mainStoryboard instantiateViewControllerWithIdentifier:@"SendViewController"];
    MyselfViewController *MyselfVC = [mainStoryboard instantiateViewControllerWithIdentifier:@"MyselfViewController"];
    
    ICSDrawerController * draw=[[ICSDrawerController alloc]initWithLeftViewController:MyselfVC centerViewController:SendVC];
    
    [self addChildViewController:draw];
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
