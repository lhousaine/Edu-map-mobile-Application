import { SchoolService } from "../services/school_service";
import { ExceptionError } from "../../core/exceptions/exceptions";

import { Request, Response } from "express";
import {
  buildResponseSchool,
  verifySchoolRequestBody
} from "../utils/school_utils";
import { MISSING_ID, MISSING_DATA } from "../../core/exceptions/messages";
import { SchoolModel } from "../../core/models/school_model";

const schoolService = new SchoolService();

export class SchoolController {
  async getById(request: Request, response: Response) {
    try {
      const idSchool = request.params.idSchool;
      if (!idSchool) throw new Error("School - " + MISSING_ID);

      const schoolModel: SchoolModel = await schoolService.getById(idSchool);
      response.json(buildResponseSchool(schoolModel));
    } catch (error) {
      new ExceptionError(500, error.message).handleError(response);
    }
  }

  async getTrendingSchools(request: Request, response: Response) {
    try {
      const schools: SchoolModel[] = await schoolService.getTrendingSchool();
      response.json(schools);
    } catch (error) {
      new ExceptionError(500, error.message).handleError(response);
    }
  }

  async getNearestSchoolsToCoodinate(request: Request, response: Response) {
    try {
      const schoolData = request.body;
      if (!schoolData) throw new Error("Data does not defined");
      if (!schoolData.coordinates)
        throw new Error("Coordinates does not defined");
      if (!schoolData.radius)
        throw new Error("You should define the radius you want to sursh with");
      const schools: SchoolModel[] = await schoolService.getNearestSchoolsToCoodinate(
        schoolData.coordinates,
        schoolData.radius
      );
      response.json(schools);
    } catch (error) {
      new ExceptionError(500, error.message).handleError(response);
    }
  }

  async getAllfiltrateSchools(request: Request, response: Response) {
    try {
      const schoolFiltrate = request.body;
      if (
        !schoolFiltrate.keyword &&
        !schoolFiltrate.city &&
        !schoolFiltrate.rating &&
        !schoolFiltrate.educationCycle
      )
        throw new Error(
          "you should define at least one parameter to filtrate with"
        );
      const schools: SchoolModel[] = await schoolService.getAllfiltratedSchools(
        schoolFiltrate
      );
      response.json(schools);
    } catch (error) {
      new ExceptionError(500, error.message).handleError(response);
    }
  }

  async getAll(request: Request, response: Response) {
    try {
      const schools: SchoolModel[] = await schoolService.getAll();
      response.json(schools);
    } catch (error) {
      new ExceptionError(500, error.message).handleError(response);
    }
  }

  async create(request: Request, response: Response) {
    try {
      verifySchoolRequestBody(request);
      const school: SchoolEntity = request.body;
      const schoolId: string = await schoolService.post(school);
      response
        .status(200)
        .json(buildResponseSchool(new SchoolModel(schoolId, school)));
    } catch (error) {
      new ExceptionError(400, error.message).handleError(response);
    }
  }

  async update(request: Request, response: Response): Promise<any> {
    try {
      let idSchool = request.params.idSchool;
      const newSchoolData = request.body;

      if (!idSchool) throw new Error("School - " + MISSING_ID);

      if (!newSchoolData) throw new Error("School - " + MISSING_DATA);

      idSchool = await schoolService.update(idSchool, newSchoolData);

      response.json(
        buildResponseSchool(new SchoolModel(idSchool, newSchoolData))
      );
    } catch (error) {
      new ExceptionError(400, error.message).handleError(response);
    }
  }

  async remove(request: Request, response: Response): Promise<any> {
    try {
      let idSchool = request.params.idSchool;
      if (!idSchool) throw new Error("School - " + MISSING_ID);
      idSchool = await schoolService.remove(idSchool);
      response.json({
        id: idSchool
      });
    } catch (error) {
      new ExceptionError(500, error.message).handleError(response);
    }
  }
}
