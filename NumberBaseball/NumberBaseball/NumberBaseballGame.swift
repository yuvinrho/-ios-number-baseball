import Foundation

enum GameResult: String {
    case userWin = "사용자 승리!"
    case computerWin = "컴퓨터 승리!"
    case gameReplay
}

func inputMenu() -> String? {
    printMenuList()
    
    return readLine()
}

func handleMenuSelectionError() {
    print("입력이 잘못되었습니다.")
    runGame()
}

func runGame() {
    let menuSelection = inputMenu()
    var Game
    
    switch menuSelection {
    case "1":
        startGame()
    case "2":
        return
    default:
        handleMenuSelectionError()
    }
}

func startGame() {
    
}


func inputThreeGameNumbers() -> [Int]? {
    let userInput = readLine()?.components(separatedBy: " ")
    return userInput?.compactMap { Int($0) }
}

func runNumberBaseballGame(leftTryCount: Int) {
    var gameResult: GameResult
    guard let menuNumber = readLine() else { return }
    
    switch menuNumber {
    case "1":
        GameResult = startGame(leftTryCount: <#T##Int#>)
    case "2":
        return
    default:
        print("입력이 잘못되었습니다.")
        return runNumberBaseballGame()
    }
    
    switch gameResult {
    case .UserWin:
        return
    case .ComputerWin:
        return
    case .GameReplay:
        startGame(leftTryCount: letTryCount - 1)
    }
}



func printMenuList() {
    print("""
          1. 게임시작
          2. 게임종료
          원하는 기능을 선택해주세요 :
          """,
          terminator: " ")
}

func manageNumberBaseballGame() {
    for leftTryCount in (0..<9).reversed() {
        let userNumbers: [Int] = inputThreeNumbers()
        if isThreeStrike(in: userNumbers) {
            print("사용자 승리!")
            break
        }
        
        print(leftTryCount != 0 ? "남은 기회: \(leftTryCount)" : "컴퓨터 승리...!")
    }
}

func startGame(leftTryCount: Int) -> GameResult {
    let userNumbers: [Int] = inputThreeNumbers()
    
    if leftTryCount == 0 {
        print("컴퓨터 승리...!")
        return GameResult.ComputerWin
    }
    
    if isThreeStrike(in: userNumbers) {
        print("사용자 승리!")
        return GameResult.UserWin
    }
    
    print("남은 기회: \(leftTryCount)")
    return GameResult.GameReplay
}

func inputThreeNumbers() -> [Int] {
    while true {
        printNumberInputRule()
        guard let threeNumbers = getThreeNumbers(from: readLine()) else {
            print("입력이 잘못되었습니다.")
            continue
        }
    
        return threeNumbers
    }
}

func printNumberInputRule() {
    print("""
           숫자 3개를 띄어쓰기로 구분하여 입력해주세요.
           중복 숫자는 허용하지 않습니다.
           입력 :
           """, terminator: " ")
}

func getThreeNumbers(from userInput: String?) -> [Int]? {
    if isValidThreeNumbers(from: userInput) {
        return userInput?.split(separator: " ").compactMap { Int($0) }
    }
    
    return nil
}

func isValidThreeNumbers(from userInput: String?) -> Bool {
    guard let userInput = userInput else {
        return false
    }
    
    let threeNumbers = userInput.split(separator: " ").compactMap { Int($0) }
    
    if threeNumbers.count != 3 {
        return false
    }
    
    return true
}

func isThreeStrike(in userNumber : [Int]) -> Bool {
    let strike: Int = countStrikeOrBall(with: userNumber).strike
    
    if strike == 3 {
        return true
    }
    
    return false
}

func countStrikeOrBall(with myNumbers: [Int]) -> (strike: Int, ball: Int) {
    var (strike, ball) = (0, 0)

    for (number, myNumber) in zip(targetNumbers, myNumbers) {
        if number == myNumber {
            strike += 1
        } else if targetNumbers.contains(myNumber) {
            ball += 1
        }
    }

    print("\(strike) 스트라이크, \(ball) 볼")
    return (strike, ball)
}

func generateThreeRandomNumbers() -> [Int] {
    return Array((1...9).shuffled()[0..<3])
}
