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
    var colour: Color = .purple
    var id: UUID = UUID()
    
}

struct TimeDialView: View {
    init() {
        _selectedSubject = State(initialValue: subjects[0])
        
        self.circleStartingPosition = 60
        
        let realEndPosition: Double = 180
         
        let calculatedStartAngle = circleStartingPosition
        let calculatedEndAngle = circleStartingPosition + (realEndPosition - circleStartingPosition)
        
        let progressPerDegree = 1.0 / 360.0
        let calculatedEndProgress = calculatedEndAngle * progressPerDegree
        let calculatedStartProgress = Double((circleStartingPosition).truncatingRemainder(dividingBy: 360)) * progressPerDegree
        
        _startAngle = State(initialValue: calculatedStartAngle)
        _startProgress = State(initialValue: calculatedStartProgress)
        
        _endAngle = State(initialValue: calculatedEndAngle)
        _endProgress = State(initialValue: calculatedEndProgress)
        
        self.timeTicksNeeded = 14
        
        self.tickInterval = Double((360 - Double(2 * Int(circleStartingPosition))) / Double(timeTicksNeeded))
        
    }
    
    @Environment(\.colorScheme) var colorScheme
    
    var circleStartingPosition: Double
        
    @State var startAngle: Double
    @State var startProgress: CGFloat
    
    @State var endAngle: Double
    @State var endProgress: CGFloat
    
    var timeTicksNeeded: Int
    var tickInterval: Double
    
    let tickBufferSpace = 0
    
    var subjects: [Subject] = [
        Subject(name: "English"),
        Subject(name: "Math", icon: "x.squareroot"),
        Subject(name: "Science", icon: "atom"),
        Subject(name: "Socials", icon: "person.2.wave.2"),
        Subject(name: "Astronomy", icon: "globe.desk"),
        Subject(name: "Health", icon: "heart")
        
    ]
    
    @State private var selectedSubject: Subject
    
    func roundToNearestMultiple(of interval: Double, startingAt base: Int, for number: Int) -> Double {
        let offsetNumber = number - base
        let roundedOffset = Double(round(Double(offsetNumber) / interval)) * interval
        
        return (roundedOffset + Double(base))
        
    }
    
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
            angle = min(max(angle, (startAngle + Double(tickInterval * Double(tickBufferSpace + 1)))), (360 - circleStartingPosition))
            
            progress = angle / 360
            
