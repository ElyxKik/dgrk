import { Injectable, NotFoundException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { Property } from './entities/property.entity';

@Injectable()
export class PropertiesService {
  constructor(
    @InjectRepository(Property)
    private propertiesRepository: Repository<Property>,
  ) {}

  async create(propertyData: Partial<Property>): Promise<Property> {
    propertyData.numeroIdentification = await this.generateNumeroIdentification();
    const property = this.propertiesRepository.create(propertyData);
    return this.propertiesRepository.save(property);
  }

  async findAll(): Promise<Property[]> {
    return this.propertiesRepository.find({ relations: ['owner', 'contracts'] });
  }

  async findByOwner(ownerId: string): Promise<Property[]> {
    return this.propertiesRepository.find({ where: { ownerId }, relations: ['contracts'] });
  }

  async findOne(id: string): Promise<Property> {
    const property = await this.propertiesRepository.findOne({
      where: { id },
      relations: ['owner', 'contracts'],
    });
    if (!property) {
      throw new NotFoundException(`Bien avec l'ID ${id} non trouvé`);
    }
    return property;
  }

  async update(id: string, updateData: Partial<Property>): Promise<Property> {
    await this.propertiesRepository.update(id, updateData);
    return this.findOne(id);
  }

  async remove(id: string): Promise<void> {
    const result = await this.propertiesRepository.delete(id);
    if (result.affected === 0) {
      throw new NotFoundException(`Bien avec l'ID ${id} non trouvé`);
    }
  }

  private async generateNumeroIdentification(): Promise<string> {
    const prefix = 'PROP';
    const timestamp = Date.now().toString().slice(-8);
    const random = Math.floor(Math.random() * 1000).toString().padStart(3, '0');
    return `${prefix}${timestamp}${random}`;
  }
}
