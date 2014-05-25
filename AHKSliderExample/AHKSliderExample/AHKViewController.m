//
//  AHKViewController.m
//  AHKSliderExample
//
//  Created by Arkadiusz on 24-05-14.
//  Copyright (c) 2014 Arkadiusz Holko. All rights reserved.
//

#import "AHKViewController.h"

static NSString *formatValue(float value)
{
    return [NSString stringWithFormat:@"%.6f", value];
}

@interface AHKViewController ()
@property (weak, nonatomic) IBOutlet UILabel *systemSliderLabel;
@property (weak, nonatomic) IBOutlet UILabel *ahkSliderLabel;
@end

@implementation AHKViewController

#pragma mark - Actions

- (IBAction)systemSliderChangedValue:(UISlider *)sender
{
    self.systemSliderLabel.text = formatValue(sender.value);
}

- (IBAction)ahkSliderChangedValue:(UISlider *)sender
{
    self.ahkSliderLabel.text = formatValue(sender.value);
}

@end
