//
//  XMToastView.m
//

#import "XMToastView.h"
#import <QuartzCore/QuartzCore.h>

#define kLeftDis 30
#define kLineDis 3
#define kMinHeight 35
#define kMinWidth 170
#define kToastTag 2001 //提示

@interface XMToastView()

@property (retain,nonatomic) NSString *message;

- (CGSize)captureTextSize:(int)textSize withText:(NSString *)text;
- (void)setTipsMessage:(NSString *)message;
- (CGFloat)captureLeftDis:(CGSize)size;
- (CGFloat)captureTopDis:(CGSize)size;

@end
    
@implementation XMToastView

@synthesize message   = _message;
@synthesize fontSize  = _textSize;
@synthesize showTimes = _showTimes;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //将图层的边框设置为圆脚 
        self.layer.cornerRadius = 8; 
        self.layer.masksToBounds = YES; 
        //给图层添加一个有色边框 
        //self.layer.borderWidth = 8; 
        //self.layer.borderColor = [UIColor grayColor].CGColor ;//[[UIColor colorWithRed:0.52 green:0.09 blue:0.07 alpha:0.5] CGColor];
        self.backgroundColor=[UIColor colorWithRed:3/255.f green:3/255.f blue:3/255.f alpha:0.5];
        self.frame=CGRectMake(20, 150, 280, 40);
        self.fontSize=16;
        self.showTimes=1.0f;
        self.tag=kToastTag;
    }
    return self;
}

- (void)setTipsMessage:(NSString *)message
{
    if(!message || [message isEqualToString:@""])
    {
        return;
    }
    self.message=message;
    CGSize size=[self captureTextSize:self.fontSize withText:message];
    CGFloat height=size.height;
    //int lines=height/2;
    height=height+2*kLineDis;
    height=MAX(height, kMinHeight);
    CGFloat width=size.width+2*kLeftDis;
    if (width<kMinWidth) {
        width=kMinWidth;
    }
    //NSLog(@"frame width:%f ,height:%f",size.width,size.height);
    CGPoint point=self.center;
    self.frame=CGRectMake(self.frame.origin.x,self.frame.origin.y,width,height);
    self.center=point;
}

//计算文本占用高度和宽度
- (CGSize)captureTextSize:(int)textSize withText:(NSString *)text
{
    //self.frame.size.width-kAcWidth-kDistance - (kLeft * 2)
    CGSize constraint = CGSizeMake(self.frame.size.width-kLeftDis*2, 20000.0f);
    CGSize size = [text sizeWithFont:[UIFont boldSystemFontOfSize:textSize] constrainedToSize:constraint lineBreakMode:NSLineBreakByWordWrapping];
    return size;
}

- (CGFloat)captureLeftDis:(CGSize)size
{
    //self.frame.size.width-kAcWidth-kDistance - (kLeft * 2)
    CGFloat left=(self.frame.size.width-size.width)/2.0f;
    left=MAX(left, kLeftDis);
    return left;
}

- (CGFloat)captureTopDis:(CGSize)size
{
    //self.frame.size.width-kAcWidth-kDistance - (kLeft * 2)
    CGFloat top=(self.frame.size.height-size.height)/2.0f;
    top=MAX(top, kLineDis);
    return top;
}

- (void)dismiss
{
    [self removeFromSuperview];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.*/
- (void)drawRect:(CGRect)rect
{
    //self.bounds=CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, height);
    if (_message) {
        CGSize size=[self captureTextSize:self.fontSize withText:_message];
        CGFloat left=[self captureLeftDis:size];
        CGFloat top=[self captureTopDis:size];
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
        [_message drawInRect:CGRectMake(left, top, size.width, size.height) withFont:[UIFont boldSystemFontOfSize:self.fontSize]];
    }
    [super drawRect:rect];
    [self performSelector:@selector(dismiss) withObject:nil afterDelay:self.showTimes];
}

- (void)dealloc
{
    [_message release];
    [super dealloc];
}

@end
