//
//  ViewController.m
//  ch6PlayBgm
//
//  Created by shoeisha on 2013/10/13.
//  Copyright (c) 2013年 shoeisha. All rights reserved.
//

#import <AVFoundation/AVAudioPlayer.h>
#import "ViewController.h"

@interface ViewController () <AVAudioPlayerDelegate>
{
    // 재생위치
    IBOutlet UISlider* slider;

    // 재생시간
    IBOutlet UILabel* time;

    // 재생취치감시
    NSTimer* timer;
    
    // BGM
    AVAudioPlayer* player;
}
@end

@implementation ViewController

- (void)updateTimer:(NSTimer*)sender
{
    NSTimeInterval t = player.currentTime;

    int hour = (int)(t / 3600) %  60;
    int min  = (int)(t /   60) %  60;
    int sec  = (int)(t /    1) %  60;
    int cs   = (int)(t / 0.01) % 100;
    time.text = [NSString stringWithFormat:@"%02d:%02d:%02d.%02d", hour, min, sec, cs];
    
    slider.value = player.currentTime / player.duration;
}

- (IBAction)slide:(UISlider*)sender
{
    if (player.playing == NO) {
        player.currentTime = player.duration * sender.value;
    }
}

- (IBAction)play:(UIButton*)sender
{
    // 재생
    [player play];
    
    slider.enabled = NO;
}

- (IBAction)pause:(UIButton*)sender
{
    // 일시정지
    [player pause];
    
    slider.enabled = YES;
}

- (IBAction)stop:(UIButton*)sender
{
    // 정지
    [player stop];
    
    // 처음으로(시작으로부터 0초)
    player.currentTime = 0;
    [player prepareToPlay];

    slider.enabled = YES;
}

- (IBAction)panning:(UISlider*)sender
{
    if (fabsf(sender.value) < 0.05f) sender.value = 0.f;
    player.pan = sender.value;
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    // 자동정지
    slider.enabled = YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // 파일 지정
    NSURL* url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"WindyCityShort" ofType:@"mp3"]];

    // 인스턴스 생성
    player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:NULL];
    player.delegate = self;
    
    // Optional Params
    {
        // 음량 설정 0.0 - 1.0
        player.volume = 0.6;
        
        // 루프횟수(-1 = 무한루프)
        player.numberOfLoops = 0;
        
        // 재생속도(1.0 = 평속)
        player.rate = 1.0;
        player.enableRate = YES;
    }
    
    // 재생준비
    [player prepareToPlay];
    
    // 재생위치감시
    timer = [NSTimer scheduledTimerWithTimeInterval:0.01
                                             target:self
                                           selector:@selector(updateTimer:)
                                           userInfo:nil
                                            repeats:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
	// BGM 정지
    [player stop];
    
    // 감시 정지
    [timer invalidate];
}

@end
