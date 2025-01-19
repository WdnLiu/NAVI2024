#pragma once
#include <godot_cpp/classes/object.hpp>

using namespace godot;

class Summator : public Object {
    GDCLASS(Summator, Object);

    int count;

protected:
    static void _bind_methods();

public:
    void add(int num);
    void reset();
    int getSum() const;

    Summator(); 
};