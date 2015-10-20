//
//  XMUtils.m
//

#import "XMUtils.h"
#import "WaitingView.h"
#import "XMToastView.h"
#import "Reachability.h"

@implementation XMUtils


#pragma mark - custom method
/**
 * 添加提示信息，如果有等待状态则更改
 * @param rootView 等待视图添加到的根视图
 * @param text 提示文字
 */
+ (void)changeWaitingViewStatus:(UIView *)rootView withText:(NSString *)text
{
    //NSLog(@"加载页面失败哦");
    WaitingView *waitingView = (WaitingView *)[rootView viewWithTag:kWaitingViewTag];
    if (!waitingView)
    {
        CGRect rc = CGRectMake(60, 120,200, 120);
        waitingView = [[WaitingView alloc] initWithFrame:rc];
        waitingView.activityPosition=WaitingActivityInTop;
        waitingView.tag = kWaitingViewTag;
        waitingView.showMessage = text;
        [rootView addSubview:waitingView];
        waitingView.warningView.hidden = NO;
        waitingView.activityIndicatorView.hidden = YES;
        [waitingView release];
    }
    else
    {
        waitingView.warningView.hidden = NO;
        waitingView.activityIndicatorView.hidden = YES;
        waitingView.showMessage = text;
        [waitingView setNeedsDisplay];
    }
}

/**
 * 添加等待状态信息，如果有提示状态则更改
 * @param rootView 等待视图添加到的根视图
 * @param text 提示文字
 */
+ (void)addWaitingView:(UIView *)rootView withText:(NSString *)text
{
    WaitingView *waitingView = (WaitingView *)[rootView viewWithTag:kWaitingViewTag];
    if (!waitingView)
    {
        CGRect rc = CGRectMake(760, 120,200, 120);
        waitingView = [[WaitingView alloc] initWithFrame:rc];
        waitingView.activityPosition=WaitingActivityInTop;
        waitingView.tag = kWaitingViewTag;
        waitingView.showMessage = text;
        [rootView addSubview:waitingView];
        [waitingView release];
    }
    else
    {
        waitingView.warningView.hidden=YES;
        waitingView.showMessage = text;
        [waitingView setNeedsDisplay];
        [rootView bringSubviewToFront:waitingView];
    } 
}

/**
 * 添加等待状态信息，如果有提示状态则更改
 * @param rootView 等待视图添加到的根视图
 * @param frame 
 * @param text 提示文字
 */
+ (void)addWaitingView:(UIView *)rootView frame:(CGRect)frame withText:(NSString *)text
{
    WaitingView *waitingView = (WaitingView *)[rootView viewWithTag:kWaitingViewTag];
    if (!waitingView)
    {
        waitingView = [[WaitingView alloc] initWithFrame:frame];
        waitingView.activityPosition=WaitingActivityInTop;
        waitingView.tag = kWaitingViewTag;
        waitingView.showMessage = text;
        [rootView addSubview:waitingView];
        [waitingView release];
    }
    else
    {
        waitingView.warningView.hidden=YES;
        waitingView.showMessage = text;
        [waitingView setNeedsDisplay];
    }
}

/**
 * 将之前添加的等待或提示信息移除
 * @param rootView 之前添加到的根视图
 **/
+ (void)removeWaitingView:(UIView *)rootView
{
    //NSLog(@"页面加载完成哦");
    UIView *waitingView = [rootView viewWithTag:kWaitingViewTag];
    if (waitingView)
    {
        [waitingView removeFromSuperview];
    }
}


/**
 * 显示Toast提示信息，提示信息2秒后消失
 * @param text 提示文字
 */
+ (void)showToast:(NSString *)text
{
    [XMUtils showToast:text withInterval:2.0f];
}

/**
 * 显示Toast提示信息，提示信息2秒后消失
 * @param text 提示文字
 * @param interval 提示信息显示时长，单位秒
 */
