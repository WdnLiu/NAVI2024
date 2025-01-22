#ifndef PLAYER_H
#define PLAYER_H

#include <godot_cpp/classes/character_body2d.hpp>
#include <godot_cpp/core/class_db.hpp>

using namespace godot;

class Player : public CharacterBody2D {
    GDCLASS(Player, CharacterBody2D);

private:
    float speed;
    float jumpForce;

protected:
    static void _bind_methods();

public:
    Player();
    ~Player();

    void _physics_process(double _delta) override;

    void setSpeed(float speed);
    float getSpeed() const;

    void setJumpForce(float jumpForce);
    float getJumpForce() const;
};

#endif // PLAYER_H