public class Meds extends Thing {
    private int healAmount;

    public Meds(String name, String desc, int heal) {
        super(name, desc);
        healAmount = heal;
        consumable = true;
    }

    public void use(Player p) {
        p.heal(healAmount);
        System.out.println("You have healed " + healAmount + " health.");
    }
}
