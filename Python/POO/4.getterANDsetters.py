# Los “Getters” y “Setters” se utilizan en POO para garantizar el principio de la encapsulación de datos.
# Claramente el getter se emplea para obtener los datos y el setter para cambiar el valor de los datos.

class Geeks: 
     def __init__(self): 
          self._age = 0
       
     # using property decorator 
     # a getter function 
     @property ## @property se usa como getter
     def age(self): 
         print("getter method called") 
         return self._age 
       
     # a setter function 
     @age.setter 
     def age(self, a): 
         if(a < 18): 
            raise ValueError("Sorry you age is below eligibility criteria") 
         print("setter method called") 
         self._age = a 
  
mark = Geeks() 
  
mark.age = 17
  
print(mark.age) 