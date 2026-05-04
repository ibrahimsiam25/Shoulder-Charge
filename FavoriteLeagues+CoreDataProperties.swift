//
//  FavoriteLeagues+CoreDataProperties.swift
//  Shoulder-Charge
//
//  Created by siam on 03/05/2026.
//
//

 import Foundation
 import CoreData


extension FavoriteLeagues {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoriteLeagues> {
        return NSFetchRequest<FavoriteLeagues>(entityName: "FavoriteLeagues")
    }

    @NSManaged public var id: Int32
    @NSManaged public var name: String?
    @NSManaged public var imageUrl: String?
    @NSManaged public var subTitle: String?
    @NSManaged public var sport: String?

}

extension FavoriteLeagues {
    func toUnifiedModel() -> UnifiedLeagueModel {
        return UnifiedLeagueModel(
            id: Int(self.id),
            name: self.name ?? "",
            logoURL: URL(string: self.imageUrl ?? ""),
            displaySubTitle: self.subTitle,
            sport: SportType(rawValue: self.sport ?? "football") ?? .football
        )
    }
}
