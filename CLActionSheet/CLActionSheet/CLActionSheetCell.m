#import "CLActionSheetCell.h"
#import "Masonry.h"

@interface CLActionSheetCell ()

@end
@implementation CLActionSheetCell

#pragma mark - 懒加载
- (UILabel *)centerLabel
{
    if(_centerLabel == nil)
    {
        _centerLabel = [[UILabel alloc]init];
    }
    return _centerLabel;
}

#pragma mark - init
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self setupUI];
    }
    return self;
}

#pragma mark - UI
- (void)setupUI
{
    //禁止选中高亮
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.contentView addSubview:self.centerLabel];
    
    
    self.centerLabel.textColor = [UIColor blackColor];
    self.centerLabel.textAlignment = NSTextAlignmentCenter;
    self.centerLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.centerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    
    
    
}
@end
