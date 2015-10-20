//
//  HttpClient.m
//  npf
//
//  Created by yulong chen on 12-5-2.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "HttpClient.h"
#import <CommonCrypto/CommonDigest.h>
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "ASIDownloadCache.h"
#import "NetworkTest.h"
#import "ASINetworkQueue.h"


@interface HttpClient (private)
-(void) initQueue;
-(void) showWaitView:(NSString *)msg;
-(void) removeWaitView;
-(void) showAlert:(NSString*) title strForMsg:(NSString*) msg withTag:(NSInteger) tag otherButtonTitles:(NSString*) btnTitle;

-(void) executeRequest:(ASIHTTPRequest *) request ;

@end

@implementation HttpClient
#define kRequestPathKey @"requestPath"
//以下是一些数据请求错误码的定义
#define kDATA_ERROR -500 //返回数据格式错误
#define kNET_ERROR -400  //网络异常
#define kNET_TIMEOUT -100 //网络超时
#define kPARAM_ERROR -2 //参数错误
#define kNO_RESULT 0 //请求结果为空
#define KOK 1 //请求OK


@synthesize delegate=_delegate;
@synthesize needTipsNetError=_needTipsNetError;
@synthesize rootView=_rootView;

static ASINetworkQueue *networkQueue;

-(void) initQueue{
    if (!networkQueue) {
        [[ASIDownloadCache sharedCache] setShouldRespectCacheControlHeaders:NO]; //设置缓存忽略http头
        [ASIHTTPRequest setShouldUpdateNetworkActivityIndicator:YES]; //是否显示网络请求信息在status bar上
        networkQueue = [[ASINetworkQueue alloc] init];
        [networkQueue setRequestDidStartSelector:@selector(requestStarted:)];
        [networkQueue setRequestDidFinishSelector:@selector(requestFinished:)];
        [networkQueue setRequestDidFailSelector:@selector(requestFailed:)];
        [networkQueue setShouldCancelAllRequestsOnFailure:NO ]; //设置为NO当取消了一个请求，不至于取消所有的请求
        [networkQueue setMaxConcurrentOperationCount:10]; //最大同时执行任务数
        //[networkQueue setShowAccurateProgress:[accurateProgress isOn]]; //设置精确控制进度
        //[networkQueue setDelegate:self];
        [networkQueue go];
    }
}

- (id)init
{
    self = [super init];
    if (self) {
        [self initQueue];
    }
    return self;
}

/** 
 * 释放网络请求
 */
+(void) releaseNetworkQueue{
    if (networkQueue) {
        [networkQueue cancelAllOperations];
        [networkQueue release];
        networkQueue=nil;
    }
}

-(id) initWithDelegate:(id<DataLoadStateDelegate>) delegate{
    self = [self init];
    if (self) {
        self.delegate=delegate;
    }
    return self;
}

+(id) httpClient{
    HttpClient *http = [[[self alloc] init] autorelease];
    return http;
}

+(id) httpClientWithDelegate:(id<DataLoadStateDelegate>) delegate{
    return [[[self alloc] initWithDelegate:delegate] autorelease];
}



-(void) executeRequest:(ASIHTTPRequest *) request {
    [request setShouldAttemptPersistentConnection:NO]; //设置是否重用链接
    [request setTimeOutSeconds:20]; //设置超时时间，单位秒
    [request setNumberOfTimesToRetryOnTimeout:0]; //设置请求超时时，设置重试的次数
    [request setDelegate:self];
    [request setShouldContinueWhenAppEntersBackground:YES];  //当应用后台运行时仍然请求数据
    [request setCachePolicy:ASIDoNotReadFromCacheCachePolicy]; //设置不使用缓存
    [networkQueue addOperation:request];
}


/**
 * @return 结果以接口回调dataLoadDone:code withObj:obj    code为通知请求发起者代码，obj为返回数据
 **/
-(void) LoadDataFromNet:(NSString*)url code:(NSInteger)code{
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:url]];
    NSMutableDictionary *userInfo=[NSMutableDictionary dictionary];
    [userInfo setValue:[NSNumber numberWithInteger:code] forKey:kRequestPathKey];
    request.userInfo=userInfo;
    [self executeRequest:request];
}



-(void) UploadHead:(NSString*)url pic:(NSString*) pic{

    //上传操作
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL: [NSURL URLWithString:url]];
    [request setFile: pic forKey: @"img"];
    NSMutableDictionary *userInfo=[NSMutableDictionary dictionary];
    [userInfo setValue:[NSNumber numberWithInt:HttpRequestPathForUploadHead] forKey:kRequestPathKey];
    request.userInfo=userInfo;
    [self executeRequest:request];
}

