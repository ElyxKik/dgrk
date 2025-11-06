import { Controller, Get, Post, Body, Patch, Param, Delete } from '@nestjs/common';
import { ApiTags, ApiOperation } from '@nestjs/swagger';
import { RevenuesService } from './revenues.service';

@ApiTags('Revenues')
@Controller('revenues')
export class RevenuesController {
  constructor(private readonly revenuesService: RevenuesService) {}

  @Post()
  @ApiOperation({ summary: 'Déclarer un revenu locatif' })
  create(@Body() createRevenueDto: any) {
    return this.revenuesService.create(createRevenueDto);
  }

  @Get()
  @ApiOperation({ summary: 'Récupérer tous les revenus' })
  findAll() {
    return this.revenuesService.findAll();
  }

  @Get('owner/:ownerId')
  @ApiOperation({ summary: 'Récupérer les revenus d\'un propriétaire' })
  findByOwner(@Param('ownerId') ownerId: string) {
    return this.revenuesService.findByOwner(ownerId);
  }

  @Get(':id')
  @ApiOperation({ summary: 'Récupérer un revenu par ID' })
  findOne(@Param('id') id: string) {
    return this.revenuesService.findOne(id);
  }

  @Patch(':id')
  @ApiOperation({ summary: 'Mettre à jour un revenu' })
  update(@Param('id') id: string, @Body() updateRevenueDto: any) {
    return this.revenuesService.update(id, updateRevenueDto);
  }

  @Delete(':id')
  @ApiOperation({ summary: 'Supprimer un revenu' })
  remove(@Param('id') id: string) {
    return this.revenuesService.remove(id);
  }
}
