//
//  FaceView.h
//  DynEmoji
//
//  Created by Shahin on 2017-02-16.
//  Copyright © 2017 98%Chimp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FaceViewDataSource.h"

IB_DESIGNABLE
@interface FaceView : UIView

@property (nonatomic) IBInspectable CGFloat lineWidth;
@property (nonatomic) IBInspectable CGFloat scale;
@property (nonatomic) IBInspectable UIColor *lineColour;
@property (nonatomic) CGPoint faceCentre;
@property (nonatomic) CGFloat faceRadius;

@property (weak, nonatomic) id<FaceViewDataSource> dataSource;

-(void)scaleFace:(UIPinchGestureRecognizer *)gestureRecongnizer;

@end
