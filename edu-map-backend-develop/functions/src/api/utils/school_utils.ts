import { DocumentSnapshot, QuerySnapshot } from "@google-cloud/firestore";
import { SchoolModel } from "../../core/models/school_model";
import { verifyAddressRequestBody } from "./address_utils";
import { verifyContactBodyRequest } from "./contact_utils";

export function buildResponseSchool(school: SchoolModel):SchoolModel{
    return {
        idSchool: school.idSchool,
        name: school.name,
        description: school.description,
        schoolType: school.schoolType,
        contact: school.contact,
        globalRating: school.globalRating,
        rating:school.rating,
        address: school.address,
        educationCycles: school.educationCycles,
        coordinates:school.coordinates,
        images:school.images
    }
}

export function querySnapshotToArraySchools(q:QuerySnapshot):SchoolModel[]{
    const schools: any[] = [];
    q.forEach(
      (resultSchool) => {
       const schoolModel: SchoolModel = new SchoolModel(resultSchool.id,documentSnapshotToSchoolEntity(resultSchool));
        schools.push(
          buildResponseSchool(schoolModel)
        );
      }
    );
    return schools;
}

export const getfilteratedSchools=(schools:SchoolModel[],keyword:string
    ,city:string,rating:number,educationCycle:EducationCycleEnum)=>
    schools.filter(
        school => (keyword?school.name.includes(keyword):true)
        && (city?school.address.city.includes(city):true)
        && (rating?school.rating>rating:true)
        && (educationCycle?school.educationCycles.includes(educationCycle):true)
    );

export function documentSnapshotToSchoolEntity(resultSchool:DocumentSnapshot){
    return {
        name: resultSchool.data()!.name,
        description: resultSchool.data()!.description,
        schoolType: resultSchool.data()!.schoolType,
        contact: resultSchool.data()!.contact,
        globalRating: resultSchool.data()!.globalRating,
        rating: resultSchool.data()!.rating,
        address: resultSchool.data()!.address,
        educationCycles: resultSchool.data()!.educationCycles,
        coordinates: resultSchool.data()!.coordinates,
        images: resultSchool.data()!.images
    };
}

export function verifySchoolRequestBody(request: any) {
        if (!request.body.name)
            throw new Error("name is required.");
        if (!request.body.description)
            throw new Error("school description is required.");
        if (!request.body.schoolType)
            throw new Error("school type is required.");
        verifyContactBodyRequest(request.body.contact);
        verifyAddressRequestBody(request.body.address);
        if (!request.body.educationCycles)
            throw new Error("school cycles are required.");
        if (!request.body.coordinates.latitude)
            throw new Error("school coordinates latitude is required.");
        if (!request.body.coordinates.longitude)
            throw new Error("school coordinates longitude is required.");
}