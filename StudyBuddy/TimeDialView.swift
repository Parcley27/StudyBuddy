//
//  TimeDialView.swift
//  StudyBuddy
//
//  Created by Pierce Oxley on 23/8/24.
//

import SwiftUI

struct Subject: Identifiable, Hashable {
    var name: String = "Subject Name"
    var icon: String = "book"
    var colour: Color = .blue
    var id: UUID = UUID()
    
}

/* USE THIS FOR TIME DURATION
 // get ticks from start-end)/tickseperation then title from return
 func getTimeFromTicks(_ ticks: Int) -> (hours: Int, minutes: Int) {
     // Returns the greater of two values given
     let normalTicks = max(ticks, 1)
     
     var hours: Int = 0
     var minutes: Int = 0
     
     switch normalTicks {
     case 1 ... 4:
         // 5 minute intervals
         minutes = normalTicks * 5
         
     case 5:
         minutes = 30
         
     case 6 ... 7:
         // 30 minite intervals on top of 30 minutes
         minutes = ((normalTicks - 5) * 15) + 30
         
     case 8 ... 11:
         // 1 hour intervals on top of 1 hour
         minutes = ((normalTicks - 7) * 30) + 60
         
     case 12:
         minutes = 240
         
     default:
         // Will display as forever
         minutes = 300
         
     }
     
     // Hours from minutes
     hours = minutes / 60
     
     // Get remainder from minutes / 60
     minutes %= 60
     
     return (hours, minutes)
     
 }
 */

// Everything gets real funky at the bottom the circle
//I dunno why but it doesn't really matter that much ig
struct TimeDialView: View {
    init() {
        // Default to the first subject in the array
        _selectedSubject = State(initialValue: subjects[0])
        
        self.circleStartingPosition = 60
         
        let calculatedStartAngle = circleStartingPosition
        let calculatedEndAngle = circleStartingPosition + 180
        
        // Calculate start and end progress based on normalizedPosition
        let progressPerDegree = 1.0 / 360.0
        let calculatedEndProgress = Double(circleStartingPosition + 180) * progressPerDegree
        let calculatedStartProgress = Double((circleStartingPosition).truncatingRemainder(dividingBy: 360)) * progressPerDegree
        
        // Set the state variables with the calculated angles and progress
        _startAngle = State(initialValue: calculatedStartAngle)
        _startProgress = State(initialValue: calculatedStartProgress)
        
        _endAngle = State(initialValue: calculatedEndAngle)
        _endProgress = State(initialValue: calculatedEndProgress)
        
    }
    
    @Environment(\.colorScheme) var colorScheme
    
    var circleStartingPosition: Double
        
    @State var startAngle: Double// = 0
    @State var startProgress: CGFloat// = 0
    
    @State var endAngle: Double// = 90
    @State var endProgress: CGFloat// = 0.25
    
    let tickInterval = 10
    
    var subjects: [Subject] = [
        Subject(name: "English"),
        Subject(name: "Math", icon: "x.squareroot", colour: .red),
        Subject(name: "Science", icon: "atom", colour: .green),
        Subject(name: "Socials", icon: "person.2.wave.2", colour: .brown),
        Subject(name: "Astronomy", icon: "globe.desk", colour: .purple),
        Subject(name: "Health", icon: "heart", colour: .pink)
    ]
    
    @State private var selectedSubject: Subject
    
    func onDrag(value: DragGesture.Value, isStartSlider: Bool = false, buttonRadius: CGFloat = 15) {
        let vector = CGVector(dx: value.location.x, dy: value.location.y)
        
        let radians = atan2(vector.dy - buttonRadius, vector.dx - buttonRadius)
        
        var angle = radians * 180 / .pi
        
        if angle < 0 {
            angle += 360
            
        }
        
        var progress = angle / 360
        
        if isStartSlider {
            self.startAngle = angle
            self.startProgress = progress
            
        } else {
            angle = min(max(angle, (startAngle + Double(tickInterval * 2))), 300)
            progress = angle / 360
            
            self.endAngle = angle
            self.endProgress = progress
            
        }
    }
    
    func getTime(angle: Double) -> Date {
        // A bigger denominator makes a smaller range in time
        let progress = angle / 40
        
        let hours = Int(progress)
        // 60 / 12 == 5 minute intervals
        let remainder = (progress.truncatingRemainder(dividingBy: 1) * 12).rounded()
        
        var minutes = remainder * 5
        minutes = minutes > 55 ? 55 : minutes
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let calendar = Calendar.current
        let components = calendar.dateComponents([.month, .day, .year], from: Date())
        
        let rawDay = (components.day ?? 0)
        var day: Int = 0
        
        if angle == endAngle {
            day = rawDay + 1
            
        } else {
            day = (startAngle > endAngle) ? rawDay : rawDay + 1
           
        }
        
        if let date = formatter.date(from: "\(components.year ?? 0)-\(components.month ?? 0)-\(day) \(hours == 24 ? 0 : hours):\(Int(minutes)):00") {
            return date
        }
        
        return .init()
        
    }
    
    func getDuration() -> (Int, Int) {
        let calendar = Calendar.current
        
        let result = calendar.dateComponents([.hour, .minute], from: getTime(angle: startAngle), to: getTime(angle: endAngle))
        
        return (result.hour ?? 0, result.minute ?? 00)
        
    }
    
