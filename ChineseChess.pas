uses graphABC;

type
   figureT = record
      name:char;
      col:Color;
   end;

   fieldT = array['a'..'i', '0'..'9'] of figureT; (* ��� ���� *)

const
   window_h = 480; (* ������ ������������ ���� *)
   window_w = 1000; (* ������ ������������ ���� *)

   line_size = 40; (* ������ ������ � �������� *)
   column_size = line_size; (* ������ ������� � ��������*)

   field_x = 30; (* ���������� ���� �� X *)
   field_y = 15; (* ���������� ���� �� Y *)
   
   field_h = 9 * line_size; (* ������ ���� *)
   field_w = 8 * column_size; (* ������ ���� *)

   info_x = 500; (* ��������� ���������� ���� ������ ���������� �� � *)
   info_y = 15; (* ��������� ���������� ���� ������ ���������� �� Y*)
   
   info_w = 480; (* ������ ���� ������ ���������� *)
   info_h = 400; (* ������ ���� ������ ���������� *)

   field_color = rgb(255, 253, 208); (* ���� ���� *)
   field_lines_color = rgb(0, 0, 0); (* ���� ����� ���� *)   
   info_lines_color = rgb(0, 0, 0); (* ���� ����� ���� ������ ���������� *)
   
   text_color = rgb(0, 0, 200); (* ���� ������ ��� ����������� ���������� *)
   background_color = rgb(255, 255, 255); (* ���� ������������ ���� *)
   
   fig_names:array[1..16] of char = ('R', 'H', 'E', 'A', 'G', 'A', 'E', 'H', 'R', 'C', 'C', 'S', 'S', 'S', 'S', 'S');
   
   figs_set = ['R', 'H', 'E', 'A', 'G', 'C', 'S', '*'];
var
   field:fieldT;
  
(* �������� ���������� ���� *)
procedure clean_info;
begin
   setPenColor(info_lines_color);
   setBrushColor(background_color);
   setBrushStyle(bsSolid);
   rectangle(info_x, info_y, info_x + info_w + 5, info_y + info_h + 5);
   setBrushStyle(bsClear);
end;
  
(* ��������� ���� ���� *)
procedure draw_field(x, y, w, h:integer);
var
   i:integer;
   ch:char;
begin
  setBrushColor(background_color);
  
  setPenColor(field_lines_color);  
  setPenWidth(2);  
  Rectangle(x, y, x + w + 16, y + h + 16);
  
  x := x + 8;
  y := y + 8;
  
  setPenWidth(1); 
  setBrushColor(field_color);
  Rectangle(x, y, x + w, y + h);
  
  setBrushColor(background_color);
  
  (* ��������� ������������ ����� *)
  for i := 1 to 7 do begin
      line(x + i * line_size, y, x + i * line_size, y + (h - line_size) div 2 - 1);
      line(x + i * line_size, y + (h + line_size) div 2, x + i * line_size, y + h - 1);
  end;
  
  (* ��������� �������������� ����� *)
  for i := 1 to 8 do
     line(x, y + i * column_size, x + w - 1,  y + i * column_size);
  
  (* ��������� ����� *)
  line(x + 3 * column_size, y, x + 5 * column_size, y + 2 * line_size);
  line(x + 3 * column_size, y + 2 * line_size, x + 5 * column_size, y);
  
  line(x + 3 * column_size, y + 7 * line_size, x + 5 * column_size, y + 9 * line_size - 1);
  line(x + 3 * column_size, y + 9 * line_size - 1, x + 5 * column_size, y + 7 * line_size);
  
  (* ��������� ����������� ����� *)
  setFontSize(9);
  SetFontStyle(fsBold);
  SetFontColor(text_color);
  
  for i := 0 to 9 do
     textOut(x - 30, y + i * line_size - textHeight('' + i) div 2, 9 - i);
     
  for ch := 'a' to 'i' do
     textOut(x + (ord(ch) - ord('a')) * column_size - textWidth(ch) div 2, y + h + line_size - 10, ch);
     
  textOut(x + w + 50, y, 'R - �����');
  textOut(x + w + 50, y + textHeight('R'), 'H - ����');
  textOut(x + w + 50, y + 2 * textHeight('H'), 'E - ����');
  textOut(x + w + 50, y + 3 * textHeight('E'), 'A - �����');
  textOut(x + w + 50, y + 4 * textHeight('A'), 'G - ������');
  textOut(x + w + 50, y + 5 * textHeight('G'), 'C - �����');
  textOut(x + w + 50, y + 6 * textHeight('C'), 'S - �����');
end;

(* �������� �������� ���� �� ����� *)
procedure clean_field(var field:fieldT);
var
   ch, num:char;
begin
   for ch := 'a' to 'i' do
      for num := '0' to '9' do
         field[ch, num].name := ' ';
end;

