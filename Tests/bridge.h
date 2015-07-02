//
//  bridge.h
//  Safe
//
//  Created by Josh Baker on 7/1/15.
//  Copyright © 2015 ONcast. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^ AnyBlock)();
NSException *_try(AnyBlock block);

bool __builtin_uadd_overflow  (unsigned x, unsigned y, unsigned *sum);
bool __builtin_uaddl_overflow (unsigned long x, unsigned long y, unsigned long *sum);
bool __builtin_uaddll_overflow(unsigned long long x, unsigned long long y, unsigned long long *sum);
bool __builtin_usub_overflow  (unsigned x, unsigned y, unsigned *diff);
bool __builtin_usubl_overflow (unsigned long x, unsigned long y, unsigned long *diff);
bool __builtin_usubll_overflow(unsigned long long x, unsigned long long y, unsigned long long *diff);
bool __builtin_umul_overflow  (unsigned x, unsigned y, unsigned *prod);
bool __builtin_umull_overflow (unsigned long x, unsigned long y, unsigned long *prod);
bool __builtin_umulll_overflow(unsigned long long x, unsigned long long y, unsigned long long *prod);
bool __builtin_sadd_overflow  (int x, int y, int *sum);
bool __builtin_saddl_overflow (long x, long y, long *sum);
bool __builtin_saddll_overflow(long long x, long long y, long long *sum);
bool __builtin_ssub_overflow  (int x, int y, int *diff);
bool __builtin_ssubl_overflow (long x, long y, long *diff);
bool __builtin_ssubll_overflow(long long x, long long y, long long *diff);
bool __builtin_smul_overflow  (int x, int y, int *prod);
bool __builtin_smull_overflow (long x, long y, long *prod);
bool __builtin_smulll_overflow(long long x, long long y, long long *prod);