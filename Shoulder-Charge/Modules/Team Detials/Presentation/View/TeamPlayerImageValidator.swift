import Foundation
import UIKit

final class TeamPlayerImageValidator {
    func validate(players: [PlayerItem], completion: @escaping (Set<Int>) -> Void) {
        let playersWithImages = players.filter { $0.imageURL != nil }
        guard !playersWithImages.isEmpty else {
            completion([])
            return
        }

        let group = DispatchGroup()
        let lock = NSLock()
        var validPlayerKeys = Set<Int>()

        playersWithImages.forEach { player in
            guard let imageURL = player.imageURL else { return }

            group.enter()
            var request = URLRequest(url: imageURL)
            request.timeoutInterval = 4
            request.cachePolicy = .returnCacheDataElseLoad

            URLSession.shared.dataTask(with: request) { data, response, _ in
                let statusCode = (response as? HTTPURLResponse)?.statusCode ?? 0
                let isHTTPValid = statusCode == 0 || (200...299).contains(statusCode)
                let isImageValid = data.flatMap { UIImage(data: $0) } != nil

                if isHTTPValid && isImageValid {
                    lock.lock()
                    validPlayerKeys.insert(player.playerKey)
                    lock.unlock()
                }

                group.leave()
            }.resume()
        }

        group.notify(queue: .main) {
            completion(validPlayerKeys)
        }
    }
}
