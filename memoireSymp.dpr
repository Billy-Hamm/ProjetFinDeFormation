program memoireSymp;

{$R *.dres}

uses
  System.StartUpCopy,
  FMX.Forms,
  PageLogin in 'PageLogin.pas' {Form1},
  FrFormElement in 'FrFormElement.pas' {Frame1: TFrame},
  varGlobale in 'varGlobale.pas',
  FrHeaderApp in 'FrHeaderApp.pas' {headerApp: TFrame},
  Principale in 'Principale.pas' {Pprincipale},
  FrNavElement in 'FrNavElement.pas' {elementNav: TFrame},
  FrEmployeTopElement in 'FrEmployeTopElement.pas' {employeTopElemnt: TFrame},
  FrEmploye in 'FrEmploye.pas' {employe: TFrame},
  FrEmployeMaquette in 'FrEmployeMaquette.pas' {employeMaquette: TFrame},
  FrEmployeClick in 'FrEmployeClick.pas' {employeClick: TFrame},
  FrEmployeClickInformation in 'FrEmployeClickInformation.pas' {employeClickInformation: TFrame},
  FrEmployeClickInformationElement in 'FrEmployeClickInformationElement.pas' {employeClickInformationElement: TFrame},
  FrEmployeClickDocument in 'FrEmployeClickDocument.pas' {employeClickDocument: TFrame},
  FrEmployeClickDocumentElement in 'FrEmployeClickDocumentElement.pas' {employeClickDocumentElement: TFrame},
  FrEvaluation in 'FrEvaluation.pas' {evaluation: TFrame},
  FrEmployeMaquetteEval in 'FrEmployeMaquetteEval.pas' {employeMaquetteEval: TFrame},
  FrEvaluationTopElement in 'FrEvaluationTopElement.pas' {evaluationTopElement: TFrame},
  FrEvaluationClick in 'FrEvaluationClick.pas' {evaluationClick: TFrame},
  FrConge in 'FrConge.pas' {conge: TFrame},
  FrEmployeMaquetteConge in 'FrEmployeMaquetteConge.pas' {employeMaquetteConge: TFrame},
  FrCongeTopElement in 'FrCongeTopElement.pas' {congeTopElement: TFrame},
  FrCongeClick in 'FrCongeClick.pas' {congeClick: TFrame},
  FrCongeClickElement in 'FrCongeClickElement.pas' {congeClickElement: TFrame},
  FrCongeClickInformation in 'FrCongeClickInformation.pas' {congeClickInformation: TFrame},
  FrCongeAjouter in 'FrCongeAjouter.pas' {congeAjouter: TFrame},
  FrInput in 'FrInput.pas' {input: TFrame},
  FrElementConge in 'FrElementConge.pas' {ElementConge: TFrame},
  FrEmployeMaquetteB in 'FrEmployeMaquetteB.pas' {EmployeMaquetteB: TFrame},
  FrAbsenceClickInformation in 'FrAbsenceClickInformation.pas' {absenceClickInformation: TFrame},
  FrAbsenceClickElement in 'FrAbsenceClickElement.pas' {absenceClickElement: TFrame},
  FrEmployeMaquetteAbsence in 'FrEmployeMaquetteAbsence.pas' {employeMaquetteAbsence: TFrame},
  FrAbsence in 'FrAbsence.pas' {absence: TFrame},
  FrTacheMaquette in 'FrTacheMaquette.pas' {tacheMaquette: TFrame},
  FrTache in 'FrTache.pas' {tachePage: TFrame},
  FrTacheSurPprincipale in 'FrTacheSurPprincipale.pas' {tacheSurPprincipale: TFrame},
  FrTopElementInfo in 'FrTopElementInfo.pas' {topElementInfo: TFrame},
  logiqueEmploye in 'logiqueEmploye.pas',
  logiqueEvaluation in 'logiqueEvaluation.pas',
  dmBasesDeDonnees in 'dmBasesDeDonnees.pas' {basesDeDonnees: TDataModule},
  logiquePartager in 'logiquePartager.pas',
  FrEvaluationClickContainer in 'FrEvaluationClickContainer.pas' {evaluationClickContrainer: TFrame},
  logiqueConge in 'logiqueConge.pas',
  FrFiltreElement in 'FrFiltreElement.pas' {filtreElement: TFrame},
  FrFiltreElementInformation in 'FrFiltreElementInformation.pas' {filtreElementInformation: TFrame},
  FrFiltre in 'FrFiltre.pas' {filtre: TFrame},
  FrFiltreMaquette in 'FrFiltreMaquette.pas' {filtreMaquette: TFrame},
  FrEmployeMaquetteFdp in 'FrEmployeMaquetteFdp.pas' {employeMaquetteFdp: TFrame},
  FrFicheDePointage in 'FrFicheDePointage.pas' {ficheDePointage: TFrame},
  FrFiltreElement2 in 'FrFiltreElement2.pas' {FiltreElement2: TFrame},
  Accueil in 'Accueil.pas' {FrAccueil: TFrame},
  FrFiltreMaquetteFdp in 'FrFiltreMaquetteFdp.pas' {filtreMaquetteFdp: TFrame},
  FrFiltreMaquetteClickFdp in 'FrFiltreMaquetteClickFdp.pas' {filtreMaquetteClickFdp: TFrame},
  FrTopElementFichePointage in 'FrTopElementFichePointage.pas' {topElementFdp: TFrame},
  FrTempsHeureTopElement in 'FrTempsHeureTopElement.pas' {tempsTopElement: TFrame},
  FrStatutFdp in 'FrStatutFdp.pas' {statutFdp: TFrame},
  logiqueFicheDePointage in 'logiqueFicheDePointage.pas',
  FrRechMC in 'FrRechMC.pas' {RechMC: TFrame},
  FrEntierIntervalle in 'FrEntierIntervalle.pas' {entierIntervalle: TFrame},
  FrValeurCritere in 'FrValeurCritere.pas' {valeurCritere: TFrame},
  FrElementListCrit in 'FrElementListCrit.pas' {elementlisteCrit: TFrame},
  logiqueFiltre in 'logiqueFiltre.pas',
  ElementAccueil in 'ElementAccueil.pas' {FrElementAccueil: TFrame},
  logiqueAbsence in 'logiqueAbsence.pas',
  navElement2 in 'navElement2.pas' {FrNavElement2: TFrame},
  FrAbsenceTopElement in 'FrAbsenceTopElement.pas' {absenceTopElement: TFrame},
  Checkbox in 'Checkbox.pas' {FrCheckbox: TFrame},
  FrCandidatTopElement in 'FrCandidatTopElement.pas' {candidatTopElement: TFrame},
  FrRechCrit in 'FrRechCrit.pas' {RechCrit: TFrame},
  configFiltre in 'configFiltre.pas',
  afficherFiltre in 'afficherFiltre.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TPprincipale, Pprincipale);
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TbasesDeDonnees, basesDeDonnees);
  Application.Run;
end.
