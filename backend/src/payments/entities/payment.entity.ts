import {
  Entity,
  Column,
  PrimaryGeneratedColumn,
  CreateDateColumn,
  UpdateDateColumn,
  ManyToOne,
  JoinColumn,
} from 'typeorm';
import { PaymentStatus } from '../../common/enums/payment-status.enum';
import { PaymentMethod } from '../../common/enums/payment-method.enum';
import { User } from '../../users/entities/user.entity';
import { Revenue } from '../../revenues/entities/revenue.entity';

@Entity('payments')
export class Payment {
  @PrimaryGeneratedColumn('uuid')
  id: string;

  @Column({ unique: true, length: 100 })
  referenceTransaction: string; // Référence unique de la transaction

  @Column({ type: 'decimal', precision: 12, scale: 2 })
  montant: number;

  @Column({
    type: 'enum',
    enum: PaymentMethod,
  })
  methodePaiement: PaymentMethod;

  @Column({
    type: 'enum',
    enum: PaymentStatus,
    default: PaymentStatus.PENDING,
  })
  statut: PaymentStatus;

  @Column({ nullable: true, length: 255 })
  numeroTelephone: string; // Pour Mobile Money

  @Column({ nullable: true, length: 255 })
  referenceExterne: string; // Référence du fournisseur de paiement

  @Column({ nullable: true, length: 255 })
  recuUrl: string; // URL du reçu PDF

  @Column({ type: 'text', nullable: true })
  detailsTransaction: string; // JSON avec détails supplémentaires

  @Column({ type: 'text', nullable: true })
  messageErreur: string;

  @Column({ type: 'timestamp', nullable: true })
  dateTraitement: Date;

  @CreateDateColumn()
  createdAt: Date;

  @UpdateDateColumn()
  updatedAt: Date;

  // Relations
  @ManyToOne(() => User, (user) => user.payments)
  @JoinColumn({ name: 'userId' })
  user: User;

  @Column()
  userId: string;

  @ManyToOne(() => Revenue, (revenue) => revenue.payments)
  @JoinColumn({ name: 'revenueId' })
  revenue: Revenue;

  @Column()
  revenueId: string;
}
