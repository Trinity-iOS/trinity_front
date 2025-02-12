//
//  AuthStatus.swift
//  Trinity
//
//  Created by Park Seyoung on 2/12/25.
//

import Foundation

enum AuthStatus {
    case idle
    case loading
    case ready
    case success
    case failure(Error)
}

