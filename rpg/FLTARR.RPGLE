**free

ctl-opt nomain;

/copy FLTARRPR

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
dcl-proc countArray export;
  dcl-pi *n int(10);
    pArrayIn_a pointer value;
    pArrayInLen int(10) value;
    pArrayElementSize int(10) value;
    pFilterProc_a pointer(*proc) value;
  end-pi;

  return filterArray(pArrayIn_a:pArrayInLen:pArrayElementSize:pFilterProc_a);
end-proc;

///
// filterArray
//
// Filters elements in an array that satisfy specified filter procedure
// into a new array
//
// @param pointer to input array
// @param length of input array
// @param size of input array entry
// @param procedure pointer to filter proc
// @param pointer to output array
///
dcl-proc filterArray export;
  dcl-pi *n int(10);
    pArrayIn_a pointer value;
    pArrayInLen int(10) value;
    pArrayElementSize int(10) value;
    pFilterProc_a pointer(*proc) value;
    pArrayOut_a pointer value options(*nopass);
  end-pi;

  dcl-s idx int(10);
  dcl-s elementMatches int(10) inz(*zero);

  dcl-s arraySpace_t char(16773104) template;
  dcl-s arrayOutSpace like(arraySpace_t) based(arrayOut_a);
  dcl-s arrayInSpace like(arraySpace_t) based(arrayIn_a);
  dcl-s outputProvided ind inz(*off);

  dcl-pr filterProc ind extproc(pFilterProc_a);
    pElement_a pointer value;
  end-pr;

  // assign the input array start
  arrayIn_a = pArrayIn_a;

  outputProvided = %passed(pArrayOut_a);

  // if not counting, assign the output array start
  if outputProvided;
    arrayOut_a = pArrayOut_a;
  endif;

  // iterate through all array elements
  for idx = 1 to pArrayInLen;
    // call the procedure to qualify the array element
    if filterProc(arrayIn_a);
      // we have a match, increment the counter
      elementMatches += 1;
      // if we are not counting, copy element to output array and increment
      // output pointer.
      if outputProvided;
        %subst(arrayOutSpace:1:pArrayElementSize) =
          %subst(arrayInSpace:1:pArrayElementSize);
        arrayOut_a += pArrayElementSize;
      endif;
    endif;
    // move to next input array element
    arrayIn_a += pArrayElementSize;
  endfor;

  return elementMatches;
end-proc;

