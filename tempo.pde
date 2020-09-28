import beads.*;
import controlP5.*;
import org.jaudiolibs.beads.*;
import java.util.*;

final int TEMPOTIME = 60;
int tempoVar;
int tempoSpeed;
int setTempo;

SamplePlayer goodBeep;
SamplePlayer badBeep;
SamplePlayer startTempo;
SamplePlayer endTempo;
Gain tempoGain;
int numGS, numBS;

public void setupTempo() {
    tempoGain = new Gain(ac, 1, 1);
    ac.out.addInput(tempoGain);
    
    goodBeep = getSamplePlayer("goodBeep.wav", false);
    badBeep = getSamplePlayer("badBeep.wav", false);
    startTempo = getSamplePlayer("startTempo.wav", false);
    endTempo = getSamplePlayer("endTempo.wav", false);
    goodBeep.pause(true);
    badBeep.pause(true);
    startTempo.pause(true);
    endTempo.pause(true);
    tempoGain.addInput(goodBeep);
    tempoGain.addInput(badBeep);
    tempoGain.addInput(startTempo);
    tempoGain.addInput(endTempo);
    
  
  
  
}