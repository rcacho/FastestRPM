//
//  ViewController.h
//  FastestRPM
//
//  Created by ricardo antonio cacho on 2015-07-09.
//  Copyright (c) 2015 ricardo antonio cacho. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

- (IBAction)trackFingerVelocity:(UIPanGestureRecognizer *)recognizer;

- (void)rotateSpeedometerNeedle:(CGFloat)speedMagnitude;

- (void)setSpeedometerNeedlebackToZero;

- (void)recursivelyRotateNeedleBack:(float)currentlocation;

@end

