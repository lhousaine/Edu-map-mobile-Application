import { DocumentReference, QuerySnapshot,} from "@google-cloud/firestore";
import { DocumentSnapshot } from "firebase-functions/lib/providers/firestore";

export abstract class Repository<T> {
    abstract async getById(id: string): Promise<DocumentSnapshot>;

    abstract async getAll(): Promise<QuerySnapshot>;

    abstract async post(entity: T): Promise<DocumentReference>;

    abstract async update(id: string, entity: T): Promise<string>;

    abstract async remove(entityId: string): Promise<string>;
}