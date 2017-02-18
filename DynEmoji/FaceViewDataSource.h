//
//  FaceViewDataSource.h
//  DynEmoji
//
//  Created by Shahin on 2017-02-17.
//  Copyright © 2017 98%Chimp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class FaceView;

@protocol FaceViewDataSource <NSObject>

-(double)smilinessForFaceView:(FaceView *)sender;

@end

