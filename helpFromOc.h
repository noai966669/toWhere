//
//  helpFromOc.h
//  Towhere
//
//  Created by ai966669 on 15/10/18.
//  Copyright © 2015年 elephant. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpClient.h"

@protocol HelpFromOcDelegate <NSObject>
@required
/**
 * 数据加载状态通知
 * @param object 加载完成回调后返回的数据对象
 **/
- (void)dataLoadDone:(NSMutableArray*)mutarrDataList;
@end

@interface helpFromOc : NSObject<DataLoadStateDelegate>
@property (weak, nonatomic) id<HelpFromOcDelegate> aHelpFromOcDelegate;
@property (nonatomic , retain) NSMutableArray *mutarrDataList;
@property (nonatomic , retain) NSString *number;
-(void)loadDataFromNetBycodeAndNumber:(NSString *)code :(NSString*)number;
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;
@end