-(void) UploadPic:(NSString*)url pic:(NSString*) pic{
    
    //上传操作
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL: [NSURL URLWithString:url]];
    [request setFile: pic forKey: @"img"];
    NSMutableDictionary *userInfo=[NSMutableDictionary dictionary];
    [userInfo setValue:[NSNumber numberWithInt:HttpRequestPathForUploadPic] forKey:kRequestPathKey];
    request.userInfo=userInfo;
    [self executeRequest:request];
}

- (void)requestStarted:(ASIHTTPRequest *)request{ //请求开始
    if([_delegate respondsToSelector:@selector(dataStartLoad:)]){
        NSDictionary *userInfo=request.userInfo;
        HttpRequestPath requestPath=[[userInfo objectForKey:kRequestPathKey] intValue];
		[_delegate dataStartLoad:requestPath];
	}else {
        [self showWaitView:@"加载中，请稍后..."];
    }
}

- (void)requestFinished:(ASIHTTPRequest *)request{ //请求成功完成
    if (request.responseStatusCode!=200 && ![request didUseCachedResponse]) {
        [self requestFailed:request];
        return;
    }

    if([_delegate respondsToSelector:@selector(dataLoadDone:withObj:)]){
        NSDictionary *userInfo=request.userInfo;
        HttpRequestPath requestPath=[[userInfo objectForKey:kRequestPathKey] intValue];
        
        NSString *responseString = [request responseString];
        switch (requestPath) {
            case HttpRequestPathForLogin:
//            case HttpRequestPathForLogin:{
//                [self removeWaitView];
//                [_delegate dataLoadDone:requestPath withObj:responseString];
//                return;
//            }
                break;

            default:
                break;
                
        }
        [self removeWaitView];
        [_delegate dataLoadDone:requestPath withObj:responseString];
	}
}

- (void)requestFailed:(ASIHTTPRequest *)request{ //请求失败
    NSInteger errorCode=0;
    NSError *error=request.error;
    if (error) {
        errorCode=error.code;
        NSDictionary *errorInfo=error.userInfo;
        if (errorInfo && [errorInfo isKindOfClass:[NSDictionary class]]) {
            NSString *descrip=[errorInfo objectForKey:NSLocalizedDescriptionKey];
            NSRange range=[descrip rangeOfString:@"timed out"];
            if (range.location!=NSNotFound) {
                errorCode=kNET_TIMEOUT;
            }
        }
        if (errorCode==KOK) {
            errorCode=kNET_ERROR;
        }
        NSLog(@"request error:%@",error);
    } else if (![NetworkTest connectedToNetwork]) { 
        errorCode=kNET_ERROR;
    } else {
        errorCode=kNET_ERROR;
    }
    if (errorCode==kNET_ERROR || errorCode==kNET_TIMEOUT) {
        if (_needTipsNetError) {
//            NSString *title=@"温馨提示";
//            NSString *tips=@"你的网络很不给力，请检查是否已连接。";
//            [XMUtils showAlert:title strForMsg:tips withTag:111 otherButtonTitles:nil];
        }
    }
    
    [self removeWaitView];
    if([_delegate respondsToSelector:@selector(dataLoadDone:withObj:)]){
        NSDictionary *userInfo=request.userInfo;
        HttpRequestPath requestPath=[[userInfo objectForKey:kRequestPathKey] intValue];
		[_delegate dataLoadDone:requestPath withObj:nil];
	}
}



-(void) showWaitView:(NSString *)msg{
    if (!_waitingView) {
        CGRect rc = CGRectMake(60, 120,200, 120);
        _waitingView = [[WaitingView alloc] initWithFrame:rc];
        _waitingView.activityPosition=WaitingActivityInTop;
        _waitingView.rootView=_rootView;
        _waitingView.tag = kWaitingViewTag;
        _waitingView.showMessage = msg;
        [_waitingView show];
    }else {
        _waitingView.warningView.hidden=YES;
        _waitingView.showMessage = msg;
        [_waitingView setNeedsDisplay];
    } 
}

-(void) removeWaitView{
    if (_waitingView) {
        [_waitingView hide];
        [_waitingView release];
        _waitingView=nil;
    }
}



- (void)dealloc
{
    [self setDelegate:nil];
    [self removeWaitView];
    if (_waitingView) {
        [_waitingView release];
    }
    [_rootView release];
    
    [super dealloc];
}
@end
