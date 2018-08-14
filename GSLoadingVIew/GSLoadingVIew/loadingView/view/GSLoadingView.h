//
//  GSLoadingView.h
//  GSLoadingVIew
//
//  Created by gersces on 2018/6/8.
//  Copyright © 2018年 gersces. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GSLoadingContentModel.h"

@interface GSLoadingView : UIView

//提示图片
@property (nonatomic,strong,readonly)UIImageView *loadImageView;
//提示文字
@property (nonatomic,strong,readonly)UILabel *textLabel;
//操作按钮
@property (nonatomic,strong,readonly)UIButton *actionBtn;


/**
 初始化
 */
- (instancetype)initWithFrame:(CGRect)frame;


/**
 loadingView出现
 
 @param contentModel 数据内容
 @param actionBlock 点击下面按钮的回调
 @param swiperAction 轻扫手势的回调（上，下，左，右）
 */
- (void)appearWithContentModel:(GSLoadingContentModel *)contentModel andActionBlock:(void(^)(NSString *btnTitle))actionBlock andSwiperAction:(void(^)(UISwipeGestureRecognizerDirection direction))swiperAction;


/**
 loadingView消失
 */
- (void)disappear;

@end
