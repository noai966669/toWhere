//
//  XMUtils.h

//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define kWaitingViewTag 1999 //等待
#define kTipsTextTag 2012 //提示信息tag


@interface XMUtils : NSObject


/**
 * 将之前添加的等待或提示信息移除
 * @param rootView 之前添加到的根视图
 **/
+ (void)removeWaitingView:(UIView *)rootView;

/**
 * 添加等待状态信息，如果有提示状态则更改
 * @param rootView 等待视图添加到的根视图
 * @param text 提示文字
 */
+ (void)addWaitingView:(UIView *)rootView withText:(NSString *)text;


/**
 * 添加等待状态信息，如果有提示状态则更改
 * @param rootView 等待视图添加到的根视图
 * @param frame
 * @param text 提示文字
 */
+ (void)addWaitingView:(UIView *)rootView frame:(CGRect)frame withText:(NSString *)text;

/**
 * 添加提示信息，如果有等待状态则更改
 * @param rootView 等待视图添加到的根视图
 * @param text 提示文字
 */
+ (void)changeWaitingViewStatus:(UIView *)rootView withText:(NSString *)text;

/**
 * 显示Toast提示信息，提示信息2秒后消失
 * @param text 提示文字
 */
+ (void)showToast:(NSString *)text;

/**
 * 显示Toast提示信息，提示信息2秒后消失
 * @param text 提示文字
 * @param interval 提示信息显示时长，单位秒
 */
+ (void)showToast:(NSString *)text withInterval:(float)interval;

/**
 * 显示Toast提示信息，提示信息2秒后消失
 * @param rootView 等待视图添加到的根视图
 * @param text 提示文字
 */
+ (void)showToast:(UIView *)rootView withText:(NSString *)text;

/**
 * 显示Toast提示信息，提示信息interval秒后消失
 * @param rootView 等待视图添加到的根视图
 * @param text 提示文字
 * @param interval 提示信息显示时长，单位秒
 */
+ (void)showToast:(UIView *)rootView withText:(NSString *)text withInterval:(float)interval;
/**
 * 显示提示信息
 * @param parentView 父级视图
 * @param text 提示文字
 **/
+ (void)showTips:(UIView *)parentView text:(NSString *)text;

/**
 * 显示提示信息
 * @param parentView 父级视图
 * @param frame 提示信息的frame
 * @param text 提示文字
 **/
+ (void)showTips:(UIView *)parentView frame:(CGRect)frame text:(NSString*)text;

/**
 * 显示提示信息
 * @param parentView 父级视图
 * @param frame 提示信息的frame
 * @param text 提示文字
 * @param color 文字颜色
 **/
+ (void)showTips:(UIView *)parentView frame:(CGRect)frame text:(NSString*)text textColor:(UIColor*)color;

/**
 * 隐藏提示信息
 * @param parentView 父级视图
 **/
+ (void)hiddenTips:(UIView*)parentView;


+ (void)showAlert:(NSString*)title strForMsg:(NSString*)msg withTag:(NSInteger)tag otherButtonTitles:(NSString*)btnTitle;

+ (void)showAlert:(NSString*)title strForMsg:(NSString*)msg withTag:(NSInteger)tag withDelegate:(id<UIAlertViewDelegate>)delegate otherButtonTitles:(NSString*)btnTitle;

+ (void)showAlert:(NSString*)title strForMsg:(NSString*)msg withTag:(NSInteger)tag withDelegate:(id<UIAlertViewDelegate>)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString*)btnTitle;

/**
 *@param reduceHeight 要减去的高度
 *@result float 返回TableView的高度
 */
+ (float)heightForTableView:(float)reduceHeight;

//利用正则表达式验证邮箱的合法性
+ (BOOL)isValidateEmail:(NSString *)email;

//获得系统当前使用语言
+ (NSString*)getPreferredLanguage;

//获取当前网络状态
+ (NSString *)getCurrentNet;

@end
