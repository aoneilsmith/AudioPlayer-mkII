//
//  AudioPlayerAppDelegate.m
//  AudioPlayer
//
//  Created by William Pirkle on 2/16/12.
//  Copyright (c) 2012 University of Miami. All rights reserved.
//

#import "AudioPlayerAppDelegate.h"
#import "AudioPlayerViewController.h"
//#ifdef DEBUG

@implementation AudioPlayerAppDelegate

@synthesize window = _window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // create our engines
    audioEngine = [[AudioEngine alloc] init];
    audioEngine2 = [[AudioEngine alloc] init];
    
    // init with the files
    NSString *musicPath = [[NSBundle mainBundle] pathForResource:@"Frolic" ofType:@"wav"];
    NSString *musicPath2 = [[NSBundle mainBundle] pathForResource:@"Temptation Sensation" ofType:@"wav"];

    // init it
    bool succeeded = [audioEngine initAudioPlayerWithFile:musicPath];
    bool succeeded2 = [audioEngine2 initAudioPlayer2WithFile:musicPath2];
    if(succeeded)
        NSLog(@"initAudioPlayerWithFile worked!");
    if(succeeded2)
        NSLog(@"initAudioPlayer2WithFile worked!");

    // create our VC and set as the RootVC
	AudioPlayerViewController *playerViewController = [[AudioPlayerViewController alloc] init];
//#ifdef DEBUG NSLog(@"View Controller set as RootVC");
    // set the engine (if it passed)
    if(succeeded)
        [playerViewController setAudioEngine:audioEngine];
    if(succeeded2)
        [playerViewController setAudioEngine:audioEngine2];
	
	[self.window setRootViewController:playerViewController];
	
	// give the VC a pointer to the audioEngine object
	 [playerViewController setAudioEngine:audioEngine];
    [playerViewController setAudioEngine2:audioEngine2];


    [[self window] makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

@end
