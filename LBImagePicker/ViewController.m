//
//  ViewController.m
//  hahaPod
//
//  Created by li on 16/6/21.
//  Copyright © 2016年 li. All rights reserved.
//

#import "ViewController.h"
#import "LBImagePickerController.h"

@interface ViewController ()<UINavigationControllerDelegate,LBImagePickerControllerDelegate>


@property (nonatomic,strong) UIImageView *imgView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILabel *tipsLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 50, self.view.frame.size.width, 50)];
    tipsLabel.text = @"点击屏幕拍照";
    tipsLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:tipsLabel];
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200, 300)];
    _imgView.center = self.view.center;
    
    [self.view addSubview:_imgView];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    LBImagePickerController *vc = [[LBImagePickerController alloc] init];
    
    //设置照片的size
    vc.imageSize = CGSizeMake(200, 300);
    
    vc.sourceType = UIImagePickerControllerSourceTypeCamera;
    vc.pickerDelegate = self;
    
    [self presentViewController:vc animated:YES completion:^{
        
    }];
}

#pragma mark - image picker delegte
- (void)lbImagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithImage:(UIImage *)image
{
    
    [picker dismissViewControllerAnimated:YES completion:^{}];
    _imgView.image = image;
}


- (void)lbImagePickerControllerDidCancel:(UIImagePickerController *)picker{
    
    [picker dismissViewControllerAnimated:YES completion:^{}];
    
}


@end
