//
//  CBondMeta.swift
//  BondsCashFlow
//
//  Created by Igor Malyarov on 25.08.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import Foundation

// MARK: - Meta
public struct Meta: Codable {
    let cmsFullGenTime: Double
    let userID: Int
    let lang: String
    let strictMode, performLogging: Int
    
    enum CodingKeys: String, CodingKey {
        case cmsFullGenTime = "cms_full_gen_time"
        case userID = "user_id"
        case lang
        case strictMode = "strict_mode"
        case performLogging
    }
}
