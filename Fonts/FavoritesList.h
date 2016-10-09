//
//  FavoritesList.h
//  Fonts
//
//  Created by 叶明 on 9/20/16.
//  Copyright © 2016 Ming Yeh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FavoritesList : NSObject

+(instancetype)sharedFavoritesList;

-(NSArray*)favorites;

-(void)addFavorite:(id)item;
-(void)removeFavorite:(id)item;

@end
