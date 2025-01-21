import controlP5.*; // Importar la biblioteca ControlP5

int pngCounter = 1; // Counter for PNG files
PGraphics pg; // For offscreen buffer


ControlP5 cp5; // OBJECTE CONTROLP5
Knob rotationKnob; // CONTROLAR ROTACIÓ DEL KNOB
PFont myfont;
int[] validAngles = {0, 30, 60, 90, 120, 150, 180, 210, 240, 270, 300, 330}; // GRAUS VALIDS DE ROTACIÓ
int selectedAngle = 0; // ANGLE SELECCIONAT PREDETRMINAT
color[] rainbowColors; // COMPOSICIÓ CROMÁTICA
String[] colorMoods = {
"Inspiració i creativitat",
"Energia i passió",
"Calidesa i optimisme",
"Felicitat i claredat",
"Vitalitat i frescor",
"Serenitat i equilibri",
"Creixement i esperança",
"Claredat i obertura",
"Confiança i concentració",
"Autoritat i profunditat",
"Ambició i luxe",
"Transformació i misticisme",
};

void setup() {
  myfont = createFont("RobotoMono-Regular.ttf", 40);
  pg = createGraphics(400, 500); // Define buffer size for the top middle section

  size(400, 740);
  noStroke();

  // CONFIGURACIÓ CONTROLP5
  cp5 = new ControlP5(this);

  // Crear el knob con valores discretos
  rotationKnob = cp5.addKnob("ASTROPSICOLOR MACHINE") // Nombre del knob
    .setRange(0, validAngles.length - 1) // Índices de los grados válidos
    .setValue(0)         // Índice inicial
    .setPosition(150, height/2+107) // Posición en el lienzo
    .setRadius(50)       // Radio del knob
    .setNumberOfTickMarks(validAngles.length) // Número de marcas (una por cada ángulo válido)
    .snapToTickMarks(true) // Ajuste a las marcas
    .setColorForeground(color(255))
    .setColorBackground(color(170, 179, 179))
    .setColorActive(color(100, 100, 100))
    .setDragDirection(Knob.VERTICAL); // Modo de arrastre

  // Inicializar colores del arco iris
  inicializarColores();
}

void draw() {
  textFont(myfont);
  background(255); // FONS BLANC
  noStroke();

  // ACTUALIZAR EL ÁNGULO SELECCIONADO BASADO EN EL ÍNDICE DEL KNOB
  selectedAngle = validAngles[int(rotationKnob.getValue())];

  pushMatrix();
  translate(0, -height/5);

  // DIBUJAR CAPAS
  dibujarEsferaGrande();
  dibujarRectangleBlanco();
  dibujarEsferaPequeña();

  // DIBUJAR RECTÁNGULO GRIS OSCURO
  pushMatrix();
  rectMode(CORNER);
  fill(98); // Gris oscuro
  rect(20, height - height/11, width - 40, 195);
  popMatrix();

  // DIBUJAR TEXTO CENTRADO EN EL RECTÁNGULO
  String moodText = colorMoods[int(rotationKnob.getValue())];
  fill(255); // Blanco
  textAlign(CENTER, CENTER);
  textSize(18);// TAMANY TEXT CAIXA GRISA
  text(moodText, width / 2, height - height /  -100+25); // Posición del texto

  dibujarMitjaEsferaBlanca();
  popMatrix();

  pg.beginDraw();
  pg.background(255); // Optional: clear buffer or match sketch background
  pg.image(get(0, 0, 400, 500), 0, 0); // Capture top-middle part
  pg.endDraw();

  image(pg, 0, 0); // Show the buffer for debugging (optional)
   
}

void keyPressed() {
  if (key == 's' || key == 'S') {
    // Save PNG when "s" is pressed
    String pngFilename = "image_" + nf(pngCounter, 5) + ".png"; // Unique PNG filename
    pg.save(pngFilename);
    println("Saved PNG: " + pngFilename);
    pngCounter++; // Increment PNG counter
  }
 
}

