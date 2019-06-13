//
//  TransformTypeProtocol.h
//  PPTryst
//
//  Created by chinaspx on 2018/8/21.
//  Copyright © 2018年 AsiaInnovations. All rights reserved.
//

#ifndef TransformTypeProtocol_h
#define TransformTypeProtocol_h

#import <Foundation/Foundation.h>

@protocol TransformTypeProtocol <NSObject>
@required
- (id)transform:(id)src;
@end

#endif /* TransformTypeProtocol_h */
