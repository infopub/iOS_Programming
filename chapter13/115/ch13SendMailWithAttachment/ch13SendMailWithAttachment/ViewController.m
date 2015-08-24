//
//  ViewController.m
//  ch13SendMailWithAttachment
//
//  Created by HU QIAO on 2013/11/19.
//  Copyright (c) 2014年 shoeisha. All rights reserved.
//

#import <MessageUI/MessageUI.h>
#import "ViewController.h"

@interface ViewController ()
< MFMailComposeViewControllerDelegate,
  UINavigationControllerDelegate
>

//송신 결과 메세지를 표시하는 라벨
@property (weak, nonatomic) IBOutlet UILabel *feedbackMsg;

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

// 메일 작성 버튼을 눌렀을 때의 처리
- (IBAction)sendMailPicker:(id)sender {
    
    // MFMailComposeViewController를 이용하기 전에 canSendMail 함수를 이용하여
    // 메일 계정이 설정되어 있는지 메일 송신 가능 여부를 확인해야 한다
    
    if ([MFMailComposeViewController canSendMail])
    {
       // 결과가 YES인 경우는 메일 작성・송신 화면의 표시 처리를 한다
       [self displayMailComposer];
    }
    else
    {
        // 결과가 NO인 경우는 메일 계정의 설정을 해야함을 사용자에게 통지한다
        self.feedbackMsg.hidden = NO;
		self.feedbackMsg.text = @"메일 계정의 설정을 해야합니다.";
    }

}

// 메일 작성・송신 화면의 표시 처리를 한다
- (void)displayMailComposer
{
    //MFMailComposeViewController 인스턴스를 생성하고 수신처나 본문 등을 설정한다
	MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
	picker.mailComposeDelegate = self;
	
    // 메일 타이틀을 설정한다
	[picker setSubject:@"첨부 파일의 송신"];
	
	// 여러 개의 수신처를 설정한다
	NSArray *toRecipients = [NSArray arrayWithObjects:@"1stRecipient@foo.com", @"2ndRecipient@foo.com", nil];
	[picker setToRecipients:toRecipients];
    
    // CC를 설정한다
    NSArray *ccRecipients = [NSArray arrayWithObject:@"ccRecipient@foo.com"];
    [picker setCcRecipients:ccRecipients];
	
    // BCC를 설정한다
	NSArray *bccRecipients = [NSArray arrayWithObject:@"bccRecipient@foo.com"];
    [picker setBccRecipients:bccRecipients];
	
	// 메일 본문을 설정한다
	NSString *emailBody = @"CSV 파일을 첨부하고 있습니다.";
    
    // body 인수로 메일 본문을 지정한다. isHTML이 NO인 경우는 텍스트 메일입니다.
	[picker setMessageBody:emailBody isHTML:NO];
    
    // NSString을 NSdata로 변환
    NSString *csv = @"foo,bar,blah,hello";
    NSData *csvData = [csv dataUsingEncoding:NSUTF8StringEncoding];
    
    // mimeType은 text/csv
    [picker addAttachmentData:csvData mimeType:@"text/csv" fileName:@"export.csv"];
    

    // 부모 뷰 컨트롤러의 presentViewController 함수를 이용하고, 모달로 메일 작성・송신 화면을 표시한다
	[self presentViewController:picker animated:YES completion:NULL];
}

//　사용자가 송신 또는 취소를 선택하면 MFMailComposeViewControllerDelegate의
//　mailComposeController:didFinishWithResult:error:메소드가 호출된다.
- (void)mailComposeController:(MFMailComposeViewController*)controller
          didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    
	self.feedbackMsg.hidden = NO;
    
	switch (result)
	{
		case MFMailComposeResultCancelled:
			self.feedbackMsg.text = @"메일을 삭제했습니다.";
			break;
		case MFMailComposeResultSaved:
			self.feedbackMsg.text = @"메일을 저장했습니다.";
			break;
		case MFMailComposeResultSent:
			self.feedbackMsg.text = @"메일을 송신했습니다.";
			break;
		case MFMailComposeResultFailed:
			self.feedbackMsg.text = @"메일 송신을 실패했습니다.";
			break;
		default:
			break;
	}
    // 모달의 메일 편집・송신 화면을 닫는다
	[self dismissViewControllerAnimated:YES completion:NULL];
}


@end
