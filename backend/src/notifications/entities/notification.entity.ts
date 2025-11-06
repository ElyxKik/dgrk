import {
  Entity,
  Column,
  PrimaryGeneratedColumn,
  CreateDateColumn,
  UpdateDateColumn,
  ManyToOne,
  JoinColumn,
} from 'typeorm';
import { User } from '../../users/entities/user.entity';

export enum NotificationType {
  INFO = 'info',
  WARNING = 'warning',
  SUCCESS = 'success',
  ERROR = 'error',
  REMINDER = 'reminder',
}

@Entity('notifications')
export class Notification {
  @PrimaryGeneratedColumn('uuid')
  id: string;

  @Column({
    type: 'enum',
    enum: NotificationType,
    default: NotificationType.INFO,
  })
  type: NotificationType;

  @Column({ length: 255 })
  titre: string;

  @Column({ type: 'text' })
  message: string;

  @Column({ default: false })
  estLu: boolean;

  @Column({ type: 'simple-json', nullable: true })
  metadata: Record<string, any>; // Données supplémentaires

  @Column({ nullable: true, length: 255 })
  actionUrl: string; // URL vers laquelle rediriger

  @Column({ nullable: true })
  dateExpiration: Date;

  @CreateDateColumn()
  createdAt: Date;

  @UpdateDateColumn()
  updatedAt: Date;

  // Relations
  @ManyToOne(() => User, (user) => user.notifications)
  @JoinColumn({ name: 'userId' })
  user: User;

  @Column()
  userId: string;
}
