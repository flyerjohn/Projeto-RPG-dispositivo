//
//  ContentView.swift
//  Project C
//
//  Created by João Medeiros on 05/04/22.
//

import SwiftUI

struct ContentView: View {
    init() {
        let descriptor = UIFontDescriptor.preferredFontDescriptor(withTextStyle: .largeTitle)
            .withDesign(.rounded)!
        let font = UIFont.init(descriptor: descriptor.withSymbolicTraits(UIFontDescriptor.SymbolicTraits.traitBold)!, size: 40)
        UINavigationBar.appearance().largeTitleTextAttributes = [.font : font]
    }
    
    @State var hasPressed = false
    @State var isCollapsed = false
    @State var isToggleActivated = false
    @State var isMotorActivated = false
    @State var intensity = 30.0
    @State var isEditing = false
    
    var body: some View {
        ZStack {
            NavigationView {
                ScrollView {
                    FeedList(isCollapsed: $isCollapsed)
                        .navigationTitle(Text("Project RPG").font(.system(.title, design: .rounded)))
                        .navigationBarItems(trailing: Button(action: { withAnimation {
                            self.hasPressed.toggle()
                        }}) {
                            ZStack {
                                Text(.init(systemName: "dot.radiowaves.left.and.right")).foregroundColor(.white).font(.system(size: 20)
                                    
                                )
                                Circle()
                                    .frame(width: 50, height: 50)
                                    .foregroundColor(.black)
                                    .zIndex(-2)
                            }
                            .position(x: 20, y: 10)
                        
                        })
                        .sheet(isPresented: $isCollapsed) {
                            NavigationView {
                                Form {
                                    Section(header: Text("Configurações do dispositivo")){
                                        Toggle("Ativar", isOn: $isToggleActivated)
                                        Toggle("Rotor tátil 1", isOn: $isMotorActivated)
                                        Toggle("Rotor tátil 2", isOn: $isMotorActivated)
                                        Toggle("Rotor tátil 3", isOn: $isMotorActivated)
                                        Toggle("Rotor tátil 4", isOn: $isMotorActivated)
                                        Text("Intensidade")
                                        Slider(
                                            value: $intensity,
                                            in: 0...100,
                                            onEditingChanged: { editing in
                                                isEditing = editing
                                            }
                                        )
                                    }
                                    Section(header: Text("Mídia")){
                                        Button("Selecionar mídia", action: {
                                            //pass
                                        })
                                    }
                                }
                                .navigationTitle("Nome da sala")
                            }
                            
                        }
                }
            }
            if (hasPressed) {
                ZStack {
                    ProgressView("Carregando")
                        .zIndex(4)
                        .font(.title)
                    Button(action: { withAnimation {self.hasPressed.toggle()} }) {
                        ZStack {
                            Text(.init(systemName: "xmark.circle.fill")).foregroundColor(.white).font(.system(size: 50)
                                
                            )
                            
                        }
                    }
                    .zIndex(5)
                    .position(x: 345, y: 10)
                    VStack {
                            
                            Text(.init(systemName: "bonjour")).font(.system(size: 60)).foregroundColor(.white)
                            Spacer()
                            Text("Conexão Bluetooth")
                                .foregroundColor(.white)
                                .bold()
                                .font(.system(size: 40))
                            Text("Buscando por dispositivos próximos...").foregroundColor(.white)
                        }
                        .frame(maxWidth: .infinity)
                        .frame(maxHeight: .infinity)
                        .background(.blue)
                        .zIndex(1)
                        
                }
                
            }
                
                
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
// TODO: change from prototype to actual thing
struct FeedList: View {
    @Binding var isCollapsed: Bool
    
    var body: some View {
        
        let columns = [
            GridItem(.adaptive(minimum: 130), spacing: 35)
        ]
        
        LazyVGrid(columns: columns) {
            ForEach((1...10), id:\.self) { prox in
                ZStack {
                    RoundedRectangle(cornerRadius: 36, style: .continuous)
                        .fill(Color.black)
                    .frame(width: 360, height: 220)
                    
                    Text(.init(systemName: "play.rectangle.on.rectangle.fill"))
                        .foregroundColor(.white)
                        .bold()
                        .font(.system(size: 32))
                        .position(x:50, y:40)
                    Text("Nome da sala")
                        .foregroundColor(.white)
                        .bold()
                        .font(.system(size: 22))
                        .position(x:85, y:70)
                }
                .onTapGesture {
                    self.isCollapsed.toggle()
                }
                    
            }
            
        }
        .padding(.horizontal, 60)
        .padding(.vertical, 30)
        
            
    }
}
