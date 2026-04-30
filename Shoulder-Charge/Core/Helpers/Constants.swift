//
//  Constants.swift
//  Shoulder-Charge
//
//  Created by Eslam Elnady on 29/04/2026.
//

struct Constants{
    static let baseUrl = "https://apiv2.allsportsapi.com/"
    static let apiKey = "5ffd0a125be1a6ecc320fb6cd7978e9246ef0660806cdf9644e383cb59061a5d"
    static let fixtures = "Fixtures"
    static let teams = "Teams"
    static let leagues = "Leagues"
    static let players = "Players"
    static let countries = "Countries"
    
    //user defualt keys
    static let userDefaultsIsFirstTimeUserKey = "isFirstTimeUser"
    
    
    
    
    
    
    
    static let onboardingSlide = [
        OnboardingSlide(
            titleWhite: L10n.Onboarding.Slide1.titleWhite,
            titlePrimary: L10n.Onboarding.Slide1.titlePrimary,
            description: L10n.Onboarding.Slide1.description,
            image: "onBoarding_1",
            currentPage: 0),
        OnboardingSlide(
            titleWhite: L10n.Onboarding.Slide2.titleWhite,
            titlePrimary: L10n.Onboarding.Slide2.titlePrimary,
            description: L10n.Onboarding.Slide2.description,
            image: "onBoarding_2",
            currentPage: 1),
        OnboardingSlide(
            titleWhite: L10n.Onboarding.Slide3.titleWhite,
            titlePrimary: L10n.Onboarding.Slide3.titlePrimary,
            description: L10n.Onboarding.Slide3.description,
            image: "onBoarding_3",
            currentPage: 2)
    ]
}
