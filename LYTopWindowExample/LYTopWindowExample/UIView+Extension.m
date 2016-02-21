//
//  UIView+Extension.m
//  LY
//

#import "UIView+Extension.h"

#import <objc/runtime.h>

static char nametag_key;

@implementation UIView (Extension)

#pragma mark - setter
- (void)setCenterX:(CGFloat)centerX {
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (void)setCenterY:(CGFloat)centerY {
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (void)setX:(CGFloat)x {
    CGRect tempFrame = self.frame;
    tempFrame.origin.x = x;
    self.frame = tempFrame;
}

- (void)setY:(CGFloat)y {
    CGRect tempFrame = self.frame;
    tempFrame.origin.y  = y;
    self.frame = tempFrame;
}

- (void)setWidth:(CGFloat)width {
    CGRect tempFrame = self.frame;
    tempFrame.size.width = width;
    self.frame = tempFrame;
}

- (void)setHeight:(CGFloat)height {
    CGRect tempFrame = self.frame;
    tempFrame.size.height = height;
    self.frame = tempFrame;
}

- (void)setOrigin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (void)setSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}


#pragma mark - getter
- (CGFloat)centerX {
    return self.center.x;
}

- (CGFloat)centerY {
    return self.center.y;
}

- (CGFloat)x {
    return self.frame.origin.x;
}

- (CGFloat)y {
    return self.frame.origin.y;
}

- (CGFloat)width {
    return self.frame.size.width;
}

- (CGFloat)height {
    return self.frame.size.height;
}

- (CGPoint)origin {
    return self.frame.origin;
}

- (CGSize)size {
    return self.frame.size;
}

- (BOOL)intersectWithView:(UIView *)anotherView {
    if (anotherView == nil) {
        anotherView = [UIApplication sharedApplication].keyWindow;
    }
    
    CGRect rect1 = [self convertRect:self.bounds toView:nil];
    CGRect rect2 = [anotherView convertRect:anotherView.bounds toView:nil];
    return CGRectIntersectsRect(rect1, rect2);
}


- (void)setNametag:(NSString *)theNametag {
    objc_setAssociatedObject(self, &nametag_key, theNametag, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)getNametag {
    return objc_getAssociatedObject(self, &nametag_key);
}

- (UIView *)viewWithNameTag:(NSString *)aName {
    if (!aName) return nil;
    
    // Is this the right view?
    if ([[self getNametag] isEqualToString:aName])
        return self;
    // Recurse depth first on subviews;
    for (UIView *subview in self.subviews) {
        UIView *resultView = [subview viewNamed:aName];
        if (resultView) return  resultView;
    }
    // Not found
    return nil;
}

- (UIView *)viewNamed:(NSString *)aName {
    if (!aName) return nil;
    return [self viewWithNameTag:aName];
}

@end
