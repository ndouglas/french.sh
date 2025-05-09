#!/usr/bin/env bash

verb_infinitive="$1";
english_meaning="$2";
english_past_tense="$3";
english_past_participle="$4";
stem="${verb_infinitive%er}";
past_participle="${stem}é";

persons=(
  "1st person singular"
  "2nd person singular"
  "3rd person singular"
  "1st person plural"
  "2nd person plural"
  "3rd person plural"
);
pronouns=(
  "je"
  "tu"
  "il/elle/on"
  "nous"
  "vous"
  "ils/elles"
);

function elide_je() {
  local next="$1"
  if [[ $next =~ ^(a|e|i|o|u|h) ]]; then
    echo "j'$next"
  else
    echo "je $next"
  fi
}

function conjugate() {
  : "${1?"Usage: ${FUNCNAME[0]} TENSE FORMS TRANSLATIONS"}";
  local tense="$1";
  local -n forms="$2";
  local -n translations=$3
  for i in "${!forms[@]}"; do
    echo "\"$verb_infinitive (${persons[$i]}, $tense)\",\"${forms[$i]}\",\"${translations[$i]}\"";
  done;
}

# Present Indicative
forms_present=(
  "$(elide_je "${stem}e")"
  "tu ${stem}es"
  "il/elle/on ${stem}e"
  "nous ${stem}ons"
  "vous ${stem}ez"
  "ils/elles ${stem}ent"
);
translations_present=(
  "I $english_meaning"
  "you $english_meaning"
  "he/she/one ${english_meaning}s"
  "we $english_meaning"
  "you (pl/formal) $english_meaning"
  "they $english_meaning"
);
conjugate "present indicative" forms_present translations_present;

# Imparfait
forms_imparfait=(
  "$(elide_je "${stem}ais")"
  "tu ${stem}ais"
  "il/elle/on ${stem}ait"
  "nous ${stem}ions"
  "vous ${stem}iez"
  "ils/elles ${stem}aient"
);
translations_imparfait=(
  "I used to $english_meaning"
  "you used to $english_meaning"
  "he/she/one used to $english_meaning"
  "we used to $english_meaning"
  "you (pl/formal) used to $english_meaning"
  "they used to $english_meaning"
);
conjugate "imparfait" forms_imparfait translations_imparfait;

# Future
forms_future=(
  "$(elide_je "${stem}erai")"
  "tu ${stem}eras"
  "il/elle/on ${stem}era"
  "nous ${stem}erons"
  "vous ${stem}erez"
  "ils/elles ${stem}eront"
);
translations_future=(
  "I will $english_meaning"
  "you will $english_meaning"
  "he/she/one will $english_meaning"
  "we will $english_meaning"
  "you (pl/formal) will $english_meaning"
  "they will $english_meaning"
);
conjugate "future" forms_future translations_future;

# Present Conditional
forms_conditional=(
  "$(elide_je "${stem}erais")"
  "tu ${stem}erais"
  "il/elle/on ${stem}erait"
  "nous ${stem}erions"
  "vous ${stem}eriez"
  "ils/elles ${stem}eraient"
);
translations_conditional=(
  "I would $english_meaning"
  "you would $english_meaning"
  "he/she/one would $english_meaning"
  "we would $english_meaning"
  "you (pl/formal) would $english_meaning"
  "they would $english_meaning"
);
conjugate "present conditional" forms_conditional translations_conditional;

# AVOIR helper forms
avoir_present=( "ai" "as" "a" "avons" "avez" "ont" )
avoir_imparfait=( "avais" "avais" "avait" "avions" "aviez" "avaient" )
avoir_future=( "aurai" "auras" "aura" "aurons" "aurez" "auront" )
avoir_conditional=( "aurais" "aurais" "aurait" "aurions" "auriez" "auraient" )
avoir_subj_present=( "aie" "aies" "ait" "ayons" "ayez" "aient" )