    var body: some View {
        //Text("Hello, TimeDial!")
        
        GeometryReader { proxy in
            let width = proxy.size.width
            
            VStack {
                Button {
                    print(startAngle)
                    print(startProgress)
                    print("")
                    print(endAngle)
                    print(endProgress)
                    
                } label: {
                    Label("Debug", systemImage: "book.pages")
                        .padding(.vertical, 5)
                        .padding(.horizontal, 10)
                        .background(.black.opacity(0.05), in: Capsule())
                    
                }
                
                Spacer()
                
                ZStack {
                    Circle()
                        .stroke(Color(.systemGray5), lineWidth: 60)
                    
                    let reverseRotation = (startProgress > endProgress) ? -Double((1 - startProgress) * 360) : 0
                    
                    Circle()
                        .trim(from: startProgress > endProgress ? 0 : startProgress, to: endProgress + (-reverseRotation / 360))
                        .stroke(selectedSubject.colour, style: StrokeStyle(lineWidth: 50, lineCap: .round, lineJoin: .round))
                        .rotationEffect(.init(degrees: 90))
                        .rotationEffect(.init(degrees: reverseRotation))
                    
                    ForEach(1...60, id: \.self) { index in
                        let tickRotation: Double = (Double(index * tickInterval) + Double(startAngle)) > endAngle ? endAngle : Double(index * tickInterval) + Double(startAngle)
                        
                        Capsule()
                            .frame(width: 3, height: index.isMultiple(of: 6) ? 30 : 25)
                            .foregroundStyle(.background)
                            .offset(y: width / 2)
                            .rotationEffect(.init(degrees: tickRotation))
                        // One solid tick every hour however that goes in the end
                            .opacity(index.isMultiple(of: 6) ? 1 : 0.5)
                    }
                    
                    //Image(systemName: "person.fill")
                    Text("Now")
                        //.font(.caption)
                        .bold()
                        .foregroundStyle(.background)
                        .frame(width: 50, height: 50)
                        .background(selectedSubject.colour, in: Circle())
                        .rotationEffect(.init(degrees: -90))
                        .rotationEffect(.init(degrees: -startAngle))
                        .offset(x: width / 2)
                        .rotationEffect(.init(degrees: startAngle))
                    /*
                        .gesture(
                            DragGesture()
                                .onChanged({ value in
                                    onDrag(value: value, isStartSlider: true)
                                })
                        )
                     */
                        .rotationEffect(.init(degrees: 90))
                    
                    Image(systemName: selectedSubject.icon)
                        //.font(.callout)
                        .font(.title2)
                        .bold()
                        .foregroundStyle(.background)
                        .frame(width: 50, height: 50)
                        .background(selectedSubject.colour, in: Circle())
                        .rotationEffect(.init(degrees: -90))
                        .rotationEffect(.init(degrees: -endAngle))
                        .offset(x: width / 2)
                        .rotationEffect(.init(degrees: endAngle))
                        .gesture(
                            DragGesture()
                                .onChanged({ value in
                                    onDrag(value: value)
                                })
                                .onEnded({ value in
                                    //endAngle = min(max(endAngle, (startAngle + 5)), 300)
                                    endAngle = round(endAngle / Double(tickInterval)) * Double(tickInterval)
                                    
                                    let progressPerDegree = 1.0 / 360.0
                                    endProgress = Double(endAngle) * progressPerDegree
                                })
                        )
                        .rotationEffect(.init(degrees: 90))
                        .sensoryFeedback(.increase, trigger: round(endAngle / Double(tickInterval)) * Double(tickInterval))
                    
                    VStack(spacing: 4) {
                        /*
                        Text("Start")
                            .font(.title)
                            .padding(.vertical, 8)
                            .padding(.horizontal, 13)
                            .background(.black.opacity(0.05), in: Capsule())
                         */
                        // Duration only works on an actual device
                        Text("\(getDuration().0)hr \(getDuration().1)min")
                            .font(.largeTitle)
                            .bold()
                        
                        // We can make our own menu later
                        
                        Menu {
                            ForEach(subjects.reversed()) { subject in
                                Button {
                                    selectedSubject = subject
                                    
                                } label: {
                                    HStack {
                                        if selectedSubject == subject {
                                            Text("✓  \(subject.name)")
                                                .bold()
                                            Image(systemName: subject.icon)
                                            
                                        } else {
                                            HStack {
                                                Label("      \(subject.name)", systemImage: subject.icon)
                                                    .bold()
                                                
                                            }
                                        }
                                    }
                                }
                                .tag(subject)
                                
                            }
                            
                        } label: {
                            HStack {
                                Text(selectedSubject.name)
                                    .font(.title2)
                                    //.bold()
                                    .foregroundStyle(colorScheme == .light ? .black : .white)
                                    .animation(.bouncy, value: selectedSubject.name) // Animate text change
                                
                                Image(systemName: "chevron.up.chevron.down")
                                    .foregroundStyle(colorScheme == .light ? .black : .white)
                                    //.bold()
                                
                            }
                        }
                        .onAppear {
                            selectedSubject = subjects[0]
                            
                        }
                        .sensoryFeedback(.increase, trigger: selectedSubject)
                        
                    }
                }
                
                Spacer()
            }
        }
        .frame(width: (screenBounds().width / 1.45), height: (screenBounds().height / 1.5))
        //.border(.red)
        
    }
}

#Preview {
    TimeDialView()
}
