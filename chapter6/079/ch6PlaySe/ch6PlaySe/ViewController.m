//
//  ViewController.m
//  ch6PlaySe
//
//  Created by shoeisha on 2013/10/10.
//  Copyright (c) 2013年 shoeisha. All rights reserved.
//

#import <AudioToolbox/AudioToolbox.h>
#import "ViewController.h"

@interface ViewController ()
{
    NSMutableArray* SoundID;
}
@end

@implementation ViewController

-(IBAction)play:(UIButton*)sender
{
    // 효과음을 재생
    AudioServicesPlaySystemSound((SystemSoundID)[[SoundID objectAtIndex:sender.tag] unsignedIntValue]);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	// Do any additional setup after loading the view, typically from a nib.

    // 재생 리소스
    NSArray* kinds = [NSArray arrayWithObjects:@"mute",         // 외부 음성 파일(무음）
                      [NSNumber numberWithUnsignedInt:1000],    // 시스템 SE : 1000-, kSystemSoundID_Vibrate
                      @"hihat",                                 // 외부 음성 파일
                      nil];
    
    // 요소수만큼 메모리 확보
    SoundID = [NSMutableArray arrayWithCapacity:kinds.count];

    // 재생 리소스 등록
    for (int i = 0; i < kinds.count; i++) {
        SystemSoundID sid;

        // 리스트의 요소가 NSNumber라면 시스템 SE 번호 외에는 외부 파일명（*.caf）로 취급함
        id kind = [kinds objectAtIndex:i];
        if ([kind isKindOfClass:[NSNumber class]]) {
            sid = (SystemSoundID)[kind unsignedIntValue];
        } else {
            NSURL* path = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:kind ofType:@"caf"]];
            // 효과음을 등록
            AudioServicesCreateSystemSoundID((__bridge CFURLRef)path, &sid);
        }
        
        [SoundID addObject:[NSNumber numberWithUnsignedInt:sid]];
    }

    // 무음을 미리 재생하여 초기재생 시의 필요 없는 음을 소거
    AudioServicesPlaySystemSound((SystemSoundID)[[SoundID objectAtIndex:0] unsignedIntegerValue]);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    // 재생 리소스 파기
    for (NSNumber* n in SoundID) {
        SystemSoundID sid = [n unsignedIntValue];
        // 시스템 SE보다 크면 파기
        if (sid > kSystemSoundID_Vibrate) AudioServicesDisposeSystemSoundID(sid);
    }
}

@end
