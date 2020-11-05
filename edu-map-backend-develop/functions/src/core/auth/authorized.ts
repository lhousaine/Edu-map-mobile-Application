import { Request, Response } from "express";
import { ExceptionError } from "../exceptions/exceptions";



export function isUserAuthorized(request: Request,response: Response, next: Function) {
        const userInfo = request.userInfo;
        if(userInfo.role=='USER')
            next();
        else
            throw new ExceptionError(403, 'Unauthorized USER').handleError(response);
}


export function isAdminAuthorized(request: Request, response: Response, next: Function){
    const userInfo = request.userInfo;
    if(userInfo.role=='ADMIN')
        next();
    else
        new ExceptionError(403, 'Unauthorized Admin').handleError(response);
}


export function isSubscriberAuthorized(request: Request, response: Response, next: Function){
        const userInfo = request.userInfo;
        if(userInfo.role=='SUBSCRIBER')
            next();
        else
            new ExceptionError(403, 'Unauthorized Admin').handleError(response);
}
