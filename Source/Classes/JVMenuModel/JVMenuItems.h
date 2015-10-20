//
//  JVMenuItems.h
//  Pods
//
//  Created by Jorge Valbuena on 2015-10-19.
//
//

#import <Foundation/Foundation.h>


@interface JVMenuItems : NSObject

/** The array of images to be used in the menu. */
@property (nonatomic, strong, readwrite) NSArray *menuImages;


/** The array of titles to be used in the menu. */
@property (nonatomic, strong, readwrite) NSArray *menuTitles;


/** The close image to be used in the close button in the menu. */
@property (nonatomic, strong, readwrite) UIImage *menuCloseButtonImage;


/** This is the type of animation @a slideInAnimation used for how the content of the menu shows up. */
@property (nonatomic, assign, readwrite) BOOL menuSlideInAnimation;


/** This is the type of animation @a slideInWithBounceAnimation used for how the content of the menu shows up (ON by default). */
@property (nonatomic, assign, readwrite) BOOL menuSlideInWithBounceAnimation;


/**
 Default initializer for @a JVMenuItems with the default @a menuSlideInWithBounceAnimation.
 
 @return
    An instance type of @a JVMenuItems;
 */
- (instancetype)init;


/**
 Custom initializer for @a JVMenuItems with @a menuImages, @a menuTitles, @a menuCloseButtonImage and default @a menuSlideInWithBounceAnimation.
 
 @param menuImages
    An array of images for the menu.
 @param menuTitles
    An array of titles for the menu.
 @param menuCloseButtonImage
    The close button image for the menu.
 
 @return
    An instance type of @a JVMenuItems;
 */
- (instancetype)initWithMenuImages:(NSArray *)images menuTitles:(NSArray *)titles menuCloseButtonImage:(UIImage *)closeImage;

@end
