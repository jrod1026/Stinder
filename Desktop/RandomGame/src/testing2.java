import org.junit.Test;
import static org.junit.Assert.*;

public class testing2 {
    @Test
    public void testAdd() {
        assertEquals(26, basicMath.add(12, 13));
    }

    @Test
    public void testSquare() {
        assertEquals(49, basicMath.square(7));
    }

    @Test
    public void testbiggest() {
        assertEquals(9, basicMath.biggest(7, 9));
    }

    @Test
    public void testBiggestList() {
        int[] list = {4, 6, 3, 2, 7, 8, 12, 4, 7};
        assertEquals(12, basicMath.biggestList(list));
    }
}