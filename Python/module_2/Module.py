def addition(num1, num2):
        return num1 + num2
    
def subtraction(num1, num2):
        return num1 - num2
    
def multiplication(num1, num2):
        return num1 * num2
    
def division(num1, num2):
        if num2 == 0:
            raise ZeroDivisionError("Cannot divide by zero")
        return num1 / num2