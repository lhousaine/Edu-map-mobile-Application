export class SchoolModel {
    idSchool: string;
    name: string;
    description: string;
    schoolType: SchoolTypeEnum;
    contact: ContactEntity;
    globalRating: GlobalRatingEntity;
    rating:number;
    address: AddressEntity;
    educationCycles:Array<EducationCycleEnum>;
    coordinates: SchoolCoordinates;
    images: Array<string> = [];

    constructor(idSchool: string, school: SchoolEntity) {
        this.idSchool = idSchool;
        this.name = school.name;
        this.description = school.description;
        this.schoolType = school.schoolType;
        this.contact = school.contact;
        this.globalRating = school.globalRating;
        this.rating=school.rating;
        this.address = school.address;
        this.educationCycles=school.educationCycles;
        this.coordinates=school.coordinates;
        this.images=school.images;
    }

}