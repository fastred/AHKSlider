//
//  AHKViewController.m
//  AHKSliderExample
//
//  Created by Arkadiusz on 24-05-14.
//  Copyright (c) 2014 Arkadiusz Holko. All rights reserved.
//

#import "AHKViewController.h"

@interface AHKViewController ()
@property (weak, nonatomic) IBOutlet UILabel *systemSliderLabel;
@property (weak, nonatomic) IBOutlet UILabel *ahkSliderLabel;
@end

@implementation AHKViewController

#pragma mark - Actions

- (IBAction)systemSliderChangedValue:(UISlider *)sender
{
    self.systemSliderLabel.text = [@(sender.value) stringValue];
}

- (IBAction)ahkSliderChangedValue:(UISlider *)sender
{
    self.ahkSliderLabel.text = [@(sender.value) stringValue];
}

@end
