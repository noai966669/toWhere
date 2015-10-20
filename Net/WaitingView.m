//
//  WaitingView.h
//

#import "WaitingView.h"
#import <QuartzCore/QuartzCore.h> 

#define kAcWidth 40 //小菊花直径
#define kDistance 5 //小菊花与字间距
#define kLeft 5 // 小菊花x轴起始位置
#define kFontSize 15 //字体大小

@interface WaitingView (private)

-(CGFloat) captureLeftDis:(NSString *) text;
-(void) sizeToFitView;
-(CGSize) captureTextSize:(int)textSize withText:(NSString *) text;

@end

@implementation WaitingView

@synthesize showMessage=_showMessage,activityIndicatorView=_activityIndicatorView,warningView=_warningView;
@synthesize activityPosition=_activityPosition;
@synthesize rootView=_rootView;

- (void)dealloc
{
    [_activityIndicatorView release];
    [_warningView release];
    [_showMessage release];
    [super dealloc];
}

- (CGFloat)captureLeftDis:(NSString *)text
{
    //self.frame.size.width-kAcWidth-kDistance - (kLeft * 2)
    CGSize size = [self captureTextSize:kFontSize withText:text];
    CGFloat left;
    BOOL isShowAct=!_activityIndicatorView.hidden;
    if(isShowAct){
        left=(self.bounds.size.width-self.bounds.origin.x-kLeft-kAcWidth-kDistance-size.width)/2.0f;
    }else{
        left=(self.bounds.size.width-self.bounds.origin.x-kLeft-size.width)/2.0f;
    }
    return left;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // background settings
        //将图层的边框设置为圆脚 
        self.layer.cornerRadius = 8; 
        self.layer.masksToBounds = YES; 
        [self setBackgroundColor:[UIColor clearColor]];
        [self setAlpha:0.8];
        [self setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
        CGRect rct=self.bounds;
        
        _panelView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, rct.size.width, rct.size.height)];
        [_panelView setBackgroundColor:[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.75]];
        [[_panelView layer] setMasksToBounds:NO]; // very important
        [[_panelView layer] setCornerRadius:10.0];
        [self addSubview:_panelView];
        
        _activityPosition=WaitingActivityInTop;
        //self.backgroundColor = [UIColor blackColor];
        //self.alpha=0.7;
        //self.backgroundColor = [UIColor whiteColor];
        _activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
		CGRect rc = self.bounds;
        _activityIndicatorView.hidden = NO;
        CGFloat left=[self captureLeftDis:self.showMessage];
        CGRect imageRect = CGRectMake(left, (rc.size.height-kAcWidth)/2, kAcWidth, kAcWidth);
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"images/warning" ofType:@"png"];
        UIImage *warningImage = [[UIImage alloc] initWithContentsOfFile:path];
        _warningView = [[UIImageView alloc] initWithImage:warningImage];
        [warningImage release];
        
        _activityIndicatorView.frame = imageRect;
        [_activityIndicatorView startAnimating];
		[_panelView addSubview:_activityIndicatorView];
        _warningView.frame = imageRect;
        _warningView.hidden = YES;
        [_panelView addSubview:_warningView];   
        
        _textView=[[UILabel alloc] initWithFrame:imageRect];
        _textView.textColor=[UIColor whiteColor];
        _textView.backgroundColor=[UIColor clearColor];
        _textView.font = [UIFont boldSystemFontOfSize:kFontSize];
        _textView.highlighted = YES;//设置高亮      
        _textView.adjustsFontSizeToFitWidth =  YES ; //设置字体大小适应label宽度
        [_panelView addSubview:_textView];
    }
    return self;
}

//计算文本占用高度和宽度
- (CGSize)captureTextSize:(int)textSize withText:(NSString *)text
{
    //self.frame.size.width-kAcWidth-kDistance - (kLeft * 2)
    CGFloat width=self.bounds.size.width;
    if (_activityIndicatorView.hidden==NO) {
        width=width-kAcWidth-kLeft;
    }
    CGSize constraint = CGSizeMake(width, 20000.0f);
    CGSize size = [text sizeWithFont:[UIFont boldSystemFontOfSize:textSize] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
    return size;
}

- (void)sizeToFitView
{
    CGRect rc = self.bounds;
    if (_activityPosition==WaitingActivityInTop) {
        CGFloat acY=(rc.size.height-kAcWidth*2)/2;
        CGFloat acX=(rc.size.width-kAcWidth)/2;
        CGRect imageRect = CGRectMake(acX, acY, kAcWidth, kAcWidth);
        _activityIndicatorView.frame = imageRect;
        _warningView.frame = imageRect;
        
        if (self.showMessage) {
            //CGSize textSize=[self captureTextSize:kFontSize withText:self.showMessage];
            //CGFloat msgX=(rc.size.width-textSize.width)/2.0f;
            //[self.showMessage drawInRect:CGRectMake(msgX, acY+kAcWidth+3, rc.size.width, kAcWidth) withFont:[UIFont boldSystemFontOfSize:kFontSize]];
            _textView.textAlignment=UITextAlignmentCenter;
            _textView.frame = CGRectMake(0, acY+kAcWidth+3, rc.size.width, kAcWidth);
            _textView.text=self.showMessage;
        }
    }else { //activity in left
        CGFloat left=[self captureLeftDis:self.showMessage];
        CGRect imageRect = CGRectMake(left, (rc.size.height-kAcWidth)/2, kAcWidth, kAcWidth);
        _activityIndicatorView.frame = imageRect;
        _warningView.frame = imageRect;
        if (self.showMessage) {
            _textView.frame=CGRectMake(left+kAcWidth+kDistance, (rc.size.height-kAcWidth)/2+5, rc.size.width-kAcWidth-kDistance, kAcWidth);
            _textView.text=self.showMessage;
            //CGContextRef context = UIGraphicsGetCurrentContext();
            //CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
            //[self.showMessage drawInRect:CGRectMake(left+kAcWidth+kDistance, (rc.size.height-kAcWidth)/2+5, rc.size.width-kAcWidth-kDistance, kAcWidth) withFont:[UIFont boldSystemFontOfSize:kFontSize]];
        }
    }
    
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    [self sizeToFitView]; //重置View界面大小
    [super drawRect:rect];
}

//-----------
// 显示
//-----------
- (void)show
{
    if (isShowing) {
        return;
    }
    if (_rootView) {
        [_rootView addSubview:self];
    }else {
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        if (!window)
        {
            window = [[UIApplication sharedApplication].windows objectAtIndex:0];
        }
        [window addSubview:self];
    }
    isShowing=YES;
}

//-----------
// 隐藏
//-----------
- (void)hide
{
    isShowing=NO;
    [self removeFromSuperview];
}

@end
