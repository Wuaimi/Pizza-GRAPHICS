#define GL_SILENCE_DEPRECATION
#include <GLFW/glfw3.h>
#include <iostream>
#include <cmath>
#include <random>
#include <glm/glm.hpp>
#include <glm/gtc/matrix_transform.hpp>
#define STB_EASY_FONT_IMPLEMENTATION
#include "stb/stb_easy_font.h"

// Random number generation setup
std::random_device rd;
std::mt19937 gen(rd());

// Step sizes (used for both shapes and targets)
const float POS_STEP = 0.05f;
const float SCALE_STEP = 0.1f;
const float ROT_STEP = 10.0f;

// Define ranges in terms of steps
std::uniform_int_distribution<int> posStepDist(-16, 16);  // -0.8 / 0.05 = -16, 0.8 / 0.05 = 16
std::uniform_int_distribution<int> scaleStepDist(5, 15);  // 0.5 / 0.1 = 5, 1.5 / 0.1 = 15
std::uniform_int_distribution<int> rotStepDist(0, 35);    // 0 / 10 = 0, 360 / 10 = 36 (0 to 350)

// Shape properties (position, scale, rotation)
struct Shape {
    float x, y, scale, rotation;
};

// Helper function to initialize shapes with stepped values
Shape createSteppedShape() {
    Shape s;
    s.x = posStepDist(gen) * POS_STEP;
    s.y = posStepDist(gen) * POS_STEP;
    s.scale = scaleStepDist(gen) * SCALE_STEP;
    s.rotation = rotStepDist(gen) * ROT_STEP;
    return s;
}

// Current shape positions and transformations
Shape triangle = createSteppedShape();
Shape square = createSteppedShape();
Shape circle = createSteppedShape();

// Target shape transformations (also aligned to steps)
Shape targetTriangle = createSteppedShape();
Shape targetSquare = createSteppedShape();
Shape targetCircle = createSteppedShape();

int selectedShape = 0; // 0 = Triangle, 1 = Square, 2 = Circle
bool successPrinted = false;

// Gradient background
void drawGradientBackground() {
    glBegin(GL_QUADS);
    glColor4f(0.1f, 0.2f, 0.3f, 1.0f); glVertex2f(-1.0f, 1.0f);
    glColor4f(0.3f, 0.1f, 0.3f, 1.0f); glVertex2f(1.0f, 1.0f);
    glColor4f(0.3f, 0.1f, 0.2f, 1.0f); glVertex2f(1.0f, -1.0f);
    glColor4f(0.1f, 0.1f, 0.3f, 1.0f); glVertex2f(-1.0f, -1.0f);
    glEnd();
}

// Draw text (adjusted for stb_easy_font)
void drawText(const char* text, float x, float y) {
    glPushMatrix();
    glLoadIdentity();
    static char buffer[99999];
    stb_easy_font_print(x * 400 + 400, y * 300 + 300, (char*)text, NULL, buffer, sizeof(buffer));
    glPopMatrix();
}

// Draw target markers with transformations
void drawTargets() {
    glLineWidth(10.0f); // Adjusted line width for visibility
    // Triangle target
    glPushMatrix();
    glm::mat4 transform = glm::translate(glm::mat4(1.0f), glm::vec3(targetTriangle.x, targetTriangle.y, 0.0f));
    transform = glm::rotate(transform, glm::radians(targetTriangle.rotation), glm::vec3(0.0f, 0.0f, 1.0f));
    transform = glm::scale(transform, glm::vec3(targetTriangle.scale, targetTriangle.scale, 1.0f));
    glMultMatrixf(&transform[0][0]);
    glColor4f(1.0f, 0.0f, 0.0f, 0.5f);
    glBegin(GL_LINE_LOOP);
    glVertex2f(0.0f, 0.1f); glVertex2f(-0.1f, -0.1f); glVertex2f(0.1f, -0.1f);
    glEnd();
    glPopMatrix();

    // Square target
    glPushMatrix();
    transform = glm::translate(glm::mat4(1.0f), glm::vec3(targetSquare.x, targetSquare.y, 0.0f));
    transform = glm::rotate(transform, glm::radians(targetSquare.rotation), glm::vec3(0.0f, 0.0f, 1.0f));
    transform = glm::scale(transform, glm::vec3(targetSquare.scale, targetSquare.scale, 1.0f));
    glMultMatrixf(&transform[0][0]);
    glColor4f(1.0f, 1.0f, 0.0f, 0.5f);
    glBegin(GL_LINE_LOOP);
    glVertex2f(-0.1f, 0.1f); glVertex2f(0.1f, 0.1f); glVertex2f(0.1f, -0.1f); glVertex2f(-0.1f, -0.1f);
    glEnd();
    glPopMatrix();

    // Circle target
    glPushMatrix();
    transform = glm::translate(glm::mat4(1.0f), glm::vec3(targetCircle.x, targetCircle.y, 0.0f));
    transform = glm::rotate(transform, glm::radians(targetCircle.rotation), glm::vec3(0.0f, 0.0f, 1.0f));
    transform = glm::scale(transform, glm::vec3(targetCircle.scale, targetCircle.scale, 1.0f));
    glMultMatrixf(&transform[0][0]);
    glColor4f(0.0f, 0.7f, 1.0f, 0.5f);
    glBegin(GL_LINE_LOOP);
    for (int i = 0; i < 30; i++) {
        float theta = 2.0f * 3.14159f * i / 30.0f;
        glVertex2f(0.1f * cosf(theta), 0.1f * sinf(theta));
    }
    glEnd();
    glPopMatrix();
}

