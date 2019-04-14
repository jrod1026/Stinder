public class Weapon extends Thing {
    private double dmg;

    public Weapon(String name, String desc, double dmg) {
        super(name, desc);
        this.dmg = dmg;
        super.equippable = true;
    }

    public void attack(Killable other) {
        other.takeDmg(dmg);
    }

    @Override
    public void use(Player p) {
        System.out.println("To use this, you should equip it.");
    }
}
