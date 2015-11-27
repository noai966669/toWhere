//
//  AppDelegate.m
//  Towhere
//
//  Created by apple on 15/7/15.
//  Copyright (c) 2015年 elephant. All rights reserved.
//

#import "AppDelegate.h"
#import <SMS_SDK/SMS_SDK.h>
#import "MyselfViewController.h"
#import "ReceiveViewController.h"
#import "ICSDrawerController.h"
#import <AlipaySDK/AlipaySDK.h>
#import "Towhere-Swift.h"
#import "XGPush.h"
#import "XGSetting.h"
#import "SBJsonParser.h"
#import "XMUtils.h"
#import "UMSocial.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialQQHandler.h"
#define appKey1 @"5b2655c71290"
#define appSecret1 @"55988074b9a3faadffa6f74cd3ae7845"

@interface AppDelegate ()

@end

@implementation AppDelegate
@synthesize deviceTokenStr;
@synthesize token;
@synthesize waitsendID;
@synthesize addname;
@synthesize addcityid;
@synthesize postname;
@synthesize postcityid;
@synthesize sendid;
@synthesize companyid;
@synthesize companyname;
@synthesize weight;
@synthesize price;
@synthesize addid;
@synthesize postid;
@synthesize username;
@synthesize userphone;
@synthesize userID;
@synthesize useruname;
@synthesize useruid;
@synthesize login;
@synthesize personnel;
@synthesize sfid;
@synthesize sfname;
@synthesize code;
@synthesize comname;
@synthesize back;
@synthesize addpsid;
@synthesize kddh;
@synthesize kdback;
@synthesize edit;
@synthesize sqname;
@synthesize sqid;
@synthesize editname;
@synthesize editid;
@synthesize editphone;
@synthesize editaddress;
@synthesize logout;
@synthesize mailNo;
@synthesize expTextName;
@synthesize expSpellName;
@synthesize status;
@synthesize edit2;
@synthesize cellhight;
@synthesize password;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //初始化应用，appKey和appSecret从后台申请得到
    [SMS_SDK registerApp:appKey1
              withSecret:appSecret1];
    //    创建数据库
    [DatabaseDelivery createDataBasedeliveryHistroy];
    
    //友盟初始化
    [UMSocialData setAppKey:@"5640c788e0f55a42040048bd"];
//    wx分享初始化
    [UMSocialWechatHandler setWXAppId:@"wx640c335963e22b33" appSecret:@"5640c788e0f55a42040048bd" url:@"http://www.nb-hb.cn/daole"];
//    qq分享初始化
    [UMSocialQQHandler setQQWithAppId:@"100424468" appKey:@"c7394704798a158208a74ab60104f0ba" url:@"http://www.nb-hb.cn/daole"];
    
    //注册通知
    //注销之后需要再次注册前的准备
    [XGPush startApp:2200156954  appKey:@"IR126KVYW68F"];
    void (^successCallback)(void) = ^(void){
        //如果变成需要注册状态
        if(![XGPush isUnRegisterStatus])
        {
            //iOS8注册push方法
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= _IPHONE80_
            
            float sysVer = [[[UIDevice currentDevice] systemVersion] floatValue];
            if(sysVer < 8){
                [self registerPush];
            }
            else{
                [self registerPushForIOS8];
            }
#else
            //iOS8之前注册push方法
            //注册Push服务，注册后才能收到推送
            [self registerPush];
#endif
        }
    };
    [XGPush initForReregister:successCallback];
    
    
    //推送反馈回调版本示例
    void (^successBlock)(void) = ^(void){
        //成功之后的处理
        NSLog(@"[XGPush]handleLaunching's successBlock");
    };
    
    void (^errorBlock)(void) = ^(void){
        //失败之后的处理
        NSLog(@"[XGPush]handleLaunching's errorBlock");
    };
    
    //角标清0
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    
    //清除所有通知(包含本地通知)
    //[[UIApplication sharedApplication] cancelAllLocalNotifications];
    
    [XGPush handleLaunching:launchOptions successCallback:successBlock errorCallback:errorBlock];
    
    
    [NSThread sleepForTimeInterval:3.0];
    [_window makeKeyAndVisible];
    
    return YES;
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    //注册设备
    NSString * deviceTokenStr = [XGPush registerDevice: deviceToken];
    
    //打印获取的deviceToken的字符串
    NSLog(@"deviceTokenStr is %@",deviceTokenStr);
    self.deviceTokenStr=deviceTokenStr;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    
    //跳转支付宝钱包进行支付，处理支付结果
    [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
        NSLog(@"result = %@",resultDic);
    }];