(* ����������� ����� �� ��������� *)
procedure figures_default(var field:fieldT);
var
   num, ch:char;
begin
   clean_field(field);
   
   for ch := 'a' to 'i' do begin
      field[ch, '0'].name := fig_names[ord(ch) - ord('a') + 1];
      field[ch, '9'].name := fig_names[ord(ch) - ord('a') + 1];
   end;
   
   field['b', '2'].name := 'C';
   field['h', '2'].name := 'C';   
   field['a', '3'].name := 'S';
   field['c', '3'].name := 'S';
   field['e', '3'].name := 'S';
   field['g', '3'].name := 'S';
   field['i', '3'].name := 'S';
   
   field['b', '7'].name := 'C';
   field['h', '7'].name := 'C';   
   field['a', '6'].name := 'S';
   field['c', '6'].name := 'S';
   field['e', '6'].name := 'S';
   field['g', '6'].name := 'S';
   field['i', '6'].name := 'S';
   
   for num := '0' to '4' do
      for ch := 'a' to 'i' do
         field[ch, num].col := clRed;
         
   for num := '5' to '9' do
      for ch := 'a' to 'i' do
         field[ch, num].col := clBlue;
end;

(* ������� ���������� ��������� � ���������� ������������ ���� (chars->pixels) *)
procedure map(x0, y0:char; var x, y:integer);
begin
   x := field_x + (ord(x0) - ord('a')) * column_size;
   y := field_y + (9 - ord(y0) + ord('0')) * line_size;
end;

(* ��������� ����� �� ���� *)
procedure print_figures(field:fieldT);
var
   x, y:integer;
   ch, num:char;
begin
   lockDrawing;
   setBrushStyle(bsSolid);
   setPenColor(background_color);
   setBrushColor(background_color);
   rectangle(0, 0, 2 * field_x + field_w, window_h);
   
   draw_field(field_x, field_y, field_w, field_h);

   setBrushStyle(bsClear);
   setFontSize(11);
   setFontStyle(fsNormal);
   setFontColor(clWhite);
   
   for ch := 'a' to 'i' do
      for num := '0' to '9' do begin
         map(ch, num, x, y);
         
         setBrushStyle(bsSolid);
         setBrushColor(field[ch, num].col);
         
         if field[ch, num].name <> ' ' then begin
            circle(x + 8, y + 9, line_size div 2 - 2);
            
            setBrushStyle(bsClear);
            textOut(x + 3, y, field[ch, num].name);
         end;
      end;
   redraw;
   unlockDrawing;
end;

(* �������� �� ������������ ���������� (������ �� a �� i, ������� �� 0 �� 9) *)
procedure correct_coordinate(fig:char; var ch, num:char; var i:integer);
begin  
   while (ch > 'i') or (ch < 'a') or (num > '9') or (num < '0') do begin
      i := i + 1;
      textOut(info_x + 5, info_y + 7 + i * textHeight('A'), '���������� ������� �������. ������� ���������� ��� ���: ');
         
      readln(ch, num); 
         
     textOut(info_x + textWidth('���������� ������� �������. ������� ���������� ��� ���: ') + 6, info_y + 7 + i * textHeight('A'), fig + '(' + ch + ',' + num + ')');          
   end; 
end;

(* �������� �� ��������� ������� ������ ������� *)
procedure is_empty_pos(var fig, ch, num:char; var i:integer);
begin   
   while field[ch, num].name <> ' ' do begin
      i := i + 1;
      textOut(info_x + 5, info_y + 7 + i * textHeight('A'), '� ���� ����� ��� ����� ������. ������� ��������� ��� ���: ');
         
      readln(ch, num); 
      
      correct_coordinate(fig, ch, num, i);
      
      textOut(info_x + textWidth('� ���� ����� ��� ����� ������. ������� ��������� ��� ���: ') + 6, info_y + 7 + i* textHeight('A'), '(' + ch + ',' + num + ')');          
   end; 
end;

(* ����������� ����� �� ���� ������������� *)
procedure arrangement_figures(var field:fieldT);
var
   fig, ch, num:char; (* ������ � ������������ *)
   i:integer;
   rem_figs:array['A'..'S'] of integer;
