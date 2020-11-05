interface UserEntity {
    firstName: string,
    lastName: string,
    birthday: Date,
    username: string,
    email: string,
    password: string,
    phone?: string,
    address: AddressEntity,
    role: RoleEnum,
    educationLevel: EducationLevelEnum,
    speciality?: SpecialityEnum
}   
