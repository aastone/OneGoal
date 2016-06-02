//
//  ZMStoreRecipientQRCodeViewController.m
//  ZaijiaMerchant
//
//  Created by stone on 16/5/19.
//  Copyright © 2016年 Small Step. All rights reserved.
//

#import "ZMStoreRecipientQRCodeViewController.h"
#import "SVProgressHUD.h"
#import "UIImage+Utils.h"
#import "UIViewController+Helper.h"
#import "UIView+Helper.h"

@interface ZMStoreRecipientQRCodeViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *QRCodeImageView;
@property (weak, nonatomic) IBOutlet UILabel *QRCodeDescLabel;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;
@property (weak, nonatomic) IBOutlet UIView *backgroundView;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;

@end

@implementation ZMStoreRecipientQRCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"扫码付收款码";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"帮助" style:UIBarButtonItemStylePlain target:self action:@selector(gotoHelp)];
    
    NSString *url = @"http://www.baidu.com";
    
    
    NSString *storeID = @"1234567890";
    
    self.QRCodeDescLabel.text = [NSString stringWithFormat:@"在家点点 No.%@", storeID];
    [self.backgroundImageView setImage:[UIImage imageNamed:@"scanPayBg"]];
    

    [self.QRCodeImageView setImage:[self createQRCodeWithString:url]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIImage *)createQRCodeWithString:(NSString *)qrString {
    NSData *stringData = [qrString dataUsingEncoding:NSISOLatin1StringEncoding];
    
    CIFilter *qrFilter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [qrFilter setValue:stringData forKey:@"inputMessage"];
    
    CGAffineTransform transform = CGAffineTransformMakeScale(5.0f, 5.0f); // Scale by 5 times along both dimensions
    CIImage *outputImage = [qrFilter.outputImage imageByApplyingTransform:transform];
    
    return [UIImage imageWithCIImage:outputImage];
}

#pragma mark - Actions
- (void)getbuttonLayer
{
    for (id object in self.view.subviews) {
        if ([object isKindOfClass:[UIButton class]]) {
            return;
        }
    }
}

- (void)gotoHelp
{
    static dispatch_once_t predicate;
    static ZMStoreRecipientQRCodeViewController *sharedInstance;
    dispatch_once(&predicate, ^{
        sharedInstance = [[ZMStoreRecipientQRCodeViewController alloc] init];
    });
    
    @synchronized (self) {
        if (!sharedInstance) {
            sharedInstance = [ZMStoreRecipientQRCodeViewController new];
        }
    }
}

- (IBAction)saveButtonPressed:(id)sender {
    self.saveButton.enabled = NO;
    UIImage *image = [UIImage imageWithUIView:self.backgroundView];
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

- (void)               image: (UIImage *) image
    didFinishSavingWithError: (NSError *) error
                 contextInfo: (void *) contextInfo
{
    if (error) {
        [SVProgressHUD showErrorWithStatus:error.localizedDescription];
    }else {
        [SVProgressHUD showSuccessWithStatus:@"保存成功！"];
    }
    
    self.saveButton.enabled = YES;
}

@end
