//
//  ViewController.m
//  ch14iTunesFileSharing
//
//  Created by HU QIAO on 2014/01/07.
//  Copyright (c) 2014年 shoeisya. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *image;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)ShowImage:(id)sender {
    
    // 도큐먼트 폴더로의 경로를 구하기（<Application_Home>/Documents）
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *userDocumentsPath = [paths objectAtIndex:0];
    
    // 도큐먼트 폴더 내의 리스트를 얻기
    NSError *error = nil;
    NSArray *array = [[NSFileManager defaultManager]
                      contentsOfDirectoryAtPath:userDocumentsPath error:&error];
    
    // 도큐먼트 폴더에 파일이 저장되는 경우
    if (array) {
        
        for (NSString *filename in array) {
            //	확장자가 jpg인 파일 구하기
            if ([[filename pathExtension] isEqualToString:@"jpg"]) {
                //	도큐먼트 폴더의 경로와 파일 이름을 사용하여 대상 파일 경로를 작성
                NSString *imageFilePath = [userDocumentsPath stringByAppendingPathComponent:filename];
                
                // UIImage을 작성
                UIImage *image = [UIImage imageWithContentsOfFile:imageFilePath];
                if (image) {
                    //　UIImageView에 설정
                    _image.image = image;
                    return;
                }
            }
        }
    }
}

@end
