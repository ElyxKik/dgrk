import {
  Entity,
  Column,
  PrimaryGeneratedColumn,
  CreateDateColumn,
  UpdateDateColumn,
  ManyToOne,
  OneToMany,
  JoinColumn,
} from 'typeorm';
import { ContractStatus } from '../../common/enums/contract-status.enum';
import { User } from '../../users/entities/user.entity';
import { Property } from '../../properties/entities/property.entity';
import { Revenue } from '../../revenues/entities/revenue.entity';

@Entity('contracts')
export class Contract {
  @PrimaryGeneratedColumn('uuid')
  id: string;

  @Column({ unique: true, length: 50 })
  numeroContrat: string; // Numéro unique du contrat

  @Column({ type: 'date' })
  dateDebut: Date;

  @Column({ type: 'date' })
  dateFin: Date;

  @Column({ type: 'decimal', precision: 12, scale: 2 })
  montantLoyer: number;

  @Column({ type: 'decimal', precision: 12, scale: 2, default: 0 })
  caution: number; // Dépôt de garantie

  @Column({ type: 'int', default: 12 })
  dureeEnMois: number;

  @Column({
    type: 'enum',
    enum: ContractStatus,
    default: ContractStatus.BROUILLON,
  })
  statut: ContractStatus;

  @Column({ type: 'text', nullable: true })
  conditions: string; // Conditions particulières

  @Column({ nullable: true, length: 255 })
  documentUrl: string; // URL du PDF du contrat

  @Column({ type: 'date', nullable: true })
  dateSignatureProprietaire: Date;

  @Column({ type: 'date', nullable: true })
  dateSignatureLocataire: Date;

  @Column({ nullable: true, length: 255 })
  signatureProprietaireUrl: string;

  @Column({ nullable: true, length: 255 })
  signatureLocataireUrl: string;

  @CreateDateColumn()
  createdAt: Date;

  @UpdateDateColumn()
  updatedAt: Date;

  // Relations
  @ManyToOne(() => Property, (property) => property.contracts)
  @JoinColumn({ name: 'propertyId' })
  property: Property;

  @Column()
  propertyId: string;

  @ManyToOne(() => User, (user) => user.ownedContracts)
  @JoinColumn({ name: 'ownerId' })
  owner: User;

  @Column()
  ownerId: string;

  @ManyToOne(() => User, (user) => user.tenantContracts, { nullable: true })
  @JoinColumn({ name: 'tenantId' })
  tenant: User;

  @Column({ nullable: true })
  tenantId: string;

  @OneToMany(() => Revenue, (revenue) => revenue.contract)
  revenues: Revenue[];
}