# Passé Composé
forms_pc=(
  "$(elide_je "${avoir_present[0]} $past_participle")"
  "tu ${avoir_present[1]} $past_participle"
  "il/elle/on ${avoir_present[2]} $past_participle"
  "nous ${avoir_present[3]} $past_participle"
  "vous ${avoir_present[4]} $past_participle"
  "ils/elles ${avoir_present[5]} $past_participle"
);
translations_pc=(
  "I ${english_past_tense}"
  "you ${english_past_tense}"
  "he/she/one ${english_past_tense}"
  "we ${english_past_tense}"
  "you (pl/formal) ${english_past_tense}"
  "they ${english_past_tense}"
);
conjugate "passé composé" forms_pc translations_pc;

# Pluperfect
forms_pqp=(
  "$(elide_je "${avoir_imparfait[0]} $past_participle")"
  "tu ${avoir_imparfait[1]} $past_participle"
  "il/elle/on ${avoir_imparfait[2]} $past_participle"
  "nous ${avoir_imparfait[3]} $past_participle"
  "vous ${avoir_imparfait[4]} $past_participle"
  "ils/elles ${avoir_imparfait[5]} $past_participle"
);
translations_pqp=(
  "I had ${english_past_participle}"
  "you had ${english_past_participle}"
  "he/she/one had ${english_past_participle}"
  "we had ${english_past_participle}"
  "you (pl/formal) had ${english_past_participle}"
  "they had ${english_past_participle}"
);
conjugate "pluperfect" forms_pqp translations_pqp;

# Future Perfect
forms_fp=(
  "$(elide_je "${avoir_future[0]} $past_participle")"
  "tu ${avoir_future[1]} $past_participle"
  "il/elle/on ${avoir_future[2]} $past_participle"
  "nous ${avoir_future[3]} $past_participle"
  "vous ${avoir_future[4]} $past_participle"
  "ils/elles ${avoir_future[5]} $past_participle"
);
translations_fp=(
  "I will have ${english_past_participle}"
  "you will have ${english_past_participle}"
  "he/she/one will have ${english_past_participle}"
  "we will have ${english_past_participle}"
  "you (pl/formal) will have ${english_past_participle}"
  "they will have ${english_past_participle}"
);
conjugate "future perfect" forms_fp translations_fp;

# Past Conditional
forms_pcnd=(
  "$(elide_je "${avoir_conditional[0]} $past_participle")"
  "tu ${avoir_conditional[1]} $past_participle"
  "il/elle/on ${avoir_conditional[2]} $past_participle"
  "nous ${avoir_conditional[3]} $past_participle"
  "vous ${avoir_conditional[4]} $past_participle"
  "ils/elles ${avoir_conditional[5]} $past_participle"
);
translations_pcnd=(
  "I would have ${english_past_participle}"
  "you would have ${english_past_participle}"
  "he/she/one would have ${english_past_participle}"
  "we would have ${english_past_participle}"
  "you (pl/formal) would have ${english_past_participle}"
  "they would have ${english_past_participle}"
);
conjugate "past conditional" forms_pcnd translations_pcnd;

# Present Subjunctive
forms_subj_present=(
  "que $(elide_je "${stem}e")"
  "que tu ${stem}es"
  "qu’il/elle/on ${stem}e"
  "que nous ${stem}ions"
  "que vous ${stem}iez"
  "qu’ils/elles ${stem}ent"
);
translations_subj_present=(
  "that I $english_meaning"
  "that you $english_meaning"
  "that he/she/one ${english_meaning}s"
  "that we $english_meaning"
  "that you (pl/formal) $english_meaning"
  "that they $english_meaning"
);
conjugate "present subjunctive" forms_subj_present translations_subj_present;

# Past Subjunctive
forms_subj_past=(
  "que $(elide_je "${avoir_subj_present[0]} $past_participle")"
  "que tu ${avoir_subj_present[1]} $past_participle"
  "qu’il/elle/on ${avoir_subj_present[2]} $past_participle"
  "que nous ${avoir_subj_present[3]} $past_participle"
  "que vous ${avoir_subj_present[4]} $past_participle"
  "qu’ils/elles ${avoir_subj_present[5]} $past_participle"
);
translations_subj_past=(
  "that I have ${english_past_participle}"
  "that you have ${english_past_participle}"
  "that he/she/one has ${english_past_participle}"
  "that we have ${english_past_participle}"
  "that you (pl/formal) have ${english_past_participle}"
  "that they have ${english_past_participle}"
);
conjugate "past subjunctive" forms_subj_past translations_subj_past;
