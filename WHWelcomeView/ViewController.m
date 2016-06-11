//
//  ViewController.m
//  WHWelcomeView
//
//  Created by Way_Lone on 16/6/7.
//  Copyright © 2016年 Way_Lone. All rights reserved.
//

#import "ViewController.h"
#import "WH_WelcomeView.h"
@interface ViewController ()
@property(nonatomic,strong) NSArray *imageArray;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    WH_WelcomeView *welcomeView = [[WH_WelcomeView alloc]initWithFrame:self.view.bounds imageNames:self.imageArray enterBlock:^{
//        NSLog(@"进行跳转");
//    }];
    WH_WelcomeView *welcomeView = [[WH_WelcomeView alloc]initWithFrame:self.view.bounds imageNames:self.imageArray timerInterval:2 enterBlock:^{
        NSLog(@"进行跳转");
    }];
    
    [self.view addSubview:welcomeView];
    
    
//    UIView *view = [[UIView alloc]initWithFrame:self.view.bounds];
//    view.backgroundColor = [UIColor redColor];
//    [self.view addSubview:view];
//        UIScrollView *view = [[UIScrollView alloc]initWithFrame:self.view.bounds];
//        view.backgroundColor = [UIColor redColor];
//        [self.view addSubview:view];

    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSArray *)imageArray {
	if(_imageArray == nil) {
		_imageArray = @[@"photo-1",@"photo-2",@"photo-3",@"photo-4",@"photo-5",@"photo-6"];
	}
	return _imageArray;
}

@end
