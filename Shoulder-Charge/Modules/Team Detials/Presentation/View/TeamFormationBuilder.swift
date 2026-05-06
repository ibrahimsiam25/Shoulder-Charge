import Foundation

struct TeamFormationBuilder {
    private let slots: [FormationSlot] = [
        FormationSlot(lines: [.forward], title: "FWD"),
        FormationSlot(lines: [.striker, .forward], title: "ST"),
        FormationSlot(lines: [.forward], title: "FWD"),
        FormationSlot(lines: [.midfielder], title: "MID"),
        FormationSlot(lines: [.midfielder], title: "MID"),
        FormationSlot(lines: [.midfielder], title: "MID"),
        FormationSlot(lines: [.defender], title: "DEF"),
        FormationSlot(lines: [.defender], title: "DEF"),
        FormationSlot(lines: [.defender], title: "DEF"),
        FormationSlot(lines: [.defender], title: "DEF"),
        FormationSlot(lines: [.goalkeeper], title: "GK")
    ]

    func build(
        from players: [PlayerItem],
        validImagePlayerKeys: Set<Int> = []
    ) -> (players: [FormationPlayer?], selectedIndexes: Set<Int>) {
        var playersByPosition = groupedPlayers(from: players, validImagePlayerKeys: validImagePlayerKeys)
        var selectedIndexes = Set<Int>()

        let selectedPlayers = slots.map { slot -> FormationPlayer? in
            guard let selection = pickPlayer(for: slot, from: &playersByPosition) else { return nil }
            let selectedPlayer = selection.player
            playersByPosition[selection.line] = selection.remainingPlayers
            selectedIndexes.insert(selectedPlayer.index)
            return FormationPlayer(player: selectedPlayer.player, cardTitle: slot.title)
        }

        return (selectedPlayers, selectedIndexes)
    }

    private func pickPlayer(
        for slot: FormationSlot,
        from playersByPosition: inout [PositionLine: [IndexedPlayer]]
    ) -> (line: PositionLine, player: IndexedPlayer, remainingPlayers: [IndexedPlayer])? {
        for line in slot.lines {
            guard var players = playersByPosition[line],
                  !players.isEmpty else {
                continue
            }

            let player = players.removeFirst()
            return (line, player, players)
        }

        return nil
    }

    private func groupedPlayers(
        from players: [PlayerItem],
        validImagePlayerKeys: Set<Int>
    ) -> [PositionLine: [IndexedPlayer]] {
        Dictionary(grouping: players.enumerated().map { index, player in
            IndexedPlayer(index: index, player: player)
        }, by: { $0.player.positionLine })
        .mapValues { players in
            players.sorted { lhs, rhs in
                let lhsHasValidImage = validImagePlayerKeys.contains(lhs.player.playerKey)
                let rhsHasValidImage = validImagePlayerKeys.contains(rhs.player.playerKey)

                if lhsHasValidImage != rhsHasValidImage {
                    return lhsHasValidImage
                }

                if lhs.player.hasImage != rhs.player.hasImage {
                    return lhs.player.hasImage
                }

                return lhs.index < rhs.index
            }
        }
    }
}

struct FormationPlayer {
    let player: PlayerItem
    let cardTitle: String
}

private struct FormationSlot {
    let lines: [PositionLine]
    let title: String
}

private struct IndexedPlayer {
    let index: Int
    let player: PlayerItem
}

enum PositionLine: Hashable {
    case goalkeeper
    case defender
    case midfielder
    case striker
    case forward
    case other
}

extension PlayerItem {
    var hasImage: Bool {
        guard let imageURL else { return false }
        return !imageURL.absoluteString.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    var positionLine: PositionLine {
        let value = position.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()

        if value.contains("goalkeeper") || value.contains("keeper") || value.contains("goalie") || value == "gk" {
            return .goalkeeper
        }

        if value.contains("defender") || value.contains("defence") || value.contains("defense") || value.contains("back") || value == "df" {
            return .defender
        }

        if value.contains("midfielder") || value.contains("midfield") || value == "mf" {
            return .midfielder
        }

        if value.contains("striker") || value.contains("centre forward") || value.contains("center forward") || value == "cf" || value == "st" {
            return .striker
        }

        if value.contains("forward") || value.contains("winger") || value.contains("attacker") || value == "fw" {
            return .forward
        }

        return .other
    }
}
