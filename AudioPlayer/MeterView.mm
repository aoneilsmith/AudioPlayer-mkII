//
//  MeterView.m
//  iPhoneAudio
//
//  Created by willpirkle on 4/15/11.
//  Copyright 2011 University of Miami. All rights reserved.
//

#import "MeterView.h"


@implementation MeterView

// iOS/MacOS mins are -120dB!
const Float32 minMeterValue = 40.0;

@synthesize meterValue_dB, upsideDownMeter;

// initialize the AudioWaveView
- (id)initWithCoder:(NSCoder *)aDecoder
{
	// if the superclass initializes properly
	if (self = [super initWithCoder:aDecoder])
	{
		meterValue_dB = -minMeterValue;
		upsideDownMeter = NO;
	} 
	
	return self; 
} 

- (id)initWithFrame:(CGRect)frame 
{
    self = [super initWithFrame:frame];
    if (self) 
	{
		meterValue_dB = -minMeterValue;
		upsideDownMeter = NO;
    }
    return self;
}

- (void)updateMeter:(float)fdB
{
	meterValue_dB = fdB;
	[self setNeedsDisplay];
}

- (void)clearMeter
{
    [self updateMeter:-minMeterValue];
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect 
{
    // Drawing code.
	// get the current device context
	CGContextRef context = UIGraphicsGetCurrentContext();
	
	// experiment with different widths
	CGContextSetLineWidth(context, 1.0);
	
	// get our width and height
	CGSize size = self.frame.size;
	
	// find the meter height (normal coordinate system)
	float fPixelPer_dB =  self.frame.size.height/minMeterValue;
	
	float fMeterPos =  self.frame.size.height + (meterValue_dB*fPixelPer_dB);
		  
    
    //Here is where to change default meter color - AOS
	// color for fill
    if(meterValue_dB> -3){
       // CGContextSetRGBFillColor(context, 1.0, 0.0, 0.0, 0.5); //red
		CGContextFillRect(context,  CGRectMake(0.0, 0.5, size.width, fMeterPos-100.0)); // make upside down; normal for us
        CGContextSetRGBFillColor(context, 1.0, 0.0, 0.0, 0.7); //red
        CGContextFillRect(context,  CGRectMake(0.0, 0, size.width, fMeterPos)); // make upside down; normal for us
        CGContextSetRGBFillColor(context, 0.0, 1.0, 0.0, 0.5); // green color, half transparent


    }
    else if(meterValue_dB > -7) {//AOS
        CGContextFillRect(context,  CGRectMake(0.0, 0, size.width, fMeterPos-80.0)); // make upside down; normal for us
        CGContextSetRGBFillColor(context, 1.0, 1.0, 0.0, 0.7);//yellow
        CGContextFillRect(context,  CGRectMake(0.0, 0, size.width, fMeterPos)); // make upside down; normal for us
        CGContextSetRGBFillColor(context, 0.0, 1.0, 0.0, 0.5); // green color, half transparent

    }
    else
        //CGContextSetRGBStrokeColor(context, red, green, blue, alpha_value);
	CGContextSetRGBFillColor(context, 0.0, 1.0, 0.0, 0.5); // green color, half transparent
	

	// fill with color
	if(!upsideDownMeter){ // -- note flipping of height here
		CGContextFillRect(context,  CGRectMake(0.0, size.height-fMeterPos, size.width, fMeterPos)); // normal, flipped ht
        //CGContextSetRGBFillColor(context, 0.0, 1.0, 0.0, 0.5); // green color, half transparent
    }
	else{
		CGContextFillRect(context,  CGRectMake(0.0, 0, size.width, fMeterPos)); // make upside down; normal for us
       // CGContextSetRGBFillColor(context, 0.0, 1.0, 0.0, 0.5); // green color, half transparent

    }
}

//CGContextSetRGBFillColor(context, 0.0, 1.0, 0.0, 0.5); // green color, half transparent
//CGContextFillRect(context, CGRectMake(20.0, 250.0, 128.0, 128.0)); // a square at the bottom left-hand corner

- (void)dealloc {
    [super dealloc];
}


@end
