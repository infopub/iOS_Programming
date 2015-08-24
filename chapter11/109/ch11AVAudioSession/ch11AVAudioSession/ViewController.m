//
//  ViewController.m
//  ch11AVAudioSession
//
//  Created by shoeisha on 2013/12/30.
//  Copyright (c) 2013年 shoeisha. All rights reserved.
//

#import <AVFoundation/AVAudioPlayer.h>
#import <AVFoundation/AVAudioSession.h>
#import <MediaPlayer/MediaPlayer.h>
#import "ViewController.h"

@interface ViewController () /* <AVAudioSessionDelegate> iOS6이후 Deprecated */
{
    // BGM
    AVAudioPlayer* player;
}
@end

@implementation ViewController

- (IBAction)beginInterruption
{
    NSLog(@"beginInterruption");
    [player pause];
}

- (IBAction)endInterruption
{
    NSLog(@"endInterruption");
    
    // 3초 후에 울린다
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [NSThread sleepForTimeInterval:3];
        [[AVAudioSession sharedInstance] setActive: YES error: nil];
        [player play];
        NSLog(@"play!");
    });
}

- (void)sessionDidInterrupt:(NSNotification*)notification
{
    // 인터럽트 정보
    NSNumber* interruptionType   = [[notification userInfo] objectForKey:AVAudioSessionInterruptionTypeKey];
    NSNumber* interruptionOption = [[notification userInfo] objectForKey:AVAudioSessionInterruptionOptionKey];
    
    switch (interruptionType.unsignedIntegerValue) {
        // 착신음 등의 인터럽트 발생
        case AVAudioSessionInterruptionTypeBegan:
            NSLog(@"AVAudioSessionInterruptionTypeBegan");
            [self beginInterruption];
            break;

        // 착신음 등의 인터럽트 종료
        case AVAudioSessionInterruptionTypeEnded:
            NSLog(@"AVAudioSessionInterruptionTypeEnded");
            switch (interruptionOption.unsignedIntegerValue) {
                case AVAudioSessionInterruptionOptionShouldResume:
                    NSLog(@"AVAudioSessionInterruptionOptionShouldResume");
                    [self endInterruption];
                    break;
                default:
                    break;
            }
            break;

        default:
            NSLog(@"Interruption other");
            break;
    }
}

- (void)sessionMediaServicesWereLost
{
    NSLog(@"sessionMediaServicesWereLost");
}

// RemoteControlDelegate
- (void)remoteControlReceivedWithEvent:(UIEvent *)event
{
    NSLog(@"receive remote control events");
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // 오디오 세션 설정
    AVAudioSession* session = [AVAudioSession sharedInstance];
    [session setCategory:AVAudioSessionCategoryPlayback error:nil];
    [session setMode:AVAudioSessionModeDefault error:nil];
    [session setActive:YES error:nil];
    
    // 리모트 컨트롤 이벤트 시작
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    
    // 알림 센터 등록
    NSNotificationCenter* center = [NSNotificationCenter defaultCenter];
    [center addObserver:self
               selector:@selector(sessionDidInterrupt:)
                   name:AVAudioSessionInterruptionNotification
                 object:session];
    /*
    [center addObserver:self
               selector:@selector(sessionMediaServicesWereLost)
                   name:AVAudioSessionMediaServicesWereLostNotification
                 object:session];
    [center addObserver:self selector:@selector(sessionRouteDidChange) name:AVAudioSessionRouteChangeNotification object:nil];
     */
    
    // 파일을 지정하여 BGM을 울린다
    NSURL* url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"WindyCityShort" ofType:@"mp3"]];
    
    // 인스턴스 생성
    player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:NULL];
    
    // 음량 설정 0.0 - 1.0
    player.volume = 0.4;
    
    // 루프 횟수(-1 = 무한루프)
    player.numberOfLoops = -1;
    
    // 재생
    [player play];
   
    
    // 곡 정보 표시
    MPNowPlayingInfoCenter* infoCenter = [MPNowPlayingInfoCenter defaultCenter];
    infoCenter.nowPlayingInfo = @{
                                  MPMediaItemPropertyArtist:@"아티스트명",
                                  MPMediaItemPropertyTitle:@"타이틀명",
                                  MPMediaItemPropertyAlbumTitle:@"앨범명",
                                  };
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    // 알람 센터 해제
    NSNotificationCenter* center = [NSNotificationCenter defaultCenter];
    
    [center removeObserver:self name:AVAudioSessionInterruptionNotification object:[AVAudioSession sharedInstance]];
    //[center removeObserver:self name:AVAudioSessionRouteChangeNotification object:[AVAudioSession sharedInstance]];
    
    // 원격 컨트롤 이벤트 해제
    [[UIApplication sharedApplication] endReceivingRemoteControlEvents];
}

@end
