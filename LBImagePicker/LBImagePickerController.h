//
//  MyImagePickerController.h
//  hahaPod
//
//  Created by li on 16/6/21.
//  Copyright © 2016年 li. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LBImagePickerControllerDelegate <NSObject>

@optional

- (void)lbImagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithImage:(UIImage *)image;

- (void)lbImagePickerControllerDidCancel:(UIImagePickerController *)picker;

@end

@interface LBImagePickerController : UIImagePickerController

@property (nonatomic,weak) id <LBImagePickerControllerDelegate> pickerDelegate;


@property (nonatomic,assign) CGSize imageSize;

@end
