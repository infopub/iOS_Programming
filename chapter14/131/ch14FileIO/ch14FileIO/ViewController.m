//
//  ViewController.m
//  ch14FileIO
//
//  Created by HU QIAO on 2014/01/22.
//  Copyright (c) 2014年 shoeisha. All rights reserved.
//

#import "ViewController.h"
#import "Book.h"

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

- (IBAction)textFile:(id)sender {
    
    // 임시 폴더 아래의 신규 디렉토리의 경로
    NSString *newTempDirPath = [NSTemporaryDirectory() stringByAppendingPathComponent:@"textFile"];
    
    // FileManager를 이용하여 디렉토리를 작성
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error = nil;
    BOOL created = [fileManager createDirectoryAtPath:newTempDirPath
                          withIntermediateDirectories:YES
                                           attributes:nil
                                                error:&error];
    // 작성에 실패한 경우는 로그를 출력
    if (!created) {
        NSLog(@"디렉토리 작성에 실패했다.reason is %@ - %@", error, error.userInfo);
        return;
    }
    
    // 파일 경로
    NSString *filePath = [newTempDirPath stringByAppendingPathComponent:@"sampleFile.txt"];
 
    // 저장하는 텍스트의 내용
    NSString *string = @"Hello, World";
    
    // 파일로 쓰기
    created = [string writeToFile:filePath               // 파일 경로
                       atomically:YES                    // 예비 파일을 생성
                         encoding:NSUTF8StringEncoding   // 문자 코드
                            error:&error];               // 에러
    
    // 실패한 경우는 로그를 출력
    if (!created) {
        NSLog(@"파일로 쓰기에 실패했습니다.reason is %@ - %@", error, error.userInfo);
        return;
    }
    
    
    // 텍스트 파일을 읽는다
    NSString *fileContents = [NSString stringWithContentsOfFile:filePath                  // 파일 경로
                                                       encoding:NSUTF8StringEncoding      // 문자 코드
                                                          error:&error];                  // 에러
    if ([fileContents isEqualToString:string]) {
        NSLog(@"%@", @"같은 텍스트입니다.");
    }
    
}

- (IBAction)archive:(id)sender {

    // 임시 폴더 아래의 신규 디렉토리 경로
    NSString *newTempDirPath = [NSTemporaryDirectory() stringByAppendingPathComponent:@"archive"];
    
    // FileManager를 이용하여 디렉토리를 작성
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error = nil;
    BOOL created = [fileManager createDirectoryAtPath:newTempDirPath
                          withIntermediateDirectories:YES
                                           attributes:nil
                                                error:&error];
    // 작성에 실패한 경우는 로그를 출력
    if (!created) {
        NSLog(@"作成に失敗した。reason is %@ - %@", error, error.userInfo);
        return;
    }

    // 파일 경로
    NSString *filePath = [newTempDirPath stringByAppendingPathComponent:@"sample.dat"];
    
    //NSArray 오브젝트를 어카이브하여 파일에 저장
    NSArray *before = @[@"Hello, world", @"안녕"];
    BOOL successful = [NSKeyedArchiver archiveRootObject:before toFile:filePath];
    
    if (successful) {
        NSLog(@"%@", @"데이터의 저장에 성공했습니다.");
    } else{
        NSLog(@"데이터 저장에 실패했습니다.reason is %@ - %@", error, error.userInfo);
        return;
    }
    
    // 어카이브된 데이터를 읽기
    NSArray *after = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    if (after) {
        for (NSString *data in after) {
            NSLog(@"%@", data);
        }
        if ([before isEqualToArray:after]) {
            NSLog(@"%@", @"같은 오브젝트입니다.");
        }
    } else {
        NSLog(@"%@", @"데이터가 없습니다.");
    }
 
    
}

- (IBAction)nscoding:(id)sender {

    // 임시 폴더 아래의 신규 디렉토리의 경로
    NSString *newTempDirPath = [NSTemporaryDirectory() stringByAppendingPathComponent:@"nscoding"];
    
    // FileManager을 이용하여 디렉토리를 작성
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error = nil;
    BOOL created = [fileManager createDirectoryAtPath:newTempDirPath
                          withIntermediateDirectories:YES
                                           attributes:nil
                                                error:&error];
    // 작성에 실패한 경우는 로그를 출력
    if (!created) {
        NSLog(@"작성에 실패했다.reason is %@ - %@", error, error.userInfo);
        return;
    }
    
    // 파일 경로
    NSString *filePath = [newTempDirPath stringByAppendingPathComponent:@"sample.dat"];
    
    Book *firstBook = [[Book alloc] init];
    firstBook.author = @"김은철";
    firstBook.title = @"바이블";
    Book *secondBook = [[Book alloc] init];
    secondBook.author = @"김은철";
    secondBook.title = @"길라잡이";
    
    // 자작 클래스의 오브젝트를 어카이브하여 파일에 저장
    NSArray *before = @[firstBook, secondBook];
    BOOL successful = [NSKeyedArchiver archiveRootObject:before toFile:filePath];
    
    if (successful) {
        NSLog(@"%@", @"데이터의 저장에 성공했습니다.");
    } else{
        NSLog(@"데이터의 저장이 실패했습니다.reason is %@ - %@", error, error.userInfo);
        return;
    }
    
    // 자작 클래스의 오브젝트를 복원한다
    NSArray *array = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    if (array) {
        for (Book *book in array) {
            NSLog(@"%@", book.author);
            NSLog(@"%@", book.title);
        }
    } else {
        NSLog(@"%@", @"데이터가 없습니다.");
    }

}

@end