begin
   (* ��������� �������� ���������� ���������� ����� *)
   rem_figs['R'] := 2;
   rem_figs['H'] := 2;
   rem_figs['E'] := 2;
   rem_figs['A'] := 2;
   rem_figs['G'] := 1;
   rem_figs['C'] := 2;
   rem_figs['S'] := 5;
   
   clean_info;
   
   setFontSize(8);
   textOut(info_x + 5, info_y + 5, '����������� ����� ������� (������� �����, *** - ��������� �����)');

   clean_field(field);
   
   i := 1;

   (* ���� �� ������� ������� ����� ����� ��� ���� �� ����������� ��� ������ *)
   repeat
      setFontColor(text_color);
      setFontSize(8);
      setFontStyle(fsNormal);
      
      textOut(info_x + 5, info_y + 7 + i * textHeight('A'), '������� ������: ');
      readln(fig, ch, num);
      
      if fig <> '*' then
         textOut(info_x + textWidth('������� ������: ') + 6, info_y + 7 + i * textHeight('A'), fig + '(' + ch + ',' + num + ')');         
      
      (* �������� �� ������������ �������� ������ *)
      while not (fig in figs_set) do begin         
         i := i + 1;
         textOut(info_x + 5, info_y + 7 + i * textHeight('A'), '������ ������� �������. ������� ������ ��� ���: ');
               
         readln(fig, ch, num);
         
         correct_coordinate(fig, ch, num, i);
               
         textOut(info_x + textWidth('������ ������� �������. ������� ������ ��� ���: ') + 6, info_y + 7 + i * textHeight('A'), fig + '(' + ch + ',' + num + ')');
      end;
      
      if fig <> '*' then
         (* ��������, ��� ��� ������ ��� �� ����� �� ���� *)
         while rem_figs[fig] = 0 do begin
            i := i + 1;
            textOut(info_x + 5, info_y + 7 + i * textHeight('A'), '��� ������ ��� ���� �� ����. ��������� ����: ');
                  
            readln(fig, ch, num); 
                  
            correct_coordinate(fig, ch, num, i);
                  
            textOut(info_x + textWidth('��� ������ ��� ���� �� ����. ��������� ����: ') + 6, info_y + 7 + i * textHeight('A'), fig + '(' + ch + ',' + num + ')');
         end
      else if rem_figs['G'] <> 0 then begin
         (* ���� ����������� ����� ���������, �� ������ ��� �� ����� �� ���� *)
         i := i + 1;
         textOut(info_x + 5, info_y + 7 + i * textHeight('A'), '������ ����������� �� ����. ������� ���������� ������: ');
         fig := 'G';
         
         readln(ch, num); 
         
         correct_coordinate(fig, ch, num, i);
         
         textOut(info_x + textWidth('������ ����������� �� ����. ������� ���������� ������: ') + 6, info_y + 7 + i * textHeight('A'), fig + '(' + ch + ',' + num + ')');     
      end;
      
      if (fig <> '*') or (rem_figs['G'] <> 0) then begin
         rem_figs[fig] := rem_figs[fig] - 1;
         
         correct_coordinate(fig, ch, num, i);
         
         (* �������� �� ��������� ������� ������ ������� *)
         while field[ch, num].name <> ' ' do begin
            i := i + 1;
            textOut(info_x + 5, info_y + 7 + i * textHeight('A'), '� ���� ����� ��� ����� ������. ������� ��������� ��� ���: ');
               
            readln(ch, num); 
               
            textOut(info_x + textWidth('� ���� ����� ��� ����� ������. ������� ��������� ��� ���: ') + 6, info_y + 7 + i* textHeight('A'), '(' + ch + ',' + num + ')');          
         end; 
         
         if (fig = 'G') or (fig = 'A') then
            (* �������� ���������� � ����� ����� � ������ *)  
            while not ((ch >= 'd') and (ch <= 'f') and (num <= '2') and (num >= '0')) do begin
               i := i + 1;
               
               case fig of
                  'G': begin
                     textOut(info_x + 5, info_y + 7 + i * textHeight('A'), '������ ��� �����. ������� ��������� ������ ��� ���: ');
                     readln(ch, num);       
                     textOut(info_x + textWidth('������ ��� �����. ������� ��������� ������ ��� ���: ') + 6, info_y + 7 + i* textHeight('A'), '(' + ch + ',' + num + ')')
                  end;
                  
                  'A': begin
                     textOut(info_x + 5, info_y + 7 + i * textHeight('A'), '����� ��� �����. ������� ��������� ����� ��� ���: ');
                     readln(ch, num);       
                     textOut(info_x + textWidth('����� ��� �����. ������� ��������� ����� ��� ���: ') + 6, info_y + 7 + i* textHeight('A'), '(' + ch + ',' + num + ')')
                  end;
               end;         
                        
               is_empty_pos(fig, ch, num, i);
            end;
         
         (* �������� �� ��,��� ���� *)
         if fig = 'E' then begin
            (* �������� �� ��, ��� ���� �� ����� ���������� *)
            while (num > '4') do begin
               i := i + 1;
               textOut(info_x + 5, info_y + 7 + i * textHeight('A'), '���� �� �� ����� ����������. ������� ���������� ����� ��� ���: ');
               
               readln(ch, num); 
               
               textOut(info_x + textWidth('���� �� �� ����� ����������. ������� ���������� ����� ��� ���: ') + 6, info_y + 7 + i * textHeight('A'), fig + '(' + ch + ',' + num + ')');          
            end; 
            
            if not ((((ch = 'c') or (ch = 'g')) and ((num = '4') or (num = '0'))) or ((num = '2') and ( (ch = 'a') or (ch = 'e') or (ch = 'i')))) then begin
               i := i + 1;
               textOut(info_x + 5, info_y + 7 + i * textHeight('A'), '���� �� ����� ����� ����������. ������� ���������� ����� ��� ���: ');
               
               readln(ch, num); 
               
               correct_coordinate(fig, ch, num, i);
               
               textOut(info_x + textWidth('���� �� ����� ����� ����������. ������� ���������� ����� ��� ���: ') + 6, info_y + 7 + i * textHeight('A'), fig + '(' + ch + ',' + num + ')');          
               
               is_empty_pos(fig, ch, num, i); 
            end;
               
         end;
      
         field[ch, num].col := clRed;
         field[ch, num].name := fig;
                
         print_figures(field);
         
         i := i + 1;
      end;
      
   until ((fig = '*') and (rem_figs['G'] = 0)) or 
         (rem_figs['A'] + rem_figs['C'] + rem_figs['E'] + rem_figs['G'] + rem_figs['H'] + rem_figs['R'] + rem_figs['S'] = 0);
   
   if fig = '*' then
      textOut(info_x + textWidth('������� ������: ') + 6, info_y + 7 + i * textHeight('A'), '��������� �����');  
   
