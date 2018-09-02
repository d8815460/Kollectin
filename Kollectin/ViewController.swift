//
//  ViewController.swift
//  Kollectin
//
//  Created by 陳駿逸 on 2018/9/1.
//  Copyright © 2018年 陳駿逸. All rights reserved.
//

import UIKit
import Parse

class ViewController: UIViewController {

    var Jessie:PFUser?
    var Emily:PFUser?
    var Mike:PFUser?
    var Linda:PFUser?
    var Susan:PFUser?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        /*
         Jessie objectId: EICKMxRrJN
         Emily  objectId: gfDEBbJJNR
         Mike   objectId: nMNAnBBZYl
         Linda  objectId: wI1EV0N99k
         Susan  objectId: dUdE8pNVlf
         */
        self.allUsers()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // All User
    func allUsers() {
        let userquery = PFUser.query()
        userquery?.findObjectsInBackground(block: { (users, error) in
            if error == nil {
                for user in users! {
                    switch (user as! PFUser).username {
                    case "Jessie":
                        self.Jessie = user as? PFUser
                    case "Emily":
                        self.Emily = user as? PFUser
                    case "Mike":
                        self.Mike = user as? PFUser
                    case "Linda":
                        self.Linda = user as? PFUser
                    case "Susan":
                        self.Susan = user as? PFUser
                    default:
                        break
                    }
                }
                
                self.calCommission(user: self.Susan!, price: 100)
            }
        })
    }
    
    // 增加上層使用者
    func addUpLine(userA:PFUser, userB:PFUser) {
        userA.relation(forKey: kPAPUserAddUpLineKey).add(userB)
        userA.saveInBackground()
    }
    
    // 增加下層使用者
    func addDownLine(userA:PFUser, userB:PFUser) {
        userA.relation(forKey: kPAPUserAddDownLinKey).add(userB)
        userA.saveInBackground()
    }
    
    // 計算當使用者消費後，每層的佣金
    func calCommission(user:PFUser, price:NSNumber)  {
        let relation = user.relation(forKey: kPAPUserAddUpLineKey)
        let queryFirst = relation.query()
        queryFirst.findObjectsInBackground { (users, error) in
            if error == nil && (users?.count)! > 0{
                for user in users! {
                    print("第一層user = \(String(describing: (user as? PFUser)?.username))")
                    print("獲得佣金50% = \(price.intValue/2)")
                    
                    // 第二層
                    let relation2 = user.relation(forKey: kPAPUserAddUpLineKey)
                    let querySecond = relation2.query()
                    querySecond.findObjectsInBackground(block: { (users2, error) in
                        if error == nil && (users2?.count)! > 0{
                            for user in users2! {
                                print("第二層 user = \(String(describing: (user as? PFUser)?.username))")
                                print("獲得佣金10% = \(price.intValue/10)")
                            }
                        } else {
                            print("沒有第二層")
                        }
                    })
                }
            } else {
                print("沒有第一層")
            }
        }
    }
}

