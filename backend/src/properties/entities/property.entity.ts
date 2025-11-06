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
import { PropertyType } from '../../common/enums/property-type.enum';
import { PropertyStatus } from '../../common/enums/property-status.enum';
import { User } from '../../users/entities/user.entity';
import { Contract } from '../../contracts/entities/contract.entity';

@Entity('properties')
export class Property {
  @PrimaryGeneratedColumn('uuid')
  id: string;

  @Column({ unique: true, length: 50 })
  numeroIdentification: string; // Numéro unique du bien

  @Column({ length: 255 })
  adresse: string;

  @Column({ length: 100 })
  commune: string;

  @Column({ length: 100 })
  quartier: string;

  @Column({ nullable: true, length: 100 })
  avenue: string;

  @Column({ nullable: true, length: 50 })
  numeroParcelle: string;

  @Column({
    type: 'enum',
    enum: PropertyType,
  })
  type: PropertyType;

  @Column({ type: 'decimal', precision: 10, scale: 2 })
  superficie: number; // en m²

  @Column({ type: 'int', default: 1 })
  nombreChambres: number;

  @Column({ type: 'int', default: 1 })
  nombreSallesBain: number;

  @Column({ type: 'decimal', precision: 12, scale: 2 })
  loyerMensuel: number; // en FC (Francs Congolais)

  @Column({
    type: 'enum',
    enum: PropertyStatus,
    default: PropertyStatus.DISPONIBLE,
  })
  statut: PropertyStatus;

  @Column({ type: 'text', nullable: true })
  description: string;

  @Column({ type: 'simple-array', nullable: true })
  photos: string[]; // URLs des photos

  @Column({ type: 'simple-json', nullable: true })
  equipements: string[]; // Liste des équipements

  @Column({ type: 'decimal', precision: 10, scale: 2, nullable: true })
  latitude: number;

  @Column({ type: 'decimal', precision: 10, scale: 2, nullable: true })
  longitude: number;

  @CreateDateColumn()
  createdAt: Date;

  @UpdateDateColumn()
  updatedAt: Date;

  // Relations
  @ManyToOne(() => User, (user) => user.properties)
  @JoinColumn({ name: 'ownerId' })
  owner: User;

  @Column()
  ownerId: string;

  @OneToMany(() => Contract, (contract) => contract.property)
  contracts: Contract[];
}
