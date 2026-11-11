**free

ctl-opt dftactgrp(*no) bnddir('FLTARR');

/copy FLTARRPR

dcl-ds struct1_t qualified template;
  field1 char(10);
  field2 int(5);
end-ds;

dcl-ds inputStruct likeds(struct1_t) dim(100);
dcl-ds outputStruct likeds(struct1_t) dim(100);
dcl-s outputStructCount int(10);
dcl-s inputStructLen int(10) inz(*zero);
dcl-s cnt int(10);

inititalize();

outputStructCount = filterArray(%addr(inputStruct)
                             :inputStructLen
                             :%size(inputStruct)
                             :%addr(outputStruct)
                             :%paddr(arrayPopulateFilter)
                             );

for cnt = 1 to outputStructCount;
  dsply ('outputStruct(' + %trim(%char(cnt)) + ') = ' + outputStruct(cnt).field1);
endfor;

outputStructCount = countArray(%addr(inputStruct)
                             :inputStructLen
                             :%size(inputStruct)
                             :%paddr(arrayCountFilter)
                             );

dsply ('array count: length = ' + %char(outputStructCount));

*inlr = *on;

dcl-proc arrayPopulateFilter;
  dcl-pi *n ind;
    pStructAddr pointer value;
  end-pi;

  dcl-ds struct likeds(struct1_t) based(pStructAddr);

  return (struct.field1 > 'E');
end-proc;

dcl-proc arrayCountFilter;
  dcl-pi *n ind;
    pStructAddr pointer value;
  end-pi;

  dcl-ds struct likeds(struct1_t) based(pStructAddr);

  return (struct.field2 < 90);
end-proc;

dcl-proc inititalize;

  inputStructLen += 1;
  inputStruct(inputStructLen).field1 = 'A';
  inputStruct(inputStructLen).field2 = 10;
  inputStructLen += 1;
  inputStruct(inputStructLen).field1 = 'B';
  inputStruct(inputStructLen).field2 = 20;
  inputStructLen += 1;
  inputStruct(inputStructLen).field1 = 'C';
  inputStruct(inputStructLen).field2 = 30;
  inputStructLen += 1;
  inputStruct(inputStructLen).field1 = 'D';
  inputStruct(inputStructLen).field2 = 40;
  inputStructLen += 1;
  inputStruct(inputStructLen).field1 = 'E';
  inputStruct(inputStructLen).field2 = 50;
  inputStructLen += 1;
  inputStruct(inputStructLen).field1 = 'F';
  inputStruct(inputStructLen).field2 = 60;
  inputStructLen += 1;
  inputStruct(inputStructLen).field1 = 'G';
  inputStruct(inputStructLen).field2 = 70;
  inputStructLen += 1;
  inputStruct(inputStructLen).field1 = 'H';
  inputStruct(inputStructLen).field2 = 80;
  inputStructLen += 1;
  inputStruct(inputStructLen).field1 = 'I';
  inputStruct(inputStructLen).field2 = 90;
  inputStructLen += 1;
  inputStruct(inputStructLen).field1 = 'J';
  inputStruct(inputStructLen).field2 = 100;
  inputStructLen += 1;
  inputStruct(inputStructLen).field1 = 'K';
  inputStruct(inputStructLen).field2 = 110;

end-proc;
