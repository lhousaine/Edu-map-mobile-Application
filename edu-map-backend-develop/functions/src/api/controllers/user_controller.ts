import { UserService } from "../services/user_service";
import { MISSING_ID, MISSING_DATA } from "../../core/exceptions/messages";

import { Request, Response } from "express";
import { ExceptionError } from "../../core/exceptions/exceptions";
import { buildResponseUserModel, verifyUserRequestBody } from "../utils/user_utils";
import { UserModel } from "../../core/models/user_model";

const userService=new UserService();

export class UserController{

    async SignIn(request:Request,response:Response){
        try{
        const username = request.body.username;
        const password = request.body.password;
        const {user,usertoken}=await userService.SignIn(username,password);
        response.header({
            'Content-Type':'application/json',
            'Access-Control-Allow-Origin': '*',
            'Access-Control-Allow-Methods': 'GET,PUT,POST,DELETE',
            'Access-Control-Allow-Headers': 'Content-Type,Last-modified,Connection,Access-Control-Allow-Origin,Access-Control-Allow-Methods,Date',
            'Access-Control-Expose-Headers': 'Content-Type,Last-modified,Connection,Access-Control-Allow-Origin,Access-Control-Allow-Methods,Date'
        });
        response.header('authorization',usertoken);
        response.json(buildResponseUserModel(user));
        } catch (error){
            new ExceptionError(500, error.message).handleError(response);
        }
    }

    async getById(request: Request, response: Response){
        try {
            const idUser = request.params.idUser;
            if (!idUser) 
                throw new Error('user - ' + MISSING_ID);
            const userModel:UserModel = await userService.getById(idUser);
            response.json(buildResponseUserModel(userModel));
        } catch (error){
            new ExceptionError(500, error.message).handleError(response);
        }
    }  
      
    async getAll(request: Request, response: Response) {
        try {
            const users:UserModel[]=await userService.getAll();
            response.json(users);
        } catch (error){
            new ExceptionError(500, error.message).handleError(response);
        }
    }

    async create(request: Request, response: Response){
        try{
            verifyUserRequestBody(request);
            const user:UserEntity = request.body;
            const userId:string = await userService.post(user);
            response.json(buildResponseUserModel(new UserModel(userId,user)));
        }catch (error){
            new ExceptionError(500, error.message).handleError(response);
        }
    }

    async update(request: Request, response: Response): Promise<any> {
        try {
            let idUser = request.params.idUser;
            const newUserData = request.body;
    
            if (!idUser) throw new Error('User - ' + MISSING_ID);
    
            if (!newUserData) throw new Error('User - ' + MISSING_DATA);
    
            idUser=await userService.update(idUser,newUserData);
    
            response.json(buildResponseUserModel(new UserModel(idUser,newUserData)));
        } catch (error) {
            new ExceptionError(500, error.message).handleError(response);
        }
    }

    async remove(request: Request, response: Response): Promise<any> {
        try {
            let idUser = request.params.idUser;
            if (!idUser) throw new Error('School - ' + MISSING_ID);
            idUser=await userService.remove(idUser);
            response.json({
                idUser: idUser,
            });
        } catch (error) {
            new ExceptionError(500, error.message).handleError(response);
        }
    }

}