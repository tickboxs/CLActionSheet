
#import "CLActionSheet.h"
#import "CLActionSheetCell.h"
#import "Masonry.h"

@interface CLActionSheet ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)UIView * maskView;
@property (nonatomic,strong)UITableView * tableView;
@property (nonatomic,copy)void(^clickCallback)(NSInteger index);
@property (nonatomic,copy)void(^dismissCallback)();
@property (nonatomic,strong)NSArray * buttonTitleArray;
@end

@implementation CLActionSheet
#pragma mark - 懒加载
- (UIView *)maskView
{
    if(_maskView == nil)
    {
        _maskView = [[UIView alloc]init];
    }
    return _maskView;
}

- (UITableView *)tableView
{
    if(_tableView == nil)
    {
        _tableView = [[UITableView alloc]init];
    }
    return _tableView;
}


#pragma mark - init
- (instancetype)init
{
    if(self = [super init])
    {
        [self prepareView];
        [self setupUI];
    }
    return self;
}

#pragma mark - UI
- (void)prepareView
{
    self.backgroundColor = [UIColor clearColor];
    self.alpha = 0;
    
    [self.tableView registerClass:[CLActionSheetCell class] forCellReuseIdentifier:@"CLActionSheetCellID"];
    
    //禁止滚动
    self.tableView.scrollEnabled = NO;

}

- (void)setupUI
{
    [self addSubview:self.maskView];
    [self addSubview:self.tableView];

    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismiss)];
    
    [self.maskView addGestureRecognizer:tap];
    
    self.maskView.backgroundColor = [UIColor blackColor];
    self.maskView.alpha = 0.5;
    self.maskView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.maskView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 44;
    
    self.tableView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, self.buttonTitleArray.count*44);
    
}

#pragma mark - 单例
+ (instancetype)shareActionSheet
{
    static CLActionSheet * shareActionSheet;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareActionSheet = [[CLActionSheet alloc]init];
    });
    return shareActionSheet;
}


#pragma mark - 调用方法
+ (void)showInView:(UIView *)view withButtonTitleArray:(NSArray *)titleArray andClickCallback:(void (^)(NSInteger index))clickCallback didDismiss:(void (^)())dismissCallback
{
    CLActionSheet * shareActionSheet = [CLActionSheet shareActionSheet];
    
    //解除输入focus
    [view endEditing:YES];
    //点击按钮回调设置
    shareActionSheet.clickCallback = clickCallback;
    //dismiss回调设置
    shareActionSheet.dismissCallback = dismissCallback;
    //设置按钮标题数组
    shareActionSheet.buttonTitleArray = titleArray;
    //刷新title数组
    [shareActionSheet.tableView reloadData];
    
    [view addSubview:shareActionSheet];
    
    shareActionSheet.translatesAutoresizingMaskIntoConstraints = NO;
    [shareActionSheet mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(view);
    }];
    
    shareActionSheet.tableView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, shareActionSheet.buttonTitleArray.count*44);


    shareActionSheet.alpha = 0;
    [UIView animateWithDuration:0.25 animations:^{
        shareActionSheet.alpha = 1;
    } completion:^(BOOL finished) {
        
        //tableView弹上来的动画
        [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            
            shareActionSheet.tableView.frame = CGRectMake(0, SCREEN_HEIGHT-shareActionSheet.buttonTitleArray.count*44, SCREEN_WIDTH, shareActionSheet.buttonTitleArray.count*44);
            
        } completion:^(BOOL finished) {
            
        }];
        
    }];
    
    
    
    
}

#pragma mark - tableView dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.buttonTitleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * reusedID = @"CLActionSheetCellID";
    CLActionSheetCell * cell = [self.tableView dequeueReusableCellWithIdentifier:reusedID forIndexPath:indexPath];
    
    cell.centerLabel.text = self.buttonTitleArray[indexPath.item];
    
    return cell;
    
    
}

#pragma mark - tableView delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //点击回调
    self.clickCallback(indexPath.item);
}

#pragma mark - 点击方法
- (void)dismiss
{
    [UIView animateWithDuration:0.25 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        self.dismissCallback();
    }];
}

+ (void)dismiss
{
    CLActionSheet * shareActionSheet = [CLActionSheet shareActionSheet];
    [shareActionSheet dismiss];
}
@end
