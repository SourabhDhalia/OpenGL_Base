
#version 330 core
out vec4 FragColor;
 void main(){
    FragColor = vec4(1.0, 0.5, 0.2, 1.0); // Set the fragment color to orange
    // You can modify the color values to achieve different colors
    // For example, vec4(1.0, 0.0, 0.0, 1.0) for red
    // or vec4(0.0, 1.0, 0.0, 1.0) for green
    // The last value (1.0) is the alpha channel, which controls transparency
    // 1.0 means fully opaque, 0.0 means fully transparent  
    
 }