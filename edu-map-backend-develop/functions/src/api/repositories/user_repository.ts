import {USER_API_COLLECTION_NAME} from "../../core/exceptions/messages";
import { db } from "../..";
import { DocumentSnapshot } from "firebase-functions/lib/providers/firestore";
import { DocumentReference, QuerySnapshot} from "@google-cloud/firestore";
import {Repository} from "./repository";
import admin = require("firebase-admin");


const usersCollection = USER_API_COLLECTION_NAME;

export class UserRepository extends Repository<UserEntity>{
    getByField(fieldName: string, fieldValue: string): Promise<QuerySnapshot> {
        throw new Error("Method not implemented.");
    }

    async GrantAdminRole(idUser:string):Promise<string>{
        admin.auth().setCustomUserClaims(idUser, { 
            ADMIN:true 
        });
        return "successfull grant admin role to user";
        
    }

    async RemoveAdminRole(idUser:string):Promise<string>{
        admin.auth().setCustomUserClaims(idUser,{ 
            ADMIN:true 
        });
        return "Remove Admin role was successfull";
    }

    async GrantSUBSCRIBERRole(idUser:string):Promise<string>{
        admin.auth().setCustomUserClaims(idUser, { 
            SUBSCRIBER:true 
        });
        return "successfull grant subscriber role to user";
    }

    async RemoveSUBSCRIBERRole(idUser:string):Promise<string>{
        admin.auth().setCustomUserClaims(idUser,{ 
            SUBSCRIBER:true 
        });
        return "Remove Admin role was successfull";
    }
    
    async SignIn(username:string,password:string):Promise<QuerySnapshot>{
        return await db.collection(usersCollection)
               .where('username','==',username)
               .where('password','==',password)
               .get();
    }

    async getById(idUser: string): Promise<DocumentSnapshot> {
        return await db.collection(usersCollection).doc(idUser).get();
    }

    async getAll(): Promise<QuerySnapshot> {
        return await db.collection(usersCollection).get();
    }
    
    async checkUsernameExistence(username:string):Promise<QuerySnapshot>{
        return await db.collection(usersCollection)
               .where('username','==',username)
               .get();
    }

    async post(user: UserEntity): Promise<DocumentReference> {
        const displayName = user.username;
        const password= user.password;
        const email = user.email;
       
        const {uid} = await admin.auth().createUser({
          displayName,
          password,
          email
        });
    
        await admin.auth().setCustomUserClaims(uid, { "USER":true })
        const docRef = db.collection(usersCollection).doc(uid);
        await docRef.set(user);
        return docRef;
    }

    async update(idUser: string,user:any): Promise<string> {
        const docRef=db.collection(usersCollection).doc(idUser);
        await docRef.update(user);
        return docRef.id;
    }

    async remove(idUser: string): Promise<string> {
        const docRef=db.collection(usersCollection).doc(idUser);
        await db.collection(usersCollection).doc(idUser).delete();
        return docRef.id;
    }

}
