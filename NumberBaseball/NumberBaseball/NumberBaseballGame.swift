enum GameResult {
    case userWin
    case computerWin
    case notYet
}

func displayMenuList() {
    print("""
          1. 게임시작
          2. 게임종료
          원하는 기능을 선택해주세요 :
          """,
          terminator: " ")
}

func inputMenu() -> String? {
    displayMenuList()
    
    return readLine()
}

func handleMenuSelectionError() {
    print("입력이 잘못되었습니다.")
    displayMeneInterface()
}


func generateThreeRandomNumbers() -> [Int] {
    return Array((1...9).shuffled()[0..<3])
}

func displayInputThreeNumbers() {
    print("""
          숫자 3개를 띄어쓰기로 구분하여 입력해주세요.
          중복 숫자는 허용하지 않습니다.
          입력 :
          """,
          terminator: " "
    )
}

func inputThreeGameNumbers() -> [Int] {
    displayInputThreeNumbers()
    
    guard let threeNumbers = readLine()?.split(separator: " ").compactMap({ Int($0) }),
              Set(threeNumbers).count == 3,
              threeNumbers.contains(0) == false else { return inputThreeGameNumbers() }
    
    return threeNumbers
}

func countStrikeAndBall(in myNumbers: [Int], and targetNumbers: [Int]) -> (strike: Int, ball: Int) {
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

func displayGameResult(_ result: GameResult) {
    switch result {
    case .userWin:
        print("사용자 승리!")
        return
    case .computerWin:
        print("컴퓨터 승리!")
        return
    case .notYet:
        return
    }
}

func startGame(targetNumbers: [Int]) {
    var gameResult: GameResult = .notYet
    
    for leftTryCount in (0..<9).reversed() {
        let userNumbers: [Int] = inputThreeGameNumbers()
        let strikeAndBall = countStrikeAndBall(in: userNumbers, and: targetNumbers)
        
        if strikeAndBall.strike == 3 {
            gameResult = .userWin
            break
        }
        
        print("남은 기회: \(leftTryCount)")
        
        if leftTryCount == 0 {
            gameResult = .computerWin
            break
        }
    }
    
    displayGameResult(gameResult)
}

func displayMeneInterface() {
    let menuSelection: String? = inputMenu()
    
    switch menuSelection {
    case "1":
        startGame(targetNumbers: generateThreeRandomNumbers())
    case "2":
        return
    default:
        handleMenuSelectionError()
    }
}
