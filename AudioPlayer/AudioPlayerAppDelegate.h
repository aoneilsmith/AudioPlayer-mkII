//
//  AudioPlayerAppDelegate.h
//  AudioPlayer
//
//  Created by William Pirkle on 2/16/12.
//  Copyright (c) 2012 University of Miami. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AudioEngine.h"

@interface AudioPlayerAppDelegate : UIResponder <UIApplicationDelegate>
{
    AudioEngine *audioEngine;
    AudioEngine *audioEngine2;
    
    
}

@property (strong, nonatomic) IBOutlet UIWindow *window;

@end
