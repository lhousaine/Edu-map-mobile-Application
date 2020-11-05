export abstract class Service<V,T> {
    abstract async getById(id: string): Promise<T>;

    
    abstract async getAll(): Promise<Array<T>>;

    abstract async post(entity: V): Promise<string>;

    abstract async update(id: string, entity: V): Promise<string>;

    abstract async remove(entityId: string): Promise<string>;
}