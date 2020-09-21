// Compute the binomial coefficient
func binomialCoefficient(_ n: Int, choose k: Int) -> Int {
  var result = 1
  for i in 0..<k {
    result *= (n - i)
    result /= (i + 1)
  }
  return result
}

func combos<T>(elements: ArraySlice<T>, k: Int) -> [[T]] {
    if k == 0 {
        return [[]]
    }

    guard let first = elements.first else {
        return []
    }

    let head = [first]
    let subcombos = combos(elements: elements.dropFirst(), k: k - 1)
    var ret = subcombos.map { head + $0 }
    ret += combos(elements: elements.dropFirst(), k: k)

    return ret
}

// Compute all permutation of an array with a specific size k
func combos<T>(elements: Array<T>, k: Int) -> [[T]] {
    return combos(elements: ArraySlice(elements), k: k)
}
