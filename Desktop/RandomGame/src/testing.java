import org.junit.Test;
import org.junit.Assert.*;


public class testing {
    @Test
    public void testMake() {
        Thing thing = new Thing("Hat", "Look fashionable with this elegant top hat");
        Player p1 = new Player();
        Killable jerry = new Killable("Jerry", 10, 1);
        Weapon knife = new Weapon("Knife", "A short blade. Deals 6 damage.", 6);
    }

    @Test
    public void testAttack() {
        Thing thing = new Thing("Hat", "Look fashionable with this elegant top hat");
        Player p1 = new Player();
        Killable jerry = new Killable("Jerry", 20, 1);
        Weapon knife = new Weapon("Knife", "A short blade. Deals 6 damage.", 6);
        p1.pickup(knife);
        p1.attack(jerry);
        p1.equip(knife);
        p1.attack(jerry);
    }

    @Test
    public void testHeal() {
        Player p1 = new Player();
        Meds bandages = new Meds("Band-aid", "Small Bandage for small cuts.", 5);
        System.out.println("You have " + p1.currentHealth() + " health.");
        p1.takeDmg(10);
        System.out.println("You have " + p1.currentHealth() + " health.");
        p1.use(bandages);
        p1.pickup(bandages);
        p1.checkBackpack();
        p1.use(bandages);
        System.out.println("You have " + p1.currentHealth() + " health.");
        p1.checkBackpack();
    }
}
