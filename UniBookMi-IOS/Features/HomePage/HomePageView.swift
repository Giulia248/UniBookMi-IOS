//
//  HomePageView.swift
//  UniBookMi-IOS
//
//  Created by giulia.floris on 09/04/24.
//

import AVKit
import MapKit
import SwiftUI
import ProgressHUD
import FirebaseCore

struct HomePageView: View {

    @State var viewModel: HomePageViewModel

    @State var allowButton = true
    @State var errorLogout = false
    @State var errorLogoutString = UniBookMiStrings.errore
    @State var location = MapCameraPosition.automatic
    @State var player: AVPlayer?

    var body: some View {

        GeometryReader { geometry in

            VStack{

                HStack {
                    Text(UniBookMiStrings.title)
                        .font(UniBookMiFont.shared.nunitMedium())
                        .foregroundStyle(LinearGradient(colors: [UniBookMiColors.shared.darkBlue2],
                                                        startPoint: .leading, endPoint: .trailing))
                        .tint(UniBookMiColors.shared.darkBlue2)
                    Text(UniBookMiStrings.homePage)
                        .font(UniBookMiFont.shared.nunitMedium())
                        .foregroundStyle(LinearGradient(colors: [Color(hex: "#7D7F7F")],
                                                        startPoint: .leading, endPoint: .trailing))
                }

                Image("logo", label: Text(""))
                    .resizable()
                    .padding()
                    .frame(width: geometry.size.width / 3.5, height: geometry.size.width / 3.5, alignment: .center)

                    ZStack (alignment: .leading) {
                        VideoPlayer(player: player)
                            .frame(width: geometry.size.width, height: 200)

                            .allowsHitTesting(false)
                            .opacity(0.6)

                        Text(UniBookMiStrings.welcome)
                            .font(UniBookMiFont.shared.nunitoBig())
                            .frame(width: geometry.size.width)
                            .foregroundStyle(LinearGradient(colors: [.white],
                                                            startPoint: .leading, endPoint: .trailing))
                            .lineLimit(3)
                            .padding(.leading, 1)


                        Text(UniBookMiStrings.welcome)
                            .font(UniBookMiFont.shared.nunitoBig())
                            .frame(width: geometry.size.width)
                            .lineLimit(3)


                    }

                Map(position: $location)
                    .frame(width: geometry.size.width, height: 200)
                    .allowsHitTesting(false)

                HStack {
                    UniBookMiButton(text: UniBookMiStrings.contacts, isEnabled: $allowButton) {

                    }

                    UniBookMiButton(text: UniBookMiStrings.news, isEnabled: $allowButton) {

                    }
                }



                // MARK: logout
                Spacer()

                UniBookMiButton(text: UniBookMiStrings.logout, isEnabled: $allowButton) {

                    viewModel.logout { error in
                        if let error {
                            errorLogout = true
                            errorLogoutString = error.localizedDescription

                        }

                    }
                }
                .alert("\(UniBookMiStrings.errore) \(errorLogoutString)", isPresented: $errorLogout) {
                    Button("OK", role: .cancel) {
                        errorLogout = false
                    }
                }


            }
            .task {
                await self.uiSetup()
            }

        }
    }

    /// change map location to "città studi"
    private func uiSetup() async{
        location = MapCameraPosition.region(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 45.478129, longitude: 9.227791), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)))

        guard let url = Bundle.main.url(forResource: "BookVideo", withExtension: "mp4") else { return }
        self.player = AVPlayer(url: url)
        self.player?.play()
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: nil, queue: .main) { _ in
            self.player?.seek(to: .zero)
            self.player?.play()
        }


    }
}
