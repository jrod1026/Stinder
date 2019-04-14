import java.util.ArrayList;
import java.util.List;

public class Player extends Killable {
    private List<Thing> backpack;
    private Weapon equipped;
    private int backpackSize = 2;
    private int wallet;



    public Player() {
        super("player", 100, 2);
        backpack = new ArrayList<>();
        equipped = null;
        isPlayer = true;
        wallet = 0;
    }

    @Override
    public void attack(Killable other) {
        if (equipped != null) {
            equipped.attack(other);
        } else {
            super.attack(other);
        }
    }

    public void heal(int redStuff) {
        super.hp += redStuff;
        if (super.hp > 100) {
            super.hp = 100;
        }
    }

    public void collectMoney(int pickup) {
        wallet += pickup;
        System.out.println("You collected " + pickup + " gold. You now have " + wallet + " gold.");
    }

    public void pickup(Thing thing) {
        if (backpack.size() == backpackSize) {
            System.out.println("Your backpack is full, you need " +
                    "to drop something in order to pick this up.");
        } else if (thing.toString().equals("Backpack")) {
            backpackSize = 10;
            System.out.println("You have put on the backpack, and can now hold 10 items.");
        } else {
            backpack.add(thing);
            System.out.println("You have placed " + thing +
                    " in your backpack.");
        }
    }

    public void equip(Thing w) {
        if (backpack.contains(w)) {
            if (w.equippable && w.getClass() == Weapon.class) {
                equipped = (Weapon) w;
                System.out.println("You have equipped " + w);
            } else {
                System.out.println("You cannot equip this.");
            }
        } else {
            System.out.println("You do not have this item in your inventory.");
        }
    }

    public void use(Thing u) {
        if (backpack.contains(u)) {
            u.use(this);
            backpack.remove(u);
        } else {
            System.out.println("You do not have this item in your inventory.");
        }
    }

    public void drop(Thing t) {
        if (backpack.contains(t)) {

        }
    }

    public void checkBackpack() {
        if (backpack.size() == 0) {
            System.out.println("You don't have anything in your inventory.");
        } else {
            System.out.println("You have these items in your inventory: ");
            for (Thing t : backpack) {
                System.out.println(t);
            }
        }
    }

}