// Draw shapes
void drawTriangle(const glm::mat4& transform) {
    glPushMatrix();
    glMultMatrixf(&transform[0][0]);
    glBegin(GL_TRIANGLES);
    glColor4f(1.0f, 0.0f, 0.0f, 0.8f); glVertex2f(0.0f, 0.1f);
    glColor4f(0.0f, 1.0f, 0.0f, 0.8f); glVertex2f(-0.1f, -0.1f);
    glColor4f(0.0f, 0.0f, 1.0f, 0.8f); glVertex2f(0.1f, -0.1f);
    glEnd();
    if (selectedShape == 0) {
        glLineWidth(2.0f); glColor4f(1.0f, 1.0f, 1.0f, 1.0f);
        glBegin(GL_LINE_LOOP);
        glVertex2f(0.0f, 0.1f); glVertex2f(-0.1f, -0.1f); glVertex2f(0.1f, -0.1f);
        glEnd();
    }
    glPopMatrix();
}

void drawSquare(const glm::mat4& transform) {
    glPushMatrix();
    glMultMatrixf(&transform[0][0]);
    glBegin(GL_QUADS);
    glColor4f(1.0f, 1.0f, 0.0f, 0.8f); glVertex2f(-0.1f, 0.1f);
    glColor4f(0.0f, 1.0f, 1.0f, 0.8f); glVertex2f(0.1f, 0.1f);
    glColor4f(1.0f, 0.0f, 1.0f, 0.8f); glVertex2f(0.1f, -0.1f);
    glColor4f(0.5f, 0.5f, 0.5f, 0.8f); glVertex2f(-0.1f, -0.1f);
    glEnd();
    if (selectedShape == 1) {
        glLineWidth(2.0f); glColor4f(1.0f, 1.0f, 1.0f, 1.0f);
        glBegin(GL_LINE_LOOP);
        glVertex2f(-0.1f, 0.1f); glVertex2f(0.1f, 0.1f); glVertex2f(0.1f, -0.1f); glVertex2f(-0.1f, -0.1f);
        glEnd();
    }
    glPopMatrix();
}

void drawCircle(const glm::mat4& transform) {
    glPushMatrix();
    glMultMatrixf(&transform[0][0]);
    glBegin(GL_TRIANGLE_FAN);
    glColor4f(1.0f, 0.5f, 0.0f, 0.8f); glVertex2f(0.0f, 0.0f);
    for (int i = 0; i <= 30; i++) {
        float theta = 2.0f * 3.14159f * i / 30.0f;
        glColor4f(0.0f, 0.7f, 1.0f, 0.8f); glVertex2f(0.1f * cosf(theta), 0.1f * sinf(theta));
    }
    glEnd();
    if (selectedShape == 2) {
        glLineWidth(2.0f); glColor4f(1.0f, 1.0f, 1.0f, 1.0f);
        glBegin(GL_LINE_LOOP);
        for (int i = 0; i < 30; i++) {
            float theta = 2.0f * 3.14159f * i / 30.0f;
            glVertex2f(0.1f * cosf(theta), 0.1f * sinf(theta));
        }
        glEnd();
    }
    glPopMatrix();
}

// Check if shapes match their targets
bool checkSuccess() {
    const float posEpsilon = POS_STEP / 2.0f;  // Half a step for tolerance (0.025)
    const float scaleEpsilon = SCALE_STEP / 2.0f;  // 0.05
    const float rotEpsilon = ROT_STEP / 2.0f;  // 5.0

    // Generic shape checker with rotation
    auto checkShapeWithRotation = [&](const Shape& shape, const Shape& target) {
        float dx = std::abs(shape.x - target.x);
        float dy = std::abs(shape.y - target.y);
        float ds = std::abs(shape.scale - target.scale);
        float dr = std::abs(fmod(shape.rotation - target.rotation + 180.0f, 360.0f) - 180.0f);

        return dx < posEpsilon && dy < posEpsilon && ds < scaleEpsilon && dr < rotEpsilon;
        };

    // Square checker with rotation mod 90 degrees
    auto checkSquare = [&](const Shape& shape, const Shape& target) {
        float dx = std::abs(shape.x - target.x);
        float dy = std::abs(shape.y - target.y);
        float ds = std::abs(shape.scale - target.scale);
        float dr = std::abs(fmod(shape.rotation - target.rotation + 45.0f, 90.0f) - 45.0f); // Mod 90-degree check

        return dx < posEpsilon && dy < posEpsilon && ds < scaleEpsilon && dr < rotEpsilon;
        };

    // Circle checker without rotation
    auto checkCircle = [&](const Shape& shape, const Shape& target) {
        float dx = std::abs(shape.x - target.x);
        float dy = std::abs(shape.y - target.y);
        float ds = std::abs(shape.scale - target.scale);

        return dx < posEpsilon && dy < posEpsilon && ds < scaleEpsilon;
        };

    bool triangleMatch = checkShapeWithRotation(triangle, targetTriangle);
    bool squareMatch = checkSquare(square, targetSquare);
    bool circleMatch = checkCircle(circle, targetCircle);

    // std::cout << "Matches: Triangle=" << triangleMatch << ", Square=" << squareMatch << ", Circle=" << circleMatch << "\n";

    return triangleMatch && squareMatch && circleMatch;
}

