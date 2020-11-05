import { Request, Response } from "express";
import { ExceptionError } from "../exceptions/exceptions";
import { TOKEN_SECRET } from "../exceptions/messages";
const jwt = require('jsonwebtoken');

export async function isAuthenticated(request: Request, response: Response, next: Function) {
     try{
     const authorization = request.headers.authorization;
   
   if (!authorization || !authorization.startsWith('Bearer'))
        throw new Error('You are not connected');

   const split = authorization.split('Bearer ');

   if (split.length !== 2)
        throw new Error('You are not connected');

   const token = split[1];
       const decodedToken=jwt.verify(token,TOKEN_SECRET);

    if (!decodedToken) 
         throw new Error('You are not connected');
        
    request.userInfo=decodedToken;
    next();
     }catch (error){
          new ExceptionError(401, error.message).handleError(response);
      }
}