//
//  AnalyticsHelper.swift
//  MovieLo
//
//  Created by Ozan Barış Günaydın on 4.09.2022.
//

import Foundation
import FirebaseAnalytics

struct AnalyticsHelper {
    
    static func sendFirebaseEvent(key: String, parameters: [String: Any]? = nil) {
        print("🔔 sendFirebaseEvent: \(key)")
        Analytics.logEvent(key, parameters: parameters)
    }
}
