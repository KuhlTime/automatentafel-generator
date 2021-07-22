import processing.pdf.*;

// Configuration
final int padding = 48;
final int binary_states = 2;
final int binary_inputs = 1;
final int binary_outputs = 1;

final int scale = 4;

final int coloumnWidth = 38;
final int rowHeight = 30;

final int totalColoumns = 1 + binary_states + (int) pow(2, binary_inputs) * (1 + binary_states + binary_outputs);
final int totalRows = 1 + (int) pow(2, binary_states);

final int totalWidth = coloumnWidth * totalColoumns;
final int totalHeight = rowHeight * totalRows;

void settings() {
  println("Please wait, this may takes some time. Depending on your settings.");
  size(padding * 2 + totalWidth, padding * 2 + totalHeight, PDF, "output.pdf");
}

void drawHorizontalLine(int y) {
  // x1, y1, x2, y2
  line(padding, y, padding + totalWidth, y);
}

void drawVerticalLine(int x) {
  // x1, y1, x2, y2
  line(x, padding, x, padding + totalHeight);
}

void loadLatex(String latex, int x, int y, int imgWidth, int imgHeight) {
  String widthStr = "&width=" + imgWidth * scale;
  String heightStr = "&height=" + imgHeight * scale;
  String latexStr = "&source=" + latex;
  
  String url = "http://68.183.67.250:8090/render?input=latex&output=png" + widthStr + heightStr + latexStr;
  
  PImage img = loadImage(url, "png");
  image(img, x, y, imgWidth, imgHeight);
}

void loadLatex(String latex, int x, int y) {
  int imageHorizontalPadding = 2;
  int imgWidth = coloumnWidth - imageHorizontalPadding * 2;
  int imgVerticalPadding = 3;
  int imgHeight = rowHeight - imgVerticalPadding * 2;
  
  loadLatex(latex, x + imageHorizontalPadding, y + imgVerticalPadding, imgWidth, imgHeight);
}

String binaryRepresent(int value, int digits) {
  String binaryString = Integer.toBinaryString(value);
  String prependZeros = repeat("0", digits - binaryString.length());
  return prependZeros + binaryString;
}

String repeat(String str, int times) {
  String result = "";
  for (int i = 0; i < times; i++) { result += str; }
  return result;
}

void setup() {
  background(255);

  // Draw something good here
  // drawHorizontalLine(padding);
  // drawHorizontalLine(height-padding);
  // drawVerticalLine(padding);
  // drawVerticalLine(width-padding);

  // First Row
  loadLatex("Z^n", padding, padding);
  
  drawHorizontalLine(padding + rowHeight);
  drawHorizontalLine(padding + rowHeight + 1);
  
  int subSetColoumns = 1 + binary_states + binary_outputs;
  println("subsetcoloumns: " + subSetColoumns);
  int subSetWidth = subSetColoumns * coloumnWidth;
  println("subSetWidth: " + subSetWidth);
  int leftColoumns = 1 + binary_states;
  println("leftColoumns: " + leftColoumns);
  
  // DRAW COLOUMNS
  for (int i = 0; i < totalColoumns + 1; i++) {
    boolean seperator = false;
    
    if ((i - leftColoumns) % subSetColoumns == 0) {
        seperator = true;
    }
    
    // Double Line
    if (seperator == true && i != totalColoumns) {
      drawVerticalLine(padding + coloumnWidth * i + 2);
    }
    
    drawVerticalLine(padding + coloumnWidth * i);
  }
  
  // DRAW ROWS
  for (int i = 0; i < pow(2, binary_states); i++) {
    int top = padding + rowHeight * (i+1);
    drawHorizontalLine(top + rowHeight);
  }
  
  // RENDER FIRST COLOUMN
  for (int i = 0; i < pow(2, binary_states); i++) {
    int top = padding + rowHeight * (i+1);
    loadLatex("Z_{" + binaryRepresent(i, binary_states) + "}", padding, top);
  }
  
  // RENDER Q^n COLOUMNS
  for (int i = 0; i < binary_states; i++) {
    // Storage Labels
    int left = padding + coloumnWidth * (i+1);
    loadLatex("Q_{" + (i+1) + "}^n", left, padding);
    
    for (int j = 0; j < pow(2, binary_states); j++) {
      int top = padding + rowHeight * (j+1);
      
      // State Labels
      String str = "" + binaryRepresent(j, binary_states).charAt(i);
      loadLatex(str, left, top);
    }
  }
  
  for(int i = 0; i < pow(2, binary_inputs); i++) {
    int left = padding + leftColoumns * coloumnWidth + i * subSetWidth;
    
    // INPUT
    int inputImageWidth = 42;
    int inputImageHeight = 24;
    loadLatex("E%3D" + binaryRepresent(i, binary_inputs), left + (subSetWidth / 2) - (inputImageWidth / 2), padding - inputImageHeight, inputImageWidth, inputImageHeight);
    
    // HEADERS
    loadLatex("Z^{n%2B1}", left, padding);
    
    for (int j = 0; j < binary_states; j++) {
      int left_t = left + coloumnWidth * (j + 1);
      loadLatex("Q_{" + (j+1) + "}^{n%2B1}", left_t, padding);
    }
    
    for (int j = 0; j < binary_outputs; j++) {
      int left_t = left + coloumnWidth * binary_states + coloumnWidth * (j + 1);
      
      if (binary_outputs == 1) {
        loadLatex("\\%20A\\%20", left_t, padding); 
      } else {
        loadLatex("A_{" + (i+1) + "}", left_t, padding); 
      }
    }
  }

  // Exit the program 
  println("Finished.");
  exit();
}
