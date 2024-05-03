//
//  User.swift
//  walkers
//
//  Created by Connor Hutchinson on 5/1/24.
//

import FirebaseFirestore

struct User: Codable {
    @DocumentID var id: String?
    var name: String
}
