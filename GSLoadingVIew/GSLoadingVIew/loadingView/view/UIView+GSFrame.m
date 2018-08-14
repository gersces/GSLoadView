//
//  UIView+GSFrame.m
//  GSLoadingVIew
//
//  Created by gersces on 2018/6/8.
//  Copyright © 2018年 gersces. All rights reserved.
//

#import "UIView+GSFrame.h"

@implementation UIView (GSFrame)

#pragma mark - origin & size
- (CGPoint)gs_origin{
    return self.frame.origin;
}
- (void)setGs_origin:(CGPoint)gs_origin{
    CGRect frame = self.frame;
    frame.origin = gs_origin;
    self.frame = frame;
}
- (CGSize)gs_size{
    return self.frame.size;
}
- (void)setGs_size:(CGSize)gs_size{
    CGRect frame = self.frame;
    frame.size = gs_size;
    self.frame = frame;
}

#pragma mark - centerX & centerY
- (CGFloat)gs_centerX{
    return self.center.x;
}
- (void)setGs_centerX:(CGFloat)gs_centerX{
    self.center = CGPointMake(gs_centerX, self.center.y);
}
- (CGFloat)gs_centerY{
    return self.center.y;
}
- (void)setGs_centerY:(CGFloat)gs_centerY{
    self.center = CGPointMake(self.center.x, gs_centerY);
}

#pragma mark - top & bottom & left & right
- (CGFloat)gs_top{
    return self.frame.origin.y;
}
- (void)setGs_top:(CGFloat)gs_top{
    CGRect frame = self.frame;
    frame.origin.y = gs_top;
    self.frame = frame;
}
- (CGFloat)gs_bottom{
    return self.frame.origin.y + self.frame.size.height;
}
- (void)setGs_bottom:(CGFloat)gs_bottom{
    CGRect  frame = self.frame;
    frame.origin.y = gs_bottom - self.frame.size.height;
    self.frame = frame;
}
- (CGFloat)gs_left{
    return self.frame.origin.x;
}
- (void)setGs_left:(CGFloat)gs_left{
    CGRect frame = self.frame;
    frame.origin.x = gs_left;
    self.frame = frame;
}
- (CGFloat)gs_right{
    return self.frame.origin.x + self.frame.size.width;
}
- (void)setGs_right:(CGFloat)gs_right{
    CGRect frame = self.frame;
    frame.origin.x = gs_right - self.frame.size.width;
    self.frame = frame;
}

#pragma mark - width & height
- (CGFloat)gs_width{
    return self.frame.size.width;
}
- (void)setGs_width:(CGFloat)gs_width{
    CGRect frame = self.frame;
    frame.size.width = gs_width;
    self.frame = frame;
}
- (CGFloat)gs_height{
    return self.frame.size.height;
}
- (void)setGs_height:(CGFloat)gs_height{
    CGRect frame = self.frame;
    frame.size.height = gs_height;
    self.frame = frame;
}

@end
