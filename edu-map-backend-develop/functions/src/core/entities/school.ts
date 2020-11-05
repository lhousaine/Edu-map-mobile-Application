interface SchoolEntity {
    name: string,
    description: string,
    schoolType: SchoolTypeEnum,
    contact: ContactEntity,
    globalRating: GlobalRatingEntity,
    rating:number,
    address: AddressEntity,
    educationCycles: Array<EducationCycleEnum>,
    coordinates:SchoolCoordinates,
    images:Array<string>,
}

