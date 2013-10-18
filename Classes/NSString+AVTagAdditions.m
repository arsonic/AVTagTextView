//
//  NSString+AVTagAdditions.m
//  AVTagTextField
//
//  Created by Arseniy Vershinin on 9/16/13.
//

#import "NSString+AVTagAdditions.h"

@implementation NSString (AVTagAdditions)

- (NSRange)wholeStringRange{
    return NSMakeRange(0, self.length);
}

- (NSString *)stringWithCheckingResult:(NSTextCheckingResult *)result{
    return [self substringWithRange:NSMakeRange(result.range.location+1, result.range.length-1)];
}

+ (NSRegularExpression *)endOfStringHashtagRegex{
    return [NSRegularExpression
            regularExpressionWithPattern:@"#(\\w+)$"
            options:NSRegularExpressionCaseInsensitive
            error:nil];
}

- (NSString *)endOfStringHashtag{
    NSRegularExpression *regex = [NSString endOfStringHashtagRegex];
    NSTextCheckingResult *result = [regex firstMatchInString:self options:0 range:NSMakeRange(0, self.length)];
    if(result) {
        NSString *match = [self substringWithRange:NSMakeRange(result.range.location+1, result.range.length-1)];
        return match;
    }
    return nil;
}

- (NSArray *)hashTags{
    NSMutableArray *results = [NSMutableArray array];
    if(self) {
        //TODO: exclude # with a regex
        NSRegularExpression *regex = [NSRegularExpression
                                      regularExpressionWithPattern:@"#(\\w+)"
                                      options:NSRegularExpressionCaseInsensitive
                                      error:nil];
        
        [regex enumerateMatchesInString:self
                                options:0
                                  range:NSMakeRange(0, [self length])
                             usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
                                 
                                 NSString *match = [self substringWithRange:NSMakeRange(result.range.location+1, result.range.length-1)];
                                 if(match) {
                                     [results addObject:match];
                                 }
                             }];
        
    }
    return results;
}


@end
