//
//  helpFromOc.m
//  Towhere
//
//  Created by ai966669 on 15/10/18.
//  Copyright © 2015年 elephant. All rights reserved.
//

#import "helpFromOc.h"
#import "HttpClient.h"
#import "XMUtils.h"
#import "SBJsonParser.h"
#import "ListBean1.h"
#import "AppDelegate.h"
#import  "Towhere-Swift.h"
@implementation helpFromOc
@synthesize number;
-(void)loadDataFromNetBycodeAndNumber:(NSString *)code :(NSString*)number{
    NSString *strPageUrl = [NSString stringWithFormat:@"http://api.ickd.cn/?id=112019&secret=9782958124314b20176452f95c11f731&com=%@&nu=%@&type=&encode=&ord=&lang=",code,number];
    self.number=number;
    HttpClient *http = [HttpClient httpClientWithDelegate:self];
    http.needTipsNetError = YES;
    [http LoadDataFromNet:strPageUrl code:HttpRequestPathForActivityList];
}

- (void)dataStartLoad:(HttpRequestPath)requestPath
{
//    [XMUtils hiddenTips:self.view];
//    
//    if (requestPath == HttpRequestPathForActivityList)
//    {
//        
//        [XMUtils addWaitingView:self.view withText:@"加载中，请稍候..."];
//    }
}

- (void)dataLoadDone:(HttpRequestPath)requestPath withObj:(NSString*)jsonData
{
    if (requestPath == HttpRequestPathForActivityList)
    {
        [self decodingJson:jsonData];
    }
}

- (void)decodingJson:(NSString *)jsonContent
{
    NSLog(@"%@",jsonContent);
    if (jsonContent.length > 0)
    {
        SBJsonParser *pause = [[SBJsonParser alloc] init];
        NSDictionary *dicData = [pause objectWithString:jsonContent];
        NSArray *array = [dicData objectForKey:@"data"];
        _mutarrDataList =[[NSMutableArray alloc] init];
        
        NSLog(@"array.count=======%lu",(unsigned long)array.count);
        if (array.count == 0) {
            UIAlertView *warning1;
            warning1 = [[UIAlertView alloc]
                        initWithTitle:@"提醒"
                        message:@"请核对输入信息。"
                        delegate:self
                        cancelButtonTitle:@"重新输入"
                        otherButtonTitles: nil];
            
            [warning1 show];
        }
        else{
            for (int i = 0; i<array.count; i++)
            {
                id item2 = [array objectAtIndex:i];
                
                ListBean1 *bean = [[ListBean1 alloc]init];
                
                bean.detail = [item2 objectForKey:@"context"];
                bean.time = [item2 objectForKey:@"time"];
                
                [_mutarrDataList addObject:bean];
                
                if (i==0)
                {
                    //    将数据保存到数据库
                    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
                    MDeliveryHistory *aMDeliveryHistory=[[MDeliveryHistory alloc] initMDeliveryHistory:number aTime:bean.time aCode:appDelegate.code];
                    
                    NSArray *arrMDeliveryHistory=[[NSArray alloc] initWithObjects:aMDeliveryHistory, nil];
                    [DatabaseDelivery saveDeliveryHistroy:arrMDeliveryHistory];
                }


            }
//            NSString *expTextName = [dicData objectForKey:@"expTextName"];
//            NSString *update = [dicData objectForKey:@"update"];
//            NSString *expSpellName = [dicData objectForKey:@"expSpellName"];
//            
//            NSLog(@"====%@",expSpellName);
//            //保存数据到本地。
//            NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
//            [defaults setObject:number.text forKey:@"mailNo"];         //快递单号。
//            [defaults setObject:expTextName forKey:@"expTextName"];    //快递名称。
//            [defaults setObject:update forKey:@"update"];              //时间戳。
//            [defaults setObject:expSpellName forKey:@"expSpellName"];   //快递拼音。
        }
        [_aHelpFromOcDelegate dataLoadDone:_mutarrDataList];
//        [self.tableView1 reloadData];
    }
}

@end
