//
//  MyselfViewController.m
//  Towhere
//
//  Created by apple on 15/7/15.
//  Copyright (c) 2015年 elephant. All rights reserved.
//

#import "MyselfViewController.h"
#import "Towhere-Swift.h"
#import "UMSocial.h"
@interface MyselfViewController ()
@property (strong, nonatomic) IBOutlet UIButton *btnPortrait;

@end

@implementation MyselfViewController
@synthesize btnPortrait;
- (void)viewDidLoad {
    [super viewDidLoad];
    btnPortrait.layer.masksToBounds=true;
    btnPortrait.layer.cornerRadius=btnPortrait.frame.size.width/2;
    [btnPortrait setImage:[DatabaseDelivery getUserPortrait] forState:UIControlStateNormal];
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
    

    [UMSocialData defaultData].extConfig.wechatFavoriteData.title=@"快递到了";
    
    [UMSocialData defaultData].extConfig.sinaData.shareText=@"为了让校园物流更高效，请使用快递到了";

    [UMSocialData defaultData].extConfig.wechatSessionData.title=@"快递到了";
    [UMSocialData defaultData].extConfig.wechatSessionData.shareText=@"为了让校园物流更高效，请使用快递到了";
    
    [UMSocialData defaultData].extConfig.wechatTimelineData.title=@"快递到了";
    [UMSocialData defaultData].extConfig.wechatTimelineData.shareText=@"为了让校园物流更高效，请使用快递到了";
    
    [UMSocialData defaultData].extConfig.emailData.title=@"快递到了";
    
    [UMSocialSnsService presentSnsIconSheetView:self.parentViewController
                                         appKey:@"5640c788e0f55a42040048bd"
                                      shareText:@"为了让校园物流更高效，请使用快递到了"
                                     shareImage:[UIImage imageNamed:@"logo-app108.png"]
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToWechatSession,UMShareToWechatTimeline,UMShareToWechatFavorite,UMShareToEmail,UMShareToSms,nil]
                                       delegate:nil];
    
    
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
