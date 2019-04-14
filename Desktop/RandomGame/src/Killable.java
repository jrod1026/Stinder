public class Killable {
    double hp;
    double dmg;
    String name;
    boolean isPlayer = false;

    public Killable(String name, double hp, double dmg) {
        this.name = name;
        this.hp = hp;
        this.dmg = dmg;
    }

    double currentHealth() {
        return hp;
    }

    void printHP() {
        System.out.println(name + " has " + hp + " health.");
    }

    void takeDmg(double damage) {
        hp -= damage;
        System.out.println(name + " has taken " + damage + " damage.");
    }

    void attack(Killable other) {
        other.takeDmg(dmg);
    }

    @Override
    public String toString() {
        return name;
    }

}
