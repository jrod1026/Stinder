public class Thing {
    boolean equippable = false;
    private String name;
    private String description;
    boolean consumable = false;

    public Thing(String n, String desc) {
        name = n;
        description = desc;
    }

    public void use(Player p) {
        System.out.println("You cannot use this.");
    }

    @Override
    public boolean equals(Object o) {
        if (o == this) {
            return true;
        }
        if (!(o instanceof Thing)) {
            return false;
        }
        Thing temp = (Thing) o;
        return name.equals(temp.name);
    }

    @Override
    public String toString() {
        return name;
    }


}
