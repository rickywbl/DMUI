//
//  ViewController.m
//  DMUIButtonDemo
//
//  Created by DoubleMint on 2017/12/26.
//  Copyright © 2017年 王保霖. All rights reserved.
//

#import "ViewController.h"
#import "DMUIButton.h"

@interface ViewController (){
    
    DMUIButton * button;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    button = [[DMUIButton alloc] initWithFrame:CGRectMake(100, 100, 200, 100)];
    button.imagePosition = DMUIButtonImagePositionRight;
    button.backgroundColor = [UIColor lightGrayColor];
    button.spacingBetweenImageAndTitle = 10;
    button.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentFill;
    [button setImage:[UIImage imageNamed:@"微信"] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [button setTitle:@"吗快递费技术老大附件简历说肯定富家大室了" forState:UIControlStateNormal];
    [self.view addSubview:button];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
 
}


@end
