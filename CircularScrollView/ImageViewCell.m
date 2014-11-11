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

- (void)rotateWithOffset:(CGFloat)offset radius:(CGFloat)radius {
    
    if (radius == 0.f) {
        return;
    }
    
    //CGFloat currentAngle = [[self.layer valueForKeyPath:@"transform.rotation.y"] floatValue];
    CGFloat angle = atan2f(offset, radius);
    
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = 1.0 / 500.0;
    transform = CATransform3DRotate(transform, angle, 0.0f, 1.0f, 0.0f);
    self.layer.transform = transform;
}

@end
