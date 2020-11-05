import { Service } from "./service";
import { SCHOOL_NOT_FOUND, SCHOOL_DEFAULT_IMAGE } from "../../core/exceptions/messages";
import { SchoolRepository } from "../repositories/school_repository";
import { documentSnapshotToSchoolEntity,  querySnapshotToArraySchools, buildResponseSchool, getfilteratedSchools } from "../utils/school_utils";
import { DocumentReference, QuerySnapshot } from "@google-cloud/firestore";
import { SchoolModel } from "../../core/models/school_model";

const schoolRepository=new SchoolRepository();

export class SchoolService extends Service<SchoolEntity,SchoolModel>{
   
  async getById(idSchool: string): Promise<SchoolModel> {
      const resultSchool = await schoolRepository.getById(idSchool);
      if (!resultSchool.exists) {
          throw new Error('School - ' + SCHOOL_NOT_FOUND)
      }
      const school = documentSnapshotToSchoolEntity(resultSchool);
      return new SchoolModel(idSchool,school);
  } 
  
  async getTrendingSchool():Promise<SchoolModel[]>{
   return querySnapshotToArraySchools(await schoolRepository.getByTrendingSchool());
  } 
  
  async getNearestSchoolsToCoodinate(coordinates:SchoolCoordinates,distance:Number): Promise<SchoolModel[]>{
    const querySnapshot:QuerySnapshot=await schoolRepository.getAll();
    const schools= [];
    querySnapshot.forEach(
      (resultSchool) => {
        const xpoint =coordinates.latitude;
        const ypoint =coordinates.longitude;
       const schoolModel: SchoolModel = new SchoolModel(resultSchool.id,documentSnapshotToSchoolEntity(resultSchool));
       let dist:number=Math.sqrt(Math.pow(xpoint-schoolModel.coordinates.latitude,2)
                 +Math.pow(ypoint-schoolModel.coordinates.longitude,2))
        if(dist<=distance){
          schools.push(
            buildResponseSchool(schoolModel)
          );
        }
      }
    );
    return schools;
  }

  async getAllfiltratedSchools(filterSchools){
       const querySchapshotSchools:QuerySnapshot=await schoolRepository.getAll();
       const allSchools: SchoolModel[] = [];
       const fschools:any[]=[];
       querySchapshotSchools.forEach(
        (resultSchool) => {
             allSchools.push(
               new SchoolModel(resultSchool.id,documentSnapshotToSchoolEntity(resultSchool))
             );
        }
      );
       const filtratedSchools =getfilteratedSchools(allSchools,
        filterSchools.keyword,
        filterSchools.city,
        filterSchools.rating,
        filterSchools.educationCycle);
        filtratedSchools.forEach((school)=>{
          fschools.push(
            buildResponseSchool(school)
          )
        })
       return fschools;
  }

  async getAll(): Promise<SchoolModel[]>{
      return querySnapshotToArraySchools(await schoolRepository.getAll());
  }

    async post(school: SchoolEntity): Promise<string> {
        school.rating=0;
        school.globalRating={level1:0,level2:0,level3:0,level4:0,level5:0};
        if(!school.images)
            school.images.push(SCHOOL_DEFAULT_IMAGE);
        else if(school.images && school.images.length===0)
                school.images.push(SCHOOL_DEFAULT_IMAGE);
        const docRef:DocumentReference=await schoolRepository.post(school);
        return docRef.id;
    }

    async update(id: string, school: SchoolEntity): Promise<string> {
        return await schoolRepository.update(id,school);
    }

    async remove(schoolId: string): Promise<string> {
        return await schoolRepository.remove(schoolId);
    }

}