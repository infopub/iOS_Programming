//
//  ViewController.m
//  ch14ResourceFile
//
//  Created by HU QIAO on 2014/01/19.
//  Copyright (c) 2014年 shoeisya. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *myImage;
@property (weak, nonatomic) IBOutlet UITextView *myText;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
    // 리소스 파일 경로를 구하기(pathForResource를 사용)
    NSString *imgfilePath = [[NSBundle mainBundle] pathForResource:@"shoeisha_logo" ofType:@"gif"];
    NSLog(@"shoeisha_logo.gif 경로%@", imgfilePath);
    
    UIImage *image = [UIImage imageWithContentsOfFile:imgfilePath];
    if (image) {
        //　UIImageView 에 설정
        _myImage.image = image;
    }
    
    // 리소스 파일 경로를 구하기 (리소스 경로를 어펜드)
    // 핸들 경로를 구하기
    NSString *bundlePath = [[NSBundle mainBundle] bundlePath];
    // 핸들 경로를 어펜드
    NSString *textFilePath = [bundlePath stringByAppendingPathComponent:@"hello.txt"];
    NSLog(@"Hello.txt의 경로%@", textFilePath);
    
    NSString *textString = [NSString stringWithContentsOfFile: textFilePath encoding: NSUTF8StringEncoding error:NULL];
    NSLog(@"Hello.txt:%@", textString);

    _myText.text = textString;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
