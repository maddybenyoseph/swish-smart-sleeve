import beads.*;
import controlP5.*;
import org.jaudiolibs.beads.*;
import java.util.*;

final int CHIME_LENGTH_1 = 100;
final int CHIME_LENGTH_2 = 75;
final int CHIME_LENGTH_GAP = 300;
final float START_FREQ_1 = 261.6 * 2;
final float START_FREQ_2 = 432f;

final float NOTE_GAP_ASC = (float) Math.pow(1.059462742, 1);
final float NOTE_GAP_DES = 1f / NOTE_GAP_ASC;

int LR = 0;  // -10 thru 10
int UD = 0;  // -10 thru 10
int currChimeLR = -1; // left/right elbow position
int currChimeUD = -2; // up/down arm postiion
long chimeStart;
WavePlayer LRChime;
WavePlayer UDChime;
Gain LRChimeGain;
Gain UDChimeGain;
Gain chimeGain;

void setupChime() {
  chimeGain = new Gain(ac, 1, 1);
  LRChimeGain = new Gain(ac, 1, 0);
  UDChimeGain = new Gain(ac, 1, 0);
  LRChime = new WavePlayer(ac, (float) START_FREQ_1, Buffer.SINE);
  UDChime = new WavePlayer(ac, (float) START_FREQ_2, Buffer.SINE);
  LRChimeGain.addInput(LRChime);
  UDChimeGain.addInput(UDChime);
  chimeGain.addInput(LRChimeGain);
  chimeGain.addInput(UDChimeGain);
  ac.out.addInput(chimeGain);
  
}

void status(int currLR, int currUD) {
  UD = currUD;
  LR = currLR;
  currChimeLR = 0;
  currChimeUD = -2;
  LRChimeGain.setGain(1);
  UDChimeGain.setGain(0);
  chimeStart = millis();
  println("LR: " + LR + " UD: " + UD);
  LRChime.setFrequency(START_FREQ_1);
  UDChime.setFrequency(START_FREQ_2);
}

void progressChime() {
  if (currChimeLR != -1) {
    if (millis() > chimeStart + CHIME_LENGTH_1 || (LRChime.getFrequency() != START_FREQ_1 && millis() > chimeStart + CHIME_LENGTH_2)) {
      chimeStart = millis();
      if (currChimeLR >= Math.abs(LR)) {
        currChimeLR = -1;
        currChimeUD = -1;
        LRChimeGain.setGain(0);
      } else {
        LRChime.setFrequency(LRChime.getFrequency() * (LR > 0 ? NOTE_GAP_ASC : NOTE_GAP_DES));
        currChimeLR++;
      }
    }
  }
  if (currChimeUD == -1) {
    if (millis() > chimeStart + CHIME_LENGTH_GAP) {
      chimeStart = millis();
      currChimeUD = 0;
      UDChimeGain.setGain(1);
    }
  }
  if (currChimeUD > -1) {
    if (millis() > chimeStart + CHIME_LENGTH_1 || (UDChime.getFrequency() != START_FREQ_2 && millis() > chimeStart + CHIME_LENGTH_2)) {
      chimeStart = millis();
      if (currChimeUD >= Math.abs(UD)) {
        currChimeUD = -2;
        UDChimeGain.setGain(0);
      } else {
        UDChime.setFrequency(UDChime.getFrequency() * (UD > 0 ? NOTE_GAP_ASC : NOTE_GAP_DES));
        currChimeUD++;
      }
    }
  }
}