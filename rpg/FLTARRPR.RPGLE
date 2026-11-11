**free
/IF DEFINED(FLTARR_PR)
/EOF
/ENDIF

/DEFINE FLTARR_PR

///
// Filter array
//
// @param pArrayIn_a address of the input array %addr()
// @param pArrayInLen number of elemenbts in the input array %elem()
// @param pArrayElementSize size of each array element %size()
// @param pFilterProc_a proc pointer of the filtering procedure %paddr()
// @param pArrayOut_a address of the output array %addr() optional if counting
// @return number of elements that match the filter criteria
///
dcl-pr filterArray int(10) extproc(*dclcase);
  pArrayIn_a pointer value;
  pArrayInLen int(10) value;
  pArrayElementSize int(10) value;
  pFilterProc_a pointer(*proc) value;
  pArrayOut_a pointer value options(*nopass);
end-pr;

///
// countArray
//
// Counts elements in an array that satisfy specified filter procedure
//
// @param pointer to input array
// @param length of input array
// @param size of input array entry
// @param procedure pointer to filter proc
///
dcl-pr countArray int(10) extproc(*dclcase);
  pArrayIn_a pointer value;
  pArrayInLen int(10) value;
  pArrayElementSize int(10) value;
  pFilterProc_a pointer(*proc) value;
end-pr;


