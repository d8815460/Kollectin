import Foundation
import CoreGraphics
import AVFoundation
import RealmSwift
import Parse

class PAPUtility {

    // MARK:- PAPUtility
    
    // MARK:- 用戶的粉絲
    
    // MARK:- 用戶追蹤的人
    
    



    // MARK Activities
    class func queryForActivitiesOnPost(adoption: PFObject, cachePolicy: PFCachePolicy) -> PFQuery<PFObject> {
        let queryLikes: PFQuery = PFQuery(className: kPAPActivityClassKey)
        queryLikes.whereKey(kPAPActivityAdoptionKey, equalTo: adoption)
        queryLikes.whereKey(kPAPActivityTypeKey, equalTo: kPAPActivityTypeLike)

        let queryComments = PFQuery(className: kPAPActivityClassKey)
        queryComments.whereKey(kPAPActivityAdoptionKey, equalTo: adoption)
        queryComments.whereKey(kPAPActivityTypeKey, equalTo: kPAPActivityTypeComment)

        let query = PFQuery.orQuery(withSubqueries: [queryLikes,queryComments])
        query.cachePolicy = cachePolicy
        query.includeKey(kPAPActivityFromUserKey)
        query.includeKey(kPAPActivityAdoptionKey)

        return query
    }
}
