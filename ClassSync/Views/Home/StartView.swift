import SwiftUI
import CoreData

struct StartView: View {
    @StateObject private var showingModel = ShowingViewModel()
    
    var body: some View {
        ZStack {
            Background()
            VStack {
                // ページタイトル
                PageTitle

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
                
                CreateButton()

                Spacer()
            }
        }
        .fullScreenCover(isPresented: $showingModel.isShowingTRView) {
            TableRegistrationView()
        }
    }
    
    @ViewBuilder
    private func CreateButton() -> some View {
        Button {
            showingModel.isShowingTRView.toggle()
        } label: {
            Image(systemName: "plus.app.fill")
                .resizable()
                .frame(width: 50, height: 50)
                .font(.title)
                .foregroundColor(Color.black)
        }
    }
}

extension StartView {
    private var PageTitle: some View {
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
    }
}

#Preview {
    StartView()
}
