//
//  Exceptions.m
//  Safe
//
//  Created by Josh Baker on 7/1/15.
//  Copyright © 2015 ONcast. All rights reserved.
//

#import "bridge.h"

NSException *_try(AnyBlock block) {
    @try {
        block();
    }
    @catch (NSException *exception) {
        return exception;
    }
    return nil;
}
