import { Injectable, NotFoundException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { Contract } from './entities/contract.entity';

@Injectable()
export class ContractsService {
  constructor(
    @InjectRepository(Contract)
    private contractsRepository: Repository<Contract>,
  ) {}

  async create(contractData: Partial<Contract>): Promise<Contract> {
    contractData.numeroContrat = await this.generateNumeroContrat();
    const contract = this.contractsRepository.create(contractData);
    return this.contractsRepository.save(contract);
  }

  async findAll(): Promise<Contract[]> {
    return this.contractsRepository.find({
      relations: ['property', 'owner', 'tenant'],
    });
  }

  async findOne(id: string): Promise<Contract> {
    const contract = await this.contractsRepository.findOne({
      where: { id },
      relations: ['property', 'owner', 'tenant', 'revenues'],
    });
    if (!contract) {
      throw new NotFoundException(`Contrat avec l'ID ${id} non trouvé`);
    }
    return contract;
  }

  async update(id: string, updateData: Partial<Contract>): Promise<Contract> {
    await this.contractsRepository.update(id, updateData);
    return this.findOne(id);
  }

  async remove(id: string): Promise<void> {
    const result = await this.contractsRepository.delete(id);
    if (result.affected === 0) {
      throw new NotFoundException(`Contrat avec l'ID ${id} non trouvé`);
    }
  }

  private async generateNumeroContrat(): Promise<string> {
    const prefix = 'CONT';
    const year = new Date().getFullYear();
    const timestamp = Date.now().toString().slice(-6);
    const random = Math.floor(Math.random() * 100).toString().padStart(2, '0');
    return `${prefix}${year}${timestamp}${random}`;
  }
}