(* ���� ����� *)
   
   clean_info;
   
   setFontSize(8);
   textOut(info_x + 5, info_y + 5, '����������� ����� ����� (*** - ��������� �����)');
   
   (* ��������� �������� ���������� ���������� ����� *)
   rem_figs['R'] := 2;
   rem_figs['H'] := 2;
   rem_figs['E'] := 2;
   rem_figs['A'] := 2;
   rem_figs['G'] := 1;
   rem_figs['C'] := 2;
   rem_figs['S'] := 5;
   
   i := 1;

   (* ���� �� ������� ������� ����� ����� ��� ���� �� ����������� ��� ������ *)
   repeat
      setFontColor(text_color);
      setFontSize(8);
      setFontStyle(fsNormal);
      
      textOut(info_x + 5, info_y + 7 + i * textHeight('A'), '������� ������: ');
      readln(fig, ch, num);
      
      if fig <> '*' then
         textOut(info_x + textWidth('������� ������: ') + 6, info_y + 7 + i * textHeight('A'), fig + '(' + ch + ',' + num + ')');         
      
      (* �������� �� ������������ �������� ������ *)
      while not (fig in figs_set) do begin         
         i := i + 1;
         textOut(info_x + 5, info_y + 7 + i * textHeight('A'), '������ ������� �������. ������� ������ ��� ���: ');
               
         readln(fig, ch, num);
         
         correct_coordinate(fig, ch, num, i);
               
         textOut(info_x + textWidth('������ ������� �������. ������� ������ ��� ���: ') + 6, info_y + 7 + i * textHeight('A'), fig + '(' + ch + ',' + num + ')');
      end;
      
      if fig <> '*' then
         (* ��������, ��� ��� ������ ��� �� ����� �� ���� *)
         while rem_figs[fig] = 0 do begin
            i := i + 1;
            textOut(info_x + 5, info_y + 7 + i * textHeight('A'), '��� ������ ��� ���� �� ����. ��������� ����: ');
                  
            readln(fig, ch, num); 
                  
            correct_coordinate(fig, ch, num, i);
                  
            textOut(info_x + textWidth('��� ������ ��� ���� �� ����. ��������� ����: ') + 6, info_y + 7 + i * textHeight('A'), fig + '(' + ch + ',' + num + ')');
         end
      else if rem_figs['G'] <> 0 then begin
         (* ���� ����������� ����� ���������, �� ������ ��� �� ����� �� ���� *)
         i := i + 1;
         textOut(info_x + 5, info_y + 7 + i * textHeight('A'), '������ ����������� �� ����. ������� ���������� ������: ');
         fig := 'G';
         
         readln(ch, num); 
         
         correct_coordinate(fig, ch, num, i);
         
         textOut(info_x + textWidth('������ ����������� �� ����. ������� ���������� ������: ') + 6, info_y + 7 + i * textHeight('A'), fig + '(' + ch + ',' + num + ')');     
      end;
      
      if (fig <> '*') or (rem_figs['G'] <> 0) then begin
         rem_figs[fig] := rem_figs[fig] - 1;
         
         correct_coordinate(fig, ch, num, i);
         
         (* �������� �� ��������� ������� ������ ������� *)
         while field[ch, num].name <> ' ' do begin
            i := i + 1;
            textOut(info_x + 5, info_y + 7 + i * textHeight('A'), '� ���� ����� ��� ����� ������. ������� ��������� ��� ���: ');
               
            readln(ch, num); 
               
            textOut(info_x + textWidth('� ���� ����� ��� ����� ������. ������� ��������� ��� ���: ') + 6, info_y + 7 + i* textHeight('A'), '(' + ch + ',' + num + ')');          
         end; 
         
         if (fig = 'G') or (fig = 'A') then
            (* �������� ���������� � ����� ����� � ������ *)  
            while not ((ch >= 'd') and (ch <= 'f') and (num <= '9') and (num >= '7')) do begin
               i := i + 1;
               
               case fig of
                  'G': begin
                     textOut(info_x + 5, info_y + 7 + i * textHeight('A'), '������ ��� �����. ������� ��������� ������ ��� ���: ');
                     readln(ch, num);       
                     textOut(info_x + textWidth('������ ��� �����. ������� ��������� ������ ��� ���: ') + 6, info_y + 7 + i* textHeight('A'), '(' + ch + ',' + num + ')')
                  end;
                  
                  'A': begin
                     textOut(info_x + 5, info_y + 7 + i * textHeight('A'), '����� ��� �����. ������� ��������� ����� ��� ���: ');
                     readln(ch, num);       
                     textOut(info_x + textWidth('����� ��� �����. ������� ��������� ����� ��� ���: ') + 6, info_y + 7 + i* textHeight('A'), '(' + ch + ',' + num + ')')
                  end;
               end;         
                        
               is_empty_pos(fig, ch, num, i);
            end;
         
         (* �������� �� ��,��� ���� *)
         if fig = 'E' then begin
            (* �������� �� ��, ��� ���� �� ����� ���������� *)
            while (num > '4') do begin
               i := i + 1;
               textOut(info_x + 5, info_y + 7 + i * textHeight('A'), '���� �� �� ����� ����������. ������� ���������� ����� ��� ���: ');
               
               readln(ch, num); 
               
               textOut(info_x + textWidth('���� �� �� ����� ����������. ������� ���������� ����� ��� ���: ') + 6, info_y + 7 + i * textHeight('A'), fig + '(' + ch + ',' + num + ')');          
            end; 
            
            if not ((((ch = 'c') or (ch = 'g')) and ((num = '5') or (num = '9'))) or ((num = '7') and ( (ch = 'a') or (ch = 'e') or (ch = 'i')))) then begin
               i := i + 1;
               textOut(info_x + 5, info_y + 7 + i * textHeight('A'), '���� �� ����� ����� ����������. ������� ���������� ����� ��� ���: ');
               
               readln(ch, num); 
               
               correct_coordinate(fig, ch, num, i);
               
               textOut(info_x + textWidth('���� �� ����� ����� ����������. ������� ���������� ����� ��� ���: ') + 6, info_y + 7 + i * textHeight('A'), fig + '(' + ch + ',' + num + ')');          
               
               is_empty_pos(fig, ch, num, i); 
            end;
               
         end;
      
         field[ch, num].col := clBlue;
         field[ch, num].name := fig;
                
         print_figures(field);
         
         i := i + 1;
      end;
      
   until ((fig = '*') and (rem_figs['G'] = 0)) or 
         (rem_figs['A'] + rem_figs['C'] + rem_figs['E'] + rem_figs['G'] + rem_figs['H'] + rem_figs['R'] + rem_figs['S'] = 0);
   
   if fig = '*' then
      textOut(info_x + textWidth('������� ������: ') + 6, info_y + 7 + i * textHeight('A'), '��������� �����');  
   
   clean_info;
