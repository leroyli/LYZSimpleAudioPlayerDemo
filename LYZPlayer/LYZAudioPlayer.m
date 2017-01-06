//
//  LYZAudioPlayer.m
//  LYZSimpleAudioPlayerDemo
//
//  Created by artios on 2017/1/6.
//  Copyright © 2017年 artios. All rights reserved.
//

#import "LYZAudioPlayer.h"



@implementation LYZAudioPlayer

static LYZAudioPlayer* _instance = nil;


/**
 * 单例
 *
 @return self
 */
+ (instancetype)shareInstance{
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init] ;
    }) ;
    
    return _instance ;
}

/**
 * 初始化播放器
 *
 @param url 音频文件的URL
 */
- (void)playWithUrl:(NSString *)url{
    
    if (url == nil) {return;}
    if (self.player) {self.player = nil;}
    if (self.audioItem) {self.audioItem = nil;}
    
    /*
     //播放本地文件
     NSString *url = [[NSBundle mainBundle] pathForResource:@"yanyuan" ofType:@"mp3"];
     NSURL *audioUrl = [NSURL fileURLWithPath:url];
     self.audioItem = [AVPlayerItem playerItemWithURL:audioUrl];
     */
    
    self.audioItem = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:url]];
    self.player    = [AVPlayer playerWithPlayerItem:self.audioItem];
    [self setupObserver];
}


/**
 * 添加观察者和通知
 */
- (void)setupObserver{
    
    [self.audioItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playbackFinished:) name:AVPlayerItemDidPlayToEndTimeNotification object:self.audioItem];
}

/**
 * 播放
 */
- (void)play{
    if (self.isPlaying) {return;}
    [self.player play];
    self.isPlaying = YES;
}


/**
 * 暂停
 */
- (void)pasue{
    if (!self.isPlaying) {return;}
    [self.player pause];
    self.isPlaying = NO;
}

/**
 *
 * 监听状态
 *
 **/
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    
    if ([keyPath isEqualToString:@"status"]) {
        switch (self.player.status) {
            case AVPlayerStatusUnknown:
                NSLog(@"KVO：未知状态，此时不能播放");
                break;
            case AVPlayerStatusReadyToPlay:
                NSLog(@"KVO：准备完毕，可以播放");
                [self play];
                break;
            case AVPlayerStatusFailed:
                NSLog(@"KVO：加载失败，网络或者服务器出现问题");
                break;
            default:
                break;
        }
    }
}

/**
 *
 * 播放完成
 *
 **/
- (void)playbackFinished:(NSNotification *)notice {
    NSLog(@"播放完成");
    [self removeObserver];
}


/**
 * 移除观察者和通知
 */
- (void)removeObserver{
    [self.audioItem removeObserver:self forKeyPath:@"status"];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


/**
 * 当前播放对象
 *
 @return AVPlayerItem
 */
- (AVPlayerItem *)currentItem{
    if (!_currentItem) {
        if (self.player) {
            _currentItem = self.player.currentItem;
        }else{
            _currentItem =  nil;
        }
    }
    return _currentItem;
}

- (void)dealloc{
    self.player = nil;
    self.audioItem = nil;
}

@end
