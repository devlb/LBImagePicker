//
//  MyImagePickerController.m
//  hahaPod
//
//  Created by li on 16/6/21.
//  Copyright © 2016年 li. All rights reserved.
//

#import "LBImagePickerController.h"

@interface LBImagePickerController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@end

@implementation LBImagePickerController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (_imageSize.width > self.view.frame.size.width) {
        _imageSize.width = self.view.frame.size.width;
    }
    
    if (_imageSize.height > self.view.frame.size.height) {
        _imageSize.height = self.view.frame.size.height - 40 - 75;
    }

    self.delegate = self;
    
    [self addShadowView];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    
    if ([self.pickerDelegate respondsToSelector:@selector(lbImagePickerControllerDidCancel:)]) {
        
        [self.pickerDelegate lbImagePickerControllerDidCancel:picker];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    image = [self scaleToSize:image size:self.view.frame.size];
    
    image = [self croppedImage:image];
    
    if ([self.pickerDelegate respondsToSelector:@selector(lbImagePickerController:didFinishPickingMediaWithImage:)]) {
        
        [self.pickerDelegate lbImagePickerController:picker didFinishPickingMediaWithImage:image];
    }
}

#pragma mark 裁剪图片

- (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size{
    UIGraphicsBeginImageContext(size);
    
    [img drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    return scaledImage;
}

- (UIImage *)croppedImage:(UIImage *)image {
    
    CGRect rect = CGRectMake((self.view.frame.size.width - _imageSize.width ) / 2,(self.view.frame.size.height - _imageSize.height ) / 2, _imageSize.width, _imageSize.height);
    
    CGImageRef imageRef = CGImageCreateWithImageInRect([image CGImage], rect);
    UIImage *thumbImage = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    
    return thumbImage;
}


/***************增加背景遮罩********************/

- (void)addShadowView{
    
    CGFloat rectY = (self.view.frame.size.height - _imageSize.height ) / 2 > 40 ? (self.view.frame.size.height - _imageSize.height ) / 2 : 40;
    
    CGRect rect = CGRectMake((self.view.frame.size.width - _imageSize.width ) / 2,rectY, _imageSize.width, _imageSize.height);
    
    //top
    UIView *shadow = [[UIView alloc] initWithFrame:CGRectMake(0, 40, self.view.frame.size.width,rect.origin.y - 40)];
    shadow.backgroundColor = [UIColor blackColor];
    shadow.alpha = 0.8;
    [self.view addSubview:shadow];
    
    //bottom
    
    if (CGRectGetMaxY(rect) < self.view.frame.size.height - 75) {
        
        shadow = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(rect), self.view.frame.size.width, self.view.frame.size.height - 75 - CGRectGetMaxY(rect))];
        shadow.backgroundColor = [UIColor blackColor];
        shadow.alpha = 0.8;
        [self.view addSubview:shadow];
    }
    
   
    
    //left
    shadow = [[UIView alloc] initWithFrame:CGRectMake(0,rect.origin.y, rect.origin.x, rect.size.height)];
    shadow.backgroundColor = [UIColor blackColor];
    shadow.alpha = 0.8;
    [self.view addSubview:shadow];
    
    //right
    shadow = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(rect),rect.origin.y,self.view.frame.size.width - CGRectGetMaxX(rect),rect.size.height)];
    shadow.backgroundColor = [UIColor blackColor];
    shadow.alpha = 0.8;
    [self.view addSubview:shadow];
    /***********************************/
}

@end
