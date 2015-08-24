//
//  PickerViewController.m
//  iOSRecipe
//
//  Created by adminfeng on 2014/01/13.
//  Copyright (c) 2014年 shaoeisya. All rights reserved.
//

#import "PickerViewController.h"

@interface PickerViewController ()
{
    NSArray *data1;
    NSArray *data2;
}
@end

@implementation PickerViewController

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
    data1 = [NSArray arrayWithObjects:@"data1",@"data2",@"data3",@"data4",@"data5", nil];
    data2 = [NSArray arrayWithObjects:@"test1",@"test2",@"test3",@"test4",@"test5",@"test6", nil];
    self.uiPicker.delegate = self;
    self.uiPicker.dataSource = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// UIPickerView에 표시할 열 수를 지정할 메소드
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 2;
}

// UIPickerView에 표시할 행 수를 지정하는 메소드
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if(0 == component) {
        return data1.count;
    } else {
        return data2.count;
    }
}

// PickerView의 각 행에 표시할 문자열을 지정하는 메소드
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if( 0== component){
        return [data1 objectAtIndex:row];
    } else {
        return [data2 objectAtIndex:row];
    }
    
}

/**
 * 피커의 선택 행을 결정한 경우
 */
- (void)pickerView:(UIPickerView *)pickerView
      didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    // 1번째의 선택된 행 수를 구하기
    NSInteger val0 = [pickerView selectedRowInComponent:0];
    
    // 2번째의 선택한 행 수를 구하기
    NSInteger val1 = [pickerView selectedRowInComponent:1];
    
    NSLog(@"1번째 줄:%@이 선택", [data1 objectAtIndex:val0]);
    NSLog(@"2번째 줄:%@이 선택", [data2 objectAtIndex:val1]);
}

- (IBAction)closePickerView:(id)sender {
    // 1번째의 선택한 행 수를 구하기
    NSInteger val0 = [self.uiPicker selectedRowInComponent:0];
    // 2번째의 선택한 행 수를 구하기
    NSInteger val1 = [self.uiPicker selectedRowInComponent:1];
    
    NSLog(@"1번째 줄:%@이 선택", [data1 objectAtIndex:val0]);
    NSLog(@"2번째 줄:%@이 선택", [data2 objectAtIndex:val1]);
    [self.delegate closePickerView:self];
}



@end
