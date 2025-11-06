# DGRK - Direction Générale de Recette de Kinshasa

Application mobile de gestion de l'impôt sur le revenu locatif pour la ville de Kinshasa.

## 🏗️ Architecture

### Backend
- **Framework**: NestJS (Node.js)
- **Base de données**: PostgreSQL
- **ORM**: TypeORM
- **Authentification**: JWT + MFA
- **Documentation API**: Swagger
- **Stockage**: AWS S3 / Firebase Storage
- **Paiements**: Mobile Money (Orange, Airtel, M-Pesa), Stripe, Flutterwave

### Frontend
- **Framework**: Flutter (Android & iOS)
- **Architecture**: Clean Architecture (Domain, Data, Presentation)
- **State Management**: Bloc/Cubit
- **Notifications**: Firebase Cloud Messaging
- **Stockage local**: Hive/Sqflite

## 📁 Structure du projet

```
DGRK/
├── backend/                 # API NestJS
│   ├── src/
│   │   ├── auth/           # Module d'authentification
│   │   ├── users/          # Gestion des utilisateurs
│   │   ├── properties/     # Gestion des biens immobiliers
│   │   ├── contracts/      # Gestion des contrats de bail
│   │   ├── revenues/       # Déclaration des revenus
│   │   ├── payments/       # Gestion des paiements
│   │   ├── notifications/  # Système de notifications
│   │   ├── common/         # Utilitaires communs
│   │   └── config/         # Configuration
│   ├── test/
│   └── package.json
│
├── mobile/                  # Application Flutter
│   ├── lib/
│   │   ├── core/           # Fonctionnalités de base
│   │   ├── features/       # Modules fonctionnels
│   │   │   ├── auth/
│   │   │   ├── properties/
│   │   │   ├── contracts/
│   │   │   ├── revenues/
│   │   │   ├── payments/
│   │   │   └── dashboard/
│   │   └── main.dart
│   ├── test/
│   └── pubspec.yaml
│
└── docs/                    # Documentation
    ├── API.md
    ├── DEPLOYMENT.md
    └── USER_GUIDE.md
```

## 🚀 Démarrage rapide

### Backend

```bash
cd backend
npm install
cp .env.example .env
# Configurer les variables d'environnement
npm run start:dev
```

### Mobile

```bash
cd mobile
flutter pub get
flutter run
```

## 📱 Fonctionnalités principales

### Pour les propriétaires
- ✅ Enregistrement et gestion des biens immobiliers
- ✅ Génération automatique de contrats de bail
- ✅ Déclaration des revenus locatifs
- ✅ Calcul automatique de l'impôt
- ✅ Paiement en ligne (Mobile Money, carte bancaire)
- ✅ Tableau de bord avec statistiques
- ✅ Historique complet des transactions

### Pour les locataires
- ✅ Consultation des contrats
- ✅ Signature numérique
- ✅ Historique des paiements

### Pour les agents fiscaux
- ✅ Suivi des déclarations
- ✅ Validation des paiements
- ✅ Génération de rapports
- ✅ Gestion des contribuables

### Pour les administrateurs
- ✅ Gestion complète des utilisateurs
- ✅ Configuration des barèmes fiscaux
- ✅ Audit logs
- ✅ Statistiques globales

## 🔒 Sécurité

- Authentification JWT avec refresh tokens
- MFA (authentification à deux facteurs)
- Chiffrement AES-256 pour les données sensibles
- HTTPS obligatoire
- Rate limiting
- Validation des entrées côté serveur
- Protection CSRF
- Audit logs complets

## 📊 Base de données

### Tables principales
- `users` - Utilisateurs du système
- `properties` - Biens immobiliers
- `contracts` - Contrats de bail
- `revenues` - Revenus locatifs déclarés
- `payments` - Paiements effectués
- `notifications` - Notifications utilisateur
- `audit_logs` - Journaux d'audit

## 🧪 Tests

### Backend
```bash
npm run test
npm run test:e2e
npm run test:cov
```

### Mobile
```bash
flutter test
flutter test --coverage
```

## 📦 Déploiement

### Backend
- **Production**: AWS / Render / Railway
- **CI/CD**: GitHub Actions
- **Monitoring**: Sentry + PM2

### Mobile
- **Android**: Google Play Store
- **iOS**: Apple App Store
- **Distribution**: Firebase App Distribution (test)

## 📝 Licence

Propriétaire - Direction Générale de Recette de Kinshasa

## 👥 Contact

Pour toute question ou support, contactez l'équipe DGRK.