end;

(* ������� �������� ����������� ���� ��� ����� *)
function R_move_possibility(field:fieldT; ch_from, num_from, ch_to, num_to:char):boolean;
var
   free_way, step:boolean;
   c:char;
begin   
   (* ���� ����������� �� �� ����������� ��� ���������, �� �� ������ ��������� ������ *)
   if not ( (ch_from = ch_to) or (num_from = num_to)) then
      R_move_possibility := false
   else begin
      free_way := true;
   
      if ch_from = ch_to then begin      
         step := num_from < num_to;
         
         if step then
            c := succ(num_from)
         else
            c := pred(num_from);
         
         while (c <> num_to) and free_way do begin
            (* ���� �� ���� ��������� �� ������ ������ � � ���� ����� ����� ������ ������ ��� ����� �� ���������, �� ��� �� ��������� �������*)
            if (field[ch_to, c].name <> ' ') and ((field[ch_from, num_from].col = field[ch_to, c].col) or 
               ((field[ch_from, num_from].col <> field[ch_to, c].col) and (c <> num_to))) then
               free_way := false;               
            
            if step then
               c := succ(c)
            else
               c:= pred(c);
         end;
         
         R_move_possibility := free_way;
      end;
      
      if num_from = num_to then begin
         step := ch_from < ch_to;
         
         if step then
            c := succ(ch_from)
         else
            c := pred(ch_from);
         
         while (c <> ch_to) and free_way do begin
            (* ���� �� ���� ��������� �� ������ ������ � � ���� ����� ����� ������ ������ *)
            if (field[c, num_to].name <> ' ') and ((field[ch_from, num_from].col = field[c, num_to].col) or 
               ((field[ch_from, num_from].col <> field[c, num_to].col) and (c <> ch_to))) then
               free_way := false;
            
            if step then
               c := succ(c)
            else
               c:= pred(c);
         end;

         R_move_possibility := free_way;
      end; 
   end;      
