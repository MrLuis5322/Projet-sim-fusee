import time

# Démarrage du chronomètre
starttime = time.time()
lasttime = starttime
lapnum = 1
value = ""

print("Appuyez sur ENTRÉE pour chaque tour.\nTapez Q et appuyez sur ENTRÉE pour arrêter.")

while value.lower() != "q":
              
    # Attente de l'entrée pour chaque tour
    value = input()
  
    # Calcul du temps du tour actuel
    laptime = round((time.time() - lasttime), 7)
  
    # Calcul du temps total écoulé depuis le début
    totaltime = round((time.time() - starttime), 7)
  
    # Affichage du numéro du tour, du temps total et du temps du tour
    print("Tour n° " + str(lapnum))
    print("Temps Total: " + str(totaltime))
    print("Temps du Tour: " + str(laptime))
            
    print("*" * 20)
  
    # Mise à jour du dernier temps et du numéro du tour
    lasttime = time.time()
    lapnum += 1
  
print("Exercice terminé  !")



#https://www.udacity.com/blog/2021/09/create-a-timer-in-python-step-by-step-guide.html