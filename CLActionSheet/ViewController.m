//
//  ViewController.m
//  CLActionSheet
//
//  Created by 蔡磊 on 16/1/20.
//  Copyright © 2016年 mamu. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"

#import "CLActionSheet.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:btn];
    [btn setTitle:@"click me show actionSheet" forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor redColor];
    
    btn.translatesAutoresizingMaskIntoConstraints = NO;
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.centerY.equalTo(self.view.mas_centerY);
    }];
    [btn addTarget:self action:@selector(showActionSheet) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)showActionSheet
{
    [CLActionSheet showInView:[UIApplication sharedApplication].keyWindow withButtonTitleArray:@[@"button0",@"button1",@"button2",@"button3",@"button4",@"button5"] andClickCallback:^(NSInteger index) {
        
        NSLog(@"click at button%ld",index);
        [CLActionSheet dismiss];
        
    } didDismiss:^{
        
        NSLog(@"DidDismss");
        
    }];
}

@end
