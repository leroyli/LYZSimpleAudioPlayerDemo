//
//  ViewController.m
//  LYZSimpleAudioPlayerDemo
//
//  Created by artios on 2017/1/6.
//  Copyright © 2017年 artios. All rights reserved.
//

#import "ViewController.h"
#import "LYZAudioPlayer.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self setupViews];
}

- (void)setupViews{
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"pause"] forState:UIControlStateSelected];
    button.frame = CGRectMake(200, 200, 60, 60);
    button.center = self.view.center;
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    
}

- (void)buttonAction:(UIButton *)sender{
    
    sender.selected = !sender.selected;
    if (sender.selected) {
        if (![LYZAudioPlayer shareInstance]) {
            NSString *url = @"http://megdadhashem.wapego.ru/files/56727/tubidy_mp3_e2afc5.mp3";
            [[LYZAudioPlayer shareInstance] playWithUrl:url];
        }else{
            [[LYZAudioPlayer shareInstance] play];
        }
        
    }else{
        [[LYZAudioPlayer shareInstance] pasue];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
