//
//  FLPCameraPhotoSource.m
//  Flip
//
//  Created by Jaime Aranaz on 23/07/14.
//  Copyright (c) 2014 MobiOak. All rights reserved.
//

#import <AssetsLibrary/AssetsLibrary.h>

#import "FLPCameraPhotoSource.h"

@implementation FLPCameraPhotoSource

- (id)init
{
    self = [super initInternetRequired:NO cacheName:@""];
    return self;
}

#pragma mark - FLPPhotoSource superclass methods

- (void)getPhotosFromSource:(NSInteger)number
                succesBlock:(void(^)(NSArray* photos))success
               failureBlock:(void(^)(NSError *error))failure
{
    NSMutableArray __block *photos = [[NSMutableArray alloc] init];
    ALAssetsLibrary *assetsLibrary = [[ALAssetsLibrary alloc] init];

    [assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupSavedPhotos
                                 usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
                                     if (group != nil) {
                                         
                                         // Get photos only
                                         [group setAssetsFilter:[ALAssetsFilter allPhotos]];
                                         FLPLogDebug(@"photos in group: %ld", (long)group.numberOfAssets);
                                       
                                         if (group.numberOfAssets >= number) {
                                             NSRange range = [self randomRangeFrom:0 to:group.numberOfAssets with:number];
                                             
                                             // Enumerate all photos in current group
                                             [group enumerateAssetsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:range]
                                                                     options:0
                                                                  usingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
                                                                      if (result != nil) {
                                                                          UIImage *image = [UIImage imageWithCGImage:[result thumbnail]];
                                                                          // Add image
                                                                          [photos addObject:image];
                                                                      }
                                                                  }];
                                             success(photos);
                                         } else {
                                             FLPLogError(@"not enough photos in group: %ld", (long)group.numberOfAssets);
                                             failure([NSError errorWithDomain:@""
                                                                         code:KErrorEnoughPhotos
                                                                     userInfo:nil]);
                                         }
                                     }
                                     
                                 } failureBlock:^(NSError *error) {
                                     FLPLogError(@"error: %@", [error localizedDescription]);
                                     failure(error);
                                 }];
}

- (BOOL)hasPhotosInCache
{
    return NO;
}

#pragma mark - Private methods

/**
 *  Returns a random range between |min| and |max| with |number| elements
 *  @param min    Minimun position for range
 *  @param max    Maximum position for range
 *  @param number Number of elements in range
 *  @return A random NSRange, or [0,0] if error
 */
- (NSRange)randomRangeFrom:(NSInteger)min to:(NSInteger)max with:(NSInteger)number
{
    NSInteger startRange, lengthRange;
    if ((max <= min) || ((max - min) < number)) {
        startRange = 0;
        lengthRange = 0;
    } else {
        startRange = (number == max) ? 0 : (arc4random() % (max - number));
        lengthRange = number;
    }
    
    return NSMakeRange(startRange, lengthRange);
}

@end
