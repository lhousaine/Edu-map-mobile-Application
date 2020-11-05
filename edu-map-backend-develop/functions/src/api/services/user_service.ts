import {Service} from "./service";
import { USER_NOT_FOUND, SERVER_EXCEPTION } from "../../core/exceptions/messages";
import { DocumentSnapshotToUserEntity, buildResponseUserModel,} from "../utils/user_utils";
import { UserRepository } from "../repositories/user_repository";
import { UserModel } from "../../core/models/user_model";
import { createToken} from "../../core/auth/Token";

let userRepository=new UserRepository();

export class UserService extends Service<UserEntity,UserModel>{

    async SignIn(username:string,password:string):Promise<any>{
        const user=await userRepository.SignIn(username,password);
        if(!user)
            throw new Error('User - ' + USER_NOT_FOUND);
        const users: any[] = [];
        user.forEach((resultUser:any) => {
         const userModel: UserModel = new UserModel(resultUser.id,DocumentSnapshotToUserEntity(resultUser));
          users.push(userModel
          );
        });
        if(users.length==1){
            const token=createToken(users[0]);
            return {
                    user:users[0],
                    usertoken:token};
        }else
            throw new Error(SERVER_EXCEPTION);
    }

    async getById(idUser: string): Promise<UserModel>{
        const resultUser = await userRepository.getById(idUser);
        if (!resultUser.exists){
            throw new Error('User - ' + USER_NOT_FOUND)
        }
        const user = DocumentSnapshotToUserEntity(resultUser);
        return new UserModel(resultUser.id,user);
    }    

    async getAll(): Promise<UserModel[]> {
        const userQuerySnapshot = await userRepository.getAll();
        const users: any[] = [];
        userQuerySnapshot.forEach(
          (resultUser) => {
           const userModel: UserModel = new UserModel(resultUser.id,DocumentSnapshotToUserEntity(resultUser));
            users.push(
              buildResponseUserModel(userModel)
            );
          }
        );
        return users;
    }
    
    async  checkUsernameExistence(username:string):Promise<boolean> {
        const userQuerySnapshot=await userRepository.checkUsernameExistence(username);
        if(userQuerySnapshot.empty)
            return false;
        else 
            return true;
    }

    async post(user: UserEntity): Promise<string> {
        if(await this.checkUsernameExistence(user.username))
            throw new Error(user.username+" is already in use, try with an other one");
        const docRef= await userRepository.post(user);
        return docRef.id;
    }

    async update(idUser: string, user: any): Promise<string> {
        return await userRepository.update(idUser,user);
    }

    async remove(idUser: string): Promise<string> {
        return await userRepository.remove(idUser);
    }
}