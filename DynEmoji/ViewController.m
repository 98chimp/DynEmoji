//
//  ViewController.m
//  DynEmoji
//
//  Created by Shahin on 2017-02-16.
//  Copyright © 2017 98%Chimp. All rights reserved.
//

#import "ViewController.h"
#define happinessGestureScale 3

@interface ViewController ()

@property (weak, nonatomic) IBOutlet FaceView *faceView;

@end

@implementation ViewController

#pragma mark Lifecycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.faceView.dataSource = self;
    self.happiness = 75;
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.faceView.frame = self.view.bounds;
    [self.faceView setNeedsDisplay];
}

#pragma mark Helpers
-(void)updateUI
{
    [self.faceView setNeedsDisplay];
}

-(void)setHappiness:(int)happiness
{
    _happiness = MIN(MAX(happiness, 0), 100);
    [self updateUI];
}

#pragma mark Actions
- (IBAction)changeHappiness:(UIPanGestureRecognizer *)sender
{
    CGPoint translation = [sender translationInView:self.faceView];
    int happinessChange;
    if (sender.state == UIGestureRecognizerStateChanged)
    {
        happinessChange = (int)(translation.y / happinessGestureScale);
        if (happinessChange != 0)
        {
            self.happiness += happinessChange;
            [sender setTranslation:CGPointZero inView:self.faceView];
        }
    }
}
- (IBAction)scaleFace:(UIPinchGestureRecognizer *)sender
{
    [self.faceView scaleFace:sender];
}

#pragma mark FaceViewDataSource Protocol
-(double)smilinessForFaceView:(FaceView *)sender
{
    double smiliness = self.happiness - 50;
    return smiliness/50;
}

@end
