/// Sample profile. Replace these values with Firebase user data later.
class DummyUser {
  static const name = 'Student User';
  static const email = 'student@example.com';
}

/// Shown on Home until a new goal is saved on Profile.
const starterCareerGoal = 'Find a path with a strong Career Fit score';

/// Sample scores from 0 to 100. Later these can come from an assessment result.
const careerFitScore = 76;
const futureProofScore = 68;

const skillGaps = [
  'Cloud basics are still light for most junior roles.',
  'System design practice is missing from the current plan.',
  'Portfolio depth needs one more finished project.',
];

const pivotBridgeSteps = [
  'Map current skills to a target role.',
  'Close the top skill gap with one small project.',
  'Practice explaining the pivot in an interview.',
];

const preferenceTags = ['Mobile apps', 'Data', 'Team work', 'Internships'];

/// One assessment question and the options the user can tap.
class AssessmentQuestion {
  const AssessmentQuestion(this.prompt, this.options);

  final String prompt;
  final List<String> options;
}

const assessmentQuestions = [
  AssessmentQuestion(
    'What kind of work do you enjoy most?',
    ['Building apps', 'Data and AI', 'Design and visuals', 'Helping people'],
  ),
  AssessmentQuestion(
    'How do you prefer to work?',
    ['Solo deep work', 'With a team', 'A mix of both'],
  ),
  AssessmentQuestion(
    'Which strength fits you best right now?',
    ['Programming', 'Communication', 'Problem solving'],
  ),
  AssessmentQuestion(
    'What do you want more of next semester?',
    ['A portfolio project', 'Interview practice', 'A new technical skill'],
  ),
];

/// One phase on the sample career roadmap. [id] is stored in Firestore.
class RoadmapPhase {
  const RoadmapPhase(this.id, this.title, this.detail);

  final String id;
  final String title;
  final String detail;
}

const roadmapPhases = [
  RoadmapPhase(
    'fundamentals',
    'Learn the fundamentals',
    'Cover core programming and problem solving.',
  ),
  RoadmapPhase(
    'projects',
    'Build two portfolio projects',
    'Ship small apps you can explain in an interview.',
  ),
  RoadmapPhase(
    'interviews',
    'Practice interviews',
    'Walk through projects and common technical questions.',
  ),
  RoadmapPhase(
    'applications',
    'Apply for internships',
    'Send a short list of targeted applications.',
  ),
];
