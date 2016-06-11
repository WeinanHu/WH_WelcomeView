//
//  WH_WelcomeView.h
//  WHWelcomeView
//
//  Created by Way_Lone on 16/6/7.
//  Copyright © 2016年 Way_Lone. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^BLOCK)();
@interface WH_WelcomeView : UIView
-(instancetype)initWithFrame:(CGRect)frame imageNames:(NSArray*)arr enterBlock:(BLOCK)block;

-(instancetype)initWithFrame:(CGRect)frame imageNames:(NSArray*)arr timerInterval:(NSUInteger)timerInteral enterBlock:(BLOCK)block;
@end
