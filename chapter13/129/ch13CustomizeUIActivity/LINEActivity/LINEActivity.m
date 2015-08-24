//
//  LINEActivity.m
//
//  Created by HU QIAO on 2013/12/07.
//  Copyright (c) 2014年 shoeisha. All rights reserved.
//

#import "LINEActivity.h"

// UIActivity의 메소드를 오버라이드한다
@implementation LINEActivity

// 종류를 나타내는 문자열
- (NSString *)activityType {
    return @"kr.naver.LINEActivity";
}

// 아이콘
- (UIImage *)activityImage
{
    return [UIImage imageNamed:@"LINEActivityIcon.png"];
}

// 타이틀
- (NSString *)activityTitle
{
    return @"LINE";
}

// 실제로 Activity를 실행할 수 있는지 여부를 반환하는 메소드
// 이 메소드에서 NO를 반환한 경우, 메뉴는 표시되지 않는다
- (BOOL)canPerformWithActivityItems:(NSArray *)activityItems
{
    
    for (id activityItem in activityItems) {
        if ([activityItem isKindOfClass:[NSString class]] || [activityItem isKindOfClass:[UIImage class]]) {
            return YES;
        }
    }
    return NO;
}

// 메뉴가 선택되었을 때에 호출되는 메소드. 여기에서 실제로 공유 처리를 한다.
- (void)prepareWithActivityItems:(NSArray *)activityItems {
    for (id activityItem in activityItems) {
        if ([self openLINEWithItem:activityItem])
            break;
    }
}

// 전달된 activityItems를 이용하여, LINE 앱을 실행.
- (BOOL)openLINEWithItem:(id)item
{
    // URL 스킴을 사용하여, LINE이 설치되었는지를 판단
    if (![[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"line://"]]) {
        //openURLでAppStoreを開く
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/kr/app/lain-line/id443904275?mt=8"]];
        return NO;
    }
    
    // 게시처리(LINE을 실행）
    NSString *LINEURLString = nil;
    if ([item isKindOfClass:[NSString class]]) {
        LINEURLString = [NSString stringWithFormat:@"line://msg/text/%@", item];
    } else if ([item isKindOfClass:[UIImage class]]) {
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        [pasteboard setData:UIImagePNGRepresentation(item) forPasteboardType:@"public.png"];
        LINEURLString = [NSString stringWithFormat:@"line://msg/image/%@", pasteboard.name];
    } else {
        return NO;
    }
    NSURL *LINEURL = [NSURL URLWithString:LINEURLString];
    [[UIApplication sharedApplication] openURL:LINEURL];
    return YES;
}

@end
