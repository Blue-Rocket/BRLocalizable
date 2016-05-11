//
//  NSString_BRTests.m
//  BlueRocketFuelCore
//
//  Created by Matt on 18/08/15.
//  Copyright (c) 2015 Blue Rocket. Distributable under the terms of the Apache License, Version 2.0.
//

#import "BaseTestingSupport.h"

#import "NSString+BRLocalize.h"

@interface NSString_BRLocalizeTests : BaseTestingSupport

@end

@implementation NSString_BRLocalizeTests {
	NSDictionary *strings;
}

- (void)setUp {
	[super setUp];
	strings = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:[self.bundle pathForResource:@"strings.json" ofType:nil]] options:0 error:nil];
}

- (void)testLocalize {
	NSString *loc = [@"{error.general}" localizedStringWithAppStrings:strings];
	assertThat(loc, equalTo(@"This is a general error: %@"));
}

- (void)testLocalizeMoreNested {
	NSString *loc = [@"{error.specific.ouch}" localizedStringWithAppStrings:strings];
	assertThat(loc, equalTo(@"Ouch, that hurt."));
}

- (void)testLocalizeMissing {
	NSString *loc = [@"{error.doesNotExist}" localizedStringWithAppStrings:strings];
	assertThat(loc, equalTo(@"{error.doesNotExist}"));
}

- (void)testLocalizeObject {
	NSString *loc = [@"{error.specific}" localizedStringWithAppStrings:strings];
	assertThat(loc, equalTo(@"{error.specific}"));
}

- (void)testLocalizeMissingEndBrace {
	NSString *loc = [@"{error.general" localizedStringWithAppStrings:strings];
	assertThat(loc, equalTo(@"{error.general"));
}

- (void)testLocalizeMissingStartBrace {
	NSString *loc = [@"error.general}" localizedStringWithAppStrings:strings];
	assertThat(loc, equalTo(@"error.general}"));
}

- (void)testLocalizeMissingBraces {
	NSString *loc = [@"error.general" localizedStringWithAppStrings:strings];
	assertThat(loc, equalTo(@"error.general"));
}

- (void)testLocalizeFormat {
	NSString *loc = [NSString localizedString:@"{error.general}" withAppStrings:strings, @"BAM!"];
	assertThat(loc, equalTo(@"This is a general error: BAM!"));
}

- (void)testLocalizeFormatMissingArgument {
	NSString *loc = [NSString localizedString:@"{error.general}" withAppStrings:strings, nil];
	assertThat(loc, equalTo(@"This is a general error: (null)"));
}

- (void)testLocalizeFormatMissingKey {
	NSString *loc = [NSString localizedString:@"{error.doesNotExist}" withAppStrings:strings, @"BAM!"];
	assertThat(loc, equalTo(@"{error.doesNotExist}"));
}

@end
