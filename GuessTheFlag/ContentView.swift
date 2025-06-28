//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Deepak Kumar Behera on 18/05/25.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = [
        "Andorra", "UnitedArabEmirates", "Afghanistan", "AntiguaandBarbuda", "Anguilla", "Albania", "Armenia", "Angola",
        "Antarctica", "Argentina", "AmericanSamoa", "Austria", "Australia", "Aruba", "AlandIslands", "Azerbaijan",
        "BosniaandHerzegovina", "Barbados", "Bangladesh", "Belgium", "BurkinaFaso", "Bulgaria", "Bahrain", "Burundi", "Benin",
        "SaintBarthelemy", "Bermuda", "BruneiDarussalam", "BoliviaPlurinationalStateof", "BritishIndianOceanTerritory", "CaribbeanNetherlands", "Brazil",
        "Bahamas", "Bhutan", "BouvetIsland", "Botswana", "Belarus", "Belize", "Canada", "CocosIslands",
        "Congo", "CentralAfricanRepublic", "RepublicoftheCongo", "Switzerland", "CotedIvoire",
        "CookIslands", "Chile", "Cameroon", "China", "Colombia", "CostaRica", "Cuba", "CapeVerde", "Curacao",
        "ChristmasIsland", "Cyprus", "CzechRepublic", "Germany", "Djibouti", "Denmark", "Dominica", "DominicanRepublic",
        "Algeria", "Ecuador", "Estonia", "Egypt", "WesternSahara", "Eritrea", "Spain", "Ethiopia", "Europe", "Finland",
        "Fiji", "FalklandIslands", "MicronesiaFederatedStatesof", "FaroeIslands", "France", "Gabon", "England",
        "NorthernIreland", "Scotland", "Wales", "NorthernMarianaIslands", "UK", "Grenada", "Georgia", "FrenchGuiana", "Guernsey", "Ghana",
        "Gibraltar", "Greenland", "Gambia", "Guinea", "Guadeloupe", "EquatorialGuinea", "Greece",
        "SouthGeorgia", "Guatemala", "Guam", "GuineaBissau", "Guyana", "HongKong",
        "HeardIslandandMcDonaldIslands", "Honduras", "Croatia", "Haiti", "Hungary", "Indonesia", "Ireland", "Israel",
        "IsleofMan", "India", "BritishIndianOceanTerritory", "Iraq", "Iran", "Iceland", "Italy", "Jersey", "Jamaica",
        "Jordan", "Japan", "Kenya", "Kyrgyzstan", "Cambodia", "Kiribati", "Comoros", "SaintKittsandNevis",
        "HolySee", "NorthKorea", "SouthKorea",  "Kuwait", "CaymanIslands", "Kazakhstan",
        "Laos", "Lebanon", "SaintLucia", "Liechtenstein", "SriLanka", "Liberia", "Lesotho", "Lithuania", "Luxembourg",
        "Latvia", "Libya", "Morocco", "Monaco", "Moldova", "Montenegro", "SaintMartin", "Madagascar", "MarshallIslands",
        "NorthMacedonia", "Mali", "Myanmar", "Mongolia", "Macao", "NorthernMarianaIslands", "Martinique", "Mauritania",
        "Montserrat", "Malta", "Mauritius", "Maldives", "Malawi", "Mexico", "Malaysia", "Mozambique", "Namibia",
        "NewCaledonia", "Niger", "NorfolkIsland", "Nigeria", "Nicaragua", "Netherlands", "Norway", "Nepal", "Nauru",
        "Niue", "NewZealand", "Oman", "Panama", "Peru", "FrenchPolynesia", "PapuaNewGuinea", "Philippines", "Pakistan",
        "Poland", "SaintPierreandMiquelon", "Pitcairn", "PuertoRico", "Palestine", "Portugal", "Palau", "Paraguay", "Qatar",
        "Reunion", "Romania", "Serbia", "Russia", "Rwanda", "SaudiArabia", "SolomonIslands", "Seychelles",
        "Sudan", "Sweden", "Singapore", "SaintHelenaAscensionandTristandaCunha", "Slovenia", "Svalbard",
        "Slovakia", "SierraLeone", "SanMarino", "Senegal", "Somalia", "Suriname", "SouthSudan", "SaoTomeandPrincipe",
        "ElSalvador", "SintMaarten", "Syria", "Swaziland", "Turks", "Chad",
        "FrenchSouthernTerritories", "Togo", "Thailand", "Tajikistan", "Tokelau", "TimorLeste", "Turkmenistan", "Tunisia",
        "Tonga", "Turkey", "Trinidad", "Tuvalu", "Taiwan", "Tanzania", "Ukraine", "Uganda",
        "USMinorOutlyingIslands", "US", "Uruguay", "Uzbekistan", "HolySee", "SaintVincentandtheGrenadines",
        "Venezuela", "VirginIslandsBritish", "VirginIslandsUS", "Vietnam", "Vanuatu", "WallisandFutunaIslands", "Samoa",
        "Kosovo", "Yemen", "Mayotte", "SouthAfrica", "Zambia", "Zimbabwe"
    ].shuffled()

    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var score = 0
    @State private var message = ""
    @State private var correctorNot = false
    @State private var gaveAnswer = false

    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        gaveAnswer = false
    }

    func checkAnswer(_ number: Int, correct: Int) {
        if number == correct {
            score += 1
            correctorNot = true
        } else {
            message = countries[correct]
            correctorNot = false

            // Show correct answer for 2 seconds, then go to next
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                askQuestion()
            }
        }
        gaveAnswer = true
    }

    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: .pink, location: 0.40),
                .init(color: .indigo, location: 0.40)
            ], center: .top, startRadius: 200, endRadius: 700)
            .ignoresSafeArea()

            VStack(spacing: 30) {
                Text("Guess the Flag")
                    .font(.largeTitle.weight(.bold))
                    .foregroundStyle(.white)

                if !gaveAnswer {
                    VStack(spacing: 20) {
                        VStack {
                            Text("Tap the flag of")
                                .foregroundStyle(.white)
                                .font(.subheadline.weight(.heavy))
                            Text(countries[correctAnswer])
                                .foregroundStyle(.white)
                                .font(.largeTitle.weight(.semibold))
                        }

                        ForEach(0..<3) { num in
                            Button {
                                checkAnswer(num, correct: correctAnswer)
                            } label: {
                                FlagImage(imageName: countries[num])
                            }
                        }

                        Text("Score: \(score)").scoreFont()
                            
                    }
                } else {
                    if correctorNot {
                        Button("Correct! Next", role: .destructive) {
                            askQuestion()
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(.mint)
                    } else {
                        VStack(spacing: 20) {
                            Text("Wrong! That was not the correct flag.")
                                .font(.title2.bold())
                                .foregroundColor(.white)
                            Text("Correct answer:")
                                .foregroundColor(.white)
                            Image(message)
                                .resizable()
                                .frame(width: 150, height: 80)
                                .clipShape(.buttonBorder)
                                .shadow(radius: 10)
                        }
                    }
                }
            }
            .padding()
        }
    }
}
struct FlagImage: View {
    var imageName : String
    var body: some View {
        Image(imageName)
            .resizable()
            .frame(width: 150, height: 80)
            .clipShape(.buttonBorder)
            .shadow(radius: 20)
    }
}

struct ScoreFont: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundStyle(.orange)
            .font(.title.bold())
            .padding(.top, 30)
    }
}

extension View {
    func scoreFont() ->  some View {
        modifier(ScoreFont())
    }
}

#Preview {
    ContentView()
}
