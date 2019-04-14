import java.util.ArrayList;
import java.util.List;

public class NPC {
    String name;
    String description;
    List<Thing> inventory;

    public NPC(String n, String d) {
        name = n;
        description = d;
        inventory = new ArrayList<>();
    }

    public NPC(String n, String d, List<Thing> i) {
        name = n;
        description = d;
        inventory = i;
    }

    public void checkInventory() {
        if (inventory.size() == 0) {
            System.out.println("I don't have anything to offer.");
        } else {
            System.out.println("I possess these wares:");
            for (Thing t: inventory) {
                System.out.println(t);
            }
        }
    }

    public Thing give(Thing t) {
        if (inventory.size() == 0 || !inventory.contains(t)) {
            System.out.println("I do not have this.");
            return null;
        }
        return null;
    }
}
