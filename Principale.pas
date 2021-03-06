unit Principale;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Edit, FMX.Objects, FMX.Effects, FMX.Layouts,
  FrNavElement, FMX.Ani, FrEmploye, FrEmployeTopElement, FrEmployeClick,
  FrEvaluationTopElement, FrEvaluation, FrConge, FrCongeTopElement,
  FrCongeAjouter, FrTacheMaquette, FrTacheSurPprincipale, FrTache, FrTopElementInfo,
  FrEmployeMaquetteFdp, FrTopElementFichePointage, FrRechMC,
  FrInput;

type
  TPprincipale = class(TForm)
    header: TLayout;
    bg: TRectangle;
    container : TLayout;
    layRecherche : TLayout;
    logo_ss : TImage;
    nav : TLayout;
    bg_recherche : TRectangle;
    recherche : TEdit;
    nomAdmin : TLabel;
    task: TLayout;
    containTask : TLayout;
    prinContainer: TLayout;
    adminContainer: TLayout;
    Label2: TLabel;
    Label1: TLabel;
    Label4: TLabel;
    navItems: TLayout;
    elementNav1: TelementNav;
    elementNav2: TelementNav;
    elementNav3: TelementNav;
    elementNav4: TelementNav;
    elementNav5: TelementNav;
    elementNav6: TelementNav;
    elementNav7: TelementNav;
    menu: TRectangle;
    menuContainer: TLayout;
    Rectangle1: TRectangle;
    menuResize: TFlowLayout;
    elementNav8: TelementNav;
    FlowLayoutBreak1: TFlowLayoutBreak;
    elementNav9: TelementNav;
    FlowLayoutBreak2: TFlowLayoutBreak;
    elementNav10: TelementNav;
    FlowLayoutBreak3: TFlowLayoutBreak;
    elementNav11: TelementNav;
    FlowLayoutBreak4: TFlowLayoutBreak;
    elementNav12: TelementNav;
    FlowLayoutBreak5: TFlowLayoutBreak;
    elementNav13: TelementNav;
    FlowLayoutBreak6: TFlowLayoutBreak;
    elementNav14: TelementNav;
    topElement: TRectangle;
    containeTopElement: TLayout;
    Layout2: TLayout;
    VertScrollBox1: TVertScrollBox;
    tacheSurPprincipale1: TtacheSurPprincipale;
    topElementInfo1: TtopElementInfo;
    Label7: TLabel;
    Button1: TButton;
    Button2: TButton;
    Label3: TLabel;
    procedure FormResize(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure menuClick(Sender: TObject);
    procedure elementNav1elementNagivationClick(Sender: TObject);
  private
    { Déclarations priv�es }
    var
//      gardeFou : Integer;
      tailleEcran : Real;
      toggleMenu : Boolean;
  public
    { Déclarations publiques }
  end;

var
  Pprincipale: TPprincipale;
  topFdp : TtopElementFdp;
//  gardeFou : Integer;
//  tailleEcran : Real;
//  toggleMenu : Boolean;

implementation
uses varGlobale, FrFiltreMaquetteClickFdp;

{$R *.fmx}
{$R *.SSW3.fmx ANDROID}
{$R *.XLgXhdpiTb.fmx ANDROID}





procedure TPprincipale.elementNav1elementNagivationClick(Sender: TObject);
begin
  elementNav1.elementNagivationClick(Sender);

end;

procedure TPprincipale.FormCreate(Sender: TObject);
begin
  // 604 est la taille minimum que l'on peut prendre charge pour le responsive
  tailleEcran := 604;
  toggleMenu := True;
  creeEnsembleElements();
//  topFdp := TtopElementFdp.Create(Self);
//  topFdp.ajoutTempsHeure();
//  topFdp.Parent := containeTopElement;
end;


procedure TPprincipale.FormResize(Sender: TObject);

begin
  Pprincipale.Label2.Text := IntToStr(Pprincipale.Width);
  // Gestion du logo et de la partie administration (inclu le if qui vient juste apr�s)
  if Pprincipale.Width < 1115 then
    begin
       // Gestion de la partie administrateur
       Pprincipale.adminContainer.Parent := Pprincipale;
       Pprincipale.adminContainer.Position.Y := 20;
       Pprincipale.adminContainer.Anchors := [ TAnchorKind.akRight ];
       // Gestion du logo
       Pprincipale.logo_ss.Parent := Pprincipale;
       Pprincipale.logo_ss.Position.Y := 8;
       Pprincipale.logo_ss.Position.X := 0;
       Pprincipale.logo_ss.Anchors := [ TAnchorKind.akLeft ];
    end;

     if Pprincipale.Width > 1115 then
    begin
      // Gestion de la partie administrateur
      Pprincipale.adminContainer.Parent := Pprincipale.container;
      Pprincipale.adminContainer.Position.Y := 20;
      Pprincipale.adminContainer.Position.X := 904;
      // Gestion du logo
      Pprincipale.logo_ss.Parent := Pprincipale.container;
      Pprincipale.logo_ss.Position.X := 0;
      Pprincipale.logo_ss.Position.Y := 8;
    end;

  // Gestion du la partie recherche (inclu le if qui vient juste apr�s)
  if Pprincipale.Width < 988 then
    begin
       Pprincipale.layRecherche.Parent := Pprincipale;
       Pprincipale.layRecherche.Position.Y := 24;
       Pprincipale.layRecherche.Position.X := 103;
       Pprincipale.adminContainer.Anchors := [ TAnchorKind.akRight ];
    end;

  if Pprincipale.Width > 988 then
    begin
      Pprincipale.layRecherche.Parent := Pprincipale.container;
      Pprincipale.layRecherche.Position.Y := 24;
      Pprincipale.layRecherche.Position.X := 160;
    end;

  // Gestion du nom de l'administrateur
  if Pprincipale.Width < 815 then
    begin
      nomAdmin.Visible := False;
    end
  else
    begin
      nomAdmin.Visible := True;
    end;

  // Gestion des T�ches
  if Pprincipale.Width < 809 then
    begin
      task.Visible := False;
    end
  else
    begin
      task.Visible := True;
    end;

  // Gestion du menu
  if Pprincipale.Width < 802 then
    begin
      navItems.Visible := False;
      menu.Visible := True;
    end
  else
    begin
      navItems.Visible := True;
      menu.Visible := False;
      menuContainer.Visible := False;
      toggleMenu := True;
    end;


    // Pour le responsive
//    responsive ();



  // Gestion de la barre de recherche
  {
  On pouvait utiliser une m�thode un peu plus appropri�, mais vu ce que nous voulons
  faire cela ne va pas nous aider. Ce que nous ne voulons pas du tout c'est que les
  �l�ment scale (grossisse) sans notre control� or c'est exactement ce que fait les
  �l�ments de layout. Pour avoir un peu plus de contr�le, on v�rif� la taille et
  on agit on changeant les dimensions.
  }
  if Pprincipale.Width < 702 then
    begin
      layRecherche.Width := 384;
      bg_recherche.Width := 384;
      recherche.Width := 312;
    end
  else
    begin
      layRecherche.Width := 497;
      bg_recherche.Width := 497;
      recherche.Width := 425;
    end;

  // Fin de redimensionnement
  {
  Nous faisons ceci pour avoir une sorte de minWidth, afin d'�viter
  de g�rer les tailles d'�cran en dessous de "tailleEcran" qui est de 604;
  Pour ce que cela fonctionne, il faut v�rifer la taille actuelle de l'�cran
  qui est Pprincipale.Width selon la taille d�finie
  }
  if Pprincipale.Width < tailleEcran then
    begin
          label4.Text := FloatToStr(tailleEcran);
          ShowMessage('Taille minimale atteint');
          tailleEcran := Pprincipale.Width;

            // Pour le debogage
           label1.Text := FloatToStr(tailleEcran);

    end;
  // Ceci permet de toujours ramener la valeur de tailleEcran � 604

  if Pprincipale.Width >= 604 then
    begin
      tailleEcran := 604;
    end;

  // Pour centrer artificiellement la liste des employ�s
  {
  On pouvait centrer directement l'�l�ment avec la propri�t� "center"
  mais le probl�me qui se pose est que �a donne un comportement bizarre,
  alors, vu que la propri�t� center de Align calcul directement les positions
  et qu'il y a des �l�ments qui sont centr�s au m�me que celui de la liste des
  employ�s, il nous suffit qu'attribu� � la liste la propri�t� position d'un �l�ment d�j�
  cent� pour que ce dernier le soit aussi, � l'occurent ici "containTask"
  }
  prinContainer.Position.X := containTask.Position.X;


  // Taille dynamique de l'affiche de la scrollbox
  {
  Ce code permet de faire à ce que l'affiche puisse être conforme à la page peu
  importe la taille de la fenêtre.
  * 700 ici est la taille de la fenêtre au lancement de l'application
  * 322 ici représente la taille de toute chose au dessus de la scrollbox
  * 42 c'est pour avoir des marge afin que le contenu de la page ne
  parte pas en dessus de la barre de tâche windows
  }
  if Pprincipale.Height > 700 then
    begin
      Pprincipale.VertScrollBox1.Height := (Pprincipale.Height -  322)- 42;
    end;

    FloatToStr(Pprincipale.VertScrollBox1.Height);
    Pprincipale.Label7.Text := FloatToStr(Pprincipale.Height);
end;



// Pour g�rer l'apparition du menu verticale
procedure TPprincipale.menuClick(Sender: TObject);
begin
  if toggleMenu then
    begin
      menuContainer.Visible := True;
      // 80 est la diff�rencce de distance qu'il y a entre le menu
      // et le menuContainer afin que �a soit bien fix�.
      menuContainer.Position.X := menu.Position.X - 80;
    end
  else
    begin
      menuContainer.Visible := False;
    end;

  if toggleMenu = True then
    begin
      toggleMenu := False;
    end
  else
    begin
      toggleMenu := True;
    end;

end;



end.
