//
//  PAPConstants.swift
//  ParseStarterProject-Swift
//
//  Created by 陳駿逸 on 2018/7/25.
//  Copyright © 2018年 Parse. All rights reserved.
//

import UIKit
import RealmSwift

let kPAPParseAPIUrlKey              = "https://parseapi.back4app.com/"
let kPAPApplicationIdKey            = "sjGeJmKckMcrrokWP4DaxyWxrxhHmXJ5kgO2cEJy"
let kPAPClientKey                   = "g8qlGJqKJtcoEpaQfE2wHctR5vCoqAI4qxyYoLqD"

let kPAPPetsLoadObjectsPerPage:UInt = 30

// User for Realm
class pUser: Object {
    @objc dynamic var username      = ""
    @objc dynamic var objectId      = ""
    let               addDownLine   = List<pUser>()
    let               addUpLine     = List<pUser>()
}

// MARK: - Followers Object
class Followers: Object {
    let               fromUser  = List<pUser>()
    let               toUser    = List<pUser>()
    @objc dynamic var createdAt = Date()
    @objc dynamic var updateAt  = Date()
}


// MARK: - User Class
// Class key
let kPAPUserClassKey            = "_User"
// Field keys
let kPAPUserAddDownLinKey       = "addDownLine"     // Followers
let kPAPUserAddUpLineKey        = "addUpLine"       // Following

// MARK: - Order Class
// Class key
let kPAPFollowersClassKey       = "Order"
// Field keys
let kPAPItemsKey                = "Items"
let kPAPFollowersFromUserKey    = "fromUser"
let kPAPFollowersToUserKey      = "toUser"

// MARK:- Activity Class
// Class key
let kPAPActivityClassKey        = "Activity"

// Field keys
let kPAPActivityTypeKey         = "type"
let kPAPActivityFromUserKey     = "fromUser"
let kPAPActivityToUserKey       = "toUser"
let kPAPActivityContentKey      = "content"
let kPAPActivityAdoptionKey     = "adoption"
let kPAPActivityPhotoKey        = "photo"

// Type values
let kPAPActivityTypeLike        = "like"
let kPAPActivityTypeFollow      = "follow"
let kPAPActivityTypeComment     = "comment"
let kPAPActivityTypeJoined      = "joined"

// MARK:- Cached Post Attributes
// keys
let kPAPPostAttributesIsLikedByCurrentUserKey = "isLikedByCurrentUser";
let kPAPPostAttributesLikeCountKey            = "likeCount"
let kPAPPostAttributesLikersKey               = "likers"
let kPAPPostAttributesCommentCountKey         = "commentCount"
let kPAPPostAttributesCommentersKey           = "commenters"

// MARK:- Cached User Attributes
// keys
let kPAPUserAttributesPostCountKey                  = "postCount"
let kPAPUserAttributesIsFollowedByCurrentUserKey    = "isFollowedByCurrentUser"

// MARK:- User Info Keys
let PAPPostDetailsViewControllerUserLikedUnlikedAdoptionNotificationUserInfoLikedKey = "liked"
let kPAPEditPostViewControllerUserInfoCommentKey = "comment"
