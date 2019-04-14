import java.util.List;

public class Place {
    String name;
    String description;
    List<NPC> characters;
    List<Killable> enemies;
    List<Thing> items;
    boolean locked = false;
    String lock = "None";


}
