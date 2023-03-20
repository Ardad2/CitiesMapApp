//
//  DetailView.swift
//  CSE335Lab5
//
//  Created by Arjun Dadhwal on 3/10/23.
//

import Foundation

import CoreLocation
import MapKit

import SwiftUI

struct Location: Identifiable {
    let id = UUID()
    var name: String
    var coordinate: CLLocationCoordinate2D
}


struct DetailView: View {
    
    var picture:String
    var cityName:String
    var description:String
    
    @State private var searchText = ""
    
   // var location:CLLocation
    
    private static let defaultLocation = CLLocationCoordinate2D(
        latitude: 33.4255,
        longitude: -111.9400
    )
    
    @State private var region = MKCoordinateRegion(
        center: defaultLocation,
        span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
        )
    
    @State private var markers = [
        Location(name: "cityName", coordinate: defaultLocation)
    ]
    
    
    @State private var makers2 = [
    ]
    
    @State var location: CLLocationCoordinate2D?

    
    
    var body: some View {
        ZStack(alignment: .bottom)
        {
            Map(coordinateRegion: $region, interactionModes: .all, annotationItems: markers) {
                location in MapAnnotation(coordinate: location.coordinate)
                {
                    
                        Text("\(location.name)")
                        .fontWeight(.bold)
                        .font(.title)
                        .foregroundColor(.black)
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.black
                                        , lineWidth: 3)
                        )
                        Text(String(location.coordinate.latitude) + "," + String(location.coordinate.longitude))
                    

                }

                
            }
            

        }            .onAppear{self.getLocation(from: cityName)
            {coordinates in
                print(coordinates)
                self.location = coordinates}
            
        }
        
        searchBar
        
    

    }
    
    func getLocation(from address: String, completion: @escaping (_ location:CLLocationCoordinate2D?) -> Void) {
        let geocoder = CLGeocoder();
        
        geocoder.geocodeAddressString(address) { (placemarks, error) in guard let placemarks = placemarks,
            
            let location = placemarks.first?.location?.coordinate
            else {
                completion(nil);
                return
            }

                    region.center = location
            markers[0] = Location(name: cityName, coordinate: location);


        }
    }
    
    private var searchBar: some View {
        HStack {
            Button {
                let searchRequest = MKLocalSearch.Request()
                searchRequest.naturalLanguageQuery = searchText
                searchRequest.region = region
                
                MKLocalSearch(request: searchRequest).start { response, error in
                    guard let response = response else {
                        print("Error: \(error?.localizedDescription ?? "Unknown error").")
                        return
                    }
                    region = response.boundingRegion
                    
                    var markers1 = response.mapItems.map { item in
                        Location(
                            
                            name: item.name ?? "Match",
                            coordinate: item.placemark.coordinate
                        )
                        
                    }
                    markers.append(contentsOf: markers1)
                }
            } label: {
                Image(systemName: "location.magnifyingglass")
                    .resizable()
                    .foregroundColor(.accentColor)
                    .frame(width: 24, height: 24)
                    .padding(.trailing, 12)
            }
            TextField("Search nearby", text: $searchText)
        }
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 8)
                .foregroundColor(.white)
        }
        .padding()
    }
    
    
    
    
    
    
    
    /*struct DetailView_Previews: PreviewProvider {
     static var previews: some View {
     DetailView(picture:"Hi", name:"Hi", description:"A")
     }
     }*/
}
