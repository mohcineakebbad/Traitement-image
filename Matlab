function main_image_processing
% Fonction principale qui contient toutes les sous-fonctions et la boucle principale
% Fonction pour lire une image et la convertir en niveaux de gris
function Img = lectureImage(filename)
    try
        Img = imread(filename);
        if size(Img, 3) == 3
            Img = rgb2gray(Img);
        end
    catch
        error('Image non trouvée ou chemin invalide');
    end
end

% affichage
function afficher_image(Img)
    figure;
    if ndims(Img) == 3 && size(Img, 3) == 3
        imshow(Img);
    else
        imshow(Img, []);
        colormap(gray);
    end
    title("Image blanche_noir");
    axis off;
end
% Sauvegarder l'image1
function saveImage(img)
    imwrite(img, "image1.png");
end

% définir l'image comme damier
function Img = image_noir_blanche(h, l)
    Img = ones(h, l);
    for i = 1:h
        for j = 1:l
            Img(i, j) = mod(i + j, 2);
        end
    end
end

% inverser l'image
function result = negatif(Img)
    % Normaliser entre 0 et 1 si nécessaire
    if max(Img(:)) > 1
        Img = double(Img) / 255;
    end
    result = 1 - Img;
end

% fonction de luminance
function moyenne = luminance(Img)
    [h, l] = size(Img);
    somme = 0;
    for i = 1:h
        for j = 1:l
            somme = somme + double(Img(i, j));
        end
    end
    moyenne = somme / (h * l);
end

% Retourne le contraste d'une image
function c = constrast(Img)
    [h, l] = size(Img);
    lum = luminance(Img);

    s = 0;
    for i = 1:h
        for j = 1:l
            s = s + (double(Img(i, j)) - lum) ^ 2;
        end
    end
    c = s / (h * l);
end

% Retourne la valeur maximale d'un pixel dans l'image Img
function maxi = profondeur(Img)
    maxi = double(Img(1, 1));
    [h, l] = size(Img);
    for i = 1:h
        for j = 1:l
            if double(Img(i, j)) > maxi
                maxi = double(Img(i, j));
            end
        end
    end
end

function img = Ouvrir(A)
    img = lectureImage(A);
end

function result = inverser(img)
    p = 255;
    result = p - double(img);
end

% Symétrie verticale (gauche-droite)
function result = flipH(img)
    [L, C] = size(img);
    img_double = double(img);

    for i = 1:L
        for j = 1:floor(C / 2)
            t = img_double(i, j);
            img_double(i, j) = img_double(i, C - j + 1);
            img_double(i, C - j + 1) = t;
        end
    end

    result = img_double;
end

% Poser verticalement img1 au-dessus de img2
function resultat = poserV(img1, img2)
    [L1, C1] = size(img1);
    [L2, C2] = size(img2);

    if C1 ~= C2
        resultat = [];
        return;
    end

    resultat = zeros(L1 + L2, C1);

    for i = 1:L1
        for j = 1:C1
            resultat(i, j) = double(img1(i, j));
        end
    end

    for i = 1:L2
        for j = 1:C2
            resultat(i + L1, j) = double(img2(i, j));
        end
    end
end

% Poser horizontalement img2 à droite de img1
function resultat = poserH(img1, img2)
    [L1, C1] = size(img1);
    [L2, C2] = size(img2);

    if L1 ~= L2
        resultat = [];
        return;
    end

    resultat = zeros(L1, C1 + C2);

    for i = 1:L1
        for j = 1:C1
            resultat(i, j) = double(img1(i, j));
        end

        for j = 1:C2
            resultat(i, j + C1) = double(img2(i, j));
        end
    end
end

function imageRGB = initImageRGB(n, m)
    % MATLAB: rand génère entre 0 et 1, on multiplie par 255
    imageRGB = zeros(3, n, m);
    for c = 1:3
        for i = 1:n
            for j = 1:m
                imageRGB(c, i, j) = randi([0, 255]);
            end
        end
    end
end

% symétrie horizontale (haut-bas)
function result = symetrie_horizontale(img)
    result = flipud(img);
end

% symétrie verticale (gauche-droite)
function result = symetrie_verticale(img)
    result = fliplr(img);
end

function gris = grayscale(imageRGB)
    m = size(imageRGB, 2);
    n = size(imageRGB, 3);
    gris = zeros(m, n);

    for i = 1:m
        for j = 1:n
            R = imageRGB(1, i, j);
            G = imageRGB(2, i, j);
            B = imageRGB(3, i, j);
            gris(i, j) = floor((max([R, G, B]) + min([R, G, B])) / 2);
        end
    end
end

% menu
function choix = menu()
    fprintf("1. Ouvrir une image\n");
    fprintf("2. Créer une image noire et blanche\n");
    fprintf("3. Construire le négatif de l'image donnée\n");
    fprintf("4. Ouvrir l'image A\n");
    fprintf("5. Inverser une image\n");
    fprintf("6. Symétrie d'axe vertical passant par le milieu de l'image\n");
    fprintf("7. Poser verticalement deux images\n");
    fprintf("8. Poser horizontalement deux images\n");
    fprintf("9. L'affichage des valeurs du matrice M de l'images RGB\n");
    fprintf("10. Initialiser et renvoyer une image RGB\n");
    fprintf("11. Symétrie horizontale d'une image\n");
    fprintf("12. Symétrie verticale d'une image\n");
    fprintf("13. Convertir une image RGB en niveaux de gris\n");
    fprintf("14. Quitter\n");

    choix = input("Veuillez choisir une option: ");
