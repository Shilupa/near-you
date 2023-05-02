import SwiftUI

struct AboutUsView: View {
    var body: some View {
        // Use a ScrollView to make the content scrollable
        ScrollView {
            VStack(spacing: 20) {
                // Add a title to the view
                Text("ABOUT US")
                    .font(Font.custom("Poppins-Bold", size: 27))
                    .padding(.top, 70)
                
                // Add an image to the view
                Image("finland")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 200, height: 200)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color("ThemeColour"), lineWidth: 4))
                    .shadow(radius: 7)
                
                // Add a description of the app and its features
                VStack(alignment: .center, spacing: 10) {
                    Text("We are a group of students who are passionate about traveling and exploring different cultures. Our love for Finland inspired us to create this travel app called 'Near You' that will help you plan your dream trip to this beautiful country.")
                        .font(Font.custom("Poppins-Regular", size: 16))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                    
                    Text("Our app provides you with insider tips on the best places to visit, eat, and stay, as well as practical information on directions, weather, and local customs. We have also included various categories in search area for different types of travelers, whether you're looking for accomodation, events, attraction, or rental services.")
                        .font(Font.custom("Poppins-Regular", size: 16))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                }
                .padding(.vertical)
                .background(Color.secondary.opacity(0.2))
                .cornerRadius(10)
                
                // Add a section for contacting the app developers or contact person
                VStack(spacing: 10) {
                    Text("Contact Us")
                        .font(Font.custom("Poppins-Bold", size: 27))
                    
                    Text("If you have any questions or feedback about our app, please don't hesitate to contact us:")
                        .font(Font.custom("Poppins-Regular", size: 16))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                        .fixedSize(horizontal: false, vertical: true)
                    
                    //button of email addresses and on click opens a url
                    Button(action: {
                        let email = "Bibek.Shrestha@metropolia.fi, LaurentiuSebastian.Hategan@metropolia.fi, Suraj.RanaBhat@metropolia.fi, Shilpa.Yadav@metropolia.fi"
                        if let url = URL(string: "mailto:\(email)") {
                            UIApplication.shared.open(url)
                        }
                    }) {
                        //VStack of  email addresses
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
                .font(Font.custom("Poppins-LightItalic", size: 16))
                
                // Add a closing message to the view
                Text("We hope our app will inspire you to discover the beauty of Finland and create unforgettable memories. Happy travels!")
                    .font(Font.custom("Poppins-Regular", size: 16))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                    .padding(.top, 20)
                
                //Addition of app's own logo
                Image("AppIconLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .padding(.bottom, 30)
            }
            .padding()
            .frame(maxWidth: 500)
        }
        // Make the color fill the entire screen, ignoring the safe area insets
        .edgesIgnoringSafeArea(.all)
    }
    
    struct AboutUsView_Previews: PreviewProvider {
        static var previews: some View {
            AboutUsView().environmentObject(GlobalVarsViewModel())
        }
    }
}
