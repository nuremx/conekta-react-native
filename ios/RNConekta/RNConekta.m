//
//  Conekta.m
//  conekta-react-native
//
//  Created by César Guadarrama on 8/19/18.
//  Copyright © 2018 Nure. All rights reserved.
//

#import <React/RCTBridgeModule.h>

@interface RCT_EXTERN_REMAP_MODULE(RNConekta, Conekta, NSObject)

RCT_EXTERN_METHOD(setPublicKey:(nonnull NSString *)publicKey)
RCT_EXTERN_METHOD(
                  createToken: (nonnull NSString *)number
                  name: (nonnull NSString *)name
                  cvc: (nonnull NSString *)cvc
                  expMonth: (nonnull NSString *)expMonth
                  expYear: (nonnull NSString *)expYear
                  callback: (RCTResponseSenderBlock)callback
                  )

@end
