part of 'images_cubit.dart';

// ignore: must_be_immutable
class ImageScreenState extends Equatable {
  int selectedImageIndex = 0;
  List<ImageAndExplanation> listOfImages = [
    ImageAndExplanation(
        explanation:
            '''  The Vomiting Centre receives afferents(GI tract, CTZ, Vestibular, Cortex) and links to the efferent vomiting limb. 
    The GI tract contains mechano and chemoreceptors which trigger nausea. The cortex sends afferents in response to nauseating sights, smells and thoughts.
    Common anti-emetics act on histamine, dopamine, serotonin and neurokinin receptors. The mechanism of action of dexamethasone and propofol are unknown but theorised to be central.
    The Apfel score is a five point system including:
    - Female sex
    - History of PONV/Motion Sickness
    - Non smoker
    - Post-op Opioids
    The risk of PONV is 10%, 20%, 40%, 60% and 80% for 0,1,2,3,4 points respectively.
      ''',
        title: "Anti-emetics",
        assetLink: "Antiemetics.jpg"),
    ImageAndExplanation(explanation: '''
    The substance labelled B is Arachidonic acid.
    The substance labelled C is PGH2.
    NSAIDS are an essential part of multi-modal analgesia for many patients. NSAIDs are COX inhibitors so act on the arachidonic acid pathway.
    COX inhibition leads to reduced levels of pro-inflammatory mediators (PGE2, PGD2). 
    Side effects are GI ulcer, MI, renal failure, fluid retention, bronchospasm.
    NSAIDS may be contraindicated in some asthmatics due to increased production of bradykinin.
    Selective COX-2 inhibitors (coxibs) have lower rates of GI ulceration but higher risks of MI and stroke. A single dose is probably OK and commonly given in the UK.

    ''', title: "Arachidonic Acid", assetLink: "ArachidonicAcid.jpg"),
    ImageAndExplanation(
        explanation:
            '''The blue line on the left represents depolarisation of the cardiac myocyte. The red line represents the cardiac action potential and depolarisation of cardiac pacemaker cell. 
    
    Similarities:
    - Both begin with a negative intracellular charge.

    Differences:  
    - A neuron has a more negative resting membrane potential(-90mV) than the cardiac pacemaker (-50mV).

        ''',
        title: "Cardiac Action Potential",
        assetLink: "CardiacActionPotential.jpg"),
    ImageAndExplanation(explanation: '''
    The diaphragm is a dome shaped muscle separating the abdomen from the thorax, and is the most important muscle in respiration.

    A useful (american) acronym to remember what passes through the diaphragm at what level is:
    'I ate 10 eggs at 12'.

    - IVC (and R phrenic) - T8
    - oEsophagus (and post vagus) - T10
    - Aorta (and thoracic duct) - T12

    Innervation of the diaphragm is:
    - Intercostal nerves supply the peripheral section
    - The phrenic nerve supplies sensory afferents and motor efferents.
        ''', title: "Diaphragm Anatomy", assetLink: "DiaphragmAnatomy.jpeg"),
    ImageAndExplanation(explanation: '''
    Flow is one of the key basic concepts of physics that should be understood for the primary FRCA.
    Imagine the flow of oxygen along oxygen tubing from a cylinder, where it is stored under pressure, to a facemask where the patient is breathing spontaneously.
    As the gas flows along the tubing it may flow turbulently or laminarly depending on Reynolds number. A fluid with a high density and velocity flowing through a wide pipe will exhibit turbulent flow like a wide, turbulent river.
    For an example of laminar flow consider highly viscous honey being squeezed out of a tube.
    The flow rate for turbulent flow is difficult to calculate, but proportional to the radius squared, whereas laminar flow is proportional to the radius^4.
    The Hagen-Poiseuille equation (pronunciation remains unknown) us used to calculate the flow rate of laminar fluids. Imagine a higher flow rate of oxygen through a wide, short tube with a great pressure gradient.


        ''', title: "Flow", assetLink: "FlowEquations.jpeg"),
  ];

  ImageScreenState({required this.selectedImageIndex});

  @override
  List<Object?> get props => [];
}
