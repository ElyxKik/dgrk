#!/bin/bash

# Script de déploiement DGRK sur GitHub Pages
# Usage: bash deploy.sh

set -e

echo "🚀 Déploiement DGRK sur GitHub Pages..."
echo ""

# Vérifier que le build web existe
if [ ! -d "mobile/build/web" ]; then
    echo "❌ Erreur: mobile/build/web n'existe pas"
    echo "Exécute d'abord: flutter build web --release"
    exit 1
fi

echo "✅ Build web trouvé"
echo ""

# Sauvegarder la branche actuelle
CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)
echo "📌 Branche actuelle: $CURRENT_BRANCH"
echo ""

# Créer ou basculer vers gh-pages
echo "🔄 Création/basculement vers branche gh-pages..."
git checkout --orphan gh-pages 2>/dev/null || git checkout gh-pages

# Nettoyer les fichiers existants
echo "🧹 Nettoyage des fichiers..."
git rm -rf . 2>/dev/null || true

# Copier les fichiers du build
echo "📋 Copie des fichiers du build..."
cp -r mobile/build/web/* .

# Créer .gitkeep pour les dossiers vides
touch .gitkeep

# Ajouter tous les fichiers
echo "📦 Ajout des fichiers..."
git add .

# Créer le commit
echo "💾 Création du commit..."
git commit -m "Deploy: Flutter web build to GitHub Pages

- Build date: $(date)
- Flutter version: $(flutter --version | head -1)
- Commit: $(git rev-parse --short HEAD)"

# Pousser vers GitHub
echo "🚀 Push vers GitHub..."
git push -u origin gh-pages --force

# Revenir à la branche principale
echo "↩️  Retour à la branche $CURRENT_BRANCH..."
git checkout $CURRENT_BRANCH

echo ""
echo "✅ Déploiement terminé!"
echo ""
echo "🌐 Ton app est disponible à:"
echo "   https://ElyxKik.github.io/dgrk/"
echo ""
echo "📝 N'oublie pas de configurer GitHub Pages:"
echo "   1. Va sur: https://github.com/ElyxKik/dgrk/settings/pages"
echo "   2. Source: Deploy from a branch"
echo "   3. Branch: gh-pages"
echo "   4. Folder: / (root)"
echo "   5. Clique Save"
