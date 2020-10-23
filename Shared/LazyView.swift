//
//  LazyView.swift
//  Silver Screen
//
//  Created by Abbas Mousavi on 10/19/20.
//

import Foundation
import SwiftUI

struct LazyView<Content: View>: View {
    let build: () -> Content
    init(_ build: @autoclosure @escaping () -> Content) {
        self.build = build
    }
    var body: Content {
        build()
    }
}
