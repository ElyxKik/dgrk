# 🚀 Guide de Déploiement - DGRK Application

## Configuration GitHub Pages

### Étape 1: Configuration Automatique (Déjà Faite ✅)

Le workflow GitHub Actions est configuré pour:
- ✅ Builder automatiquement l'app Flutter Web à chaque push sur `main`
- ✅ Déployer sur GitHub Pages
- ✅ Utiliser le chemin de base `/dgrk/`

### Étape 2: Configuration Manuelle de GitHub Pages

1. **Accès aux paramètres:**
   - Va sur: https://github.com/ElyxKik/dgrk/settings/pages

2. **Configure les paramètres:**
   - **Source:** Deploy from a branch
   - **Branch:** `gh-pages`
   - **Folder:** `/ (root)`
   - Clique **Save**

3. **Attends le déploiement:**
   - GitHub crée automatiquement la branche `gh-pages`
   - Le workflow GitHub Actions s'exécute
   - Attends ~2-3 minutes

### Étape 3: Accès à l'Application

Une fois déployée, ton application sera disponible à:

**🌐 URL:** https://ElyxKik.github.io/dgrk/

## 📊 Workflow de Déploiement

```
1. Push sur main
        ↓
2. GitHub Actions déclenché
        ↓
3. Flutter build web --release
        ↓
4. Upload vers gh-pages
        ↓
5. GitHub Pages déploie
        ↓
6. App disponible en ligne ✅
```

## 🔄 Déploiements Futurs

À chaque fois que tu pushes sur `main`:
1. Le workflow s'exécute automatiquement
2. L'app est rebuildée
3. Les changements sont déployés immédiatement

**Aucune action manuelle requise!**

## 📝 Fichiers de Configuration

- `.github/workflows/deploy-web.yml` - Workflow GitHub Actions
- `.nojekyll` - Désactive Jekyll pour Flutter Web
- `mobile/build/web/` - Build output (généré automatiquement)

## 🐛 Dépannage

### L'app ne charge pas
- Vérifier que GitHub Pages est activé
- Vérifier que la branche `gh-pages` existe
- Attendre 5 minutes après le push

### Erreur de build
- Vérifier les logs du workflow: https://github.com/ElyxKik/dgrk/actions
- Vérifier que `flutter pub get` fonctionne localement
- Vérifier qu'il n'y a pas d'erreurs Dart

### Problèmes de CORS avec l'API
- Configurer le backend pour accepter les requêtes depuis `https://ElyxKik.github.io`
- Utiliser des variables d'environnement pour les URLs d'API
- Voir la section "Configuration API" ci-dessous

## 🔌 Configuration API

Pour communiquer avec ton backend:

1. **Créer un fichier `.env` dans `mobile/`:**
```
API_BASE_URL=https://ton-api.com
```

2. **Utiliser dans le code:**
```dart
final apiUrl = String.fromEnvironment('API_BASE_URL', 
  defaultValue: 'http://localhost:3000');
```

3. **Builder avec les variables:**
```bash
flutter build web --release \
  --dart-define=API_BASE_URL=https://ton-api.com
```

## 📚 Ressources

- [Flutter Web Deployment](https://docs.flutter.dev/deployment/web)
- [GitHub Pages Documentation](https://docs.github.com/en/pages)
- [GitHub Actions for Flutter](https://github.com/subosito/flutter-action)

## ✅ Checklist de Déploiement

- [x] Workflow GitHub Actions créé
- [x] `.nojekyll` configuré
- [x] Code poussé sur GitHub
- [ ] GitHub Pages configuré (manuel)
- [ ] App accessible en ligne
- [ ] API backend déployée
- [ ] CORS configuré
- [ ] Tests en production

---

**Dernière mise à jour:** 6 Novembre 2025
**Status:** ✅ Prêt pour le déploiement
