//
//  AppState.swift
//  NeoChat
//
//  Created by Shreyas on 24/10/25.
//

import SwiftUI

@Observable
class AppState {
    private(set) var showTabBar: Bool {
        didSet {
            UserDefaults.standard.set(showTabBar, forKey: "showTabbarView")
        }
    }

    init(showTabBar: Bool = UserDefaults.showTabBarView) {
        self.showTabBar = showTabBar
    }

    func updateViewState(_ showTabBar: Bool) {
        self.showTabBar = showTabBar
    }
}

extension UserDefaults {

    private struct Keys {
        static let showTabBarView = "showTabbarView"
    }

    static var showTabBarView: Bool {
        get {
            standard.bool(forKey: Keys.showTabBarView)
        }
        set {
            standard.set(newValue, forKey: Keys.showTabBarView)
        }
    }
}
