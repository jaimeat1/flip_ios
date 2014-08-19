//
//  FLPRecordsViewController.m
//  Flip
//
//  Created by Jaime on 12/08/14.
//  Copyright (c) 2014 MobiOak. All rights reserved.
//

#import "FLPRecordsViewController.h"
#import "FLPTitleLetterView.h"

#import "GADBannerView.h"

@interface FLPRecordsViewController ()

@property (nonatomic, weak) IBOutlet UIView *titleView;
@property (nonatomic, weak) IBOutlet UILabel *subtitleLbl;
@property (nonatomic, weak) IBOutlet UILabel *titleLbl;
@property (nonatomic, weak) IBOutlet UILabel *smallLbl;
@property (nonatomic, weak) IBOutlet UILabel *smallResultLbl;
@property (nonatomic, weak) IBOutlet UILabel *normalLbl;
@property (nonatomic, weak) IBOutlet UILabel *normalResultLbl;
@property (nonatomic, weak) IBOutlet UILabel *bigLbl;
@property (nonatomic, weak) IBOutlet UILabel *bigResultLbl;
@property (nonatomic, weak) IBOutlet UIButton *mainBtn;
@property (nonatomic, weak) IBOutlet UIView *bannerView;
@property (nonatomic, strong) NSTimer *timerTitle;

- (IBAction)mainButtonPressed:(id)sender;

@end

@implementation FLPRecordsViewController

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
    
    [_mainBtn setTitle:NSLocalizedString(@"OTHER_MAIN", @"") forState:UIControlStateNormal];
    _titleLbl.text = NSLocalizedString(@"RECORDS_TITLE", @"");
    [_subtitleLbl setFont:[UIFont fontWithName:@"Pacifico" size:25]];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    NSDate *recordSmall = (NSDate *)[userDefaults objectForKey:@"small"];
    NSDate *recordNormal = (NSDate *)[userDefaults objectForKey:@"normal"];
    NSDate *recordBig = (NSDate *)[userDefaults objectForKey:@"big"];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"mm:ss:SSS"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0.0]];
    
    _smallLbl.text = NSLocalizedString(@"RECORDS_SMALL", @"");
    _smallResultLbl.text = (recordSmall) ? [dateFormatter stringFromDate:recordSmall] : NSLocalizedString(@"RECORDS_NONE", @"");
    
    _normalLbl.text = NSLocalizedString(@"RECORDS_NORMAL", @"");
    _normalResultLbl.text = (recordNormal) ? [dateFormatter stringFromDate:recordNormal] : NSLocalizedString(@"RECORDS_NONE", @"");
    
    _bigLbl.text = NSLocalizedString(@"RECORDS_BIG", @"");
    _bigResultLbl.text = (recordBig) ? [dateFormatter stringFromDate:recordBig] : NSLocalizedString(@"RECORDS_NONE", @"");
    
    // Banner
    GADBannerView *banner = [[GADBannerView alloc] initWithAdSize:kGADAdSizeBanner];
    banner.adUnitID = kAddMobID;
    banner.rootViewController = self;
    [_bannerView addSubview:banner];
    [banner loadRequest:[GADRequest request]];
    
    [self startTimer];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBAction methods

- (IBAction)mainButtonPressed:(id)sender
{
    [self endTimer];
    [self performSegueWithIdentifier:@"mainFromRecordsSegue" sender:self];
}

#pragma mark - Private methods

- (void)startTimer
{
    if (_timerTitle == nil) {
        _timerTitle = [NSTimer scheduledTimerWithTimeInterval:3.0
                                                       target:self
                                                     selector:@selector(flipRandomLetter)
                                                     userInfo:nil
                                                      repeats:YES];
    }
}

- (void)endTimer
{
    if (_timerTitle != nil) {
        [_timerTitle invalidate];
        _timerTitle = nil;
    }
}

- (void)flipRandomLetter
{
    NSInteger random = (arc4random() % 4);
    UIView *letter = [_titleView.subviews objectAtIndex:random];
    
    if ([letter isKindOfClass:[FLPTitleLetterView class]]){
        [letter performSelector:@selector(flipAnimated:) withObject:[NSNumber numberWithBool:YES]];
    }
}

@end