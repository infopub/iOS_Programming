//
//  ViewController.m
//  InAppPurchase
//
//  Created by katsuya on 2014/01/22.
//  Copyright (c) 2014年 shoeisha. All rights reserved.
//

#import "ViewController.h"
#import "MyPaymentTransactionObserver.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIButton *buyButton;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    
    // 구입 처리가 완료한 때의 통지를 받도록 등록
    [notificationCenter addObserver:self
                           selector:@selector(paymentCompletedNotification:)
                               name:kPaymentCompletedNotification
                             object:nil];
    
    // 구입 처리가 실패한 때의 통지를 받도록 등록
    [notificationCenter addObserver:self
                           selector:@selector(paymentErrorNotification:)
                               name:kPaymentErrorNotification
                             object:nil];}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)startProductRequest
{
    // iTunes Connect에서 등록한 프로덕터의 ID로 써주세요
    NSSet *productIds = [NSSet setWithObjects:@"co.jp.se.chapter18.productid", nil];
    
    SKProductsRequest *productRequest;
    productRequest = [[SKProductsRequest alloc] initWithProductIdentifiers:productIds];
    productRequest.delegate = self;
    [productRequest start];
}

- (void)buy
{
    // 구입 처리의 시작 전에 단말의 설정이 컨텐츠를 구입하게 되어 있는지를 확인한다
        if ([SKPaymentQueue canMakePayments] == NO) {
        NSString *message = @"차단으로 App내 에서의 구입이 가능하지 않습니다.";
        UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"에러"
                                                      message:message
                                                     delegate:self
                                            cancelButtonTitle:@"OK"
                                            otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    // 구입 처리를 시작한다
    SKPayment *payment = [SKPayment paymentWithProduct:[self.products objectAtIndex:0]];
    [[SKPaymentQueue defaultQueue] addPayment:payment];
}

#pragma mark - SKProductsRequestDelegate
- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response {
    for (NSString *invalidProductIdentifier in response.invalidProductIdentifiers) {
        // invalidProductIdentifiers가 있으면 로그에 출력한다
        NSLog(@"%s invalidProductIdentifiers : %@", __PRETTY_FUNCTION__, invalidProductIdentifier);
    }
    
    // 프로덕트 정보를 뒤에서 참조할 수 있도록 멤버 변수에 저장하여 둔다
    self.products = response.products;
    
    // 얻은 프로덕트 정보를 순서대로 UItextVIew에 표시한다（이번은 하나만）
    for (SKProduct *product in response.products) {
        NSString *text = [NSString stringWithFormat:@"Title %@\nDescription %@\nPrice %@\n",
                          product.localizedTitle,
                          product.localizedDescription,
                          product.price];
        self.textView.text = text;
    }
    
    // 구입 버튼을 유효로 한다
    [self.buyButton setEnabled:YES];
}

#pragma mark - SKRequestDelegate
- (void)requestDidFinish:(SKRequest *)request {
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

- (void)request:(SKRequest *)request didFailWithError:(NSError *)error {
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

- (void)paymentCompletedNotification:(NSNotification *)notification {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    
    // 실제는 여기에서 기능을 유효로 하거나 컨텐츠를 표시하거나 한다
    SKPaymentTransaction *transaction = [notification object];
    NSString *message = [NSString stringWithFormat:@"%@를 구입했습니다", transaction.payment.productIdentifier];
    UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"구입처리완료"
                                                  message:message
                                                 delegate:self
                                        cancelButtonTitle:@"OK"
                                        otherButtonTitles:nil];
    [alert show];
}

- (void)paymentErrorNotification:(NSNotification *)notification {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    
    // 여기에서 에러를 표시한다
    SKPaymentTransaction *transaction = [notification object];
    NSString *message = [NSString stringWithFormat:@"에러코드 %ld", transaction.error.code];
    UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"구입 처리 실패"
                                                  message:message
                                                 delegate:self
                                        cancelButtonTitle:@"OK"
                                        otherButtonTitles:nil];
    [alert show];
}

#pragma mark - handle method
- (IBAction)handleProductsRequestButton:(id)sender
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
    [self startProductRequest];
}

- (IBAction)handleBuyButton:(id)sender
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
    [self buy];
}
@end
