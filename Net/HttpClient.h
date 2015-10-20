//
//  HttpClient.h
//  npf
//
//  Created by yulong chen on 12-5-2.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequestDelegate.h"
#import "WaitingView.h"

typedef enum {
    HttpRequestPathForLogin,           //用户登录
    HttpRequestPathForRegister,        //用户注册
    HttpRequestPathForUploadHead,      //上传头像
    HttpRequestPathForUploadPic,       //上传图片
    HttpRequestPathForActivityList,    //获取活动列表
    
} HttpRequestPath;

@protocol DataLoadStateDelegate <NSObject>

@optional
/*
 * 数据开始加载状态通知
 */
- (void)dataStartLoad:(HttpRequestPath)requestPath;

@required
/**
 * 数据加载状态通知
 * @param object 加载完成回调后返回的数据对象
 **/
- (void)dataLoadDone:(HttpRequestPath)requestPath withObj:(NSString*)jsonContent;
@end

//post数据类型
typedef enum
{
    kHttpRequestPostDataTypeNone,
	kHttpRequestPostDataTypeNormal,			// for normal data post, such as "user=name&password=psd"
	kHttpRequestPostDataTypeMultipart,        // for uploading images and files.
}HttpRequestPostDataType;

//本类中实现了app所有数据请求协议，全为异步请求，采用接口回调方式通知请求发起对象，需要实现DataLoadStateDelegate协议
@interface HttpClient : NSObject<ASIHTTPRequestDelegate>{
    WaitingView *_waitingView;
    //HttpRequestPath _requestPath;
    //ASIHTTPRequest *_request;
}

@property(nonatomic,assign) BOOL needTipsNetError; //是否需要提醒网络未连接状态
@property(nonatomic,retain) id<DataLoadStateDelegate> delegate;
@property(nonatomic,retain) UIView *rootView;

//初始化
-(id) initWithDelegate:(id<DataLoadStateDelegate>) delegate;

+(id) httpClient;

+(id) httpClientWithDelegate:(id<DataLoadStateDelegate>) delegate;

/** 
 * 释放网络请求
 */
+(void) releaseNetworkQueue;


/**
 * @param url 带参数的整个请求地址
 * @return 结果以接口回调dataLoadDone:code withObj:obj    code为通知请求发起者代码，obj为返回数据
 **/
-(void) LoadDataFromNet:(NSString*)url code:(NSInteger)code;


/**
 * 用户头像上传
 **/
-(void) UploadHead:(NSString*)url pic:(NSString*)pic;

/**
 * 上传讨论图片
 **/
-(void) UploadPic:(NSString*)url pic:(NSString*)pic;


@end
