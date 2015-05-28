//
//  AudioWaveView.h
//  VoiceRecorder
//
//  Created by willpirkle on 4/6/11.
//  Copyright 2011 University of Miami. All rights reserved.
//
#import "AudioWaveView.h"

@implementation AudioWaveView
@synthesize showColorLevels;
const Float32 minWaveValue = -40.0;

// initialize the AudioWaveView
- (id)initWithCoder:(NSCoder *)aDecoder
{
   // if the superclass initializes properly
   if (self = [super initWithCoder:aDecoder])
   {
       // initialize powers with an entry for every other pixel width
	   //rmsPowerLevels = [[NSMutableArray alloc] initWithCapacity:self.frame.size.width / 2];
	   rmsPowerLevels = [[NSMutableArray alloc] initWithCapacity:self.frame.size.width];
	   
	   // 0dB is MAX; min is -160dB
	   minRMSPower = 0;
       showColorLevels = NO;
	   
	   [self setColorWithRed:0 Green:1 Blue:0 Alpha:1]; // set the color of wave

   } 
   
   return self; 
} 

- (void)setPower:(float)p
{
	// add the point to the array
	[rmsPowerLevels addObject:[NSNumber numberWithFloat:p]]; // add value to powers
   
	// NSLog(@"power = %f" ,p);
	
	// remove the leading points. until the array fits in the frame width
  	//while (rmsPowerLevels.count * 2 > self.frame.size.width)
	while (rmsPowerLevels.count > self.frame.size.width)
	{
		// remove leading edge
		[rmsPowerLevels removeObjectAtIndex:0]; 
	}
   
	// for dynamic scaling of view:
	// if (p < minPower)
	  // minPower = p;
	
} 

// clears all the points from the AudioWaveView
// remember to call setNeedsUpdate to repaint
- (void)clear
{
	// remove all objects 
   [rmsPowerLevels removeAllObjects]; 
	
	// reset
	minRMSPower = 0.0;
} 

// set the color
- (void)setColorWithRed:(float)r Green:(float)g Blue:(float)b Alpha:(float)a // set the color of wave
{
	red = r;
	green = g;
	blue = b;
	alpha_value = a;
}

// draws the AudioWaveView Histogram
- (void)drawRect:(CGRect)rect
{
   // get the current device context
   CGContextRef context = UIGraphicsGetCurrentContext();
   
	// experiment with different widths
	CGContextSetLineWidth(context, 1.0);

	// get our width and height
	CGSize size = self.frame.size; // equiv to [[self frame] size];
   
	// draw a line for each point in rmsPowerLevels
	for (int i = 0; i < rmsPowerLevels.count; i++)
	{
	   // get next power level
	   float newPower = [[rmsPowerLevels objectAtIndex:i] floatValue];
	   
	   // clamp at -60dB: this is y = 0, right on the x-axis
	   newPower = newPower < minWaveValue ? minWaveValue : newPower;
	   
	   // calculate the height for this power level; -60dB is the "min power" 
	   float height = (1 - (newPower/minWaveValue)) * (size.height / 2);
	   
	   // for dynamic scaling of view:
 	// float height = (1 - newPower / minPower) * (size.height / 2);	   
     
	   // Draw lines down each x-axis pixel; the total height of each line
	   // is calculated from the difference between the power and the minRMSPower
	   //
	   // move to a point ABOVE the center of the window
	   //CGContextMoveToPoint(context, i * 2, size.height/2 - height);
	   CGContextMoveToPoint(context, i , size.height/2 - height);
      
	   // add a line to a point below the middle of the view
	   //CGContextAddLineToPoint(context, i * 2, size.height/2 + height);
	   CGContextAddLineToPoint(context, i , size.height/2 + height);
      
	   // set the color for this line segment 
	   // CGContextSetRGBStrokeColor(context, red, green, blue, alpha)
        if(showColorLevels && newPower > -3)
            CGContextSetRGBStrokeColor(context, 1, 0, 0, 1);
        else if(showColorLevels && newPower > -7) //AOS
            CGContextSetRGBStrokeColor(context, 1, 1, 0, 1);//AOS
        else 
           CGContextSetRGBStrokeColor(context, red, green, blue, alpha_value);
        
	   // stroke 
	   CGContextStrokePath(context);    
	} 
} 


// destruct
- (void)dealloc
{
	[rmsPowerLevels release]; // release the powers NSMutableArray
	[super dealloc]; // call the superclass's dealloc method
} 

@end 
