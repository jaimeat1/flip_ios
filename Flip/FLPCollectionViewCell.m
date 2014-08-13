//
//  FLPCollectionViewCell.m
//  Flip
//
//  Created by Jaime on 11/08/14.
//  Copyright (c) 2014 MobiOak. All rights reserved.
//

#import "FLPCollectionViewCell.h"

@implementation FLPCollectionViewCell

- (BOOL)isShowingImage
{
    return ([self.contentView.subviews objectAtIndex:1] == _imageView);
}

- (void)flipCellToImageAnimated:(NSNumber *)animated
{
    if ([animated boolValue]) {
        [UIView transitionWithView:self.contentView
                          duration:0.4
                           options:UIViewAnimationOptionTransitionFlipFromRight
                        animations:^{
                                [self.contentView bringSubviewToFront:_imageView];
                        } completion:^(BOOL finished) {
                        }];
    } else {
        [self.contentView bringSubviewToFront:_imageView];
    }
}

- (void)flipCellToCoverAnimated:(NSNumber *)animated
{
    if ([animated boolValue]) {
        [UIView transitionWithView:self.contentView
                          duration:0.4
                           options:UIViewAnimationOptionTransitionFlipFromRight
                        animations:^{
                            [self.contentView bringSubviewToFront:_coverView];
                        } completion:^(BOOL finished) {
                        }];
    } else {
        [self.contentView bringSubviewToFront:_coverView];
    }
}

@end
