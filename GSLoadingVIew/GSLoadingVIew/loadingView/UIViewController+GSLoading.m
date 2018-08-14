//
//  UIViewController+GSLoading.m
//  GSLoadingVIew
//
//  Created by gersces on 2018/6/8.
//  Copyright © 2018年 gersces. All rights reserved.
//

#import "UIViewController+GSLoading.h"
#import "GSLoadingView.h"

@implementation UIViewController (GSLoading)

- (UIView *)loadViewSuperView{
    if (self.tabBarController) {
        return self.tabBarController.view;
    }
    else{
        return self.view;
    }
}
- (void)setLoadViewSuperView:(UIView *)loadViewSuperView{
    if (loadViewSuperView) {
        self.loadViewSuperView = loadViewSuperView;
    }
}
- (void)appearLoadingViewWithContentModele:(GSLoadingContentModel *)contentModel andLoadingModel:(GSLoadingPropertyModel *)propertyModel andActionBlock:(void(^)(NSString *btnTitle))actionBlock andSwiperAction:(void(^)(UISwipeGestureRecognizerDirection direction))swiperAction{

    NSAssert(contentModel, @"请先配置contentModel");
    
    GSLoadingView *loadView;
    for (UIView *subView in self.loadViewSuperView.subviews) {
        if ([subView isKindOfClass:[GSLoadingView class]]) {
            loadView = (GSLoadingView *)subView;
            break;
        }
    }
    if (!loadView) {
        loadView = [[GSLoadingView alloc]initWithFrame:self.view.bounds];
        [self.loadViewSuperView addSubview:loadView];
    }
    
    if (propertyModel)[self confignLoadingView:loadView andLoadingModel:propertyModel];
    
    [loadView appearWithContentModel:contentModel andActionBlock:actionBlock andSwiperAction:swiperAction];
    
}
- (void)confignLoadingView:(GSLoadingView *)view andLoadingModel:(GSLoadingPropertyModel *)model{
    if (model.backgroudColor) view.backgroundColor = model.backgroudColor;
    
    //文字颜色
    if (model.textColor) view.textLabel.textColor = model.textColor;
    //文字大小
    if (model.textFont && model.textFont > 5) view.textLabel.font = [UIFont systemFontOfSize:model.textFont];
    
    //按钮背景色
    if (model.actionBackgroundColor) view.actionBtn.backgroundColor = model.actionBackgroundColor;
    //按钮文字颜色
    if (model.actionTextColor) [view.actionBtn setTitleColor:model.actionTextColor forState:UIControlStateNormal];
    //按钮文字颜色
    if (model.actionTextFont && model.actionTextFont > 5) view.actionBtn.titleLabel.font = [UIFont systemFontOfSize:model.actionTextFont];
}
- (void)disappearLoadingView{
    for (UIView *subView in self.loadViewSuperView.subviews) {
        if ([subView isKindOfClass:[GSLoadingView class]]) {
            [(GSLoadingView *)subView disappear];
            break;
        }
    }
}
@end
