//
//  ViewController.m
//  ch6PlayVideo
//
//  Created by shoeisha on 2013/10/10.
//  Copyright (c) 2013年 shoeisha. All rights reserved.
//

#import <MediaPlayer/MediaPlayer.h>
#import "ViewController.h"

@interface ViewController ()
{
    MPMoviePlayerController* player;
    IBOutlet UIView* subview;
}
@end

@implementation ViewController

- (IBAction)play:(id)sender
{
    // 재생
    [player play];

    NSLog(@"%f / %f", player.playableDuration, player.duration);
}

- (IBAction)pause:(id)sender
{
    // 일시정지
    [player pause];
}

- (IBAction)stop:(id)sender
{
    // 정지
    [player stop];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // 미디어 지정
    NSURL* url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"sample_iPod" ofType:@"m4v"]];

    // 인스턴스 생성
    player = [[MPMoviePlayerController alloc] initWithContentURL:url];
    
    // 재생 설정 항목
    player.movieSourceType          = MPMovieSourceTypeFile;
    player.view.frame               = subview.bounds;
    player.shouldAutoplay           = NO;
    player.view.autoresizingMask    = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;

    // 뷰를 등록
    [subview addSubview:player.view];
    
    // 재생 준비
    [player prepareToPlay];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    if (player != nil) {
        [player stop];
        [player.view removeFromSuperview];
    }
}

@end
