import { Request } from "express";
import { DocumentSnapshot } from "@google-cloud/firestore";
import { UserModel } from "../../core/models/user_model";
import { verifyAddressRequestBody } from "./address_utils";

  export function DocumentSnapshotToUserEntity(resultUser:DocumentSnapshot){
    return {
      username: resultUser.data()!.username,
      firstName: resultUser.data()!.firstName,
      lastName: resultUser.data()!.lastName,
      birthday: resultUser.data()!.birthday,
      email: resultUser.data()!.email,
      phone: resultUser.data()!.phone || '',
      password: "",
      address: resultUser.data()!.address,
      role: resultUser.data()!.role,
      educationLevel: resultUser.data()!.educationLevel,
      speciality: resultUser.data()!.speciality
    }
  }

  export function buildResponseUserModel(resultUser: UserModel):UserModel{
    return {
      idUser: resultUser.idUser,
      firstName: resultUser.firstName,
      lastName: resultUser.lastName,
      birthday: resultUser.birthday,
      username: resultUser.username,
      email: resultUser.email,
      phone: resultUser.phone || '',
      address: resultUser.address,
      role: resultUser.role,
      educationLevel: resultUser.educationLevel,
      speciality: resultUser.speciality
    };
  }
  
export function verifyUserRequestBody(request: Request) {
    if (!request.body.firstName)
      throw new Error("FirstName is required.");
    if (!request.body.lastName)
      throw new Error("LastName is required.");
    if (!request.body.birthday)
      throw new Error("Birthday is required.");
    if (!request.body.username)
      throw new Error("Username is required.");
    if (!request.body.email)
      throw new Error("User Email is required.");
    if (!request.body.password)
      throw new Error("Password is required.");

    verifyAddressRequestBody(request.body.address);
    
    if (!request.body.role)
      throw new Error("User Role is required.");
    if (!request.body.educationLevel)
      throw new Error("Education level is required.");
    if (!request.body.speciality)
      throw new Error("speciality is required.");
  }