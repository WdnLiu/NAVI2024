#pragma once

#include <godot_cpp/classes/character_body2d.hpp>

using namespace godot;

class Player : public CharacterBody2D {
    GDCLASS(Player, Node2D);

private:
    float speed;

protected:
    static void _bind_methods();

public:
    Player();
    ~Player();

    void _ready();
    void _physics_process(double delta) override;
    void setSpeed(float speed);
    float getSpeed() const;
};
