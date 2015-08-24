//
//  ViewController.m
//  ch13AddressBookPrivacy
//
//  Created by HU QIAO on 2013/11/25.
//  Copyright (c) 2014年 shoeisha. All rights reserved.
//

#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>

#import "ViewController.h"

@interface ViewController () <ABPeoplePickerNavigationControllerDelegate>

@property (nonatomic, assign) ABAddressBookRef addressBook;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    // 주소록을 생성
	_addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    if(_addressBook) {
        //ABAddressBookUnregisterExternalChangeCallback(_addressBook, handleAddressBookChange, (__bridge void *)(self));
        CFRelease(_addressBook);
    }
}


// 개인 정보 보호 → 「연락처」 상태 버튼을 눌렀을 때 처리
- (IBAction)checkAddressBookAccess:(id)sender {
    
    ABAuthorizationStatus status = ABAddressBookGetAuthorizationStatus();
    
    // 사용자에 아직 액세스 허가를 요청하지 않음
    if(status == kABAuthorizationStatusNotDetermined) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"개인 정보 보호 상태"
                                                        message:@"사용자에 아직 액세스의 허가를 요청하지 않음"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
    // iPhone 설정의 「기능제한」에서 주소록에의 액세스를 제한함
    else if(status == kABAuthorizationStatusRestricted) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"개인 정보 보호 상태"
                                                        message:@"iPhone 설정의 「기능제한」에서 주소록에의 액세스를 제한함"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
    // 주소록에의 액세스를 사용자가 거부함
    else if(status == kABAuthorizationStatusDenied) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"개인 정보 보호 상태"
                                                        message:@"주소록에의 액세스를 사용자가 거부함"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
    // 주소록에의 액세스를 사용자가 허가함
    else if(status == kABAuthorizationStatusAuthorized) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"개인 정보 보호 상태"
                                                        message:@"주소록에의 액세스를 사용자가 허가함"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
    
}

// 연락처 표시 버튼을 눌렀을 때의 처리
- (IBAction)showAddressBook:(id)sender {
    switch (ABAddressBookGetAuthorizationStatus())
    {
        // 주소록에의 액세스를 사용자가 허가한 경우
        case  kABAuthorizationStatusAuthorized:
            [self showPeoplePickerController];
            break;
            
        // 사용자에게 아직 액세스 허가를 요청하지 않은 경우
        case  kABAuthorizationStatusNotDetermined :
        {
            // 사용자에 따라서 주소록에 접근하는 허가를 요구한다
            ViewController * __weak weakSelf = self;
            ABAddressBookRequestAccessWithCompletion(self.addressBook, ^(bool granted, CFErrorRef error)
                                                     {
                                                         if (granted)
                                                         {
                                                             // 사용자가 주소록에 접근을 허가한 경우, granted에 true가 들어간다.
                                                             // 메인 스레드를 멈추기 위하여 dispatch_async을 사용하여 처리를 백그라운드에서 실행한다.
                                                             dispatch_async(dispatch_get_main_queue(), ^{
                                                                 [weakSelf showPeoplePickerController];
                                                             });
                                                         } else {
                                                             // 사용자가 「허가하지 않는다」를 탭한 경우는 granted에 false가 들어온다.
                                                             // 알람을 표시한다
                                                             UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Privacy Warning"
                                                                                                             message:@"주소록으로의 접근을 사용자가 거부했습니다."
                                                                                                            delegate:nil
                                                                                                   cancelButtonTitle:@"OK"
                                                                                                   otherButtonTitles:nil];
                                                             [alert show];
                                                         }
                                                     });
        }
            break;
            
            // 주소록으로의 접근을 사용자가 거부한 경우
        case  kABAuthorizationStatusDenied:
            //iPhone 설정의 「차단」에서 주소록으로의 접근을 제한한 경우
        case  kABAuthorizationStatusRestricted:
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Privacy Warning"
                                                            message:@"주소록으로의 접근을 허가해주세요."
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
        }
            break;
        default:
            break;
    }
}


// 주소록을 표시한다
-(void)showPeoplePickerController
{
	ABPeoplePickerNavigationController *picker = [[ABPeoplePickerNavigationController alloc] init];
    picker.peoplePickerDelegate = self;
	// 전화번호,Email,생일을 표시
	NSArray *displayedItems = [NSArray arrayWithObjects:[NSNumber numberWithInt:kABPersonPhoneProperty],
                               [NSNumber numberWithInt:kABPersonEmailProperty],
                               [NSNumber numberWithInt:kABPersonBirthdayProperty], nil];
	
	
	picker.displayedProperties = displayedItems;
	// picker를 표시
    [self presentViewController:picker animated:YES completion:nil];
}


// 주소록에서 개인을 선택할 때에 호출된다
- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person
{
    // 반환값으로 YES를 반환하면 개인 상세 표시 화면을 표시한다
	return YES;
}

// 주소록에서 개인 특정의 프로퍼티를 선택할 때에 호출된다
- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person
								property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier
{
    // 반환값으로 NO를 반환하면 선택한 프로퍼티에 맞는 액션 （전화、메일 송신 등）을 실행하지 않는다.
	return NO;
}

// Cancel 되었을 때에 호출된다
- (void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker;
{
	[self dismissViewControllerAnimated:YES completion:NULL];
}


@end
