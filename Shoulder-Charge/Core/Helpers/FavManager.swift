//
//  FavManager.swift
//  Shoulder-Charge
//
//  Created by siam on 04/05/2026.
//

import UIKit
import CoreData


protocol FavoriteManagerProtocol {
    func add(league: UnifiedLeagueModel)
    func delete(id: Int)
    func fetchAll() -> [UnifiedLeagueModel]
    func isExist(id: Int) -> Bool
}

class FavoriteManager: FavoriteManagerProtocol {
    
    static let shared = FavoriteManager()
    
    private init() {}

    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func add(league: UnifiedLeagueModel) {
        let newFav = FavoriteLeagues(context: context)
        newFav.id = Int32(league.id)
        newFav.name = league.name
        newFav.imageUrl = league.logoURL?.absoluteString
        newFav.subTitle = league.displaySubTitle
        newFav.sport = league.sport.rawValue
        
        saveContext()
    }

    func delete(id: Int) {
        let request: NSFetchRequest<FavoriteLeagues> = FavoriteLeagues.fetchRequest()
        request.predicate = NSPredicate(format: "id == %d", Int32(id))
        
        if let items = try? context.fetch(request) {
            items.forEach { context.delete($0) }
            saveContext()
        }
    }

    func fetchAll() -> [UnifiedLeagueModel] {
        let request: NSFetchRequest<FavoriteLeagues> = FavoriteLeagues.fetchRequest()
        let result = try? context.fetch(request)
        
        return result?.map { $0.toUnifiedModel() } ?? []
    }

    func isExist(id: Int) -> Bool {
        let request: NSFetchRequest<FavoriteLeagues> = FavoriteLeagues.fetchRequest()
        request.predicate = NSPredicate(format: "id == %d", Int32(id))
        
        let count = try? context.count(for: request)
        return (count ?? 0) > 0
    }
    
    private func saveContext() {
        if context.hasChanges {
            try? context.save()
        }
    }
}
