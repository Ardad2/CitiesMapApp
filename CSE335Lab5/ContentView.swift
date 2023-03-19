//
//  ContentView.swift
//  CSE335Lab5
//
//  Created by Arjun Dadhwal on 3/10/23.
//

import SwiftUI

struct ContentView: View {

    @State var cityData = [
        city(name:"New Delhi", picture: "NewDelhiPicture", description: "The capital city of India."),
        city(name:"Tempe", picture: "TempePicture", description: "Located near the capital city, Phoenix, of Arizona, United States"),
        city(name:"Barcelona", picture: "BarcelonaPicture", description: "A city in Spain."),
        city(name:"Paris", picture: "ParisPicture", description:"Capital of France."),
        city(name:"Cape Town", picture: "CapeTownPicture", description:"A capital of South Africa.")
    ]

    
    @State var toInsertView = false
    @State var toDeleteView = false
    
    @State private var newCityName = ""
    @State private var newCityDescription = ""
    @State  var type = ""
    @State var sectionType = ["List of Cities visited"]
    
    @State var invalidString = false;
    

    var body: some View {
        NavigationView
        {
    
            List {
                    ForEach(cityData) { datum in
                        NavigationLink(destination: DetailView(picture: datum.picture, cityName: datum.name, description: datum.description))
                            {
                                HStack {
                                    Text(datum.name)
                                    Spacer()
                                    Image("\(datum.picture)").resizable().aspectRatio(contentMode: .fit).frame(width: 75, height: 75 )
                                }
                            }
                    }.onDelete(perform: {IndexSet in
                        cityData.remove(atOffsets: IndexSet)
                    })
                    

            }.navigationBarTitleDisplayMode(.inline)
                .navigationTitle("Cities Visited")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                         
                            toInsertView = true
                            
                        } label: {
                            Image(systemName: "plus")
                        }
                    }
                }.alert("Insert", isPresented: $toInsertView, actions: {

                        TextField("Name:", text: $newCityName)
                        TextField("Description: ", text: $newCityDescription)

                        Button("Insert", action: {
                            /*
                            var validString = false;
                            
                            for char in newCityName {
                                if (char != " ")
                                {
                                    validString = true;
                                }
                            }
                             
                            
                            if (validString == false || newCityName == "")
                            {
                                invalidString = true;
                            }
                            else
                            {*/
                                let c = city(name: newCityName, picture: "DefaultPicture", description: newCityDescription)
                                cityData.append(c)
                                toInsertView = false
                           // }
                        })
                    
                    Button("Cancel", role: .cancel, action: {
                        toInsertView = false
                    })
                }, message: {
                    Text("Enter the details of the city you want to add")
                })
                .alert("Invalid", isPresented: $invalidString, actions: {
                    
                    Button("Okay", role: .cancel, action: {
                        toInsertView = false;
                        invalidString = false
                    })
                }, message: {
                    Text("The city name can not be blank!")
                })
        }
        
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
