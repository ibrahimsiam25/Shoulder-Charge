import Foundation

struct LineupCardViewModel {
    let imageURL: URL?
    let name: String
    let positionTitle: String
    let number: String
}

struct LineupViewModel {
    let gk: LineupCardViewModel?
    let def1: LineupCardViewModel?
    let def2: LineupCardViewModel?
    let def3: LineupCardViewModel?
    let def4: LineupCardViewModel?
    let mid1: LineupCardViewModel?
    let mid2: LineupCardViewModel?
    let mid3: LineupCardViewModel?
    let fwd1: LineupCardViewModel?
    let fwd2: LineupCardViewModel?
    let st: LineupCardViewModel?
}

struct PlayerRowViewModel {
    let name: String
    let position: String
    let imageURL: URL?
}

struct PlayerSectionViewModel {
    let title: String
    let players: [PlayerRowViewModel]
}
