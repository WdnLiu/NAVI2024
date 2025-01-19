#include "summator.h"
#include <godot_cpp/core/class_db.hpp>

void Summator::_bind_methods() {
    ClassDB::bind_method(D_METHOD("add", "num"), &Summator::add);
    ClassDB::bind_method(D_METHOD("reset"), &Summator::reset);
    ClassDB::bind_method(D_METHOD("getSum"), &Summator::getSum);
}

Summator::Summator() : count(0) {}

void Summator::add(int num) {
    count += num;
}

void Summator::reset() {
    count = 0;
}

int Summator::getSum() const {
    return count;
}