end;

(* ������� �������� ����������� ���� ��� ����� *)
function E_move_possibility(field:fieldT; ch_from, num_from, ch_to, num_to:char):boolean;
begin
   (* ���� ���� ������� �� ���� ����������, �� ��� ������������, ����� ������� ���������� ���� ������ ���� ����� 8 (2*2+2*2) *)
   if ((field[ch_from, num_from].col = clRed) and (num_to > '4')) or
      ((field[ch_from, num_from].col = clBlue) and (num_to < '5')) then
      E_move_possibility := false
   else
      E_move_possibility := sqr(ord(ch_to) - ord(ch_from)) + sqr(ord(num_to) - ord(num_from)) = 8;
end;

(* ������� �������� ����������� ���� ��� ����� *)
function A_move_possibility(field:fieldT; ch_from, num_from, ch_to, num_to:char):boolean;
begin
   (* ���� ����� ��� �����, �� ��� ������������, ����� ������� ���������� ���� ������ ���� ����� 2 (1*1+1*1) *)
   if (ch_to > 'f') or (ch_to < 'd') then
      A_move_possibility := false
   else if ((field[ch_from, num_from].col = clRed) and (num_to > '2')) or
           ((field[ch_from, num_from].col = clBlue) and (num_to < '7')) then
      A_move_possibility := false
   else
      A_move_possibility := sqr(ord(ch_to) - ord(ch_from)) + sqr(ord(num_to) - ord(num_from)) = 2;
end;

(* ������� �������� ����������� ���� ��� ������ *)
function G_move_possibility(field:fieldT; ch_from, num_from, ch_to, num_to:char):boolean;
begin
   (* ���� ������ ��� �����, �� ��� ������������, ����� ������� ���������� ���� ������ ���� ����� 1 (1*1+0*0) *)
   if (ch_to > 'f') or (ch_to < 'd') then
      G_move_possibility := false
   else if ((field[ch_from, num_from].col = clRed) and (num_to > '2')) or
           ((field[ch_from, num_from].col = clBlue) and (num_to < '7')) then
      G_move_possibility := false
   else
      G_move_possibility := sqr(ord(ch_to) - ord(ch_from)) + sqr(ord(num_to) - ord(num_from)) = 1;
end;

(* ������� �������� ����������� ���� ��� ����� *)
function S_move_possibility(field:fieldT; ch_from, num_from, ch_to, num_to:char):boolean;
begin
   (* �������� ���� ����� *)
   if field[ch_from, num_from].col = clRed then
      if ord(num_to) - ord(num_from) < 0 then
         S_move_possibility := false
      (* ���� ����� �� ���� ����������,�� ������ �����, ����� + ������/����� *)
      else if (ch_from <> ch_to) and (num_to <= '5') or (abs(ord(num_to)-ord(num_from)) > 1) or
         (num_to >= '5') and (sqr(ord(ch_to) - ord(ch_from)) + sqr(ord(num_to) - ord(num_from)) <> 1) then
         S_move_possibility := false
      else
         S_move_possibility := true
   else
      if ord(num_to) - ord(num_from) > 0 then
         S_move_possibility := false
      (* ���� ����� �� ���� ����������,�� ������ �����, ����� + ������/����� *)
      else if (ch_from <> ch_to) and (num_to >= '6') or (abs(ord(num_to)-ord(num_from)) > 1) or
         (num_to <= '5') and (sqr(ord(ch_to) - ord(ch_from)) + sqr(ord(num_to) - ord(num_from)) <> 1) then
         S_move_possibility := false
      else
         S_move_possibility := true
end;

(* ������� �������� ����������� ���� ��� ���� *)
function H_move_possibility(field:fieldT; ch_from, num_from, ch_to, num_to:char):boolean;
begin
   if (ord(num_to) - ord(num_from) = 2) and (field[ch_from, succ(num_from)].name <> ' ') then
      H_move_possibility := false
   else if (ord(num_to) - ord(num_from) = -2) and (field[ch_from, pred(num_from)].name <> ' ') then
      H_move_possibility := false
   else if (ord(ch_to) - ord(ch_from) = 2) and (field[succ(ch_from), num_from].name <> ' ') then
      H_move_possibility := false
   else if (ord(ch_to) - ord(ch_from) = -2) and (field[pred(ch_from), num_from].name <> ' ') then
      H_move_possibility := false
   else
      H_move_possibility := sqr(ord(ch_from) - ord(ch_to)) + sqr(ord(num_from) - ord(num_to)) = 5;