// Draw instructions
void drawInstructions() {
    glColor4f(1.0f, 1.0f, 1.0f, 0.8f);
    drawText("GOAL: Match shapes to targets (pos, scale, rot)", -0.9f, 0.9f);
    drawText("TAB: Switch | Arrows: Move | R: Rotate | S/X: Scale", -0.9f, 0.8f);
}

// Key callback with fixed step sizes
void keyCallback(GLFWwindow* window, int key, int scancode, int action, int mods) {
    if (action == GLFW_PRESS || action == GLFW_REPEAT) {
        Shape* shape;
        switch (selectedShape) {
        case 0: shape = &triangle; break;  // Fixed: Use &triangle instead of ▵
        case 1: shape = &square; break;    // Fixed: Use &square instead of □
        case 2: shape = &circle; break;
        default: return; // Safety check
        }

        switch (key) {
        case GLFW_KEY_UP:
            shape->y = std::min(shape->y + POS_STEP, 0.9f);
            break;
        case GLFW_KEY_DOWN:
            shape->y = std::max(shape->y - POS_STEP, -0.9f);
            break;
        case GLFW_KEY_LEFT:
            shape->x = std::max(shape->x - POS_STEP, -0.9f);
            break;
        case GLFW_KEY_RIGHT:
            shape->x = std::min(shape->x + POS_STEP, 0.9f);
            break;
        case GLFW_KEY_R:
            shape->rotation = fmod(shape->rotation + ROT_STEP, 360.0f);
            break;
        case GLFW_KEY_S:
            shape->scale = std::min(shape->scale + SCALE_STEP, 2.0f);
            break;
        case GLFW_KEY_X:
            shape->scale = std::max(shape->scale - SCALE_STEP, 0.5f);
            break;
        case GLFW_KEY_TAB:
            selectedShape = (selectedShape + 1) % 3;
            break;
        case GLFW_KEY_ESCAPE:
            glfwSetWindowShouldClose(window, true);
            break;
        }
    }
}

int main() {
    if (!glfwInit()) {
        std::cerr << "Failed to initialize GLFW" << std::endl;
        return -1;
    }

    GLFWwindow* window = glfwCreateWindow(800, 600, "Wonderland of Shapes", NULL, NULL);
    if (!window) {
        std::cerr << "Failed to create window" << std::endl;
        glfwTerminate();
        return -1;
    }
    glfwMakeContextCurrent(window);
    glfwSetKeyCallback(window, keyCallback);

    glEnable(GL_BLEND);
    glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);

    while (!glfwWindowShouldClose(window)) {
        glClear(GL_COLOR_BUFFER_BIT);
        glMatrixMode(GL_MODELVIEW);
        glLoadIdentity();

        drawGradientBackground();
        drawTargets();

        // Draw shapes with transformations
        glm::mat4 transform = glm::translate(glm::mat4(1.0f), glm::vec3(triangle.x, triangle.y, 0.0f));
        transform = glm::rotate(transform, glm::radians(triangle.rotation), glm::vec3(0.0f, 0.0f, 1.0f));
        transform = glm::scale(transform, glm::vec3(triangle.scale, triangle.scale, 1.0f));
        drawTriangle(transform);

        transform = glm::translate(glm::mat4(1.0f), glm::vec3(square.x, square.y, 0.0f));
        transform = glm::rotate(transform, glm::radians(square.rotation), glm::vec3(0.0f, 0.0f, 1.0f));
        transform = glm::scale(transform, glm::vec3(square.scale, square.scale, 1.0f));
        drawSquare(transform);

        transform = glm::translate(glm::mat4(1.0f), glm::vec3(circle.x, circle.y, 0.0f));
        transform = glm::rotate(transform, glm::radians(circle.rotation), glm::vec3(0.0f, 0.0f, 1.0f));
        transform = glm::scale(transform, glm::vec3(circle.scale, circle.scale, 1.0f));
        drawCircle(transform);

        drawInstructions();

        if (checkSuccess() && !successPrinted) {
            std::cout << "SUCCESS! All shapes match their targets!" << std::endl;
            successPrinted = true;
        }

        glfwSwapBuffers(window);
        glfwPollEvents();
    }
    glfwTerminate();
    return 0;
}
