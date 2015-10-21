//
//  ViewController.m
//  Towhere
//
//  Created by apple on 15/7/15.
//  Copyright (c) 2015年 elephant. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "MyKeyChainHelper.h"

@interface ViewController ()

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    NSString *name = [defaults objectForKey:@"zhanghao"];//根据键值取出name
    NSLog(@"name==%@",name);
//    根据
    if ([defaults integerForKey:@"needAutoLogin"]){
    [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(login:) userInfo:nil
                                    repeats:false];
    }
    //[self dismissViewControllerAnimated:YES completion:nil];
   // [self show];
 //   int a = [name intValue];
//        UIViewController *next = [[self storyboard]instantiateViewControllerWithIdentifier:@"LoginViewController"];
//    
//        [self presentViewController:next animated:NO completion:nil];
     
    
}

//-(void)show{
//    UIViewController *next = [[self storyboard]instantiateViewControllerWithIdentifier:@"LoginViewController"];
//    [self presentViewController:next animated:NO completion:nil];
//}

-(IBAction)registerd:(id)sender{
    UIViewController *next = [[self storyboard]instantiateViewControllerWithIdentifier:@"RegisterdViewController"];
    [self presentViewController:next animated:NO completion:nil];
}

-(IBAction)login:(id)sender{
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    appDelegate.logout = @"0";  //从头登录。

    
    UIViewController *next = [[self storyboard]instantiateViewControllerWithIdentifier:@"LoginViewController"];
    [self presentViewController:next animated:NO completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
