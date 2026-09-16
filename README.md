# Traitement d'image

## Description

Ce projet est un mini-projet universitaire réalisé dans le cadre du module Informatique 3 : Programmation en Python et en Matlab.

L'objectif est d'étudier la représentation et la manipulation des images numériques sous différentes formes :
- Images noir et blanc
- Images en niveaux de gris
- Images RGB

Le projet implémente plusieurs opérations de traitement d'images à l'aide de Python.

## Technologies utilisées

- Python
- NumPy
- Matplotlib
- Pillow (PIL)

## Fonctionnalités

### 1. Lecture et affichage d'une image

Le programme permet d'ouvrir une image et de la convertir en niveaux de gris avant son affichage.

Fonctions utilisées :
- `lectureImage()`
- `afficher_image()`

### 2. Création d'une image noir et blanc

Le programme permet de générer une image sous forme de damier à partir de sa hauteur et de sa largeur.

Fonction :
- `image_noir_blanche()`

### 3. Négatif d'une image

La fonction `negatif()` permet d'inverser les valeurs d'une image noir et blanc.

```text
0 → 1
1 → 0
