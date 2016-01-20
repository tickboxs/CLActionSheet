#import <UIKit/UIKit.h>
//获取屏幕 宽度、高度
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
@interface CLActionSheet : UIView
+ (void)showInView:(UIView *)view withButtonTitleArray:(NSArray *)titleArray andClickCallback:(void (^)(NSInteger index))clickCallback didDismiss:(void (^)())dismissCallback;


+ (void)dismiss;

@end
