program CloseWindow;

{$APPTYPE CONSOLE}

uses
  SysUtils,
  Messages,
  Windows;

function FindWindowExtd(partialTitle: string): HWND;
var
  hWndTemp: hWnd;
  iLenText: Integer;
  cTitletemp: array [0..254] of Char;
  sTitleTemp: string;
begin
  hWndTemp := FindWindow(nil, nil);
  while hWndTemp <> 0 do begin
    iLenText := GetWindowText(hWndTemp, cTitletemp, 255);
    sTitleTemp := cTitletemp;
    sTitleTemp := UpperCase(copy( sTitleTemp, 1, iLenText));
    partialTitle := UpperCase(partialTitle);
    if pos( partialTitle, sTitleTemp ) <> 0 then
      Break;
    hWndTemp := GetWindow(hWndTemp, GW_HWNDNEXT);
  end;
  result := hWndTemp;
end;

var
  vTitle: String;
  vHandle: Hwnd;
begin
  try
    sleep(8000);
    if ParamCount = 1 then
    begin
      vTitle := ParamStr(1);
      vHandle := FindWindowExtd(vTitle);
      if vHandle <> 0 then
        PostMessage(vHandle, WM_CLOSE, 1, 1)
    end
    else
      Writeln('CloseWindow WindowTitle');
  except
    on E:Exception do
      Writeln(E.Classname, ': ', E.Message);
  end;
end.

