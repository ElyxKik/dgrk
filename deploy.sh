#!/bin/bash

# Script de déploiement DGRK sur GitHub Pages
# Usage: bash deploy.sh

set -e

echo "🚀 Déploiement DGRK sur GitHub Pages..."
echo ""

# Reconstruire l'application Flutter Web avec le bon base-href
echo "🏗️  Reconstruction de l'application Flutter Web..."
(cd mobile && flutter build web --release --base-href=/dgrk/)
echo "✅ Build terminé avec succès!"
echo ""

# Sauvegarder la branche actuelle
CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)
echo "📌 Branche actuelle: $CURRENT_BRANCH"
echo ""

# Créer ou basculer vers gh-pages
echo "🔄 Création/basculement vers branche gh-pages..."
git checkout --orphan gh-pages 2>/dev/null || git checkout gh-pages

# Nettoyer les fichiers existants (uniquement sur la branche gh-pages)
if [ "$(git rev-parse --abbrev-ref HEAD)" == "gh-pages" ]; then
    echo "🧹 Nettoyage de la branche gh-pages..."
    git rm -rf . 2>/dev/null || true
fi

# Copier les fichiers du build
echo "📋 Copie des fichiers du build..."
cp -r ../mobile/build/web/* .

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
