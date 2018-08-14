//
//  GSLoadingView.m
//  GSLoadingVIew
//
//  Created by gersces on 2018/6/8.
//  Copyright © 2018年 gersces. All rights reserved.
//

#import "GSLoadingView.h"
#import "UIView+GSFrame.h"

@interface GSLoadingView ()
@property (nonatomic,strong)UIImageView *tipImageView;//提示图片
@property (nonatomic,strong)UILabel *tipLabel;//提示label
@property (nonatomic,strong)UIButton *tipBtn;//操作按钮

@property (nonatomic,strong)void(^actionBlock)(NSString *btnTitle);//操作按钮点击的回调
@property (nonatomic,strong)void(^swiperAction)(UISwipeGestureRecognizerDirection direction);//轻扫手势的回调

@end

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

@implementation GSLoadingView

#pragma mark - 懒加载image、label、和btn
- (UIImageView *)tipImageView{
    if (!_tipImageView) {
        _tipImageView = [[UIImageView alloc]init];
    }
    return _tipImageView;
}
- (UILabel *)tipLabel{
    if (!_tipLabel) {
        _tipLabel = [[UILabel alloc]init];
        _tipLabel.numberOfLines = 0;
        _tipLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _tipLabel;
}
- (UIButton *)tipBtn{
    if (!_tipBtn) {
        _tipBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_tipBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_tipBtn addTarget:self action:@selector(tipBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        _tipBtn.backgroundColor = [UIColor yellowColor];
    }
    return _tipBtn;
}
- (void)tipBtnClick:(UIButton *)sender{
    if (self.actionBlock) {
        self.actionBlock(sender.titleLabel.text);
    }
}
#pragma mark - 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        
        [self addSubview:self.tipImageView];
        [self addSubview:self.tipLabel];
        [self addSubview:self.tipBtn];

        [self addSwipes];
    }
    return self;
}
#pragma mark - readOnly的一些属性
- (UIImageView *)loadImageView{
    return self.tipImageView;
}
- (UILabel *)textLabel{
    return self.tipLabel;
}
- (UIButton *)actionBtn{
    return self.tipBtn;
}

#pragma mark - 出现、消失的方法
- (void)appearWithContentModel:(GSLoadingContentModel *)contentModel andActionBlock:(void(^)(NSString *btnTitle))actionBlock andSwiperAction:(void(^)(UISwipeGestureRecognizerDirection direction))swiperAction{
    
    if (!contentModel) return;
    
    if (!self.subviews) return;
    
    [self.superview bringSubviewToFront:self];
    self.hidden = NO;
    
    if (actionBlock) {
        self.actionBlock = actionBlock;
    }
    if (swiperAction) {
        self.swiperAction = swiperAction;
    }
    
    if (contentModel.content && contentModel.content.length > 0) {
        self.tipLabel.hidden = NO;
        self.tipLabel.text = contentModel.content;
        self.tipLabel.gs_width = kScreenWidth - 40;
        [self.tipLabel sizeToFit];
        self.tipLabel.gs_centerX = self.gs_centerX;
        self.tipLabel.gs_centerY = self.gs_centerY;
    }
    else{
        self.tipLabel.gs_top = 0;
        self.tipLabel.hidden = YES;
    }
    
    if (contentModel.images){
        NSAssert([contentModel.images isKindOfClass:[NSArray class]], @"images对应的vaule应该是数组");
        self.tipImageView.hidden = NO;
        NSArray *ary = [NSArray arrayWithArray:contentModel.images];
        NSMutableArray *images = [NSMutableArray new];
        for (int i = 0; i < ary.count; i ++) {
            if(i == 0){
                UIImage *image = [UIImage imageNamed:ary[0]];
                if (image.size.width > kScreenWidth/2) {
                    self.tipImageView.gs_width = kScreenWidth/2;
                    self.tipImageView.gs_height = (image.size.height * kScreenWidth/2)/image.size.width;
                }
                else{
                    self.tipImageView.gs_width = image.size.width;
                    self.tipImageView.gs_height = image.size.height;
                }
                self.tipImageView.gs_bottom = self.tipLabel.gs_top>0 ? self.tipLabel.gs_top-20 : self.gs_centerY-20;
                self.tipImageView.gs_centerX = self.gs_centerX;
            }
            [images addObject:[UIImage imageNamed:ary[i]]];
        }
        self.tipImageView.animationImages = [images copy];
        self.tipImageView.animationDuration = images.count/5;
        self.tipImageView.animationRepeatCount = 0;
        [self.tipImageView startAnimating];
    }
    else if (contentModel.image) {
        self.tipImageView.hidden = NO;
        UIImage *image = [UIImage imageNamed:contentModel.image];
        self.tipImageView.image = image;
        self.tipImageView.animationImages = nil;
        if (image.size.width > kScreenWidth/2) {
            self.tipImageView.gs_width = kScreenWidth/2;
            self.tipImageView.gs_height = (image.size.height * kScreenWidth/2)/image.size.width;
        }
        else{
            self.tipImageView.gs_width = image.size.width;
            self.tipImageView.gs_height = image.size.height;
        }
        self.tipImageView.gs_bottom = self.tipLabel.gs_top>0 ? self.tipLabel.gs_top-20 : self.gs_centerY-20;
        self.tipImageView.gs_centerX = self.gs_centerX;
    }
    else{
        self.tipImageView.hidden = YES;
    }
    
    if (contentModel.title && [NSString stringWithFormat:@"%@",contentModel.title].length > 0) {
        self.tipBtn.hidden = NO;
        [self.tipBtn setTitle:contentModel.title forState:UIControlStateNormal];
        self.tipBtn.frame = CGRectMake(kScreenWidth/2 - 75, self.tipLabel.gs_top>0 ? self.tipLabel.gs_bottom+20 : self.gs_centerY+20, 150, 40);
    }
    else{
        self.tipBtn.hidden = YES;
    }
    
}
- (void)disappear{
    if (self.tipImageView.animating) {
        [self.tipImageView stopAnimating];
    }
    self.hidden = YES;
}
#pragma mark - 添加手势
- (void)addSwipes{
    //up
    UISwipeGestureRecognizer *upSwipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeAction:)];
    [upSwipe setDirection:UISwipeGestureRecognizerDirectionUp];
    [self addGestureRecognizer:upSwipe];
    
    //down
    UISwipeGestureRecognizer *downSwipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeAction:)];
    [downSwipe setDirection:UISwipeGestureRecognizerDirectionDown];
    [self addGestureRecognizer:downSwipe];
    
    //left
    UISwipeGestureRecognizer *leftSwipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeAction:)];
    [leftSwipe setDirection:UISwipeGestureRecognizerDirectionLeft];
    [self addGestureRecognizer:leftSwipe];
    
    //right
    UISwipeGestureRecognizer *rightSwipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeAction:)];
    [rightSwipe setDirection:UISwipeGestureRecognizerDirectionRight];
    [self addGestureRecognizer:rightSwipe];
}
- (void)swipeAction:(UISwipeGestureRecognizer *)sender{
    if (self.swiperAction) {
        self.swiperAction(sender.direction);
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
