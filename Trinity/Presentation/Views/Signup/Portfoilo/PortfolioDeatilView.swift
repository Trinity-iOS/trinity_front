//
//  PortfolioDeatilView.swift
//  Trinity
//
//  Created by Park Seyoung on 3/16/25.
//

import SwiftUI

struct PortfolioDeatilView: View {
    @StateObject private var viewModel: PortfolioDetailViewModel
    
    init(viewModel: PortfolioDetailViewModel) {
            _viewModel = StateObject(wrappedValue: viewModel)
        }
    
    var body: some View {
        ScrollView {
            ZStack(alignment: .top) {
                VStack {
                    Spacer()
                        .frame(height: 150)
                    
                    backgroundView
                }
                
                VStack {
                    headerView
                    title
                }
            }
            .background(Color(.IFBlackPrimary))
        }
    }
    
    private var headerView: some View {
        ZStack {
            HStack {
                Button(action: {}){
                    Image("backButton")
                        .resizable()
                        .frame(width: 24, height: 24)
                }
                .padding(.leading, 30)
                
                Spacer()
            }
            
            HStack {
                Spacer()
                
                ProgressView(value: 0.66)
                    .progressViewStyle(LinearProgressViewStyle())
                    .tint(Color(UIColor.IFIvory2))
                    .frame(width: 120)
                
                Spacer()
            }
        }
    }
    
    private var title: some View {
        HStack {
            Spacer()
            
            Text("WRITE\nTHE DESCRIPTION")
                .font(Font(UIFont(name: "Moderniz", size: 20)!))
                .padding(.trailing, 24)
                .foregroundStyle(Color(UIColor.IFIvory))
                .frame(alignment: .trailing)
        }
        .padding(.top, 44)
    }
    
    private var backgroundView: some View {
        VStack{
            Spacer()
            
            Rectangle()
                .fill(Color(UIColor.IFIvory))
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.04)
                .clipShape(RoundedCornerShape(radius: 300, corners: [.topLeft]))
        }
    }
    
    private var content: some View {
        VStack(alignment: .center) {
            Text("Please write down\nthe description of your work.")
                .foregroundStyle(Color(.IFBorderDef))
                .font(Font(UIFont(name: "Pretendard-Medium", size: 14)!))
                .padding(.top, 64)
            
            if viewModel.isImage!, let uiImage = viewModel.image {
                Image(uiImage: uiImage) // ✅ SwiftUI에서 UIImage 사용 가능!
                    .resizable()
                    .scaledToFill()
                    .frame(height: 300)
                    .clipped()
            } else {
                Text("여기에는 음악;;")
            }
            
            
            HStack {
                Text("Title")
                    .foregroundStyle(Color(.IFBorderAct))
                    .font(Font(UIFont(name: "Pretendard-Regular", size: 14)!))
                    .padding(.leading, 24)
                
                Spacer()
            }
            .padding(.top, 24)
            
            ZStack {
                Rectangle()
                    .fill(.clear)
                    .stroke(Color(.IFTextInfo))
                
                TextField("Ex. Forest", text: $viewModel.title)
                    .font(Font(UIFont(name: "Pretendard-Regular" ,size: 16)!))
                    .foregroundStyle(Color(.IFTextDef))
                    .padding(.top, 8)
            }
            .padding(.horizontal, 24)
            .frame(height: 52)
            
            HStack {
                Text("Content")
                    .foregroundStyle(Color(.IFBorderAct))
                    .font(Font(UIFont(name: "Pretendard-Regular", size: 14)!))
                    .padding(.leading, 24)
                
                Spacer()
            }
            .padding(.top, 16)
            
            ZStack {
                Rectangle()
                    .fill(.clear)
                    .stroke(Color(.IFTextInfo))
                
                TextEditor(text: $viewModel.content)
                    .font(Font(UIFont(name: "Pretendard-Regular" ,size:16)!))
                    .foregroundStyle(Color(.IFTextDef))
                    .padding(.top, 8)
            }
            .padding(.horizontal, 24)
            .frame(height: 80)
            
            Spacer()
            
            Button(action: {viewModel.saveTitleContents()}
            ) {
                ZStack {
                    Rectangle()
                        .fill(viewModel.isSaveEnabled ? Color(.IFIvory2) : Color(.IFBlackSecondary))
                    Text("Upload")
                        .foregroundStyle(viewModel.isSaveEnabled ? Color(.IFTextDis) : Color(.IFIvory))
                        .font(Font(UIFont(name: "Pretendard-Medium", size: 16)!))
                }
            }
            .padding(.bottom, 60)
        }
    }
}

struct RoundedCornerShape: Shape {
    var radius: CGFloat
    var corners: UIRectCorner
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}
