//
//  AppDelegate.m
//  helloworld
//
//  Created by Andrew Lunny on 11-05-18.
//  Copyright Nitobi 2011. All rights reserved.
//

#import "AppDelegate.h"
#ifdef PHONEGAP_FRAMEWORK
	#import <PhoneGap/PhoneGapViewController.h>
#else
	#import "PhoneGapViewController.h"
#endif

@implementation AppDelegate

@synthesize invokeString;

- (id) init
{	
	/** If you need to do any extra app-specific initialization, you can do it here
	 *  -jm
	 **/
    return [super init];
}

/**
 * This is main kick off after the app inits, the views and Settings are setup here. (preferred - iOS4 and up)
 */
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	
	NSArray *keyArray = [launchOptions allKeys];
    NSError *err;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); 
    NSString *documentsDirectoryPath = [paths objectAtIndex:0];
    NSString *targetCouchPath = [documentsDirectoryPath stringByAppendingPathComponent:@"couchdb/demoapp.couch"];
    BOOL targetCouchExists = [[NSFileManager defaultManager] fileExistsAtPath:targetCouchPath];

	if ([launchOptions objectForKey:[keyArray objectAtIndex:0]]!=nil) 
	{
		NSURL *url = [launchOptions objectForKey:[keyArray objectAtIndex:0]];
		self.invokeString = [url absoluteString];
		NSLog(@"helloworld launchOptions = %@",url);
	}
    
    if (!targetCouchExists) {
        NSLog(@"no couch - copy over");
        [[NSFileManager defaultManager] copyItemAtPath:[[[NSBundle mainBundle] resourcePath]
                                                    stringByAppendingPathComponent:@"demoapp.couch"]
                                            toPath:targetCouchPath
                                             error:&err];
    } else {
        NSLog(@"couch is there - no copying");
    }
    [Couchbase startCouchbase:self];
	
	return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

// this happens while we are running ( in the background, or from within our own app )
// only valid if helloworld.plist specifies a protocol to handle
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url 
{
	// Do something with the url here
	NSString* jsString = [NSString stringWithFormat:@"handleOpenURL(\"%@\");", url];
	[webView stringByEvaluatingJavaScriptFromString:jsString];
	
	return YES;
}

-(id) getCommandInstance:(NSString*)className
{
	/** You can catch your own commands here, if you wanted to extend the gap: protocol, or add your
	 *  own app specific protocol to it. -jm
	 **/
	return [super getCommandInstance:className];
}

/**
 Called when the webview finishes loading.  This stops the activity view and closes the imageview
 */
- (void)webViewDidFinishLoad:(UIWebView *)theWebView 
{
	// only valid if helloworld.plist specifies a protocol to handle
	if(self.invokeString)
	{
		// this is passed before the deviceready event is fired, so you can access it in js when you receive deviceready
		NSString* jsString = [NSString stringWithFormat:@"var invokeString = \"%@\";", self.invokeString];
		[theWebView stringByEvaluatingJavaScriptFromString:jsString];
	}
	return [ super webViewDidFinishLoad:theWebView ];
}

- (void)webViewDidStartLoad:(UIWebView *)theWebView 
{
	return [ super webViewDidStartLoad:theWebView ];
}

/**
 * Fail Loading With Error
 * Error - If the webpage failed to load display an error with the reason.
 */
- (void)webView:(UIWebView *)theWebView didFailLoadWithError:(NSError *)error 
{
	return [ super webView:theWebView didFailLoadWithError:error ];
}

/**
 * Start Loading Request
 * This is where most of the magic happens... We take the request(s) and process the response.
 * From here we can re direct links and other protocalls to different internal methods.
 */
- (BOOL)webView:(UIWebView *)theWebView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
	return [ super webView:theWebView shouldStartLoadWithRequest:request navigationType:navigationType ];
}


- (BOOL) execute:(InvokedUrlCommand*)command
{
	return [ super execute:command];
}

- (void)dealloc
{
	[ super dealloc ];
}

-(void)couchbaseDidStart:(NSURL *)serverURL {
    NSLog(@"Couch is ready!");
    NSLog(@"couch server runs at %@", serverURL);
    
    NSString *openFuton = [NSString stringWithFormat:@"window.location.href = \"%@demoapp\/_design\/demoapp\/index.html\"", serverURL];
    
    [webView stringByEvaluatingJavaScriptFromString:openFuton];
}

@end
