//
//  MyPaymentTransactionObserver.h
//  Chapter03
//
//
//

#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>

// 구입 완료의 노티피케이션
#define kPaymentCompletedNotification  @"PaymentCompletedNotification"

// 구입 실패의 노티피케이션
#define kPaymentErrorNotification @"PaymentErrorNotification"

@interface MyPaymentTransactionObserver : NSObject <SKPaymentTransactionObserver>
+ (id)sharedObserver;
@end
