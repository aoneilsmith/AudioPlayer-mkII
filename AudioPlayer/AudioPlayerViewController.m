//
//  AudioPlayerViewController.m
//  AudioPlayer
//
//  Created by William Pirkle on 2/16/12.
//  Copyright (c) 2012 University of Miami. All rights reserved.
//

#import "AudioPlayerViewController.h"

@implementation AudioPlayerViewController
@synthesize audioEngine, audioEngine2, leftWaveView, rightWaveView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [colorSwitch setOn:NO];
    }
    return self;
}

// our first CALLBACK! 
- (void)playbackMonitorTimerFired:(NSTimer *)timer
{
    // get the left meter value
    float leftMeterdB = [audioEngine getLeftMeterValue];
    float rightMeterdB = [audioEngine2 getRightMeterValue]; // AOS
    
    // update the meter - it takes dB values! 
    [leftMeterView updateMeter:leftMeterdB];
    [rightMeterView updateMeter:rightMeterdB]; //added by AOS
    
    
    [leftWaveView setPower:leftMeterdB];
    [leftWaveView setNeedsDisplay]; // redraw the visualizer
    
    [rightWaveView setPower:rightMeterdB];//AOS
    [rightWaveView setNeedsDisplay]; //AOS
 
}

-(IBAction)startButtonPressed:(id)sender
{
    if([audioEngine isPlaying])
        return;
    if([audioEngine2 isPlaying])
        return;
    
    //playAtTime: ?
    //@prop NSTIMEINTERVAL devicecurrenttiem
    
    // start the player
    [audioEngine startAudioPlayer];
    [audioEngine2 startAudioPlayer];
    
    
    [leftWaveView clear];
	[leftWaveView setNeedsDisplay]; // redraw the visualizer
    
    [rightWaveView clear];//AOS
    [rightWaveView setNeedsDisplay];//AOS

    // create timer and set callback (selector) function/method:
    playbackMonitorTimer = [NSTimer scheduledTimerWithTimeInterval:0.050 
                                                            target:self
                                                          selector:@selector(playbackMonitorTimerFired:) 
                                                          userInfo:nil 
                                                           repeats:YES];
}

-(IBAction)stopButtonPressed:(id)sender
{
    // stop the player
    [audioEngine stopAudioPlayer];
    [audioEngine2 stopAudioPlayer];
    
    // stop the timer
    [playbackMonitorTimer invalidate];
    
    // clear the meter
    [leftMeterView clearMeter];
    [rightMeterView clearMeter]; //added by AOS
}

-(IBAction)showColorLevels:(id)sender
{
    // toggle
    [leftWaveView setShowColorLevels:[colorSwitch isOn]];
    [rightWaveView setShowColorLevels:[colorSwitch isOn]];//AOS
}


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}
/*
-(void) setupAVPlayerForURL: (int) url{
    NSString *songname=[NSString stringWithFormat:@"02 The City",songArray[songIndex]];
    songTitle.text=songname;
    NSString* saveFileName = songname;
    
    NSARray *paths =
}
 */
#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
   /* soundsArray = [NSMutableArray new];

    count=songArray.count;
    [self setupAVPlayerForURL:songIndex];
    _AudioPlayer.delegate = self;
    */
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
