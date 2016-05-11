//
//  Created by Shawn McKee on 12/9/13.
//
//  Copyright (c) 2015 Blue Rocket, Inc. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import "NSString+BRLocalize.h"

#import "NSBundle+BRLocalize.h"
#import "NSDictionary+BRLocalize.h"

@implementation NSString (BRLocalize)

- (NSString *)localizedString {
	return [self localizedStringWithAppStrings:[NSBundle appStrings]];
}

+ (NSString *)localizedAppString:(NSString *)format, ... {
	va_list args;
	va_start(args, format);
	NSString *s = [NSString localizedAppString:format locale:[NSLocale currentLocale] arguments:args];
	va_end(args);
	return s;
}

+ (NSString *)localizedAppString:(NSString *)format locale:(nullable NSLocale *)locale arguments:(va_list)argList {
	NSString *s = [format localizedStringWithAppStrings:[[NSBundle mainBundle] appStringsForLocale:locale]];
	if ( [s isEqualToString:format] == NO ) {
		s = [[NSString alloc] initWithFormat:s locale:locale arguments:argList];
	}
	return s;
}

+ (NSString *)localizedString:(NSString *)format withAppStrings:(NSDictionary *)strings, ... {
	va_list args;
	va_start(args, strings);
	NSString *s = [NSString localizedString:format withAppStrings:strings locale:nil arguments:args];
	va_end(args);
	return s;
}

+ (NSString *)localizedString:(NSString *)format withAppStrings:(NSDictionary *)strings
					   locale:(nullable NSLocale *)locale arguments:(va_list)argList {
	NSString *s = [format localizedStringWithAppStrings:strings];
	if ( [s isEqualToString:format] == NO ) {
		s = [[NSString alloc] initWithFormat:s locale:locale arguments:argList];
	}
	return s;
}


- (NSString *)localizedStringWithAppStrings:(NSDictionary *)strings {
    NSString *finalString = self;
    NSString *string = [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if ( string.length > 2 && [string characterAtIndex:0] == '{' && [string characterAtIndex:string.length-1] == '}' ) {
        NSString *key = [string substringWithRange:NSMakeRange(1, string.length - 2)];
        string = [strings stringForKeyPath:key];
		if ( string && [string isKindOfClass:[NSString class]] && ![string isEqualToString:key] ) {
			finalString = string;
		}
    }
    return finalString;
}

@end
