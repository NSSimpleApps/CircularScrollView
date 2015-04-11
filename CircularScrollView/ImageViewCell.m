//
//  ImageViewCell.m
//  CircularScrollView
//
//  Created by NSSimpleApps on 11.11.14.
//  Copyright (c) 2014 NSSimpleApps. All rights reserved.
//


#import "ImageViewCell.h"

@interface ImageViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ImageViewCell

- (void)setImage:(UIImage*)image {
        
    self.imageView.image = image;
}

@end