end;

(* ������� �������� ����������� ���� ��� ����� *)
function C_move_possibility(var field:fieldT; ch_from, num_from, ch_to, num_to:char):boolean;
var
   free_way, step:boolean;
   c:char;
begin  
   if (field[ch_to, num_to].col <> field[ch_from, num_from].col) and (field[ch_to, num_to].name <> ' ') then
      C_move_possibility := false
   else if not ( (ch_from = ch_to) or (num_from = num_to)) then
      C_move_possibility := false
   else begin
      free_way := true;
   
      if ch_from = ch_to then begin      
         step := num_from < num_to;
         
         if step then
            c := succ(num_from)
         else
            c := pred(num_from);
         
         while (c <> num_to) and free_way do begin
            if (field[ch_to, c].name <> ' ') then 
               free_way := false;
            
            if step then
               c := succ(c)
            else
               c:= pred(c);
         end;
         
         if (succ(succ(num_from)) = num_to) and (field[ch_from, succ(num_from)].name <> ' ') and 
            (field[ch_from, succ(num_from)].col <> field[ch_from, num_from].col) then begin
               field[ch_from, succ(num_from)].name := ' ';
               free_way := true;
         end               
         else if (pred(pred(num_from)) = num_to) and (field[ch_from, pred(num_from)].name <> ' ') and 
            (field[ch_from, pred(num_from)].col <> field[ch_from, num_from].col) then begin
               field[ch_from, pred(num_from)].name := ' ';
               free_way := true;
         end;
         
         C_move_possibility := free_way;
      end;
      
      if num_from = num_to then begin
         step := ch_from < ch_to;
         
         if step then
            c := succ(ch_from)
         else
            c := pred(ch_from);
         
         while (c <> ch_to) and free_way do begin
            if (field[c, num_to].name <> ' ') then
               free_way := false;
            
            if step then
               c := succ(c)
            else
               c:= pred(c);
         end;

         if (succ(succ(ch_from)) = ch_to) and (field[succ(ch_from), num_from].name <> ' ') and 
            (field[succ(ch_from), num_from].col <> field[ch_from, num_from].col) then begin
               field[succ(ch_from), num_from].name := ' ';
               free_way := true;
         end               
         else if (pred(pred(ch_from)) = ch_to) and (field[pred(ch_from), num_from].name <> ' ') and 
            (field[pred(ch_from), num_from].col <> field[ch_from, num_from].col) then begin
               field[pred(ch_from), num_from].name := ' ';
               free_way := true;
         end;

         C_move_possibility := free_way;
      end; 
   end;
end;

(* ��������� ��������� ��������� ������ ������� ����� *)
procedure get_G_coordinates(field:fieldT; var ch, num:char; col:Color);
var
   tmp_ch, tmp_num:char;  
   searched:boolean;
begin
   tmp_ch := 'd';
   searched := false;
   
   while (tmp_ch <> 'f') and not searched do begin
      if col = clRed then begin
         tmp_num := '0';
         
         while (tmp_num <> '2') and not searched do begin
            if field[tmp_ch, tmp_num].name = 'G' then begin
               searched := true;
               ch := tmp_ch;
               num := tmp_num;
            end;
            
            tmp_num := succ(tmp_num);
         end;
      end
      else begin
         tmp_num := '7';
         
         while (tmp_num <> '9') and not searched do begin
            if field[tmp_ch, tmp_num].name = 'G' then begin
               searched := true;
               ch := tmp_ch;
               num := tmp_num;
            end;
            
            tmp_num := succ(tmp_num);
         end;
      end;
      
      tmp_ch := succ(tmp_ch);
   end;
end;

procedure read_base_move(var field:fieldT);
var
   fig, ch_from, num_from, ch_to, num_to, c:char;
   G_ch, G_num:char; (* ���������� ������ *)
   i:integer;
   is_possible:boolean;
   col, col1, col2:Color;
