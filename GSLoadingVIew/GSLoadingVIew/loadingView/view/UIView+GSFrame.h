//
//  UIView+GSFrame.h
//  GSLoadingVIew
//
//  Created by gersces on 2018/6/8.
//  Copyright © 2018年 gersces. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (GSFrame)

@property (nonatomic,assign)CGPoint gs_origin;
@property (nonatomic,assign)CGSize gs_size;

@property (nonatomic)CGFloat gs_centerX;
@property (nonatomic)CGFloat gs_centerY;

@property (nonatomic)CGFloat gs_top;
@property (nonatomic)CGFloat gs_bottom;
@property (nonatomic)CGFloat gs_left;
@property (nonatomic)CGFloat gs_right;

@property (nonatomic)CGFloat gs_width;
@property (nonatomic)CGFloat gs_height;

@end
