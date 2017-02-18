//
//  FaceView.m
//  DynEmoji
//
//  Created by Shahin on 2017-02-16.
//  Copyright © 2017 98%Chimp. All rights reserved.
//

#import "FaceView.h"

typedef NS_ENUM(int, Eye)
{
    LeftEye,
    RightEye
};

@interface FaceView()

@property (nonatomic) CGFloat faceRadiusToEyeRadiusRatio;
@property (nonatomic) CGFloat faceRadiusToEyeOffsetRatio;
@property (nonatomic) CGFloat faceRadiusToEyeSeparationRatio;
@property (nonatomic) CGFloat faceRadiusToMouthWidthRatio;
@property (nonatomic) CGFloat faceRadiusToMouthHeightRatio;
@property (nonatomic) CGFloat faceRadiusToMouthOffsetRatio;

@end

@implementation FaceView

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    self.faceRadiusToEyeRadiusRatio = 10;
    self.faceRadiusToEyeOffsetRatio = 3;
    self.faceRadiusToEyeSeparationRatio = 1.5;
    self.faceRadiusToMouthWidthRatio = 1;
    self.faceRadiusToMouthHeightRatio = 3;
    self.faceRadiusToMouthOffsetRatio = 3;

    UIBezierPath *facePath = [UIBezierPath bezierPathWithArcCenter:self.faceCentre radius:self.faceRadius startAngle:0 endAngle:(2 * M_PI) clockwise:YES];
    
    facePath.lineWidth = self.lineWidth;
    [self.lineColour setStroke];
    [facePath stroke];
    
    [[self bezierPathForEye:LeftEye] stroke];
    [[self bezierPathForEye:RightEye] stroke];
    
    double smilieness = (double)[self.dataSource smilinessForFaceView:self];
    UIBezierPath *smilePath = [self bezierPathForSmile:smilieness];
    [self.lineColour setStroke];
    [smilePath stroke];
}

-(void)setLineWidth:(CGFloat)lineWidth
{
    if (_lineWidth != lineWidth)
    {
        _lineWidth = lineWidth;
    }
    
    [self setNeedsDisplay];
}

-(void)setLineColour:(UIColor *)lineColour
{
    if (_lineColour != lineColour)
    {
        _lineColour = lineColour;
    }
    [self setNeedsDisplay];
}

-(void)setScale:(CGFloat)scale
{
    if (_scale != scale)
    {
        _scale = scale;
    }
    [self setNeedsDisplay];
}

-(CGPoint)faceCentre
{
    return CGPointMake(self.superview.frame.size.width/2, self.superview.frame.size.height/2);
}

-(CGFloat)faceRadius
{
    CGFloat faceRadius = MIN(self.bounds.size.width, self.bounds.size.height)/2;
    return faceRadius * self.scale;
}

-(void)scaleFace:(UIPinchGestureRecognizer *)gestureRecongnizer
{
    if (gestureRecongnizer.state == UIGestureRecognizerStateChanged)
    {
        self.scale *= gestureRecongnizer.scale;
        gestureRecongnizer.scale = 1;
    }
}

-(UIBezierPath *)bezierPathForEye:(Eye)whichEye
{
    CGFloat eyeRadius = self.faceRadius / self.faceRadiusToEyeRadiusRatio;
    CGFloat eyeVerticalOffset = self.faceRadius / self.faceRadiusToEyeOffsetRatio;
    CGFloat eyeHorizontalOffset = self.faceRadius / self.faceRadiusToEyeSeparationRatio;
    
    CGPoint eyeCentre = self.faceCentre;
    
    eyeCentre.y -= eyeVerticalOffset;
    
    switch (whichEye) {
        case LeftEye:
            eyeCentre.x -= eyeHorizontalOffset / 2;
            break;
            
        case RightEye:
            eyeCentre.x += eyeHorizontalOffset / 2;
            break;
    }
    
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:eyeCentre radius:eyeRadius startAngle:0 endAngle:(2 * M_PI) clockwise:YES];
    [self.lineColour setStroke];
    path.lineWidth = self.lineWidth;
    return path;
}

-(UIBezierPath *)bezierPathForSmile:(double)fractionOfMaxSmile
{
    CGFloat mouthWidth = self.faceRadius / self.faceRadiusToMouthWidthRatio;
    CGFloat mouthHight = self.faceRadius / self.faceRadiusToMouthHeightRatio;
    CGFloat mouthVerticalOffset = self.faceRadius / self.faceRadiusToMouthOffsetRatio;
    
    CGFloat smileHeight = MAX(MIN(fractionOfMaxSmile, 1), -1) * mouthHight;
    
    CGPoint start = CGPointMake(self.faceCentre.x - mouthWidth / 2, self.faceCentre.y + mouthVerticalOffset);
    CGPoint end = CGPointMake(start.x + mouthWidth, start.y);
    CGPoint cp1 = CGPointMake(start.x + mouthWidth / 3, start.y + smileHeight);
    CGPoint cp2 = CGPointMake(end.x - mouthWidth / 3, cp1.y);
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:start];
    [path addCurveToPoint:end controlPoint1:cp1 controlPoint2:cp2];
    path.lineWidth = self.lineWidth;
    
    return path;
}

@end
