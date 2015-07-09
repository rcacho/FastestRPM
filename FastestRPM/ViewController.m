//
//  ViewController.m
//  FastestRPM
//
//  Created by ricardo antonio cacho on 2015-07-09.
//  Copyright (c) 2015 ricardo antonio cacho. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *speedometerNeedle;

@property (weak, nonatomic) IBOutlet UILabel *speedMeterLabel;

@property (weak, nonatomic) IBOutlet UILabel *highScoreLabel;

@property float currentNeedleAngle;

@property float highScore;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.speedometerNeedle.transform = CGAffineTransformMakeRotation(5.4977);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)trackFingerVelocity:(UIPanGestureRecognizer *)recognizer {
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        CGPoint velocity = [recognizer velocityInView:self.view];
        // calculate the magnitude ot the get the speed..
        CGFloat magnitude = sqrtf((velocity.x * velocity.x) + (velocity.y * velocity.y));
        self.speedMeterLabel.text = [NSString stringWithFormat:@"%f",magnitude];
        if (magnitude > self.highScore) {
            self.highScore = magnitude;
            self.highScoreLabel.text = [NSString stringWithFormat:@"%f",self.highScore];
        }
        
        NSLog(@"%f", magnitude);
        [self setSpeedometerNeedlebackToZero];
    } else if (recognizer.state == UIGestureRecognizerStateChanged){
        // instead of tracking it needs to be measuring the speed....
        // the faster it is the higher the needle will reach in the speedometer
        NSLog(@"tracking...");
        CGPoint velocity = [recognizer velocityInView:self.view];
        CGFloat magnitude = sqrtf((velocity.x * velocity.x) + (velocity.y * velocity.y));
        [self rotateSpeedometerNeedle:magnitude];
    }
}

- (void)rotateSpeedometerNeedle:(CGFloat)speedMagnitude {
    // I've seen the speed go roughly up to 10,000 and the speedometer has 10 speeds so try making them a range of 1000
    // try.. each range should be about 0.483321947...
    // the starting point is 5.4977, fo each one point increase transform the the image 0.000483 radians
    float transformation = 0.000483 * speedMagnitude + 5.4977;
    self.currentNeedleAngle = transformation;
    self.speedometerNeedle.transform = CGAffineTransformMakeRotation(transformation);
    
}

- (void)setSpeedometerNeedlebackToZero {
    // rotate back to sero at the same rate that we rotated up..
    [self recursivelyRotateNeedleBack:self.currentNeedleAngle];
}

- (void)recursivelyRotateNeedleBack:(float)currentlocation {
    if (currentlocation >= 5.4977) {
        float transformation = currentlocation - 0.000483;
        self.speedometerNeedle.transform = CGAffineTransformMakeRotation(transformation);
        NSLog(@"%f",transformation);
        [self recursivelyRotateNeedleBack:transformation];
    }
}

@end