// FUNCIÓ INICIAR ELS COLORS DE L'ARC DE SANT MARTÍ
void inicializarColores() {
  rainbowColors = new color[12];
  rainbowColors[0] = color(215, 6, 247);   // HEX: #d706f7
  rainbowColors[1] = color(216, 0, 0);     // HEX: #d80000
  rainbowColors[2] = color(223, 117, 27);  // HEX: #df751b
  rainbowColors[3] = color(252, 252, 59);  // HEX: #fcfc3b
  rainbowColors[4] = color(168, 251, 59);  // HEX: #a8fb3b
  rainbowColors[5] = color(136, 223, 179); // HEX: #88dfb3
  rainbowColors[6] = color(142, 252, 127); // HEX: #8efc7f
  rainbowColors[7] = color(142, 252, 252); // HEX: #8efcfc
  rainbowColors[8] = color(66, 117, 248);  // HEX: #4275f8
  rainbowColors[9] = color(0, 0, 247);     // HEX: #0000f7
  rainbowColors[10] = color(100, 0, 247);  // HEX: #6400f7
  rainbowColors[11] = color(215, 6, 247);  // HEX: #d706f7
}

// FUNCIÓ DIBUIX ESFERA GRAN
void dibujarEsferaGrande() {
  push();
  translate(width / 2, height / 2);
  rotate(radians(selectedAngle)); // Rotar según el ángulo seleccionado
  drawRainbowGradient(0, 0, width / 4, width / 2);
  pop();
}

// FUNCIÓ DIBUIX RECTANGLE BLANC
void dibujarRectangleBlanco() {
  fill(255); // Color blanco
  noStroke();
  rect(width / 2, 0, width / 2, height); // Rectángulo blanco a la derecha
}

// FUNCIÓ DIBUIX ESFERA DE COLORS XICOTETA
void dibujarEsferaPequeña() {
  push();
  translate(width / 2, height / 2);
  rotate(radians(selectedAngle)); // Rotar según el ángulo seleccionado
  drawRainbowSphere(0, 0, width / 6);
  pop();
}

// FUNCIÓ DIBUIX MITJA ESFERA BLANCA
void dibujarMitjaEsferaBlanca() {
  push();
  translate(width / 2, height / 2);
  drawHalfWhiteSphere(0, 0, width / 6, HALF_PI, 3 * HALF_PI);
  pop();
}
// FUNCIÓ DIBUIX DEGRADAT COLORS ARC DE SANT MARTÍ EN L'ESFERA
void drawRainbowGradient(float centerX, float centerY, float innerRadius, float outerRadius) {
  for (int i = 0; i < 12; i++) {
    int next = (i + 1) % 12;
    for (float t = 0; t < 1; t += 0.01) {
      fill(lerpColor(rainbowColors[i], rainbowColors[next], t));
      float angle1 = map(i + t, 0, 12, 0, TWO_PI);
      float angle2 = map(i + t + 0.01, 0, 12, 0, TWO_PI);
      float x1 = centerX + innerRadius * cos(angle1);
      float y1 = centerY + innerRadius * sin(angle1);
      float x2 = centerX + outerRadius * cos(angle2);
      float y2 = centerY + outerRadius * sin(angle2);
      triangle(centerX, centerY, x1, y1, x2, y2);
    }
  }
}

// Función para dibujar una esfera pequeña
void drawRainbowSphere(float centerX, float centerY, float radius) {
  for (int i = 0; i < 12; i++) {
    int next = (i + 1) % 12; // Color siguiente para interpolación
    for (float t = 0; t < 1; t += 0.01) {
      fill(lerpColor(rainbowColors[i], rainbowColors[next], t));
      float angle1 = map(i + t, 0, 12, 0, TWO_PI);
      float angle2 = map(i + t + 0.01, 0, 12, 0, TWO_PI);
      float x1 = centerX + radius * cos(angle1);
      float y1 = centerY + radius * sin(angle1);
      float x2 = centerX + radius * cos(angle2);
      float y2 = centerY + radius * sin(angle2);
      triangle(centerX, centerY, x1, y1, x2, y2);
    }
  }
}

// Función para dibujar una media esfera blanca
void drawHalfWhiteSphere(float centerX, float centerY, float radius, float startAngle, float endAngle) {
  fill(255); // Color blanco
  noStroke();
  beginShape();
  for (float angle = startAngle; angle <= endAngle; angle += 0.01) {
    float x = centerX + radius * cos(angle);
    float y = centerY + radius * sin(angle);
    vertex(x, y);
  }
  vertex(centerX, centerY); // Cerrar forma
  endShape(CLOSE);
}
