//
//  Ch01_UIActionSheet_01_ViewController.m
//  iOSRecipe
//
//  Created by adminfeng on 2014/01/26.
//  Copyright (c) 2014年 shaoeisya. All rights reserved.
//

#import "Ch01_UIActionSheet_01_ViewController.h"

@interface Ch01_UIActionSheet_01_ViewController ()

@end

@implementation Ch01_UIActionSheet_01_ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)showActionSheet:(id)sender {
    // Do any additional setup after loading the view from its nib.
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  // 타이틀을 설정
                                  initWithTitle:@"UIActionSheet 샘플"
                                  // 델리게이트를 지정
                                  delegate:self
                                  // 취소버튼의 타이틀을 지정
                                  cancelButtonTitle:@"취소"
                                  // 적색 경고 버튼의 타이틀을 지정
                                  destructiveButtonTitle:@"삭제"
                                  // 기타 버튼을 지정
                                  otherButtonTitles:@"button1",@"button2", nil];
    
    // 뷰의 중심에 액션시트를 표시
    [actionSheet showInView:self.view];
}

-(void)actionSheet:(UIActionSheet*)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (buttonIndex) {
        case 0:
            self.label1.text=@"삭제 버튼";
            break;
        case 1:
            self.label1.text=@"button1";
            break;
        case 2:
            self.label1.text=@"button2";
            break;
        case 3:
            self.label1.text=@"취소 버튼";
            break;
    }
}
@end