//    return YES;
    
       return  [UMSocialSnsService handleOpenURL:url];
}
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return  [UMSocialSnsService handleOpenURL:url];
}
- (void)application:(UIApplication*)application didReceiveRemoteNotification:(NSDictionary*)userInfo
{
    //推送反馈(app运行时)
    [XGPush handleReceiveNotification:userInfo];
    
    
    //回调版本示例
    /*
     void (^successBlock)(void) = ^(void){
     //成功之后的处理
     NSLog(@"[XGPush]handleReceiveNotification successBlock");
     };
     
     void (^errorBlock)(void) = ^(void){
     //失败之后的处理
     NSLog(@"[XGPush]handleReceiveNotification errorBlock");
     };
     
     void (^completion)(void) = ^(void){
     //失败之后的处理
     NSLog(@"[xg push completion]userInfo is %@",userInfo);
     };
     
     [XGPush handleReceiveNotification:userInfo successCallback:successBlock errorCallback:errorBlock completion:completion];
     */
}
-(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification{
    //notification是发送推送时传入的字典信息
    [XGPush localNotificationAtFrontEnd:notification userInfoKey:@"clockID" userInfoValue:@"myid"];
    
    //删除推送列表中的这一条
    [XGPush delLocalNotification:notification];
    //[XGPush delLocalNotification:@"clockID" userInfoValue:@"myid"];
    
    //清空推送列表
    //[XGPush clearLocalNotifications];
}

- (void)registerPushForIOS8{
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= _IPHONE80_
    
    //Types
    UIUserNotificationType types = UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
    
    //Actions
    UIMutableUserNotificationAction *acceptAction = [[UIMutableUserNotificationAction alloc] init];
    
    acceptAction.identifier = @"ACCEPT_IDENTIFIER";
    acceptAction.title = @"Accept";
    
    acceptAction.activationMode = UIUserNotificationActivationModeForeground;
    acceptAction.destructive = NO;
    acceptAction.authenticationRequired = NO;
    
    //Categories
    UIMutableUserNotificationCategory *inviteCategory = [[UIMutableUserNotificationCategory alloc] init];
    
    inviteCategory.identifier = @"INVITE_CATEGORY";
    
    [inviteCategory setActions:@[acceptAction] forContext:UIUserNotificationActionContextDefault];
    
    [inviteCategory setActions:@[acceptAction] forContext:UIUserNotificationActionContextMinimal];
    
    //    [acceptAction release];
    
    NSSet *categories = [NSSet setWithObjects:inviteCategory, nil];
    
    //    [inviteCategory release];
    
    
    UIUserNotificationSettings *mySettings = [UIUserNotificationSettings settingsForTypes:types categories:categories];
    
    [[UIApplication sharedApplication] registerUserNotificationSettings:mySettings];
    
    
    [[UIApplication sharedApplication] registerForRemoteNotifications];
#endif
}
//注册UserNotification成功的回调
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
{
    NSLog(@"注册UserNotification成功的回调");
    //用户已经允许接收以下类型的推送
    //UIUserNotificationType allowedTypes = [notificationSettings types];
    
}
//如果deviceToken获取不到会进入此事件
- (void)application:(UIApplication *)app didFailToRegisterForRemoteNotificationsWithError:(NSError *)err {
    
    NSString *str = [NSString stringWithFormat: @"Error: %@",err];
    
    NSLog(@"注册UserNotification失败%@",str);
    
}

- (void)registerPush{
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound)];
}
//- (void)postToken:(NSString*)deviceTokenStr{
//    
//    NSString *userId=[MyKeyChainHelper getPasswordWithService:@"com.company.app.userId"];
////    此处需要注意名字，tokenUser是
//    if (![userId  isEqual: @""]){
//        NSString *tokenUser=[[NSUserDefaults standardUserDefaults] valueForKey:@"token"];
//        NSString *strPageUrl = [NSString stringWithFormat:@"http://120.26.74.234/index.php?c=user&a=changeuserid&token=%@&userid=%@&environment=2",tokenUser,deviceTokenStr];
//        HttpClient *http = [HttpClient httpClientWithDelegate:self];
//        http.needTipsNetError = YES;
//        [http LoadDataFromNet:strPageUrl code:HttpRequestPathForActivityList];
//    }
//}
//
//- (void)dataStartLoad:(HttpRequestPath)requestPath
//{
//    //    [XMUtils hiddenTips:self.view];
//    
//    if (requestPath == HttpRequestPathForActivityList)
//    {
//        
//        //        [XMUtils addWaitingView:self.view withText:@"加载中，请稍候..."];
//    }
//}
//- (void)dataLoadDone:(HttpRequestPath)requestPath withObj:(NSString*)jsonData
//{
//    if (requestPath == HttpRequestPathForActivityList)
//    {
//        [self decodingJson:jsonData];
//    }
//}
//
//- (void)decodingJson:(NSString *)jsonContent
//{
////    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
//    
//    NSLog(@"%@",jsonContent);
//    if (jsonContent.length > 0)
//    {
//        SBJsonParser *pause = [[SBJsonParser alloc] init];
//        NSDictionary *dicData = [pause objectWithString:jsonContent];
//        NSDictionary *array = [dicData objectForKey:@"result"];
////        appDelegate.token = [array objectForKey:@"token"];
////        NSLog(@"token===%@",appDelegate.token);
//    }
//}
@end
