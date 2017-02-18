//
//  ViewController.h
//  DynEmoji
//
//  Created by Shahin on 2017-02-16.
//  Copyright © 2017 98%Chimp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FaceView.h"
#import "FaceViewDataSource.h"

@interface ViewController : UIViewController <FaceViewDataSource>

@property (nonatomic) int happiness;

@end

