//
//  ViewController.m
//  ch14CreateFile
//
//  Created by HU QIAO on 2013/10/06.
//  Copyright (c) 2014年 shoeisha. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

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

- (IBAction)createFile:(id)sender {
    
    // 애플리케이션의 도큐먼트 디렉토리의 장소를 특정
    NSArray *arrayPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    // Document 디렉토리로의 파일 경로는 배열의 1 번째의 요소
    NSString *docDirectory = [arrayPaths objectAtIndex:0];
    
    // 신규 디렉토리 경로
    NSString *newDocumentDirPath = [docDirectory stringByAppendingPathComponent:@"newDirectory"];
    
    // FileManager를 사용하여 디렉토리를 작성
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error = nil;
    BOOL created = [fileManager createDirectoryAtPath:newDocumentDirPath
                          withIntermediateDirectories:YES
                                           attributes:nil
                                                error:&error];
    if (!created) {
        // 작성에 실패한 경우
        NSString *errMsg = [NSString stringWithFormat:@"디렉토리 작성에 실패했습니다.%@ - %@",error, error.userInfo];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"확인"
                                                        message:errMsg
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    // 파일 경로
    NSString *savedPath = [newDocumentDirPath stringByAppendingPathComponent:@"sampleFile.txt"];
    
    // 빈 파일을 작성
    created = [fileManager createFileAtPath:savedPath
                                   contents:nil
                                 attributes:nil];
    
    if (!created) {
        // 작성에 실패한 경우
        NSString *errMsg = [NSString stringWithFormat:@"빈 파일 작성에 실패했습니다.%d - %s",errno, strerror(errno)];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"확인"
                                                        message:errMsg
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    } else {
        // 작성에 성공한 경우
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"확인"
                                                        message:[savedPath stringByAppendingString:@"이 빈 파일을 작성했습니다."]
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
}

@end
