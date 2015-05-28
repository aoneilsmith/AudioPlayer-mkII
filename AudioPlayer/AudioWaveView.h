//
//  AudioWaveView.h
//  VoiceRecorder
//
//  Created by willpirkle on 4/6/11.
//  Copyright 2011 University of Miami. All rights reserved.
//
#import <UIKit/UIKit.h>

@interface AudioWaveView : UIView
{
	// array for RMSDetectorOutput
	NSMutableArray *rmsPowerLevels;  
	
	// for auto-normalization
	float minRMSPower; 
	float red, green, blue, alpha_value; // "alpha" is a reserved word
    bool showColorLevels;
} 

@property (nonatomic, readwrite) bool showColorLevels;

- (void)setColorWithRed:(float)r Green:(float)g Blue:(float)b Alpha:(float)a; // set the color of wave
- (void)setPower:(float)p; // set the powerLevel
- (void)clear; // clear all the past power levels

@end 
