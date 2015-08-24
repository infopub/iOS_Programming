//
//  PickerView2Controller.m
//  iOSRecipe
//
//  Created by adminfeng on 2014/01/13.
//  Copyright (c) 2014年 shaoeisya. All rights reserved.
//

#import "PickerView2Controller.h"

@interface PickerView2Controller ()

@end

@implementation PickerView2Controller

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
    // Do any additional setup after loading the view from its nib.
    self.uiPicker.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// UIPickerView에 표시할 열 수를 지정하는 메소드
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

// UIPickerView에 표시할 행 수를 지정하는 메소드
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return 3;
}

// PickerView의 각 행에 표시할 문자열을 지정하는 메소드
- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component{
    NSString *str = @"Error";
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:str];
    NSRange range1 = [str rangeOfString:@"Error"];
    // 빨간색으로 설정
    [attrStr addAttribute:NSForegroundColorAttributeName
                    value:[[UIColor redColor] colorWithAlphaComponent:1.]
                    range:range1];

    NSString *str2 = @"Warn";
    NSMutableAttributedString *attrStr2 = [[NSMutableAttributedString alloc] initWithString:str2];
    NSRange range2 = [str2 rangeOfString:@"Warn"];
    // 노란색으로 설정
    [attrStr2 addAttribute:NSForegroundColorAttributeName
                    value:[[UIColor yellowColor] colorWithAlphaComponent:1.]
                    range:range2];
    
    NSString *str3 = @"Info";
    NSMutableAttributedString *attrStr3 = [[NSMutableAttributedString alloc] initWithString:str3];
    NSRange range3 = [str3 rangeOfString:@"Info"];
    // 회색으로 설정
    [attrStr3 addAttribute:NSForegroundColorAttributeName
                    value:[[UIColor grayColor] colorWithAlphaComponent:1.]
                    range:range3];
    NSMutableAttributedString *result;
    switch (row) {
        case 0:
            result = attrStr;
            break;
        case 1:
            result = attrStr2;
            break;
        case 2:
            result = attrStr3;
            break;
        default:
            result =[[NSMutableAttributedString alloc] initWithString:@"NULL"];
            break;
    }
    
    return result;
}


- (IBAction)closePickerView:(id)sender {
    [self.delegate closePickerView:self];
}

@end
