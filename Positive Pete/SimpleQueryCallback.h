//
//  SimpleQueryCallback.h
//  Positive Pete
//
//  Created by Louis Ahola on 2/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#ifndef _SIMPLE_QUERY_CALLBACK
#define _SIMPLE_QUERY_CALLBACK

#import "Box2D.h"

class SimpleQueryCallback : public b2QueryCallback
{
public:
    b2Vec2 pointToTest;
    NSMutableArray *bodiesFound;
    b2Fixture *fixtureFound;
    
    SimpleQueryCallback(const b2Vec2& point, NSMutableArray *bodiesClicked) {
        pointToTest = point;
        bodiesFound = bodiesClicked;
        fixtureFound = NULL;
    }

    bool ReportFixture(b2Fixture *fixture) {
        b2Body *body = fixture->GetBody();
        
        if((body->GetType() == b2_kinematicBody ||
           body->GetType() == b2_dynamicBody) && body->GetUserData() != NULL) {
            //if(fixture->TestPoint(pointToTest)) {
                [bodiesFound addObject:[NSValue valueWithPointer:body]];
                fixtureFound = fixture;
                //return false;
            //}
        }
        return true;
    }
};

#endif
