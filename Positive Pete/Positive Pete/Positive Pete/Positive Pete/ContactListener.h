//
//  ContactListener.h
//  Positive Pete
//
//  Created by Louis Ahola on 4/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#ifndef _CONTACT_LISTENER
#define _CONTACT_Listener

#import "GameObject.h"
#import "ShutDownSite.h"
#import "PowerChip.h"
#import "NeutralPad.h"
#import "Pete.h"
#import "ReversePad.h"
#import "SpeedPad.h"
#import "Box2D.h"

class ContactListener : public b2ContactListener
{
public:
    void BeginContact(b2Contact* contact)
    
    { /* handle begin event */ }
    
    
    
    void EndContact(b2Contact* contact)
    
    { /* handle end event */ }
    
    
    
    void PreSolve(b2Contact* contact, const b2Manifold* oldManifold)
    {
        ///b2Fixture *a = contact->GetFixtureA();
        //b2Fixture *b = contact->GetFixtureB();
        
        GameObject *objectA = (GameObject*)(contact->GetFixtureA()->GetBody()->GetUserData());
        GameObject *objectB = (GameObject*)(contact->GetFixtureB()->GetBody()->GetUserData());
        
        //PETE COLLISIONS
        if ([objectB gameObjectType] == kPeteType) {
            GameObject *tempObject = objectA;
            objectA = objectB;
            objectB = tempObject;
        }
        
        if ([objectA gameObjectType] != kPeteType) {
            //NOT A PETE COLLISIONS - DONT CARE YET
            return;
        }
        
        if ([objectB gameObjectType] == kShutDownSiteType) {
            [(ShutDownSite*)objectB changeState:kStatePoweredDown];
            contact->SetEnabled(false);
        } else if ([objectB gameObjectType] == kCannonType) {
            contact->SetEnabled(false);
        } else if ([objectB gameObjectType] == kPowerChipType) {
            [(PowerChip*)objectB changeState:kStatePickedUp];
            contact->SetEnabled(false);
        } else if ([objectB gameObjectType] == kSpeedPadType) {
            [(SpeedPad*)objectB changeState:kStatePickedUp];
            [(Pete*)objectA changeState:kStateSpeed];
        } else if ([objectB gameObjectType] == kNeutralPadType) {
            [(NeutralPad*)objectB changeState:kStatePickedUp];
            [(Pete*)objectA changeState:kStateNeutral];
        } else if ([objectB gameObjectType] == kReversPadType) {
            [(ReversePad*)objectB changeState:kStatePickedUp];
            [(Pete*)objectA changeState:kStateReversed];
        }
    }
    
    
    
    void PostSolve(b2Contact* contact, const b2ContactImpulse* impulse)
    
    { /* handle post-solve event */ }
    

};

#endif
