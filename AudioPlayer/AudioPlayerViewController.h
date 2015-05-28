//
//  AudioPlayerViewController.h
//  AudioPlayer
//
//  Created by William Pirkle on 2/16/12.
//  Copyright (c) 2012 University of Miami. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AudioEngine.h"
#import "MeterView.h"
#import "AudioWaveView.h"

@interface AudioPlayerViewController : UIViewController
{
    AudioEngine *audioEngine;
    AudioEngine *audioEngine2;
    
    // left - you do right
    IBOutlet MeterView   *leftMeterView;
    IBOutlet MeterView   *rightMeterView; //AOS

    
    
	IBOutlet AudioWaveView *leftWaveView;
    IBOutlet AudioWaveView *rightWaveView; //AOS
	IBOutlet UISwitch *colorSwitch;
    
    // timer for metering and other stuff...
    NSTimer *playbackMonitorTimer;
}

// get/set my engine
@property (nonatomic, assign) AudioEngine *audioEngine;
@property (nonatomic, assign) AudioEngine *audioEngine2;
@property (nonatomic, strong) AVAudioPlayer *audioPlayer;

@property (nonatomic, retain) AudioWaveView *leftWaveView;
@property (nonatomic, retain) AudioWaveView *rightWaveView; //AOS

-(IBAction)startButtonPressed:(id)sender;
-(IBAction)stopButtonPressed:(id)sender;
-(IBAction)showColorLevels:(id)sender;

@end
