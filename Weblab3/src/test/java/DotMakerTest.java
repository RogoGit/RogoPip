import org.junit.Before;
import org.junit.Test;
import org.rogisa.beans.DotMaker;

import java.util.function.Function;

import static org.junit.Assert.assertEquals;

public class DotMakerTest {
    private DotMaker dotMaker;

    @Before
    public void init() {
        dotMaker = new DotMaker();
        dotMaker.setKx(0);
        dotMaker.setKy(0);
        dotMaker.setRad(0);
    }

    @Test
    public void testAreaCheckRect() {
        //test left down corner
        testPoint((rad) -> (-rad / 2), (rad) -> (-rad), true);

        //test left up corner
        testPoint((rad) -> (-rad / 2), (rad) -> (0.), true);

        //test right up corner
        testPoint((rad) -> (0.), (rad) -> (0.), true);

        //test right down corner
        testPoint((rad) -> (0.), (rad) -> (-rad), true);

        //test center
        testPoint((rad) -> (-rad / 4), (rad) -> (-rad / 2), true);

        //test overflow
        testPoint((rad) -> (-rad * 2), (rad) -> (-rad * 2), false);
    }

    @Test
    public void testAreaCheckCircle() {
        //test left down corner
        testPoint((rad) -> (-rad / 2), (rad) -> (0.), true);

        //test point on radius
        //testPoint((rad)->(Math()), (rad)->(0.), true);
    }

    private void testPoint(Function<Double, Double> calcX, Function<Double, Double> calcY, boolean isResult) {
        for (double rad = 1; rad < 4; rad++) {
            dotMaker.setRad(rad);
            dotMaker.setKx(calcX.apply(rad));
            dotMaker.setKy(calcY.apply(rad));
            dotMaker.areaCheck();
            assertEquals(dotMaker.isRes(), isResult);
        }
    }
}
