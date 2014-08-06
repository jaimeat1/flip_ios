//
//  FLPSizeViewController.m
//  Flip
//
//  Created by Jaime on 06/08/14.
//  Copyright (c) 2014 MobiOak. All rights reserved.
//

#import "FLPSizeViewController.h"
#import "FLPGridViewController.h"

@interface FLPSizeViewController ()

@property (nonatomic, weak) IBOutlet UIButton *backBtn;
@property (nonatomic, weak) IBOutlet UIButton *smallBtn;
@property (nonatomic, weak) IBOutlet UIButton *normalBtn;
@property (nonatomic, weak) IBOutlet UIButton *bigBtn;

@end

@implementation FLPSizeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [_backBtn setTitle:NSLocalizedString(@"OTHER_BACK", @"") forState:UIControlStateNormal];
    [_smallBtn setTitle:NSLocalizedString(@"SIZE_SMALL", @"") forState:UIControlStateNormal];
    [_normalBtn setTitle:NSLocalizedString(@"SIZE_NORMAL", @"") forState:UIControlStateNormal];
    [_bigBtn setTitle:NSLocalizedString(@"SIZE_BIG", @"") forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"gridSegue"]) {
        FLPGridViewController *gridViewController=(FLPGridViewController *)segue.destinationViewController;
        gridViewController.photos = _photos;
    }
}

#pragma mark - IBAction methods

- (IBAction)onSmallButtonPressed:(id)sender
{
    FLPLogDebug(@"small button pressed");
    [self performSegueWithIdentifier:@"gridSegue" sender:self];
}

- (IBAction)onNormalButtonPressed:(id)sender
{
    FLPLogDebug(@"normal button pressed");
    [self performSegueWithIdentifier:@"gridSegue" sender:self];
}

- (IBAction)onBigButtonPressed:(id)sender
{
    FLPLogDebug(@"big button pressed");
    [self performSegueWithIdentifier:@"gridSegue" sender:self];
}

- (IBAction)onBackButtonPressed:(id)sender
{
    FLPLogDebug(@"back button pressed");
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end