import { Injectable, NotFoundException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { Revenue } from './entities/revenue.entity';
import { ConfigService } from '@nestjs/config';

@Injectable()
export class RevenuesService {
  constructor(
    @InjectRepository(Revenue)
    private revenuesRepository: Repository<Revenue>,
    private configService: ConfigService,
  ) {}

  async create(revenueData: Partial<Revenue>): Promise<Revenue> {
    // Calculer l'impôt
    const taxRate = this.configService.get<number>('DEFAULT_TAX_RATE', 0.15);
    const exemptionThreshold = this.configService.get<number>('TAX_EXEMPTION_THRESHOLD', 50000);
    
    const montantImposable = Math.max(0, revenueData.montantRevenu - exemptionThreshold);
    revenueData.montantImpot = montantImposable * taxRate;
    revenueData.montantNetAPayer = revenueData.montantImpot - (revenueData.montantReduction || 0);
    revenueData.tauxImposition = taxRate;
    revenueData.dateDeclaration = new Date();
    
    const revenue = this.revenuesRepository.create(revenueData);
    return this.revenuesRepository.save(revenue);
  }

  async findAll(): Promise<Revenue[]> {
    return this.revenuesRepository.find({
      relations: ['owner', 'contract', 'payments'],
    });
  }

  async findByOwner(ownerId: string): Promise<Revenue[]> {
    return this.revenuesRepository.find({
      where: { ownerId },
      relations: ['contract', 'payments'],
    });
  }

  async findOne(id: string): Promise<Revenue> {
    const revenue = await this.revenuesRepository.findOne({
      where: { id },
      relations: ['owner', 'contract', 'payments'],
    });
    if (!revenue) {
      throw new NotFoundException(`Revenu avec l'ID ${id} non trouvé`);
    }
    return revenue;
  }

  async update(id: string, updateData: Partial<Revenue>): Promise<Revenue> {
    await this.revenuesRepository.update(id, updateData);
    return this.findOne(id);
  }

  async remove(id: string): Promise<void> {
    const result = await this.revenuesRepository.delete(id);
    if (result.affected === 0) {
      throw new NotFoundException(`Revenu avec l'ID ${id} non trouvé`);
    }
  }
}
