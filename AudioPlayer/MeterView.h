//
//  MeterView.h
//  iPhoneAudio
//
//  Created by willpirkle on 4/15/11.
//  Copyright 2011 University of Miami. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MeterView : UIView 
{
	float meterValue_dB;
	bool upsideDownMeter;
}

@property (nonatomic)float meterValue_dB;
@property (nonatomic)bool upsideDownMeter;

- (void)updateMeter:(float)fdB;
- (void)clearMeter;

@end
