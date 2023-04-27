import SwiftUI

struct AboutUsView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 20) {
                Text("About-Us")
                    .font(.largeTitle)
                    .bold()
                    .padding(.top, 70)
                
                Image("finland")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .padding(.top, 5)
                
                Text("We are a group of students who are passionate about traveling and exploring different cultures. Our love for Finland inspired us to create this travel app that will help you plan your dream trip to this beautiful country.")
                    .font(.body)
                    .multilineTextAlignment(.center)
                
                Image("team")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(10)
                    .padding(.top, 20)
                
                Text("Our app provides you with insider tips on the best places to visit, eat, and stay, as well as practical information on transportation, weather, and local customs. We have also included recommended itineraries for different types of travelers, whether you're looking for adventure, culture, nature, or relaxation.")
                    .font(.body)
                    .multilineTextAlignment(.center)
                
                VStack(spacing: 5) {
                    Text("Contact Us")
                        .font(.title2)
                        .bold()
                    
                    Text("If you have any questions or feedback about our app, please don't hesitate to contact us:")
                        .font(.body)
                        .multilineTextAlignment(.center)
                    
                    Button(action: {
                        let email = "Bibek.Shrestha@metropolia.fi, LaurentiuSebastian.Hategan@metropolia.fi, Suraj.RanaBhat@metropolia.fi, Shilpa.Yadav@metropolia.fi"
                        if let url = URL(string: "mailto:\(email)") {
                            UIApplication.shared.open(url)
                        }
                    }) {
                        VStack(spacing: 5) {
                                Text("Bibek.Shrestha@metropolia.fi")
                                    .underline()
                                Text("LaurentiuSebastian.Hategan@metropolia.fi")
                                    .underline()
                                Text("Suraj.RanaBhat@metropolia.fi")
                                    .underline()
                                Text("Shilpa.Yadav@metropolia.fi")
                                    .underline()
                            }
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                
                Text("We hope our app will inspire you to discover the beauty of Finland and create unforgettable memories. Happy travels!")
                    .font(.body)
                    .multilineTextAlignment(.center)
            }
            .padding()
        }
        .edgesIgnoringSafeArea(.all)
    }
}
