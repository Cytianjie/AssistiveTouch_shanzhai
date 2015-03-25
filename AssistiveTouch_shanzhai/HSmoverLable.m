

#import "HSmoverLable.h"


@interface HSmoverLable ()
@property (nonatomic, strong)UIPanGestureRecognizer *panGestureRecognizer;
@property (nonatomic, strong)UITapGestureRecognizer *tapGestureRecognizer;
@property(nonatomic,strong)UIView *selfview;
@property(nonatomic,assign)CGRect FreameRect;

@end
@implementation HSmoverLable





/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(id)initWithFrame:(CGRect)frame WhithView:(UIView *)selfview{

    self = [super initWithFrame:frame];
    if (self) {
        
        self.FreameRect = frame;
        self.selfview = selfview;
        
        self.text = @"Hello World";
        self.backgroundColor = [UIColor blackColor];
        self.textColor = [UIColor whiteColor];
        self.textAlignment = NSTextAlignmentCenter;
       
        self.userInteractionEnabled = YES;
      
        
     
        
        self.tapGestureRecognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGestureRecognizer:)];
        self.tapGestureRecognizer.numberOfTapsRequired=1;
        self.tapGestureRecognizer.numberOfTouchesRequired=1;
        [self addGestureRecognizer:self.tapGestureRecognizer];
        
        
        
    }
    return self;
}
/**
 *  点击
 *
 */
-(void)tapGestureRecognizer:(UITapGestureRecognizer *)tapGestureRecognizer{

    
    static BOOL isFist = YES;
   static CGPoint location;
    if (isFist == YES) {
        location = self.center;
        [UIView animateWithDuration:0.5 animations:^{
            self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.FreameRect.size.width*self.Amplification, self.FreameRect.size.height*self.Amplification);
            self.center = self.selfview.center;
            [self.selfview bringSubviewToFront:self];
            
            
        }];
        isFist = NO;
        self.moboleView = SlidingNo;
       
    }else{
    
        [UIView animateWithDuration:0.5 animations:^{
            self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.FreameRect.size.width, self.FreameRect.size.height);
            self.center = location;
            [self.selfview bringSubviewToFront:self];
            
            
        }];
        isFist = YES;
        self.moboleView = SlidingYes;
    
    }
   

}


/**
 *  移动
 *
 *  @param touches <#touches description#>
 *  @param event   <#event description#>
 */
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"触摸移动Touch对象个数：%d",[touches count]);
    // 要移动界面上黄颜色的视图
    
    // 1. 得到当前手指的位置
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:self];
    // 2. 得到上一次手指的位置
    CGPoint preLocation = [touch previousLocationInView:self];
    // 3. 计算两个位置之间的偏移
    CGPoint offset = CGPointMake(location.x - preLocation.x, location.y - preLocation.y);
    // 4. 使用计算出来的偏移量，调整视图的位置
    [self setCenter:CGPointMake(self.center.x + offset.x, self.center.y + offset.y)];
   // self.center = location;
    self.backgroundColor = [UIColor greenColor];
   
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    // 完整的UITouch事件调试方法
    self.backgroundColor = [UIColor blueColor];
    [self MobileViewSlidingYesOrNo];
    NSLog(@"触摸完成");
    for (UITouch *touch in touches) {
        NSLog(@"%@", touch);
    }
}
/**
 *  是否允许移动
 */
-(void)MobileViewSlidingYesOrNo{

    if (self.moboleView == SlidingYes) {
        [self MobileViewSlidingYes];
    }
}
/**
 *  允许移动,计算各边界值
 */
-(void)MobileViewSlidingYes{
    /**
     *  view距离左边的距离
     */
    
    float left = self.center.x - (self.bounds.size.width)/2;
    
    /**
     *  view距离右边的距离
     */
    
    float right = _selfview.bounds.size.width -   self.center.x - (self.bounds.size.width)/2;
    
    
    /**
     *  view距离上边的距离
     */
    
    float top = self.center.y - (self.bounds.size.height)/2;
    
    /**
     *  view距离下边的距离
     */
    
    float bottom = _selfview.bounds.size.height -   self.center.y - (self.bounds.size.height)/2;
    
    float end =   [self ReturnsTheMinimumEachBoundaryWhitLeft:left WhitRight:right WhitTop:top WhitBottom:bottom];
    
    [self BeganToMove:end WhitLeft:left WhitRight:right WhitTop:top WhitBottom:bottom];

}
/**
 *  将各个边界的值排序
 *
 *  @param left   左边
 *  @param right  右边
 *  @param top    上边
 *  @param bottom 下边
 *
 *  @return 返回最小值
 */
-(float)ReturnsTheMinimumEachBoundaryWhitLeft:(float)left WhitRight:(float)right WhitTop:(float)top WhitBottom:(float)bottom{

    float array[4]={
        left,right,top,bottom
    };
    
    float temp;
    for (int i=0; i<4; i++) {
        for (int j=i+1; j<4; j++) {
            
            if (array[i]>array[j]) {
                temp=array[i];
                array[i]=array[j];
                array[j]=temp;
            }
        }
    }
    
    float end = array[0];
    return end;

}
/**
 *  开始移动
 *
 *  @param end    最小值
 *  @param left   左边
 *  @param right  右边
 *  @param top    上边
 *  @param bottom 下边
 */
-(void)BeganToMove:(float)end WhitLeft:(float)left WhitRight:(float)right WhitTop:(float)top WhitBottom:(float)bottom{

    [UIView animateWithDuration:_SlidingTime>0?_SlidingTime:0.2 animations:^{
        if (end == left) {
            
            self.center = CGPointMake(self.bounds.size.width/2, self.center.y);
        }else if (end == right)
        {
            self.center = CGPointMake(_selfview.bounds.size.width - (self.bounds.size.width)/2, self.center.y);
        }else if (end == top)
        {
            self.center = CGPointMake(self.center.x, self.bounds.size.height/2);
        }else
        {
            self.center = CGPointMake(self.center.x, _selfview.bounds.size.height - (self.bounds.size.height)/2);
        }
        
        
       
        
        
    }];


    /**
     *  调整边界
     */
    
    if (self.frame.origin.x<0) {
        self.frame = CGRectMake(0, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
    }
    
    if (self.frame.origin.x+self.bounds.size.width>self.selfview.bounds.size.width) {
        self.frame = CGRectMake(self.selfview.bounds.size.width-self.bounds.size.width,self.frame.origin.y , self.frame.size.width, self.frame.size.height);
    }
    
    if (self.frame.origin.y<0) {
        self.frame = CGRectMake(self.frame.origin.x,0 , self.frame.size.width, self.frame.size.height);
    }
    
    if (self.frame.origin.y+self.bounds.size.height>self.selfview.bounds.size.height) {
        self.frame = CGRectMake(self.frame.origin.x,self.selfview.bounds.size.height-self.bounds.size.height , self.frame.size.width, self.frame.size.height);
    }

}
@end
