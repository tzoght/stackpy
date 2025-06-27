import unittest
from stackpy.generator import PrimeGenerator


class TestPrimeGenerator(unittest.TestCase):
    def setUp(self):
        self.generator = PrimeGenerator()

    def test_is_prime(self):
        self.assertFalse(self.generator.is_prime(0))
        self.assertFalse(self.generator.is_prime(1))
        self.assertTrue(self.generator.is_prime(2))
        self.assertTrue(self.generator.is_prime(3))
        self.assertFalse(self.generator.is_prime(4))
        self.assertTrue(self.generator.is_prime(5))
        self.assertFalse(self.generator.is_prime(6))
        self.assertTrue(self.generator.is_prime(7))
        self.assertFalse(self.generator.is_prime(8))
        self.assertFalse(self.generator.is_prime(9))
        self.assertTrue(self.generator.is_prime(11))

    def test_generate(self):
        self.assertEqual(self.generator.generate(0, 0), [])
        self.assertEqual(self.generator.generate(0, 2), [2])
        self.assertEqual(self.generator.generate(0, 5), [2, 3, 5])
        self.assertEqual(self.generator.generate(0, 10), [2, 3, 5, 7])
        self.assertEqual(self.generator.generate(10, 20), [11, 13, 17, 19])


if __name__ == "__main__":
    unittest.main()
