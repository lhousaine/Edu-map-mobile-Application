import { Response } from "express";

abstract class SystemException {
    code: number = 0;
    message: string = "";

    constructor(code: number, message: string){
        this.code = code;
        this.message = message;
    }
    abstract handleError(response: Response) : Response;
}

export class ExceptionError extends SystemException {
    
    constructor(code: number, message: string){
        super(code, message);
    }

    handleError(response: Response) {
        return response.status(this.code).send({ message: this.message });
    }

}

