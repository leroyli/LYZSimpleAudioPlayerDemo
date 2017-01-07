//
//  LYZAudioPlayer.h
//  LYZSimpleAudioPlayerDemo
//
//  Created by artios on 2017/1/6.
//  Copyright © 2017年 artios. All rights reserved.
//

#import <Foundation/Foundation.h>
@import AVFoundation;

@interface LYZAudioPlayer : NSObject

@property (nonatomic, strong) AVPlayer     *player;
@property (nonatomic, strong) NSString     *audioUrl;
@property (nonatomic, assign) BOOL         isPlaying;
@property (nonatomic, assign) BOOL         isPauseing;
@property (nonatomic, strong) AVPlayerItem *currentItem;
@property (nonatomic, strong) AVPlayerItem *audioItem;

+ (instancetype)shareInstance;
- (void)play;
- (void)pasue;

@end
