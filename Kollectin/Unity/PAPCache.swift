import Foundation
import Parse

final class PAPCache {
    private var cache: NSCache<AnyObject, AnyObject>

    // MARK:- Initialization
    
    static let sharedCache = PAPCache()

    private init() {
        self.cache = NSCache()
    }

    // MARK:- PAPCache

    func clear() {
        cache.removeAllObjects()
    }

    func setAttributesForAdoption(adoption: PFObject, likers: [PFUser], commenters: [PFUser], likedByCurrentUser: Bool) {
        let attributes = [
            kPAPPostAttributesIsLikedByCurrentUserKey: likedByCurrentUser,
            kPAPPostAttributesLikeCountKey: likers.count,
            kPAPPostAttributesLikersKey: likers,
            kPAPPostAttributesCommentCountKey: commenters.count,
            kPAPPostAttributesCommentersKey: commenters
            ] as [String : Any]
        setAttributes(attributes: attributes as [String : AnyObject], forAdoption: adoption)
    }

    func attributesForAdoption(adoption: PFObject) -> [String:AnyObject]? {
        let key: String = self.keyForAdoption(adoption: adoption)
        return cache.object(forKey: key as AnyObject) as? [String:AnyObject]
    }

    func likeCountForAdoption(adoption: PFObject) -> Int {
        let attributes = self.attributesForAdoption(adoption: adoption)!
        if attributes != nil {
            let count = attributes[kPAPPostAttributesLikeCountKey]
            return count as! Int
        }

        return 0
    }

    func commentCountForAdoption(adoption: PFObject) -> Int {
        let attributes = attributesForAdoption(adoption: adoption)
        if attributes != nil {
            return attributes![kPAPPostAttributesCommentCountKey] as! Int
        }
        
        return 0
    }

    func likersForAdoption(adoption: PFObject) -> [PFUser] {
        let attributes = attributesForAdoption(adoption: adoption)
        if attributes != nil {
            return attributes![kPAPPostAttributesLikersKey] as! [PFUser]
        }
        
        return [PFUser]()
    }

    func commentersForAdoption(adoption: PFObject) -> [PFUser] {
        let attributes = attributesForAdoption(adoption: adoption)
        if attributes != nil {
            return attributes![kPAPPostAttributesCommentersKey] as! [PFUser]
        }
        
        return [PFUser]()
    }

    func setAdoptionIsLikedByCurrentUser(adoption: PFObject, liked: Bool) {
        var attributes = attributesForAdoption(adoption: adoption)
        attributes![kPAPPostAttributesIsLikedByCurrentUserKey] = liked as AnyObject
        setAttributes(attributes: attributes!, forAdoption: adoption)
    }

    func isAdoptionLikedByCurrentUser(adoption: PFObject) -> Bool {
        let attributes = attributesForAdoption(adoption: adoption)
        if attributes != nil {
            return attributes![kPAPPostAttributesIsLikedByCurrentUserKey] as! Bool
        }
        
        return false
    }

    func incrementLikerCountForAdoption(adoption: PFObject) {
        let likerCount = likeCountForAdoption(adoption: adoption) + 1
        var attributes = attributesForAdoption(adoption: adoption)
        attributes![kPAPPostAttributesLikeCountKey] = likerCount as AnyObject
        setAttributes(attributes: attributes!, forAdoption: adoption)
    }

    func decrementLikerCountForAdoption(adoption: PFObject) {
        let likerCount = likeCountForAdoption(adoption: adoption) - 1
        if likerCount < 0 {
            return
        }
        var attributes = attributesForAdoption(adoption: adoption)
        attributes![kPAPPostAttributesLikeCountKey] = likerCount as AnyObject
        setAttributes(attributes:attributes!, forAdoption: adoption)
    }

    func incrementCommentCountForAdoption(adoption: PFObject) {
        let commentCount = commentCountForAdoption(adoption: adoption) + 1
        var attributes = attributesForAdoption(adoption: adoption)
        attributes![kPAPPostAttributesCommentCountKey] = commentCount as AnyObject
        setAttributes(attributes: attributes!, forAdoption: adoption)
    }

    func decrementCommentCountForAdoption(adoption: PFObject) {
        let commentCount = commentCountForAdoption(adoption: adoption) - 1
        if commentCount < 0 {
            return
        }
        var attributes = attributesForAdoption(adoption: adoption)
        attributes![kPAPPostAttributesCommentCountKey] = commentCount as AnyObject
        setAttributes(attributes: attributes!, forAdoption: adoption)
    }

    func setAttributesForUser(user: PFUser, adoptionCount count: Int, followedByCurrentUser following: Bool) {
        let attributes = [
            kPAPUserAttributesPostCountKey: count,
            kPAPUserAttributesIsFollowedByCurrentUserKey: following
            ] as [String : Any]

        setAttributes(attributes: attributes as [String : AnyObject], forUser: user)
    }

    func attributesForUser(user: PFUser) -> [String:AnyObject]? {
        let key = keyForUser(user: user)
        return cache.object(forKey: key as AnyObject) as? [String:AnyObject]
    }

    func adoptionCountForUser(user: PFUser) -> Int {
        if let attributes = attributesForUser(user: user) {
            if let adoptionCount = attributes[kPAPUserAttributesPostCountKey] as? Int {
                return adoptionCount
            }
        }
        
        return 0
    }

    func followStatusForUser(user: PFUser) -> Bool {
        if let attributes = attributesForUser(user: user) {
            if let followStatus = attributes[kPAPUserAttributesIsFollowedByCurrentUserKey] as? Bool {
                return followStatus
            }
        }

        return false
    }

    func setAdoptionCount(count: Int,  user: PFUser) {
        if var attributes = attributesForUser(user: user) {
            attributes[kPAPUserAttributesPostCountKey] = count as AnyObject
            setAttributes(attributes: attributes, forUser: user)
        }
    }

    // MARK:- ()

    func setAttributes(attributes: [String:AnyObject], forAdoption adoption: PFObject) {
        let key: String = self.keyForAdoption(adoption: adoption)
        cache.setObject(attributes as AnyObject, forKey: key as AnyObject)
    }

    func setAttributes(attributes: [String:AnyObject], forUser user: PFUser) {
        let key: String = self.keyForUser(user: user)
        cache.setObject(attributes as AnyObject as AnyObject, forKey: key as AnyObject)
    }

    func keyForAdoption(adoption: PFObject) -> String {
        return "adoption_\(String(describing: adoption.objectId))"
    }

    func keyForUser(user: PFUser) -> String {
        return "user_\(String(describing: user.objectId))"
    }
}
