export class UserModel {
    idUser: string;
    username: string;
    firstName: string;
    lastName: string;
    birthday: Date;
    email: string;
    phone?: string;
    address: AddressEntity;
    role:RoleEnum;
    educationLevel: EducationLevelEnum;
    speciality?: SpecialityEnum;

    constructor(idUser: string, user: UserEntity) {
        this.idUser = idUser;
        this.username = user.username;
        this.firstName = user.firstName;
        this.lastName = user.lastName;
        this.birthday = user.birthday;
        this.email = user.email;
        this.phone = user.phone || '';
        this.address = user.address;
        this.role = user.role;
        this.educationLevel = user.educationLevel;
        this.speciality = user.speciality;
    }
}