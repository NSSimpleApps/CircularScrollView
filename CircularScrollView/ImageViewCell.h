//
//  ImageViewCell.h
//  CircularScrollView
//
//  Created by NSSimpleApps on 11.11.14.
//  Copyright (c) 2014 NSSimpleApps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageViewCell : UICollectionViewCell

- (void)setImage:(UIImage*)image;

- (void)rotateWithOffset:(CGFloat)offset radius:(CGFloat)radius;

@end
