//
//  protcolprofile.swift
//  ITIRestaurant
//
//  Created by MacBook Pro on 20/09/2024.
//

import Foundation
protocol profileDelegates: AnyObject{
    func didUpdate(name:String , phone:String,password:String,Email:String)
}