+ (void)showToast:(NSString *)text withInterval:(float)interval
{
    CGRect rc = CGRectMake(10, 150, 300, 40);
    XMToastView *toastView = [[XMToastView alloc] initWithFrame:rc];
    toastView.showTimes=interval;
    [toastView setTipsMessage:text];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    if (!window)
    {
        window = [[UIApplication sharedApplication].windows objectAtIndex:0];
    }
    [window addSubview:toastView];
    [toastView release];
}

/**
 * 显示Toast提示信息，提示信息2秒后消失
 * @param rootView 等待视图添加到的根视图
 * @param text 提示文字
 */
+ (void)showToast:(UIView *)rootView withText:(NSString *)text
{
    [XMUtils showToast:rootView withText:text withInterval:2.0];
}

/**
 * 显示Toast提示信息，提示信息interval秒后消失
 * @param rootView 等待视图添加到的根视图
 * @param text 提示文字
 * @param interval 提示信息显示时长，单位秒
 */
+ (void)showToast:(UIView *)rootView withText:(NSString *)text withInterval:(float)interval
{
    CGRect rc = CGRectMake(10, 150, 300, 40);
    XMToastView *toastView = [[XMToastView alloc] initWithFrame:rc];
    toastView.showTimes=interval;
    [toastView setTipsMessage:text];
    [rootView addSubview:toastView];
    [toastView release];
}

/**
 * 显示提示信息
 * @param parentView 父级视图
 * @param text 提示文字
 **/
+ (void)showTips:(UIView *)parentView text:(NSString *)text
{
    [XMUtils showTips:parentView frame:CGRectMake(10, 10, 300, 160) text:text];
}

/**
 * 显示提示信息
 * @param parentView 父级视图
 * @param frame 提示信息的frame
 * @param text 提示文字
 **/
+ (void)showTips:(UIView *)parentView frame:(CGRect)frame text:(NSString*)text
{
    UILabel *textView=(UILabel*)[parentView viewWithTag:kTipsTextTag];
    if (textView==nil) {
        CGFloat tempH=frame.size.height;
        CGFloat height=tempH>160?tempH-100:tempH;
        CGRect newFrame=CGRectMake(frame.origin.x+10, frame.origin.y, frame.size.width-20, height);
        textView=[[UILabel alloc] initWithFrame:newFrame];
        textView.textColor=[UIColor blackColor];
        textView.tag=kTipsTextTag;
        textView.backgroundColor=[UIColor clearColor];
        textView.textAlignment=NSTextAlignmentCenter;
        textView.font = [UIFont boldSystemFontOfSize:16];
        textView.highlighted = YES;//设置高亮      
        textView.numberOfLines=0;
        textView.adjustsFontSizeToFitWidth =  YES ; //设置字体大小适应label宽度
        textView.text=text;
        [parentView addSubview:textView];
        [textView release];
    }else {
        textView.frame=frame;
        textView.text=text;
    }
}

/**
 * 显示提示信息
 * @param parentView 父级视图
 * @param frame 提示信息的frame
 * @param text 提示文字
 * @param color 文字颜色
 **/
+ (void)showTips:(UIView *)parentView frame:(CGRect)frame text:(NSString*)text textColor:(UIColor*)color
{
    UILabel *textView=(UILabel*)[parentView viewWithTag:kTipsTextTag];
    if (textView==nil)
    {
        CGFloat tempH=frame.size.height;
        CGFloat height=tempH>160?tempH-100:tempH;
        CGRect newFrame=CGRectMake(frame.origin.x+10, frame.origin.y, frame.size.width-20, height);
        textView=[[UILabel alloc] initWithFrame:newFrame];
        textView.textColor=color;
        textView.tag=kTipsTextTag;
        textView.backgroundColor=[UIColor clearColor];
        textView.textAlignment=NSTextAlignmentCenter;
        textView.font = [UIFont boldSystemFontOfSize:16];
        textView.highlighted = YES;//设置高亮      
        textView.numberOfLines=0;
        textView.adjustsFontSizeToFitWidth =  YES ; //设置字体大小适应label宽度
        textView.text=text;
        [parentView addSubview:textView];
        [textView release];
    }
    else
    {
        textView.frame=frame;
        textView.text=text;
    }
}

