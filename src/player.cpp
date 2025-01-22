#include <godot_cpp/classes/input.hpp>
#include "player.h"
#include <godot_cpp/core/math.hpp>

void Player::_bind_methods() {
    ClassDB::bind_method(D_METHOD("setSpeed", "speed"), &Player::setSpeed);
    ClassDB::bind_method(D_METHOD("getSpeed"), &Player::getSpeed);
    ClassDB::bind_method(D_METHOD("setJumpForce", "jumpForce"), &Player::setJumpForce);
    ClassDB::bind_method(D_METHOD("getJumpForce"), &Player::getJumpForce);

    ADD_PROPERTY(PropertyInfo(Variant::FLOAT, "speed"), "setSpeed", "getSpeed");
    ADD_PROPERTY(PropertyInfo(Variant::FLOAT, "jumpForce"), "setJumpForce", "getJumpForce");
}

Player::Player() : speed(300.0), jumpForce(-400.0) {}

Player::~Player() {}

void Player::_physics_process(double delta) {
    Input* input = Input::get_singleton();
    Vector2 velocity = Vector2();

    if (!is_on_floor())
        velocity += get_gravity()*delta;
    if (is_on_floor() && input->is_action_just_released("ui_accept")) {
        velocity.y = jumpForce;
    }

    double direction = input->get_axis("ui_left", "ui_right");

    if (direction) {
        velocity.x = direction * speed;
    }
    else {
        velocity.x = Math::move_toward(velocity.x, 0, speed);
    }

    set_velocity(velocity);
    move_and_slide();
}

void Player::setSpeed(float speed) {
    this->speed = speed;
}

float Player::getSpeed() const {
    return speed;
}

void Player::setJumpForce(float jumpForce) {
    this->jumpForce = jumpForce;
}

float Player::getJumpForce() const {
    return jumpForce;
}