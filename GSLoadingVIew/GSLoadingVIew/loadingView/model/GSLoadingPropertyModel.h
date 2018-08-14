//
//  GSLoadingModel.h
//  GSLoadingVIew
//
//  Created by gersces on 2018/6/8.
//  Copyright © 2018年 gersces. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface GSLoadingPropertyModel : NSObject

//loadingView的背景色
@property (nonatomic,strong)UIColor *backgroudColor;

//提示文字的颜色
@property (nonatomic,strong)UIColor *textColor;
//提示文字的大小
@property (nonatomic,assign)NSInteger textFont;

//操作按钮的背景色
@property (nonatomic,strong)UIColor *actionBackgroundColor;
//操作按钮的文字颜色
@property (nonatomic,strong)UIColor *actionTextColor;
//操作按钮的文字大小
@property (nonatomic,assign)NSInteger actionTextFont;

@end
