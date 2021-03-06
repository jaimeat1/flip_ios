//
//  FLPCoverFromLeftSegue.m
//  Flip
//
//  Created by Jaime Aranaz on 17/08/14.
//  Copyright (c) 2014 MobiOak. All rights reserved.
//

#import "FLPCoverFromLeftSegue.h"

@implementation FLPCoverFromLeftSegue

-(void)perform
{
    UIViewController *sourceViewController = (UIViewController*)[self sourceViewController];
    UIViewController *destinationController = (UIViewController*)[self destinationViewController];
    
    CATransition* transition = [CATransition animation];
    transition.duration = 0.25;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionMoveIn;
    transition.subtype = kCATransitionFromLeft;

    [UIView animateWithDuration:0.25
                     animations:^{
                         CGRect frame = sourceViewController.view.frame;
                         frame.origin.x = 320;
                         [sourceViewController.view setFrame:frame];
                     }
                     completion:^(BOOL finished) {
                         [destinationController.view.layer addAnimation:transition forKey:kCATransition];
                         [sourceViewController presentViewController:destinationController animated:NO completion:nil];
                     }];
}

@end
