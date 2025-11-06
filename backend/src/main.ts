import { NestFactory } from '@nestjs/core';
import { ValidationPipe } from '@nestjs/common';
import { SwaggerModule, DocumentBuilder } from '@nestjs/swagger';
import { ConfigService } from '@nestjs/config';
import * as helmet from 'helmet';
import * as compression from 'compression';
import { AppModule } from './app.module';
import { LoggerService } from './common/services/logger.service';

async function bootstrap() {
  const app = await NestFactory.create(AppModule, {
    logger: new LoggerService(),
  });

  const configService = app.get(ConfigService);
  const port = configService.get<number>('PORT', 3000);

  // Security
  app.use(helmet());
  app.enableCors({
    origin: configService.get<string>('FRONTEND_URL'),
    credentials: true,
  });

  // Compression
  app.use(compression());

  // Global validation pipe
  app.useGlobalPipes(
    new ValidationPipe({
      whitelist: true,
      forbidNonWhitelisted: true,
      transform: true,
      transformOptions: {
        enableImplicitConversion: true,
      },
    }),
  );

  // API prefix
  app.setGlobalPrefix('api/v1');

  // Swagger documentation
  const config = new DocumentBuilder()
    .setTitle('DGRK API')
    .setDescription('API pour la gestion de l\'impôt sur le revenu locatif - Direction Générale de Recette de Kinshasa')
    .setVersion('1.0')
    .addBearerAuth()
    .addTag('Authentication', 'Endpoints d\'authentification et de sécurité')
    .addTag('Users', 'Gestion des utilisateurs')
    .addTag('Properties', 'Gestion des biens immobiliers')
    .addTag('Contracts', 'Gestion des contrats de bail')
    .addTag('Revenues', 'Déclaration des revenus locatifs')
    .addTag('Payments', 'Gestion des paiements')
    .addTag('Notifications', 'Système de notifications')
    .build();

  const document = SwaggerModule.createDocument(app, config);
  SwaggerModule.setup('api/docs', app, document);

  await app.listen(port);
  
  console.log(`
    ╔═══════════════════════════════════════════════════════════╗
    ║                                                           ║
    ║   🏛️  DGRK API - Direction Générale de Recette de Kinshasa ║
    ║                                                           ║
    ║   🚀 Server running on: http://localhost:${port}           ║
    ║   📚 API Documentation: http://localhost:${port}/api/docs  ║
    ║   🌍 Environment: ${configService.get('NODE_ENV')}                  ║
    ║                                                           ║
    ╚═══════════════════════════════════════════════════════════╝
  `);
}

bootstrap();
