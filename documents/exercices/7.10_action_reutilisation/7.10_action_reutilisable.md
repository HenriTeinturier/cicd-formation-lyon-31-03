# Exercice : Création d'une Action Réutilisable

## 🔍 Contexte

Vous devez créer une action réutilisable pour configurer un projet Node.js. Cette action permettra d'installer Node.js et les dépendances d'un projet, avec la possibilité de choisir le gestionnaire de paquets et la version de Node.js. Elle sera utilisée dans plusieurs workflows pour éviter la duplication de code.

> 💡 **Code de départ** : 
> - [Workflow réutilisable (check-test.yml)](check-test.yml)
> - [Workflow principal (cicd.yml)](cicd.yml)

## 🎯 Objectifs pédagogiques

* Comprendre la structure d'une action réutilisable
* Maîtriser la syntaxe YAML pour les actions
* Utiliser les inputs et leurs paramètres
* Implémenter des steps dans une action composite
* Réutiliser l'action dans un workflow

## 📊 Structure d'une action

Une action réutilisable se trouve dans le dossier `.github/actions/setup-node-project/` et contient :
- `action.yml` : le fichier principal de configuration
- `README.md` : la documentation (optionnel)

## 📝 Étapes de réalisation

### 1️⃣ Configuration de base

1. Créer le dossier `.github/actions/setup-node-project/`
2. Créer le fichier `action.yml` avec la structure de base :
```yaml
name: 'Nom de l'action'
description: 'Description de ce que fait l'action'

inputs:
  # Les inputs seront définis ici

runs:
  using: "composite"
  steps:
    # Les steps seront définis ici
```

### 2️⃣ Configuration des inputs

Notre action doit :
- Installer Node.js avec une version spécifiable
- Installer les dépendances avec le gestionnaire de paquets choisi
- Permettre de choisir entre npm, yarn et pnpm
- Avoir des valeurs par défaut pour tous les inputs

Chaque input peut avoir les propriétés suivantes :
```yaml
mon-input:
  description: "Description de l'input"
  required: false
  default: "valeur par défaut"
  type: string  # ou boolean, number, etc.
```

Exemple d'une action simple avec deux inputs :
```yaml
name: 'Greet User'
description: 'Affiche un message de bienvenue personnalisé'

inputs:
  username:
    description: "Nom de l'utilisateur"
    required: true
  language:
    description: "Langue du message"
    required: false
    default: "fr"

runs:
  using: "composite"
  steps:
    - name: Display greeting
      shell: bash
      run: |
        if [ "${{ inputs.language }}" = "fr" ]; then
          echo "Bonjour ${{ inputs.username }} !"
        else
          echo "Hello ${{ inputs.username }} !"
        fi
```

### 3️⃣ Utilisation dans un workflow

Pour utiliser l'action dans un workflow :
```yaml
jobs:
  mon-job:
    steps:
      - uses: ./.github/actions/setup-node-project
        with:
          # Les inputs seront définis ici
```

Maintenant, vous devez intégrer cette action dans deux workflows existants :

1. Dans le workflow `cicd.yml` :
   - Remplacer les étapes d'installation de Node.js et des dépendances dans les jobs `check-frontend` et `build-frontend`
   - Adapter les paramètres selon le contexte (client ou server)

2. Dans le workflow réutilisable `check-test.yml` :
   - Remplacer les étapes d'installation de Node.js et des dépendances
   - Utiliser les inputs du workflow réutilisable pour configurer l'action

Cette modification permettra de centraliser la configuration de Node.js et l'installation des dépendances dans une seule action réutilisable.

## 🛠️ Conseils techniques

* Utilisez des noms descriptifs pour les actions
* Documentez bien les inputs
* Pensez aux valeurs par défaut
* Testez l'action dans un workflow simple

## ⚠️ Points d'attention

* Les chemins dans `uses` sont relatifs au dossier `.github`
* Les actions composites utilisent `using: "composite"`
* Les steps peuvent utiliser des conditions avec `if`

## ✅ Critères de réussite

* L'action est correctement structurée
* Les inputs sont bien documentés
* L'action s'exécute sans erreur
* L'action est réutilisable dans différents workflows