//
//  ViewController.m
//  GSLoadingVIew
//
//  Created by gersces on 2018/6/8.
//  Copyright © 2018年 gersces. All rights reserved.
//

#import "ViewController.h"
#import "UIViewController+GSLoading.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor cyanColor];
    
    __weak typeof(self)weakSelf = self;

    GSLoadingContentModel *contentModel = [[GSLoadingContentModel alloc]init];
    contentModel.image = @"netError";
    contentModel.content = @"网络错误";
    contentModel.title = @"重新加载";
    
    GSLoadingPropertyModel *propertyModel = [[GSLoadingPropertyModel alloc]init];
    propertyModel.backgroudColor = [UIColor whiteColor];
    propertyModel.textColor = [UIColor redColor];
    
    [self appearLoadingViewWithContentModele:contentModel andLoadingModel:propertyModel andActionBlock:^(NSString *btnTitle) {
        NSLog(@"%@",btnTitle);
        [weakSelf loadData];
    } andSwiperAction:^(UISwipeGestureRecognizerDirection direction) {
        [weakSelf swipeDirection:direction];
    }];
    
}

- (void)loadData{
    
    __weak typeof(self)weakSelf = self;

    NSArray *images = @[@"image-0",@"image-1",@"image-2",@"image-3",@"image-4",@"image-5",@"image-6",@"image-7",@"image-8",@"image-9"];
    GSLoadingContentModel *contentModel = [[GSLoadingContentModel alloc]init];
    contentModel.images = images;
    contentModel.content = @"加载中...";
    contentModel.title = @"";
    [self appearLoadingViewWithContentModele:contentModel andLoadingModel:nil andActionBlock:^(NSString *btnTitle) {
        NSLog(@"%@",btnTitle);
    } andSwiperAction:^(UISwipeGestureRecognizerDirection direction) {
        [weakSelf swipeDirection:direction];
    }];

    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        contentModel.images = nil;
        contentModel.image = @"noData";
        contentModel.content = @"没有数据";
        contentModel.title = @"获取更多";
        [self appearLoadingViewWithContentModele:contentModel andLoadingModel:nil andActionBlock:^(NSString *btnTitle) {
            NSLog(@"%@",btnTitle);
            [weakSelf disappearLoadingView];
        } andSwiperAction:^(UISwipeGestureRecognizerDirection direction) {
            [weakSelf swipeDirection:direction];
        }];
    });
}
- (void)swipeDirection:(UISwipeGestureRecognizerDirection)direction{
    switch (direction) {
        case UISwipeGestureRecognizerDirectionUp:
            NSLog(@"上滑");
            break;
        case UISwipeGestureRecognizerDirectionDown:
            NSLog(@"下滑");
            break;
        case UISwipeGestureRecognizerDirectionLeft:
            NSLog(@"左滑");
            break;
        case UISwipeGestureRecognizerDirectionRight:
            NSLog(@"右滑");
            break;

        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
