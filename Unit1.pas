unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  WebView2, Winapi.ActiveX, Vcl.Edge,
  Vcl.Buttons, Vcl.StdCtrls, Vcl.ExtCtrls, NetEncoding, Clipbrd;

type
  TForm1 = class(TForm)
    EdgeBrowser1: TEdgeBrowser;
    Panel1: TPanel;
    Label1: TLabel;
    Edit1: TEdit;
    Button1: TButton;
    Button2: TButton;
    procedure EdgeBrowser1NavigationCompleted(Sender: TCustomEdgeBrowser;
      IsSuccess: Boolean; WebErrorStatus: TOleEnum);
    procedure FindClick(Sender: TObject);
    procedure BackClick(Sender: TObject);
    procedure ForwardClick(Sender: TObject);
    procedure CopyClick(Sender: TObject);
    procedure EdgeBrowser1WebMessageReceived(Sender: TCustomEdgeBrowser;
      Args: TWebMessageReceivedEventArgs);
    procedure EdgeBrowser1CreateWebViewCompleted(Sender: TCustomEdgeBrowser;
      AResult: HRESULT);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FindClick(Sender: TObject);
begin
  if Edit1.Text <> '' then begin
    var address := 'https://docs.microsoft.com/en-us/search/?terms=' +
      TNetEncoding.URL.Encode(Edit1.Text);
    EdgeBrowser1.Navigate(address);
  end;
end;

procedure TForm1.CopyClick(Sender: TObject);
begin
  EdgeBrowser1.ExecuteScript(
'var results = [...document.querySelectorAll(''[data-bi-name="result"]'')]'+
'.map(a => {'+ #13#10 +
'  let aElement = a.querySelector("a");'+ #13#10 +
'  return {'+ #13#10 +
'    title: aElement.innerText,'+ #13#10 +
'    link: aElement.getAttribute("href")'+ #13#10 +
'  };'+ #13#10 +
'});'+ #13#10 +
'console.log(results);'+ #13#10 +
'if (results.length >= 1){'+ #13#10 +
'  window.chrome.webview.postMessage(results);'+ #13#10 +
'}'+ #13#10 +
'else {'+  #13#10 +
'  alert("There are no results in the page");'+ #13#10 +
'}');
end;


procedure TForm1.EdgeBrowser1CreateWebViewCompleted(Sender: TCustomEdgeBrowser;
  AResult: HRESULT);
begin
  if AResult <> 0 then
    ShowMessage('Error initializing WebView: $'+IntToHex(AResult));
end;

procedure TForm1.EdgeBrowser1NavigationCompleted(Sender: TCustomEdgeBrowser;
  IsSuccess: Boolean; WebErrorStatus: TOleEnum);
begin
  if IsSuccess then
    EdgeBrowser1.ExecuteScript(
' var rss = document.querySelector(''[data-bi-name="search-rss-link"]'');'+ #13#10 +
' console.log(rss);'+ #13#10 +
' if (rss)'+ #13#10 +
'   rss.style.display = "none";'+ #13#10 +
' var form = document.getElementById("facet-search-form");'+ #13#10 +
' console.log(form);'+ #13#10 +
' if (form)'+ #13#10 +
'   form.style.display = "none";'+ #13#10 +
' var container = document.getElementById("left-container");'+ #13#10 +
' console.log(container);'+ #13#10 +
' if (container)'+ #13#10 +
'   container.style.display = "none";'+ #13#10 +
' var hiddenClasses = ["header-holder", "footerContainer"];'+ #13#10 +
' var divs = document.getElementsByTagName("div");'+ #13#10 +
' for( var i = 0; i < divs.length; i++) {'+ #13#10 +
'   if (hiddenClasses.some(r=> divs[i].classList.contains(r))){'+ #13#10 +
'     divs[i].style.display = "none";'+ #13#10 +
'   }'+ #13#10 +
' }');
end;

procedure TForm1.EdgeBrowser1WebMessageReceived(Sender: TCustomEdgeBrowser;
  Args: TWebMessageReceivedEventArgs);
var
  json : PWideChar;
begin
  var msg := Args as ICoreWebView2WebMessageReceivedEventArgs;
  msg.Get_webMessageAsJson(json);
  Clipboard.AsText := json;
  ShowMessage('Results sent to clipboard');
end;

procedure TForm1.BackClick(Sender: TObject);
begin
  if EdgeBrowser1.CanGoBack then
    EdgeBrowser1.GoBack;
end;

procedure TForm1.ForwardClick(Sender: TObject);
begin
  if EdgeBrowser1.CanGoForward then
    EdgeBrowser1.GoForward;
end;

end.
