interface GlobalRatingEntity {
    level1: number, //number of users rating school by 1
    level2: number, //number of users rating school by 2
    level3: number, //number of users rating school by 3
    level4: number, //number of users rating school by 4
    level5: number, //number of users rating school by 5
}

/*
moyenne (level1*1+level2*2+level3*3+level4*4+level5*5)/(level1+level2+level3+level4+level5)
*/