//
//  PSCollectionViewController.m
//  CircularScrollView
//
//  Created by NSSimpleApps on 11.11.14.
//  Copyright (c) 2014 NSSimpleApps. All rights reserved.
//

#import "PSCollectionViewController.h"
#import "ImageViewCell.h"


@interface PSCollectionViewController () <UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) NSArray* arrayOfImages;
@property (assign, nonatomic) CGSize cellSize;

@end

@implementation PSCollectionViewController

static NSString * const reuseIdentifier = @"ImageViewCell";

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.arrayOfImages = @[[UIImage imageNamed:@"cat1.jpg"], [UIImage imageNamed:@"cat2.jpg"], [UIImage imageNamed:@"cat3.jpg"]];
    
    CGRect screenSize = [[UIScreen mainScreen] bounds];
    
    self.cellSize = CGSizeMake(screenSize.size.width, screenSize.size.height - 50.f);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return [self.arrayOfImages count];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ImageViewCell *cell = (ImageViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    [cell setImage:[self.arrayOfImages objectAtIndex:indexPath.section]];
    
    return cell;
}

#pragma mark <UICollectionViewDelegateFlowLayout>

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return self.cellSize;
}

#pragma mark <UIScrollView>

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat currentOffset = scrollView.contentOffset.x;
    
    for (NSIndexPath *indexPath in [self.collectionView indexPathsForVisibleItems]) {
        
        ImageViewCell* cell = (ImageViewCell*)[self.collectionView cellForItemAtIndexPath:indexPath];
        [cell rotateWithOffset:(currentOffset - self.cellSize.width*indexPath.section) radius:100.f];
    }
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    
    if (velocity.x < 0 && scrollView.contentOffset.x < -self.cellSize.width/4) {
        
        [scrollView setContentOffset:CGPointMake(scrollView.contentSize.width, 0)
                            animated:NO];
    }
    if (velocity.x > 0 && scrollView.contentOffset.x > scrollView.contentSize.width - 3*self.cellSize.width/4) {
        
        [scrollView setContentOffset:CGPointMake(-self.cellSize.width/2, 0)
                            animated:NO];
    }
    
    // disable deceleration
    *targetContentOffset = scrollView.contentOffset;
}


- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {

    CGFloat currentOffset = scrollView.contentOffset.x;
    
    CGFloat cellWidth = self.cellSize.width;
        
    NSInteger section = (NSInteger)(currentOffset/cellWidth);
        
    CGFloat deltaX = currentOffset - section*cellWidth;
        
    if (deltaX >= cellWidth/2) section++;
    
    section = MIN(section, [self.arrayOfImages count] - 1);
    section = MAX(section, 0);
    
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:section]
                                atScrollPosition:UICollectionViewScrollPositionNone
                                        animated:YES];
}


@end
