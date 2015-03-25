

#import <UIKit/UIKit.h>


@interface HSmoverLable : UILabel

typedef enum {
    /**
     *  是否允许移动
     */
    SlidingYes,
    SlidingNo
    
    
}MobileView;


-(id)initWithFrame:(CGRect)frame WhithView:(UIView *)selfview;
/**
 *  是否允许自由移动
 */
@property(nonatomic)MobileView moboleView;
/**
 *  滑动时间
 */
@property(nonatomic,assign)NSInteger SlidingTime;
/**
 *  放大的view
 */
@property(nonatomic,assign)NSInteger Amplification;
@end



