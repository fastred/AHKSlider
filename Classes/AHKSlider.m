//
//  AHKSlider.m
//
//  Created by Arkadiusz on 24-05-14.
//

#import "AHKSlider.h"

/**
 *  Used for keeping track of how long a given value was present on the slider during a touch.
 */
@interface AHKSliderEntry : NSObject
/// slider's value
@property (nonatomic) float value;
/// time at which this position was reached ("slided to")
@property (nonatomic) NSTimeInterval startingTime;
/// how long the user has kept the slider in this position
@property (nonatomic) NSTimeInterval duration;
@end

@implementation AHKSliderEntry
- (NSString *)description
{
    return [ @{ @"value" : @(self.value),
              @"startingTime" : @(self.startingTime),
              @"duration" : @(self.duration) } description];
}
@end



@interface AHKSlider ()
/// Keeps AHKSliderEntry objects from the current touch.
@property (strong, nonatomic) NSMutableArray *entries;
@end

@implementation AHKSlider

#pragma mark - UIControl

- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    BOOL retVal = [super beginTrackingWithTouch:touch withEvent:event];

    if (retVal) {
        // reset entries from the previous touch
        self.entries = nil;

        [self addNewEntry];
    }

    return retVal;
}

- (BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    BOOL retVal = [super continueTrackingWithTouch:touch withEvent:event];

    if (retVal) {
        [self updateLastEntryDuration];
        [self addNewEntry];
    }

    return retVal;
}

- (void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    [super endTrackingWithTouch:touch withEvent:event];

    [self updateLastEntryDuration];
    [self correctValueIfNeeded];
}

#pragma mark - Properties

- (NSMutableArray *)entries
{
    if (!_entries) {
        _entries = [[NSMutableArray alloc] init];
    }

    return _entries;
}

#pragma mark - Private

- (void)addNewEntry
{
    AHKSliderEntry *newEntry = [[AHKSliderEntry alloc] init];
    newEntry.value = self.value;
    newEntry.startingTime = CACurrentMediaTime();
    [self.entries addObject:newEntry];
}

/**
 *  Put the slider at a position that was selected when a user was raising up a finger.
 */
- (void)correctValueIfNeeded
{
    static const CGFloat kAcceptableLocationDelta = 12.0f;
    __block float properSliderValue = FLT_MIN;

    // finds the newest entry with a duration longer than 0.05s
    [self.entries enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(AHKSliderEntry *entry, NSUInteger idx, BOOL *stop) {
        if (entry.duration > 0.05) {

            CGFloat width = CGRectGetWidth(self.frame);
            CGFloat valueDelta = fabsf(entry.value - self.value);
            CGFloat sliderRange = fabsf(self.maximumValue - self.minimumValue);
            CGFloat locationDelta = valueDelta / sliderRange * width;

            // assume this value as the one user tried to select if it's close enough to the value after the touch has ended
            if (locationDelta < kAcceptableLocationDelta) {
                properSliderValue = entry.value;
            }

            *stop = YES;
        }
    }];

    // correct the value
    if (properSliderValue != FLT_MIN) {
        [self setValue:properSliderValue animated:YES];
        [self sendActionsForControlEvents:UIControlEventValueChanged];
    }
}

/// update the duration of the latest entry in the entries array
- (void)updateLastEntryDuration
{
    AHKSliderEntry *lastEntry = [self.entries lastObject];
    lastEntry.duration = CACurrentMediaTime() - lastEntry.startingTime;
}

@end
