enum Rank {
  Novice, // 0 - 999
  Intermediate, // 1000 - 4999
  Advanced, // 5000 - 9999
  Professional, // 10000 - 19999
  Expert, // 20000 - 49999
  Master, // 50000 - 99999
}

class Ranks {
  Rank getRank(int xp) {
    if (xp < 1000) {
      return Rank.Novice;
    } else if (xp < 5000) {
      return Rank.Intermediate;
    } else if (xp < 10000) {
      return Rank.Advanced;
    } else if (xp < 20000) {
      return Rank.Professional;
    } else if (xp < 50000) {
      return Rank.Expert;
    } else {
      return Rank.Master;
    }
  }
}