end

%% Boucle principale
while true
    choix = menu();

    if choix == 14
        fprintf("Au revoir!\n");
        break;
    elseif choix == 1
        try
            m = input("Entrez le chemin d'accès de l'image sans guillemets: ", 's');
            img = lectureImage(m);
            afficher_image(img);
        catch ME
            fprintf("Image non trouvée, veuillez écrire un chemin d'accès valide\n");
        end
    elseif choix == 2
        h = input("Entrez la hauteur de l'image: ");
        l = input("Entrez la largeur de l'image: ");
        img = image_noir_blanche(h, l);
        afficher_image(img);
    elseif choix == 3
        chemin = input("Entrez le chemin d'accès de l'image A sans guillemets: ", 's');
        img = lectureImage(chemin);
        neg = negatif(img);
        afficher_image(neg);
    elseif choix == 4
        chemin = input("Entrez le chemin d'accès de l'image sans guillemets: ", 's');
        imgA = lectureImage(chemin);
        afficher_image(imgA);
    elseif choix == 5
        chemin = input("Entrez le chemin d'accès de l'image sans guillemets: ", 's');
        img = lectureImage(chemin);
        inv = inverser(img);
        afficher_image(inv);
    elseif choix == 6
        chemin = input("Entrez le chemin d'accès de l'image sans guillemets: ", 's');
        img = lectureImage(chemin);
        symV = flipH(img);
        afficher_image(symV);
    elseif choix == 7
        try
            chemin1 = input("Entrez le chemin d'accès de la première image sans guillemets: ", 's');
            img1 = lectureImage(chemin1);
            chemin2 = input("Entrez le chemin d'accès de la deuxième image sans guillemets: ", 's');
            img2 = lectureImage(chemin2);
            posV = poserV(img1, img2);
            if isempty(posV)
                fprintf("Les images n'ont pas la même largeur!\n");
            else
                afficher_image(posV);
            end
        catch ME
            fprintf("Image non trouvée, veuillez écrire un chemin d'accès valide\n");
        end
    elseif choix == 8
        try
            fprintf("Les deux images doivent avoir même hauteur\n");
            chemin1 = input("Entrez le chemin d'accès de la première image sans guillemets: ", 's');
            img1 = lectureImage(chemin1);
            chemin2 = input("Entrez le chemin d'accès de la deuxième image sans guillemets: ", 's');
            img2 = lectureImage(chemin2);
            posH = poserH(img1, img2);
            if isempty(posH)
                fprintf("Les images n'ont pas la même hauteur!\n");
            else
                afficher_image(posH);
            end
        catch ME
            fprintf("Importez deux images de même dimension avec un chemin d'accès valide\n");
        end
    elseif choix == 9
        % Création d'un tableau 3D représentant l'image RGB
        M = zeros(6, 6, 3);

        % Plan R (rouge)
        M(:,:,1) = [
            [210, 100, 255, 100, 50, 255];
            [190, 255, 89, 201, 255, 29];
            [255, 0, 0, 255, 0, 0];
            [210, 100, 255, 100, 50, 255];
            [190, 255, 89, 201, 255, 29];
            [255, 0, 0, 255, 0, 0]
        ];

        % Plan G (vert)
        M(:,:,2) = [
            [100, 50, 255, 90, 90, 255];
            [201, 255, 29, 200, 255, 100];
            [0, 0, 0, 0, 0, 0];
            [100, 50, 255, 90, 90, 255];
            [201, 255, 29, 200, 255, 100];
            [0, 0, 0, 0, 0, 0]
        ];

        % Plan B (bleu)
        M(:,:,3) = [
            [90, 90, 255, 90, 80, 255];
            [100, 255, 90, 20, 255, 200];
            [0, 0, 0, 0, 0, 0];
            [90, 90, 255, 90, 80, 255];
            [100, 255, 90, 20, 255, 200];
            [0, 0, 0, 0, 0, 0]
        ];

        fprintf('M(1,2,2) = %d\n', M(1,2,2));
        fprintf('M(2,1,2) = %d\n', M(2,1,2));
        fprintf('M(3,2,1) = %d\n', M(3,2,1));
    elseif choix == 10
        m = input("Veuillez déterminer le nombre de lignes: ");
        n = input("Veuillez déterminer le nombre de colonnes: ");
        imgRGB = initImageRGB(m, n);
        % Afficher l'image RGB (convertir en format HxWx3)
        imgRGB_display = permute(imgRGB, [2, 3, 1]);
        afficher_image(uint8(imgRGB_display));
    elseif choix == 11
        chemin = input("Entrez le chemin d'accès de l'image sans guillemets: ", 's');
        img = lectureImage(chemin);
        symH = symetrie_horizontale(img);
        afficher_image(symH);
    elseif choix == 12
        chemin = input("Entrez le chemin d'accès de l'image sans guillemets: ", 's');
        img = lectureImage(chemin);
        symV = symetrie_verticale(img);
        afficher_image(symV);
    elseif choix == 13
        % Créer une image RGB aléatoire
        imgRGB = initImageRGB(5, 5);
        imgRGB_display = permute(imgRGB, [2, 3, 1]);
        afficher_image(uint8(imgRGB_display));

        % Convertir en niveaux de gris
        img_gray = grayscale(imgRGB);
        afficher_image(uint8(img_gray));
    else
        fprintf("Option invalide. Veuillez réessayer.\n");
    end
end

end