begin
   clean_info;
   i := 0;
   
   col1 := clRed;
   col2 := clBlue;
   col := col1;
   
   repeat
      readln(fig, ch_from, num_from, c, ch_to, num_to);
      
      if 7 + i * textHeight('A') >= info_h then begin
         clean_info;
         i := 0;
      end;
      
      if field[ch_from, num_from].col = col then begin      
         setFontColor(rgb(0, 255, 0));
         setFontSize(8);
         
         if field[ch_from, num_from].name = ' ' then begin
            textOut(info_x + 5, info_y + 7 + i * textHeight('A'), '��� ' + fig+ch_from+num_from+'-'+ch_to+num_to+' ����������, ��� ������ � ��������� ������.');
            i := i + 1;
         end
         else if (fig <> field[ch_from, num_from].name) then begin
            textOut(info_x + 5, info_y + 7 + i * textHeight('A'), '��� ' + fig+ch_from+num_from+'-'+ch_to+num_to+' ����������, � ���� ������ ����� ' + field[ch_from, num_from].name + ', � �� '+ fig);
            i := i + 1
         end
         else if (field[ch_to, num_to].name <> ' ') and (field[ch_to, num_to].col = field[ch_from, num_from].col) then begin
            textOut(info_x + 5, info_y + 7 + i * textHeight('A'), '��� ' + fig+ch_from+num_from+'-'+ch_to+num_to+' ����������, ��� ������ ������.');
            i := i + 1;
         end
         else begin
            (* �������� ����������� ����� ��� ����� *)
            case fig of
               'R': begin
                     is_possible := R_move_possibility(field, ch_from, num_from, ch_to, num_to);
                     
                     if not is_possible then begin
                        textOut(info_x + 5, info_y + 7 + i * textHeight('A'), '��� ' + fig+ch_from+num_from+'-'+ch_to+num_to+' ����������, ������ ������ �� ����.');
                        i := i + 1;                  
                     end;
                  end;
                  
               'E': begin
                     is_possible := E_move_possibility(field, ch_from, num_from, ch_to, num_to);
                     
                     if not is_possible then begin
                        textOut(info_x + 5, info_y + 7 + i * textHeight('A'), '��� ' + fig+ch_from+num_from+'-'+ch_to+num_to+' ����������, ���� ��� �� �����.');
                        i := i + 1; 
                     end;
                  end;
                  
               'A': begin
                     is_possible := A_move_possibility(field, ch_from, num_from, ch_to, num_to);
                     
                     if not is_possible then begin
                        textOut(info_x + 5, info_y + 7 + i * textHeight('A'), '��� ' + fig+ch_from+num_from+'-'+ch_to+num_to+' ����������, ����� ��� �� �����.');
                        i := i + 1; 
                     end;
                  end;
                  
               'G': begin
                     is_possible := G_move_possibility(field, ch_from, num_from, ch_to, num_to);
                     
                     if not is_possible then begin
                        textOut(info_x + 5, info_y + 7 + i * textHeight('A'), '��� ' + fig+ch_from+num_from+'-'+ch_to+num_to+' ����������, ������ ��� �� �����.');
                        i := i + 1; 
                     end;
                  end;
                  
               'S': begin
                     is_possible := S_move_possibility(field, ch_from, num_from, ch_to, num_to);
                     
                     if not is_possible then begin
                        textOut(info_x + 5, info_y + 7 + i * textHeight('A'), '��� ' + fig+ch_from+num_from+'-'+ch_to+num_to+' ����������, ����� ��� �� �����.');
                        i := i + 1; 
                     end;
                  end;           
              
              'C': begin
                     is_possible := C_move_possibility(field, ch_from, num_from, ch_to, num_to);
                     
                     if not is_possible then begin
                        textOut(info_x + 5, info_y + 7 + i * textHeight('A'), '��� ' + fig+ch_from+num_from+'-'+ch_to+num_to+' ����������, ����� ��� �� �����.');
                        i := i + 1; 
                     end;
                  end;
                         
               'H': begin
                     is_possible := H_move_possibility(field, ch_from, num_from, ch_to, num_to);
                     
                     if not is_possible then begin
                        textOut(info_x + 5, info_y + 7 + i * textHeight('A'), '��� ' + fig+ch_from+num_from+'-'+ch_to+num_to+' ����������, ���� ��� �� �����.');
                        i := i + 1; 
                     end;
                  end;
            end;
            
            (* ���� ��� ��������, �� ��������� ��� *)
            if is_possible then begin
               field[ch_to, num_to] := field[ch_from, num_from];
               field[ch_from, num_from].name := ' ';
               print_figures(field);
               
               (*get_G_coordinates(field, G_ch, G_num, col);
               setFontColor(text_color);
               setFontSize(8);
               textOut(info_x + 5, info_y + 7 + i * textHeight('A'), '' + G_ch+G_num);
               i := i + 1;*)
               
               if col = col1 then
                  col := col2
               else
                  col := col1;
            end; 
         end;
      end
      else begin
         setFontColor(text_color);
         setFontSize(8);
         
         if col = col1 then begin
            textOut(info_x + 5, info_y + 7 + i * textHeight('A'), '������ ����� �������.');
            i := i + 1;
         end
         else begin
            textOut(info_x + 5, info_y + 7 + i * textHeight('A'), '������ ����� �����.');
            i := i + 1;
         end;
      end;   
   until fig = '*';
end;

begin
   SetWindowSize(window_w, window_h);
   SetWindowCaption('113 �������� �������');
   ClearWindow(background_color);
   Window.IsFixedSize := true;
   CenterWindow;

   draw_field(field_x, field_y, field_w, field_h);
   
   figures_default(field);
   
   //arrangement_figures(field);
   
   print_figures(field);
   
   read_base_move(field);

   print_figures(field);
end.