/**
 * 隐藏提示信息
 * @param parentView 父级视图
 **/
+ (void)hiddenTips:(UIView*)parentView
{
    UILabel *textView=(UILabel*)[parentView viewWithTag:kTipsTextTag];
    [textView removeFromSuperview];
}

+ (void)showAlert:(NSString*)title strForMsg:(NSString*)msg withTag:(NSInteger)tag otherButtonTitles:(NSString*)btnTitle
{
    UIAlertView* alert;
    if(btnTitle)
    {
        alert = [[UIAlertView alloc] initWithTitle:title message:msg delegate:nil cancelButtonTitle:@"关闭"otherButtonTitles:btnTitle,nil];
    }
    else
    {
        alert = [[UIAlertView alloc] initWithTitle:title message:msg delegate:nil cancelButtonTitle:@"关闭" otherButtonTitles:btnTitle,nil];
    }
    alert.tag = tag;
    [alert show];
    [alert release];
}

+ (void)showAlert:(NSString*)title strForMsg:(NSString*)msg withTag:(NSInteger)tag withDelegate:(id<UIAlertViewDelegate>)delegate otherButtonTitles:(NSString*)btnTitle
{
    UIAlertView* alert;
    if(btnTitle)
    {
        alert = [[UIAlertView alloc] initWithTitle:title message:msg delegate:delegate cancelButtonTitle:@"关闭" otherButtonTitles:btnTitle,nil];
    }
    else
    {
        alert = [[UIAlertView alloc] initWithTitle:title message:msg delegate:delegate cancelButtonTitle:@"关闭" otherButtonTitles:btnTitle,nil];
    }
    alert.tag = tag;
    [alert show];
    [alert release];
}

+ (void)showAlert:(NSString*)title strForMsg:(NSString*)msg withTag:(NSInteger)tag withDelegate:(id<UIAlertViewDelegate>)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString*)btnTitle
{
    UIAlertView* alert;
    if(btnTitle){
        alert = [[UIAlertView alloc] initWithTitle:title message:msg delegate:delegate cancelButtonTitle:cancelButtonTitle otherButtonTitles:btnTitle,nil];
    }else{
        alert = [[UIAlertView alloc] initWithTitle:title message:msg delegate:delegate cancelButtonTitle:cancelButtonTitle otherButtonTitles:btnTitle,nil];
    }
    alert.tag = tag;
    [alert show];
    [alert release];
}

+ (float)heightForTableView:(float)reduceHeight
{
    float fTableHeight = 480 - reduceHeight;
    CGRect mainBounds = [[UIScreen mainScreen] bounds];
    if (mainBounds.size.height > 480)
    {
        fTableHeight = fTableHeight + 88;
    }
    return fTableHeight;
}

//利用正则表达式验证邮箱的合法性
+ (BOOL)isValidateEmail:(NSString *)email {
    
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

//获得系统当前使用语言
+ (NSString *)getPreferredLanguage
{
    NSUserDefaults *defs = [NSUserDefaults standardUserDefaults];
    NSArray  *languages  = [defs objectForKey:@"AppleLanguages"];
    NSString *preferredLang = [languages objectAtIndex:0];
    NSLog(@"Preferred Language:%@", preferredLang);
    return preferredLang;
}

//获取当前网络状态
+ (NSString *)getCurrentNet
{
    NSString *result;
    
    Reachability *reach = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    
    switch ([reach currentReachabilityStatus])
    {
        case NotReachable: //没有网络连接
            result = nil;
            break;
            
        case ReachableViaWWAN: //使用蜂窝网络
            result = @"FW";
            break;
            
        case ReachableViaWiFi: //使用
            result = @"WF";
            break;
            
        default:
            break;
    }
    
    return result;
}


@end
