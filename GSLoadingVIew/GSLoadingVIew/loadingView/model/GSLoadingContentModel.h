//
//  GSLoadingContentModel.h
//  GSLoadingVIew
//
//  Created by gersces on 2018/6/8.
//  Copyright © 2018年 gersces. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface GSLoadingContentModel : NSObject

//帧动画的数据，优先级高于image
@property (nonatomic,strong)NSArray <NSString *>*images;
//单张图片，优先级低于images
@property (nonatomic,strong)NSString *image;

//提示文字
@property (nonatomic,strong)NSString *content;

//操作按钮title
@property (nonatomic,strong)NSString *title;

@end
