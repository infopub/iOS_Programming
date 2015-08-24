//
//  ViewController.m
//  ch13SendMailWithImg
//
//  Created by HU QIAO on 2013/11/19.
//  Copyright (c) 2014年 shoeisha. All rights reserved.
//

#import <MessageUI/MessageUI.h>
#import "ViewController.h"

@interface ViewController ()
<
MFMailComposeViewControllerDelegate,
UINavigationControllerDelegate,
UIImagePickerControllerDelegate,
UIActionSheetDelegate
>

// 송신 결과 메세지를 표시하는 라벨
@property (weak, nonatomic) IBOutlet UILabel *feedbackMsg;

// 사진을 저장하는 UIImage
@property (strong, nonatomic) UIImage *image;

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


#pragma mark - pictureSelection

// 사진 선택 버튼을 눌렀을 때의 처리
- (IBAction)pictureSelectionPicker:(id)sender {
    
    UIActionSheet *sheet = [[UIActionSheet alloc]
                            initWithTitle:@"송신할 사진을 선택"
                            delegate:self
                            cancelButtonTitle:@"취소"
                            destructiveButtonTitle:nil
                            otherButtonTitles:@"포토 라이브러리", @"카메라", @"카메라롤", nil];
    [sheet showInView:self.view];
}


// 액션시트의 버튼이 눌렸을 때의 처리
- (void)actionSheet:(UIActionSheet*)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    UIImagePickerControllerSourceType sourceType;
    UIImagePickerController *ipc;
    
    switch (buttonIndex) {
        case 0:
            // 포토 라이브러리를 표시
            sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            if (![UIImagePickerController isSourceTypeAvailable:sourceType]) {
                self.feedbackMsg.hidden = NO;
                self.feedbackMsg.text = @"포토 라이브러리를 표시할 수 없습니다.";
                return;
            }
            
            ipc = [[UIImagePickerController alloc] init];
            [ipc setSourceType:sourceType];
            [ipc setDelegate:self];
            [self presentViewController:ipc animated:YES completion:NULL];
            break;
            
            
        case 1:
            // 카메라를 실행한다
            sourceType = UIImagePickerControllerSourceTypeCamera;
            if (![UIImagePickerController isSourceTypeAvailable:sourceType]) {
                self.feedbackMsg.hidden = NO;
                self.feedbackMsg.text = @"카메라를 실행할 수 없습니다.";
                return;
            }
            
            ipc = [[UIImagePickerController alloc] init];
            [ipc setSourceType:sourceType];
            [ipc setDelegate:self];
            [self presentViewController:ipc animated:YES completion:NULL];
            break;
            
        case 2:
            // 카메라롤을 표시한다
            sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            if (![UIImagePickerController isSourceTypeAvailable:sourceType]) {
                self.feedbackMsg.hidden = NO;
                self.feedbackMsg.text = @"카메라 롤을 표시할 수 없습니다.";
                return;
            }
            
            ipc = [[UIImagePickerController alloc] init];
            [ipc setSourceType:sourceType];
            [ipc setDelegate:self];
            [self presentViewController:ipc animated:YES completion:NULL];
            break;
            
        default:
            break;
    }
}

// 이미지를 선택한 후의 처리
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    _image = image;
    if ([picker respondsToSelector:@selector(presentingViewController)]) {
        [[picker presentingViewController] dismissViewControllerAnimated:YES completion:NULL];
    } else {
        [[picker parentViewController] dismissViewControllerAnimated:YES completion:NULL];
    }
}


#pragma mark - sendMail

// 메일 작성 버튼을 눌렀을 때의 처리
- (IBAction)sendMailPicker:(id)sender {
    
    
    // MFMailComposeViewController을 이용하기 전에 canSendMail 함수를 이용하여
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
		self.feedbackMsg.text = @"메일 계정의 설정을 해야 합니다.";
    }
    
}

// 메일 작성・송신 화면의 표시 처리를 한다
- (void)displayMailComposer
{
    //MFMailComposeViewController 인스턴스를 작성하고, 수신처나 본문 등을 설정한다
	MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
	picker.mailComposeDelegate = self;
	
    // 메일 타이틀을 설정한다
	[picker setSubject:@"이미지 송신"];
	
	// 여러 개의 수신처를 설정한다
	NSArray *toRecipients = [NSArray arrayWithObjects:@"1stRecipient@foo.com", @"2ndRecipient@foo.com", nil];
	[picker setToRecipients:toRecipients];
    
    // CC를 설정한다
    NSArray *ccRecipients = [NSArray arrayWithObject:@"ccRecipient@foo.com"];
    [picker setCcRecipients:ccRecipients];
	
    // BCC를 설정한다
	NSArray *bccRecipients = [NSArray arrayWithObject:@"bccRecipient@foo.com"];
    [picker setBccRecipients:bccRecipients];
	
	// 매일 본문을 설정한다
	NSString *emailBody = @"이미지를 송신합니다.";
    // body 인수로 메일 본문을 지정합니다.isHTML이 NO인 경우는 텍스트 메일입니다.
	[picker setMessageBody:emailBody isHTML:NO];
    
    //사진을 첨부로 설정한다
    //_image의 nil 체크
    if (_image){
        // 압축율
        CGFloat compressionQuality = 0.8;
        // UIImageJPEGRepresentation로 JPEG 압축
        NSData *attachData = UIImageJPEGRepresentation(_image, compressionQuality);
        // 압축한 이미지를 첨부
        [picker addAttachmentData:attachData mimeType:@"image/jpeg" fileName:@"image.jpg"];
    }
    
	// 리소스 이미지를 첨부로 설정한다
	NSString *path = [[NSBundle mainBundle] pathForResource:@"shoeisha_logo" ofType:@"gif"];
	NSData *myData = [NSData dataWithContentsOfFile:path];
	[picker addAttachmentData:myData mimeType:@"image/gif" fileName:@"shoeisha_logo"];
    
    // 부모 뷰 컨트롤러의 presentViewController 함수를 이용하고, 모달로 메일 작성・송신 화면을 표시한다
	[self presentViewController:picker animated:YES completion:NULL];
}

//　사용자가 송신 또는 취소를 선택하면, MFMailComposeViewControllerDelegate의
//　mailComposeController:didFinishWithResult:error:메소드가 호출된다
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
			self.feedbackMsg.text = @"메일 송신에 실패했습니다.";
			break;
		default:
			break;
	}
    // 모달의 메일 편집・송신 화면을 닫는다
	[self dismissViewControllerAnimated:YES completion:NULL];
}

@end
