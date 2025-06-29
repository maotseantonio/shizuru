pragma Singleton
import QtQuick

QtObject {
    readonly property var dark: ({
        name: "Rxyhn + Decay Blend (Dark)",
        type: "dark",
        base00: "#0b0e14",    // Base (Rxyhn deep base)
        base01: "#11151c",    // Mantle
        base02: "#1e252f",    // Surface0
        base03: "#2a313c",    // Surface1
        base04: "#38404a",    // Surface2
        base05: "#c8d0e0",    // Text
        base06: "#a7c080",    // Soft Green (Decay)
        base07: "#9bbec7",    // Accent Light Blue (blend)
        base08: "#e26c7c",    // Red
        base09: "#e0af68",    // Peach / Orange (blend)
        base0A: "#dbbc7f",    // Yellow (Decay soft gold)
        base0B: "#a7c080",    // Green (Decay soft green)
        base0C: "#7fbbb3",    // Teal
        base0D: "#83b6af",    // Blue
        base0E: "#c594c5",    // Mauve (Rxyhn + Decay mix)
        base0F: "#d3869b"     // Pinkish accent
    })

    readonly property var light: ({
        name: "Rxyhn + Decay Blend (Light)",
        type: "light",
        base00: "#f4f5f6",    // Base
        base01: "#e8eaec",    // Mantle
        base02: "#d3d7db",    // Surface0
        base03: "#c2c7cc",    // Surface1
        base04: "#b0b5bb",    // Surface2
        base05: "#2d3138",    // Text
        base06: "#8daa9b",    // Soft Green Accent
        base07: "#5fafaf",    // Accent Blue-Green
        base08: "#d65d5d",    // Red
        base09: "#d7a65f",    // Peach
        base0A: "#cda45c",    // Yellow
        base0B: "#8daa9b",    // Green
        base0C: "#7acaca",    // Teal
        base0D: "#5a9dbb",    // Blue
        base0E: "#b48ead",    // Mauve
        base0F: "#a3685a"     // Pink/Brown Accent
    })
}