            self.endAngle = angle
            self.endProgress = progress
            
        }
    }
    
    func getTicksFromAngles(_ startAngle: Double, _ endAngle: Double) -> Int {
        let diffirence = endAngle - startAngle
        
        let diffirenceWithBuffer = diffirence - Double(tickInterval * Double(tickBufferSpace))
        
        let ticks = diffirenceWithBuffer / Double(tickInterval)
        
        return Int(ticks)
        
    }
    
    func getTimeFromTicks(_ ticks: Int) -> (hours: Int, minutes: Int) {
        // Returns the greater of two values given fyi
        let normalTicks = max(ticks, 1)
        
        var hours: Int = 0
        var minutes: Int = 0
        
        switch normalTicks {
        case 1 ... 4:
            minutes = normalTicks * 5
            
        case 5:
            minutes = 30
            
        case 6 ... 7:
            minutes = ((normalTicks - 5) * 15) + 30
            
        case 8 ... 11:
            minutes = ((normalTicks - 7) * 30) + 60
            
        case 12 ... 13:
            minutes = (normalTicks - 8) * 60
            
        default:
            minutes = 600
            
        }
        
        hours = minutes / 60
        
        minutes %= 60
        
        return (hours, minutes)
        
    }
    
    func formatTime(_ input: (hours: Int, minutes: Int)) -> String {
        var timeString = ""
        
        if input.hours > 0 {
            timeString += input.hours == 1 ? "1hr" : "\(input.hours)hrs"
            
        }
            
        if input.minutes > 0 {
            if !timeString.isEmpty {
                timeString += " "
                
            }
            
            timeString += "\(input.minutes)min"
            
        }
        
        if input.hours == 10 {
            timeString = "Forever"
            
        }
        
        return timeString
        
    }
    
    var body: some View {
        GeometryReader { proxy in
            let width = proxy.size.width
            
            VStack {
                ZStack {
                    /*
                    VStack {
                        Button {
                            print("Start")
                            print(startAngle)
                            print(startProgress)
                            print("")
                            print("End")
                            print(endAngle)
                            print(endProgress)
                            print("")
                            print("Ticks")
                            print(getTicksFromAngles(startAngle, endAngle))
                            
                        } label: {
                            Label("Debug", systemImage: "book.pages")
                                .padding(.vertical, 5)
                                .padding(.horizontal, 10)
                                .background(.black.opacity(0.05), in: Capsule())
                            
                        }
                        
                        Spacer()
                    }
                     */
                    
                    ZStack() {
                        Circle()
                            .stroke(Color(.purple), lineWidth: 60)
                        Circle()
                            .stroke(Color(.blue), lineWidth: 60)
                            .opacity(0.4)
                    }
                    .opacity(0.25)
                    .blur(radius: 20)
                    
                    
                    let reverseRotation = (startProgress > endProgress) ? -Double((1 - startProgress) * 360) : 0
                    
                    
                    Circle()
                        .trim(from: startProgress > endProgress ? 0 : startProgress, to: endProgress + (-reverseRotation / 360))
                        .stroke(selectedSubject.colour, style: StrokeStyle(lineWidth: 52, lineCap: .round, lineJoin: .round))
                        .rotationEffect(.init(degrees: 90))
                        .rotationEffect(.init(degrees: reverseRotation))
                    
                    Circle()
                        .trim(from: startProgress > endProgress ? 0 : startProgress, to: endProgress + (-reverseRotation / 360))
                        .stroke(.background, style: StrokeStyle(lineWidth: 50, lineCap: .round, lineJoin: .round))
                        .rotationEffect(.init(degrees: 90))
                        .rotationEffect(.init(degrees: reverseRotation))
                
                    ZStack {
                        Circle()
                            .trim(from: startProgress > endProgress ? 0 : startProgress, to: endProgress + (-reverseRotation / 360))
                            .stroke(.purple, style: StrokeStyle(lineWidth: 40, lineCap: .round, lineJoin: .round))
                            .rotationEffect(.init(degrees: 90))
                            .rotationEffect(.init(degrees: reverseRotation))
                        
                        Circle()
                            .trim(from: startProgress > endProgress ? 0 : startProgress, to: endProgress + (-reverseRotation / 360))
                            .stroke(.blue, style: StrokeStyle(lineWidth: 40, lineCap: .round, lineJoin: .round))
                            .rotationEffect(.init(degrees: 90))
                            .rotationEffect(.init(degrees: reverseRotation))
                            .opacity(0.4)
                    }
                    .opacity(0.3)
                    .blur(radius: 20)

                    
                    ForEach(1...timeTicksNeeded + 2, id: \.self) { index in
                        let tickRotation: Double = (Double(Double(index) * Double(tickInterval)) + Double(startAngle)) > endAngle ? endAngle : Double(Double(index) * Double(tickInterval)) + Double(startAngle)
                        
                        Capsule()
                            .fill(selectedSubject.colour)
                            .frame(width: 2, height: (index + 1).isMultiple(of: 2) ? 30 : 25)
                            .foregroundStyle(.background)
                            .offset(y: width / 2)
                            .rotationEffect(.init(degrees: tickRotation))
                            .opacity(tickRotation >= (endAngle - 5) ? 0 : 1)
                            .opacity((index + 1).isMultiple(of: 2) ? 1 : 0.5)
                        
                    }
                    
                    //Image(systemName: "person.fill")
                    
                    Text("Now")
                        .foregroundStyle(.white)
                        .frame(width: 50, height: 50)
                        //.background((.black), in: Circle())
                        //.bold()
                        //.foregroundStyle(.background)
                        
                        .rotationEffect(.init(degrees: -90))
                        .rotationEffect(.init(degrees: -startAngle))
                        .offset(x: width / 2)
                        .rotationEffect(.init(degrees: startAngle))
                        .rotationEffect(.init(degrees: 90))
                    
                    Image(systemName: selectedSubject.icon)
                        .font(.title2)
                        //.bold()
                        .foregroundStyle(.white)
                        .frame(width: 50, height: 50)
                        //.background((.black), in: Circle())
                        //.background(selectedSubject.colour, in: Circle())
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
                                    print(endAngle)
                                    endAngle = roundToNearestMultiple(of: tickInterval, startingAt: Int(circleStartingPosition), for: Int(endAngle))
                                    print(endAngle)
                                    
                                    let progressPerDegree = 1.0 / 360.0
                                    endProgress = Double(endAngle) * progressPerDegree
                                    
                                })
                        )
                        .rotationEffect(.init(degrees: 90))
                        .sensoryFeedback(.increase, trigger: round(endAngle / Double(tickInterval)) * Double(tickInterval))
                    
                    VStack(spacing: 4) {
                        let ticks = getTicksFromAngles(startAngle, endAngle)
                        let displayText = formatTime(getTimeFromTicks(ticks))
                        
                        Text(formatTime(getTimeFromTicks(ticks)))
                            .animation(.bouncy, value: displayText)
                            .font(.largeTitle)
                            .bold()
                        
                        // Doesn't look good here
                        /*
                        Text("Start Session")
                            .font(.title2)
                            .padding(.vertical, 8)
                            .padding(.horizontal, 13)
                            .background(Color(.systemGray5), in: Capsule())
                         */
                        
                        // We can also make our own menu later
                        
                        Menu {
                            ForEach(subjects.reversed()) { subject in
                                Button {
                                    selectedSubject = subject
                                    
                                } label: {
                                    HStack {
                                        if selectedSubject == subject {
                                            Text("✓  \(subject.name)")
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
                                // Looks better with spaces in front
                                Text("  \(selectedSubject.name)")
                                    .font(.title3)
                                    .foregroundStyle(colorScheme == .light ? .black : .white)
                                    .animation(.bouncy, value: selectedSubject.name)
                                
                                Image(systemName: "chevron.up.chevron.down")
                                    .foregroundStyle(colorScheme == .light ? .black : .white)
                                
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
        
    }
}

#Preview {
    TimeDialView()
}
