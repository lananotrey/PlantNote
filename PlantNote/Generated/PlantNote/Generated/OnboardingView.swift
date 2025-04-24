import SwiftUI

struct OnboardingView: View {
    @AppStorage("hasCompletedOnboarding") private var hasCompletedOnboarding = false
    @State private var currentPage = 0
    
    let pages = [
        OnboardingPage(
            title: "Welcome to Plant Note",
            description: "Your personal assistant for taking care of your plants",
            imageName: "leaf.fill"
        ),
        OnboardingPage(
            title: "Track Your Plants",
            description: "Keep detailed records of watering, fertilizing, and repotting schedules",
            imageName: "calendar"
        ),
        OnboardingPage(
            title: "Never Forget",
            description: "Get reminders when it's time to water or care for your plants",
            imageName: "bell.fill"
        )
    ]
    
    var body: some View {
        ZStack {
            Color("BackgroundColor")
                .ignoresSafeArea()
            
            VStack {
                TabView(selection: $currentPage) {
                    ForEach(0..<pages.count, id: \.self) { index in
                        OnboardingPageView(page: pages[index])
                            .tag(index)
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
                
                Button {
                    withAnimation {
                        hasCompletedOnboarding = true
                    }
                } label: {
                    Text(currentPage == pages.count - 1 ? "Get Started" : "Skip")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green)
                        .cornerRadius(10)
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 30)
            }
        }
    }
}

struct OnboardingPage {
    let title: String
    let description: String
    let imageName: String
}

struct OnboardingPageView: View {
    let page: OnboardingPage
    
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: page.imageName)
                .font(.system(size: 80))
                .foregroundColor(.green)
            
            Text(page.title)
                .font(.title)
                .bold()
            
            Text(page.description)
                .font(.body)
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
                .padding(.horizontal)
        }
        .padding()
    }
}