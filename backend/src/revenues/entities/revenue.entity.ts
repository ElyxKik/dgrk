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
import { User } from '../../users/entities/user.entity';
import { Contract } from '../../contracts/entities/contract.entity';
import { Payment } from '../../payments/entities/payment.entity';

@Entity('revenues')
export class Revenue {
  @PrimaryGeneratedColumn('uuid')
  id: string;

  @Column({ type: 'int' })
  mois: number; // 1-12

  @Column({ type: 'int' })
  annee: number;

  @Column({ type: 'decimal', precision: 12, scale: 2 })
  montantRevenu: number; // Revenu locatif déclaré

  @Column({ type: 'decimal', precision: 5, scale: 4 })
  tauxImposition: number; // Taux d'imposition appliqué (ex: 0.15 pour 15%)

  @Column({ type: 'decimal', precision: 12, scale: 2 })
  montantImpot: number; // Impôt calculé

  @Column({ type: 'decimal', precision: 12, scale: 2, default: 0 })
  montantExoneration: number; // Montant exonéré

  @Column({ type: 'decimal', precision: 12, scale: 2, default: 0 })
  montantReduction: number; // Réductions appliquées

  @Column({ type: 'decimal', precision: 12, scale: 2 })
  montantNetAPayer: number; // Montant final à payer

  @Column({ default: false })
  estPaye: boolean;

  @Column({ type: 'date', nullable: true })
  datePaiement: Date;

  @Column({ type: 'date' })
  dateDeclaration: Date;

  @Column({ type: 'date', nullable: true })
  dateEcheance: Date;

  @Column({ type: 'text', nullable: true })
  notes: string;

  @CreateDateColumn()
  createdAt: Date;

  @UpdateDateColumn()
  updatedAt: Date;

  // Relations
  @ManyToOne(() => User)
  @JoinColumn({ name: 'ownerId' })
  owner: User;

  @Column()
  ownerId: string;

  @ManyToOne(() => Contract, (contract) => contract.revenues, {
    nullable: true,
  })
  @JoinColumn({ name: 'contractId' })
  contract: Contract;

  @Column({ nullable: true })
  contractId: string;

  @OneToMany(() => Payment, (payment) => payment.revenue)
  payments: Payment[];
}
