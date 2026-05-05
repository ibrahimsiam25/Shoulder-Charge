//
//  L10n.swift
//  Shoulder-Charge
//
//  Created by Eslam Elnady on 28/04/2026.
//
//  Type-safe localization key namespace.
//  All properties are computed vars so they re-evaluate after a language switch.
//
//  Usage:
//    label.text = L10n.Settings.title
//    label.text = L10n.Settings.Theme.dark
//

import Foundation

enum L10n {

    enum Settings {
        static var title:       String { "settings.title".localized }
        static var theme:       String { "settings.theme".localized }
        static var appearance:  String { "settings.appearance".localized }
        static var language:    String { "settings.language".localized }

        enum Theme {
            static var system: String { "settings.theme.system".localized }
            static var light:  String { "settings.theme.light".localized }
            static var dark:   String { "settings.theme.dark".localized }
        }

        enum Language {
            static var system:  String { "settings.language.system".localized }
            static var english: String { "settings.language.english".localized }
            static var arabic:  String { "settings.language.arabic".localized }
        }
    }

    enum Onboarding {
        enum Slide1 {
            static var titleWhite: String { "onboarding.slide1.titleWhite".localized }
            static var titlePrimary: String { "onboarding.slide1.titlePrimary".localized }
            static var description: String { "onboarding.slide1.description".localized }
        }

        enum Slide2 {
            static var titleWhite: String { "onboarding.slide2.titleWhite".localized }
            static var titlePrimary: String { "onboarding.slide2.titlePrimary".localized }
            static var description: String { "onboarding.slide2.description".localized }
        }

        enum Slide3 {
            static var titleWhite: String { "onboarding.slide3.titleWhite".localized }
            static var titlePrimary: String { "onboarding.slide3.titlePrimary".localized }
            static var description: String { "onboarding.slide3.description".localized }
        }

        static var continueTitle: String { "onboarding.continue".localized }
        static var skip: String { "onboarding.skip".localized }
    }

    enum Leagues {
        static var title:             String { "leagues.title".localized }
        static var searchPlaceholder: String { "leagues.searchPlaceholder".localized }
    }

    enum Common {
        static var done:   String { "common.done".localized }
        static var cancel: String { "common.cancel".localized }
        static var save:   String { "common.save".localized }
        static var appName: String { "common.appName".localized }
    }
    enum Home {
        static var soccer: String { "home.soccer".localized }
        static var basket: String { "home.basket".localized }
        static var tennis: String { "home.tennis".localized }
        static var racquet: String { "home.racquet".localized }
    }

    enum LeagueDetails {
        static var upcoming: String { "leagueDetails.upcoming".localized }
        static var finished: String { "leagueDetails.finished".localized }
        static var teams:    String { "leagueDetails.teams".localized }
        static var players:  String { "leagueDetails.players".localized }
        static var title:    String { "leagueDetails.title".localized }
        static var noUpcomingEventsTitle: String { "leagueDetails.noUpcomingEvents.title".localized }
        static var noUpcomingEventsSubtitle: String { "leagueDetails.noUpcomingEvents.subtitle".localized }
        static var noFinishedEventsTitle: String { "leagueDetails.noFinishedEvents.title".localized }
        static var noFinishedEventsSubtitle: String { "leagueDetails.noFinishedEvents.subtitle".localized }
    }
    enum Favorites {
        static var title:         String { "favorites.title".localized }
        static var emptyTitle:    String { "favorites.empty.title".localized }
        static var emptySubtitle: String { "favorites.empty.subtitle".localized }
    }

    enum PlayerDetails {
        static var stats:       String { "playerDetails.stats".localized }
        static var tournaments: String { "playerDetails.tournaments".localized }
        static var season:      String { "playerDetails.season".localized }
        static var rank:        String { "playerDetails.rank".localized }
        static var titles:      String { "playerDetails.titles".localized }
        static var matchesWon:  String { "playerDetails.matchesWon".localized }
        static var matchesLost: String { "playerDetails.matchesLost".localized }
        static var hard:        String { "playerDetails.hard".localized }
        static var clay:        String { "playerDetails.clay".localized }
        static var grass:       String { "playerDetails.grass".localized }
        static var singles:     String { "playerDetails.singles".localized }
        static var doubles:     String { "playerDetails.doubles".localized }
        static var surface:     String { "playerDetails.surface".localized }
        static var prize:       String { "playerDetails.prize".localized }
        static var country:     String { "playerDetails.country".localized }
        static var birthdate:   String { "playerDetails.birthdate".localized }
    }
}
