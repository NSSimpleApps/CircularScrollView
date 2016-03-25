//
//  CustomFlowLayout.m
//  CircularScrollView
//
//  Created by NSSimpleApps on 25.03.16.
//  Copyright © 2016 NSSimpleApps. All rights reserved.
//

#import "CustomFlowLayout.h"

@implementation CustomFlowLayout

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    
    return YES;
}

- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {
    
    CGFloat offSetAdjustment = CGFLOAT_MAX;
    
    CGFloat horizontalCenter = (proposedContentOffset.x + (self.collectionView.bounds.size.width / 2.0));
    
    CGRect targetRect = CGRectMake(proposedContentOffset.x, 0.0f, self.collectionView.bounds.size.width, self.collectionView.bounds.size.height);
    
    NSArray<UICollectionViewLayoutAttributes *> *array = [super layoutAttributesForElementsInRect:targetRect];
    
    for (UICollectionViewLayoutAttributes * layoutAttributes in array) {
        
        CGFloat itemHorizontalCenter = layoutAttributes.center.x;
        
        if (fabs(itemHorizontalCenter - horizontalCenter) < fabs(offSetAdjustment)) {
            offSetAdjustment = itemHorizontalCenter - horizontalCenter;
        }
    }
    return CGPointMake(proposedContentOffset.x + offSetAdjustment, proposedContentOffset.y);
}

// TODO

/*- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    
    
}*/

@end

