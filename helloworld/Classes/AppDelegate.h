//
//  AppDelegate.h
//  helloworld
//
//  Created by Andrew Lunny on 11-05-18.
//  Copyright Nitobi 2011. All rights reserved.
//

#import <UIKit/UIKit.h>
#ifdef PHONEGAP_FRAMEWORK
	#import <PhoneGap/PhoneGapDelegate.h>
#else
	#import "PhoneGapDelegate.h"
#endif
#import "Couchbase.h"

@interface AppDelegate : PhoneGapDelegate <CouchbaseDelegate> {

	NSString* invokeString;
}

// invoke string is passed to your app on launch, this is only valid if you 
// edit helloworld.plist to add a protocol
// a simple tutorial can be found here : 
// http://iphonedevelopertips.com/cocoa/launching-your-own-application-via-a-custom-url-scheme.html

@property (copy)  NSString* invokeString;

@end

