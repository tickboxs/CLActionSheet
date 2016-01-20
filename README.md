# CLActionSheet
Desc: a customized UIActionSheet with click callback and dismiss callback
![image](https://raw.githubusercontent.com/iOS-mamu/CLActionSheet/master/clips/clip_0.png)
![image](https://raw.githubusercontent.com/iOS-mamu/CLActionSheet/master/clips/clip_1.png)

How to use:

1.you need to download Masonry to autolayout. Or you can modify the source .m file with frame(CGRect) to layout.However I still recommend Masonry.

2.drag the CLActionSheet source code folder to your project.

3.just one line code
+ (void)showInView:(UIView *)view withButtonTitleArray:(NSArray *)titleArray andClickCallback:(void (^)(NSInteger index))clickCallback didDismiss:(void (^)())dismissCallback;

titleArray is the array of titles you want to click.
clickCallback is the callback triggered by click at the buttons
dismissCallback is the callback triggered by compeletion of dismiss animation

4.check the demo to test


feel free to modify as you wish.


