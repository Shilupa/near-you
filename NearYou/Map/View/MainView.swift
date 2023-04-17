//
////  MainView.swift
////  NearYou
////
////  Created by iosdev on 15.4.2023.
//
//
//import SwiftUI
//import CoreLocation
//
//struct MainView: View {
//    @StateObject var mapData = LocationsViewModel()
//    @State private var currentIndex = 0
//    @StateObject var vm = DataViewModel()
//    // @State private var currentData :  ProductResponse.Product
//
//
//
//    //location manager
//    @State var locationManager = CLLocationManager()
//    var body: some View {
//        ZStack {
//            LocationsView()
//                .environmentObject(mapData)
//                .ignoresSafeArea()
//
//            VStack{
//                Spacer()
//
//                HStack{
//
//                    ZStack {
//                        if vm.isRefreshing {
//                            ProgressView()
//                        } else {
//                            if let products = vm.allData?.data.product {
//
//                                ForEach(products, id: \.id) { product in
//                                    Text(product.id!)
//                                }
//
//
//                                MapCardView(data: products[currentIndex])
//                                    .gesture(
//                                        DragGesture(minimumDistance: 20)
//                                            .onEnded { value in
//                                                if value.translation.width > 0 {
//                                                    currentIndex = max(currentIndex - 1, 0)
//                                                } else {
//                                                    currentIndex = min(currentIndex + 1, products.count - 1)
//                                                }
//                                            }
//                                    )
//                            } else {
//                                Text("No products found.")
//                            }
//                        }
//                    }
//                    .onAppear(perform: vm.getData)
//                    .alert(isPresented: $vm.hasError, error: vm.error) {
//                        Button(action: vm.getData) {
//                            Text("Retry")
//                        }
//                    }
//
//
//                    VStack{
//                        Button(action: mapData.focusLocation, label: {
//                            Image(systemName: "location.fill")
//                                .font(.title2)
//                                .padding(10)
//                                .background(Color.primary)
//                                .clipShape(Circle())
//                        })
//
//                        Button(action: mapData.updateMapType, label: {
//                            Image(systemName: mapData.mapType == .standard ? "network" : "map")
//                                .font(.title2)
//                                .padding(10)
//                                .background(Color.primary)
//                                .clipShape(Circle())
//                        })
//
//                    }
//                    .frame(maxWidth: .infinity, alignment:  .trailing)
//                    .padding()
//                }
//                .padding()
//            }
//        }
//        .onAppear(perform: {
//            // setting delegate
//            locationManager.delegate = mapData
//            locationManager.requestWhenInUseAuthorization()
//        })
//        .alert(isPresented: $mapData.permissionDenied,
//               content: {
//            Alert(title: Text("Permission Denied"),
//                  message: Text("Please enable permission"),
//                  dismissButton: .default(Text("Go to Settings"),
//                                          action: {
//                //Redirect to settings
//                UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
//
//            }))
//        })
//    }
//}
//
//struct MainView_Previews: PreviewProvider {
//    static var previews: some View {
//        MainView()
//    }
//}
