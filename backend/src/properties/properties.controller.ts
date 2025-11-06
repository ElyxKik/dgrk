import { Controller, Get, Post, Body, Patch, Param, Delete } from '@nestjs/common';
import { ApiTags, ApiOperation } from '@nestjs/swagger';
import { PropertiesService } from './properties.service';

@ApiTags('Properties')
@Controller('properties')
export class PropertiesController {
  constructor(private readonly propertiesService: PropertiesService) {}

  @Post()
  @ApiOperation({ summary: 'Créer un nouveau bien immobilier' })
  create(@Body() createPropertyDto: any) {
    return this.propertiesService.create(createPropertyDto);
  }

  @Get()
  @ApiOperation({ summary: 'Récupérer tous les biens' })
  findAll() {
    return this.propertiesService.findAll();
  }

  @Get('owner/:ownerId')
  @ApiOperation({ summary: 'Récupérer les biens d\'un propriétaire' })
  findByOwner(@Param('ownerId') ownerId: string) {
    return this.propertiesService.findByOwner(ownerId);
  }

  @Get(':id')
  @ApiOperation({ summary: 'Récupérer un bien par ID' })
  findOne(@Param('id') id: string) {
    return this.propertiesService.findOne(id);
  }

  @Patch(':id')
  @ApiOperation({ summary: 'Mettre à jour un bien' })
  update(@Param('id') id: string, @Body() updatePropertyDto: any) {
    return this.propertiesService.update(id, updatePropertyDto);
  }

  @Delete(':id')
  @ApiOperation({ summary: 'Supprimer un bien' })
  remove(@Param('id') id: string) {
    return this.propertiesService.remove(id);
  }
}
