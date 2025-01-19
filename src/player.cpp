#include <godot_cpp/classes/input.hpp>
#include "player.h"

void Player::_bind_methods() {
    ClassDB::bind_method(D_METHOD("_ready"), &Player::_ready);
    ClassDB::bind_method(D_METHOD("_process", "delta"), &Player::_process);
    ClassDB::bind_method(D_METHOD("setSpeed", "speed"), &Player::setSpeed);
    ClassDB::bind_method(D_METHOD("getSpeed"), &Player::getSpeed);

    ADD_PROPERTY(PropertyInfo(Variant::FLOAT, "speed"), "setSpeed", "getSpeed");
}

Player::Player() : speed(100) {}

Player::~Player() {}

void Player::_ready() {
    Input *input = Input::get_singleton();
}

void Player::_physics_process(double delta) {
    Input *input = Input::get_singleton();
    Vector2 velocity = Vector2();
    if (input->is_action_pressed("ui_up")) {
        velocity.y -= 1;
    }
    if (input->is_action_pressed("ui_down")) {
        velocity.y += 1;
    }
    if (input->is_action_pressed("ui_left")) {
        velocity.x -= 1;
    }
    if (input->is_action_pressed("ui_right")) {
        velocity.x += 1;
    }
    velocity = velocity.normalized() * speed;
    set_velocity(velocity);
    move_and_slide();
}

void Player::setSpeed(float speed) {
    this->speed = speed;
}

float Player::getSpeed() const {
    return speed;
}