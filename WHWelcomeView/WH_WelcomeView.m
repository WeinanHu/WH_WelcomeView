//
//  WH_WelcomeView.m
//  WHWelcomeView
//
//  Created by Way_Lone on 16/6/7.
//  Copyright © 2016年 Way_Lone. All rights reserved.
//

#import "WH_WelcomeView.h"
@interface WH_WelcomeView()<UIScrollViewDelegate>
@property(nonatomic,strong) UIScrollView *scrollView;
@property(nonatomic,strong) UIPageControl *pageControl;
@property(nonatomic,strong) NSArray *imageNames;
@property(nonatomic,strong) NSTimer *timer;
@property(nonatomic,assign) BOOL timerEnable;
@property(nonatomic,assign) NSInteger timerInterval;
@property(nonatomic,strong) BLOCK block;
@end
@implementation WH_WelcomeView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithFrame:(CGRect)frame imageNames:(NSArray *)arr enterBlock:(BLOCK)block{
    if(self = [super initWithFrame:frame]){
        self.imageNames = arr;
        self.timerEnable = NO;
        self.timerInterval = 3;
        self.block = block;
        [self setUpScrollView];
        [self setUpPageControl];
        [self setUpGesture];
        
    }
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame imageNames:(NSArray*)arr timerInterval:(NSUInteger)timerInteral enterBlock:(BLOCK)block{
    self = [self initWithFrame:frame imageNames:arr enterBlock:block];
    self.timerEnable = YES;
    self.timerInterval = timerInteral;
    [self setUpTimer];
    return self;
}
-(void)setUpScrollView{
    if (!self.scrollView) {
        self.scrollView = [[UIScrollView alloc]initWithFrame:self.frame];
        
    }
    {
        int i = 0;
        for (NSString *str in self.imageNames) {
            UIImage *image = [UIImage imageNamed:str];
            if (!image) {
                NSLog(@"welcome图片缺失");
            }
            UIImageView *imageView = [[UIImageView alloc]initWithImage:image];
            imageView.frame = CGRectMake(self.frame.origin.x + self.frame.size.width * i, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
            [self.scrollView addSubview:imageView];
            
            i++;
        }
    }
    self.scrollView.pagingEnabled = YES;
    self.scrollView.delegate = self;
    self.scrollView.contentSize = CGSizeMake(self.imageNames.count * self.frame.size.width, self.frame.size.height);
    self.scrollView.contentInset = UIEdgeInsetsZero;
    NSLog(@"%@",NSStringFromCGSize(self.scrollView.contentSize));

    self.scrollView.showsHorizontalScrollIndicator = NO;
    NSLog(@"%@",NSStringFromCGRect(self.scrollView.frame));
    NSLog(@"%@",NSStringFromCGRect(self.frame));
    [self addSubview:self.scrollView];
}
-(void)setUpPageControl{
    if (!self.pageControl) {
        self.pageControl = [[UIPageControl alloc]init];
        self.pageControl.numberOfPages = self.imageNames.count;
        self.pageControl.currentPage = 0;
        self.pageControl.center = CGPointMake(self.frame.size.width/2,self.frame.size.height*0.88);
    }
    [self addSubview:self.pageControl];
}
-(void)setUpGesture{
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didTap:)];
    [self addGestureRecognizer:tapGesture];
}
-(void)didTap:(UITapGestureRecognizer*)tapGesture{
    if (self.scrollView.contentOffset.x >= self.frame.size.width * (self.imageNames.count-1)) {
        [self didLogin];
    }
}
-(void)setUpTimer{
    if (self.timerEnable) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:self.timerInterval target:self selector:@selector(timerPerform) userInfo:nil repeats:YES];
    }
}
-(void)timerPerform{
    if (self.scrollView.contentOffset.x < self.frame.size.width * (self.imageNames.count-1)) {
        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.scrollView.contentOffset = CGPointMake(self.scrollView.contentOffset.x + self.frame.size.width, self.scrollView.contentOffset.y);
            
        } completion:^(BOOL finished) {
            
        }];
    }
    
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    self.pageControl.currentPage = round(self.scrollView.contentOffset.x / self.frame.size.width);
//    NSLog(@"%@",NSStringFromCGRect(self.scrollView.frame));

}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    NSLog(@"%d",decelerate);
    if (self.scrollView.contentOffset.x > self.frame.size.width * (self.imageNames.count-1)) {
        [self didLogin];
    }
}
-(void)dealloc{
    [self.timer invalidate];
    self.timer = nil;
}
-(void)didLogin{
    self.block();
    if(self.timer){
        [self.timer invalidate];
        self.timer = nil;
    }
}
@end
