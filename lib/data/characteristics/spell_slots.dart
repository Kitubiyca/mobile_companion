class SpellSlots {
  static List<List<int>> basicMagicTable =
  List.filled(20, List.filled(9, 0, growable: false), growable: false);

  static List<List<int>> specialMagicTable =
  List.filled(20, List.filled(2, 0, growable: false), growable: false); //[0]-level [1]-count

  static initialize() {

    basicMagicTable[0][0] = 2;

    basicMagicTable[1][0] = 3;

    basicMagicTable[2][0] = 4;
    basicMagicTable[2][1] = 2;

    basicMagicTable[3][0] = 4;
    basicMagicTable[3][1] = 3;

    basicMagicTable[4][0] = 4;
    basicMagicTable[4][1] = 3;
    basicMagicTable[4][2] = 2;

    basicMagicTable[5][0] = 4;
    basicMagicTable[5][1] = 3;
    basicMagicTable[5][2] = 3;

    basicMagicTable[6][0] = 4;
    basicMagicTable[6][1] = 3;
    basicMagicTable[6][2] = 3;
    basicMagicTable[6][3] = 1;

    basicMagicTable[7][0] = 4;
    basicMagicTable[7][1] = 3;
    basicMagicTable[7][2] = 3;
    basicMagicTable[7][3] = 2;

    basicMagicTable[8][0] = 4;
    basicMagicTable[8][1] = 3;
    basicMagicTable[8][2] = 3;
    basicMagicTable[8][3] = 3;
    basicMagicTable[8][4] = 1;

    basicMagicTable[9][0] = 4;
    basicMagicTable[9][1] = 3;
    basicMagicTable[9][2] = 3;
    basicMagicTable[9][3] = 3;
    basicMagicTable[9][4] = 2;

    basicMagicTable[10][0] = 4;
    basicMagicTable[10][1] = 3;
    basicMagicTable[10][2] = 3;
    basicMagicTable[10][3] = 3;
    basicMagicTable[10][4] = 2;
    basicMagicTable[10][5] = 1;

    basicMagicTable[11][0] = 4;
    basicMagicTable[11][1] = 3;
    basicMagicTable[11][2] = 3;
    basicMagicTable[11][3] = 3;
    basicMagicTable[11][4] = 2;
    basicMagicTable[11][5] = 1;

    basicMagicTable[12][0] = 4;
    basicMagicTable[12][1] = 3;
    basicMagicTable[12][2] = 3;
    basicMagicTable[12][3] = 3;
    basicMagicTable[12][4] = 2;
    basicMagicTable[12][5] = 1;
    basicMagicTable[12][6] = 1;

    basicMagicTable[13][0] = 4;
    basicMagicTable[13][1] = 3;
    basicMagicTable[13][2] = 3;
    basicMagicTable[13][3] = 3;
    basicMagicTable[13][4] = 2;
    basicMagicTable[13][5] = 1;
    basicMagicTable[13][6] = 1;

    basicMagicTable[14][0] = 4;
    basicMagicTable[14][1] = 3;
    basicMagicTable[14][2] = 3;
    basicMagicTable[14][3] = 3;
    basicMagicTable[14][4] = 2;
    basicMagicTable[14][5] = 1;
    basicMagicTable[14][6] = 1;
    basicMagicTable[14][7] = 1;

    basicMagicTable[15][0] = 4;
    basicMagicTable[15][1] = 3;
    basicMagicTable[15][2] = 3;
    basicMagicTable[15][3] = 3;
    basicMagicTable[15][4] = 2;
    basicMagicTable[15][5] = 1;
    basicMagicTable[15][6] = 1;
    basicMagicTable[15][7] = 1;

    basicMagicTable[16][0] = 4;
    basicMagicTable[16][1] = 3;
    basicMagicTable[16][2] = 3;
    basicMagicTable[16][3] = 3;
    basicMagicTable[16][4] = 2;
    basicMagicTable[16][5] = 1;
    basicMagicTable[16][6] = 1;
    basicMagicTable[16][7] = 1;
    basicMagicTable[16][8] = 1;

    basicMagicTable[17][0] = 4;
    basicMagicTable[17][1] = 3;
    basicMagicTable[17][2] = 3;
    basicMagicTable[17][3] = 3;
    basicMagicTable[17][4] = 3;
    basicMagicTable[17][5] = 1;
    basicMagicTable[17][6] = 1;
    basicMagicTable[17][7] = 1;
    basicMagicTable[17][8] = 1;

    basicMagicTable[18][0] = 4;
    basicMagicTable[18][1] = 3;
    basicMagicTable[18][2] = 3;
    basicMagicTable[18][3] = 3;
    basicMagicTable[18][4] = 3;
    basicMagicTable[18][5] = 2;
    basicMagicTable[18][6] = 1;
    basicMagicTable[18][7] = 1;
    basicMagicTable[18][8] = 1;

    basicMagicTable[19][0] = 4;
    basicMagicTable[19][1] = 3;
    basicMagicTable[19][2] = 3;
    basicMagicTable[19][3] = 3;
    basicMagicTable[19][4] = 3;
    basicMagicTable[19][5] = 2;
    basicMagicTable[19][6] = 2;
    basicMagicTable[19][7] = 1;
    basicMagicTable[19][8] = 1;

  specialMagicTable[0][0] = 1;
  specialMagicTable[0][1] = 1;

  specialMagicTable[1][0] = 1;
  specialMagicTable[1][1] = 2;

  specialMagicTable[2][0] = 2;
  specialMagicTable[2][1] = 2;

  specialMagicTable[3][0] = 2;
  specialMagicTable[3][1] = 2;

  specialMagicTable[4][0] = 3;
  specialMagicTable[4][1] = 2;

  specialMagicTable[5][0] = 3;
  specialMagicTable[5][1] = 2;

  specialMagicTable[6][0] = 4;
  specialMagicTable[6][1] = 2;

  specialMagicTable[7][0] = 4;
  specialMagicTable[7][1] = 2;

  specialMagicTable[8][0] = 5;
  specialMagicTable[8][1] = 2;

  specialMagicTable[9][0] = 5;
  specialMagicTable[9][1] = 2;

  specialMagicTable[10][0] = 5;
  specialMagicTable[10][1] = 3;

  specialMagicTable[11][0] = 5;
  specialMagicTable[11][1] = 3;

  specialMagicTable[12][0] = 5;
  specialMagicTable[12][1] = 3;

  specialMagicTable[13][0] = 5;
  specialMagicTable[13][1] = 3;

  specialMagicTable[14][0] = 5;
  specialMagicTable[14][1] = 3;

  specialMagicTable[15][0] = 5;
  specialMagicTable[15][1] = 3;

  specialMagicTable[16][0] = 5;
  specialMagicTable[16][1] = 4;

  specialMagicTable[17][0] = 5;
  specialMagicTable[17][1] = 4;

  specialMagicTable[18][0] = 5;
  specialMagicTable[18][1] = 4;

  specialMagicTable[19][0] = 5;
  specialMagicTable[19][1] = 4;
  }

}
