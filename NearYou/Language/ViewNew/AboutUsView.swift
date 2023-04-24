import SwiftUI

struct AboutUsView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("About-Us")
                    .font(.largeTitle)
                    .bold()
                    .padding(.top, 70)
                
                Image("finland")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 200, height: 200)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 4))
                    .shadow(radius: 7)
                
                VStack(alignment: .center, spacing: 10) {
                    Text("We are a group of students who are passionate about traveling and exploring different cultures. Our love for Finland inspired us to create this travel app called 'Near You' that will help you plan your dream trip to this beautiful country.")
                        .font(.body)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                    
                    Text("Our app provides you with insider tips on the best places to visit, eat, and stay, as well as practical information on directions, weather, and local customs. We have also included various categories in search area for different types of travelers, whether you're looking for accomodation, events, attraction, or rental services.")
                        .font(.body)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                }
                .padding(.vertical)
                .background(Color.secondary.opacity(0.2))
                .cornerRadius(10)
                
                VStack(spacing: 10) {
                    Text("Contact Us")
                        .font(.title)
                        .bold()
                    
                    Text("If you have any questions or feedback about our app, please don't hesitate to contact us:")
                        .font(.body)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                        .fixedSize(horizontal: false, vertical: true)
                    
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
                .padding(.vertical)
                .background(Color.secondary.opacity(0.2))
                .cornerRadius(10)
                
                Text("We hope our app will inspire you to discover the beauty of Finland and create unforgettable memories. Happy travels!")
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                    .padding(.top, 20)
                
                Image("AppIconLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .padding(.bottom, 30)
            }
            .padding()
            .frame(maxWidth: 500)
        }
        .edgesIgnoringSafeArea(.all)
    }
}
