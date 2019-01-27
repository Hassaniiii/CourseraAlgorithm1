//
//  main.m
//  InversionCounter
//
//  Created by Hassaniiii on 1/25/19.
//  Copyright © 2019 Hassan Shahbazi. All rights reserved.
//

#import <Foundation/Foundation.h>
#define filePath @"/Users/admin/Projects/helper/InversionCounter/InversionCounter/IntegerArray.txt"

NSArray* readFile(void);
NSArray* sortAndCount(NSArray *array);
NSArray* merge(NSArray *, NSArray *);
void bruteForce(NSArray *array);
long inversionCount = 0;

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSArray *items = readFile();
        
        NSDate *start = [NSDate date];
        NSLog(@"Recursive calculation started");
        sortAndCount(items);
        NSLog(@"%ld inversions found in %.2f seconds using recursion", inversionCount, [[NSDate date] timeIntervalSinceDate:start]);
        
        inversionCount = 0;
        start = [NSDate date];
        NSLog(@"Brute force calculation started");
        bruteForce(items);
        NSLog(@"%ld inversions found in %.2f seconds using brute force", inversionCount, [[NSDate date] timeIntervalSinceDate:start]);
    }
    return 0;
}

void bruteForce(NSArray *array) {
    for (int i=0; i<array.count; i++) {
        for (int j=i; j<array.count; j++) {
            if ([array[i] integerValue] > [array[j] integerValue]) {
                inversionCount++;
            }
        }
        if (i%2500 == 0 && i > 0)
            NSLog(@"Brute force at %d", i);
    }
}

NSArray* readFile() {
    NSString *fileContents = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    return [fileContents componentsSeparatedByString:@"\n"];
}

NSArray* sortAndCount(NSArray *array) {
    if (array.count <= 1) { return array; }
    
    unsigned long lastIndex = array.count/2;
    NSArray *firstSubarray = sortAndCount([array subarrayWithRange:NSMakeRange(0, lastIndex)]);
    NSArray *secondSubarray = sortAndCount([array subarrayWithRange:NSMakeRange(lastIndex, array.count - lastIndex)]);
    return merge(firstSubarray, secondSubarray);
}

NSArray* merge(NSArray *a, NSArray *b) {
    NSMutableArray *d = [a mutableCopy];
    int i = 0, j = 0;
    for (int k=0; k<(a.count + b.count); k++) {
        if (i == a.count) {
            [d addObjectsFromArray:[b subarrayWithRange:NSMakeRange(j, b.count - j)]];
            return d;
        }
        else if (j == b.count) {
            [d addObjectsFromArray:[a subarrayWithRange:NSMakeRange(i, a.count - i)]];
            return d;
        }
        else if ([a[i] integerValue] < [b[j] integerValue]) {
            d[k] = a[i];
            i++;
        }
        else if ([a[i] integerValue] >= [b[j] integerValue]) {
            d[k] = b[j];
            j++;
            inversionCount += [a subarrayWithRange:NSMakeRange(i, a.count - i)].count;
        }
    }
    return d;
}
