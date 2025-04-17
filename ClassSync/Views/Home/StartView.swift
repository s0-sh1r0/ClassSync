import SwiftUI

struct StartView: View {
    
    @State private var isShowingTRView: Bool = false // TableRegistrationView
    
    var body: some View {
        ZStack {
            Background()
            VStack {
                HStack {
                    Image("ClassSync-image")
                        .resizable()
                        .frame(width: 70, height: 70)
                    
                    Spacer()
                    
                    Text("ClassSync")
                        .font(.title)
                        .bold()
                        .foregroundColor(Color.white)
                    
                    Spacer()
                    
                    Text("")
                        .frame(width: 70)
                }

                Spacer()
                
                Text("時間割が登録されていません")
                    .font(.title)
                    .foregroundColor(Color.black)
                Text("時間割を作成してください")
                    .font(.headline)
                    .foregroundColor(Color.gray)
                
                Spacer()
                
                Text("時間割を作成")
                    .foregroundColor(.black)
                
                Button {
                    isShowingTRView.toggle()
                } label: {
                    Image(systemName: "plus.app.fill")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .font(.title)
                        .foregroundColor(Color.black)
                }

                Spacer()
            }
        }
        .fullScreenCover(isPresented: $isShowingTRView) {
            TableRegistrationView()
        }
    }
}

#Preview {
    StartView()
}
