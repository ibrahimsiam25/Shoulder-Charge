import Foundation
import Alamofire

final class NetworkMonitor {
    static let shared = NetworkMonitor()

    private let reachabilityManager = NetworkReachabilityManager()

    var isConnected: Bool {
        return reachabilityManager?.isReachable ?? false
    }

    private init() {}
}
