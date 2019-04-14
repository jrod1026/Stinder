import java.util.Scanner;

public class basicMath {
    public static int add(int x, int y) {
        return x + y;
    }

    public static int square(int x) {
        return x * x;
    }

    public static int biggest(int x, int y) {
        if (x > y) {
            return x;
        } else {
            return y;
        }
    }

    public static void hiAlot(int x) {
        for (int i = 0; i < x; i++) {
            System.out.println("Hi!");
        }
    }

    public static int biggestList(int[] list) {
        int biggest = list[0];
        for (int i = 1; i < list.length; i++) {
            biggest = biggest(biggest, list[i]);
        }
        return biggest;
    }

}
