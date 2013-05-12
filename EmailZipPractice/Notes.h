//
//  Notes.h
//  EmailZipPractice
//
//  Created by Ali Vafai on 5/11/13.
//  Copyright (c) 2013 admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Notes : NSManagedObject

@property (nonatomic, retain) NSString * noteBody;
@property (nonatomic, retain) NSString * noteTaker;

@end
