//
//  UIViewController+GSLoading.h
//  GSLoadingVIew
//
//  Created by gersces on 2018/6/8.
//  Copyright © 2018年 gersces. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GSLoadingContentModel.h"
#import "GSLoadingPropertyModel.h"

@interface UIViewController (GSLoading)

//loadView所在的父视图
@property (nonatomic,strong)UIView *loadViewSuperView;

/**
 loadingView出现
 
 @param contentModel 数据内容
 @param propertyModel 设置loadingView的样式
 @param actionBlock 点击下面按钮的回调
 @param swiperAction 轻扫手势的回调（上，下，左，右）
 */
- (void)appearLoadingViewWithContentModele:(GSLoadingContentModel *)contentModel andLoadingModel:(GSLoadingPropertyModel *)propertyModel andActionBlock:(void(^)(NSString *btnTitle))actionBlock andSwiperAction:(void(^)(UISwipeGestureRecognizerDirection direction))swiperAction;

/**
 loadingView消失
 */
- (void)disappearLoadingView;

@end
