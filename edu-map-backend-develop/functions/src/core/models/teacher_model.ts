export class TeacherModel {
    idTeacher: string;
    first_name: string;
    last_name: string;
    contact: ContactEntity;
    
    constructor(idTeacher: string, teacher: TeacherEntity) {
        this.idTeacher = idTeacher;
        this.first_name = teacher.first_name;
        this.last_name = teacher.last_name;
        this.contact = teacher.contact;
    }
}