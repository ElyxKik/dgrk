import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { RevenuesController } from './revenues.controller';
import { RevenuesService } from './revenues.service';
import { Revenue } from './entities/revenue.entity';

@Module({
  imports: [TypeOrmModule.forFeature([Revenue])],
  controllers: [RevenuesController],
  providers: [RevenuesService],
  exports: [RevenuesService],
})
export class RevenuesModule {}
