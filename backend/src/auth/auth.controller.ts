import { Controller, Post, Body, UseGuards, Request } from '@nestjs/common';
import { ApiTags, ApiOperation } from '@nestjs/swagger';
import { AuthService } from './auth.service';

@ApiTags('Authentication')
@Controller('auth')
export class AuthController {
  constructor(private authService: AuthService) {}

  @Post('register')
  @ApiOperation({ summary: 'Inscription d\'un nouvel utilisateur' })
  async register(@Body() registerDto: any) {
    return this.authService.register(registerDto);
  }

  @Post('login')
  @ApiOperation({ summary: 'Connexion utilisateur' })
  async login(@Body() loginDto: { email: string; password: string }) {
    return this.authService.login(loginDto.email, loginDto.password);
  }

  @Post('mfa/enable')
  @ApiOperation({ summary: 'Activer l\'authentification à deux facteurs' })
  async enableMFA(@Body() body: { userId: string }) {
    return this.authService.enableMFA(body.userId);
  }

  @Post('mfa/verify')
  @ApiOperation({ summary: 'Vérifier le code MFA' })
  async verifyMFA(@Body() body: { userId: string; token: string }) {
    const isValid = await this.authService.verifyMFA(body.userId, body.token);
    return { valid: isValid };
  }
}
