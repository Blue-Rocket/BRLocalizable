//
//  NSBundle+BRLocalize.m
//  BlueRocketFuelCore
//
//  Created by Matt on 10/08/15.
//  Copyright (c) 2015 Blue Rocket. Distributable under the terms of the Apache License, Version 2.0.
//

#import "NSBundle+BRLocalize.h"

@implementation NSBundle (BRLocalize)

+ (NSDictionary *)appStrings {
	return [NSBundle mainBundle].appStrings;
}

- (NSDictionary *)appStrings {
	return [self appStringsForLocale:nil];
}

- (NSDictionary *)appStringsForLocale:(NSLocale *)locale {
	static NSMutableDictionary *appStrings = nil;
	if ( appStrings == nil ) {
		appStrings = [[NSMutableDictionary alloc] initWithCapacity:2];
	}
	
	NSString *lang = [(locale == nil ? [NSLocale currentLocale] : locale) objectForKey:NSLocaleLanguageCode];
	NSDictionary *result = appStrings[lang];
	if ( !result ) {
		NSString *path = [self pathForResource:@"strings" ofType:@"json" inDirectory:nil forLocalization:lang];
		if ( !path ) {
			return nil;
		}
		NSData *data = [[NSData alloc] initWithContentsOfFile:path];
		NSError *error = nil;
		result = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
		if ( error ) {
			NSLog(@"Error loading strings.json (%@): %@", lang, [error localizedDescription]);
		} else {
			appStrings[lang] = result;
		}
	}
	return result;
}

@end
