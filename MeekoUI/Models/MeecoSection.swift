//
//  MeecoSection.swift
//  MeekoUI
//
//  Created by Kyujin Cho on 7/19/19.
//  Copyright © 2019 Kyujin Cho. All rights reserved.
//

import SwiftUI

struct MeecoSection {
    var name: String
    var boards: [MeecoBoard]
}

struct MeecoBoard: Identifiable {
    var id: String
    var name: String
}
