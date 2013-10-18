//
//  NSString+AVTagAdditions.h
//  AVTagTextField
//
//  Created by Arseniy Vershinin on 9/16/13.
//

#import <Foundation/Foundation.h>

@interface NSString(AVTagAdditions)

+ (NSRegularExpression *)endOfStringHashtagRegex;

- (NSRange)wholeStringRange;
- (NSString *)stringWithCheckingResult:(NSTextCheckingResult *)result;
- (NSString *)endOfStringHashtag;
- (NSArray *)hashTags;

@end
