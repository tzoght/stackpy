class PrimeGenerator:
    """
    A class to generate prime numbers.

    ...

    Attributes
    ----------
    None

    Methods
    -------
    is_prime(n: int) -> bool:
        Checks if a given number is prime.

    generate(start: int, end: int) -> List[int]:
        Generates a list of prime numbers between the specified range.
    """

    def __init__(self):
        """Initializes the PrimeGenerator class."""
        pass

    @staticmethod
    def is_prime(n):
        """
        Checks if a given number is prime.

        Parameters:
        - n (int): The number to be checked.

        Returns:
        - bool: True if n is prime, False otherwise.
        """
        if n <= 1:
            return False
        if n <= 3:
            return True
        if n % 2 == 0 or n % 3 == 0:
            return False
        i = 5
        while i * i <= n:
            if n % i == 0 or n % (i + 2) == 0:
                return False
            i += 6
        return True

    def generate(self, start, end):
        """
        Generates a list of prime numbers between the specified range.

        Parameters:
        - start (int): The starting value of the range.
        - end (int): The ending value of the range.

        Returns:
        - List[int]: A list containing prime numbers between the start and end
        svalues.
        """
        return [num for num in range(start, end + 1) if self.is_prime(num)]
