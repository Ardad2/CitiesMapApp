//
//  cityModel.swift
//  CSE335Lab4
//
//  Created by Arjun Dadhwal on 2/27/23.
//
import Foundation

/*struct City: Identifiable{
    var id = UUID()
    var name = String()
    var picture = String()
    var description = String()
}*/

struct city: Identifiable
{
    var id = UUID()
    var name: String
    var picture: String
    var description: String
}
