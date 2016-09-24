;;1.installing the system version of map as a primitive fails for the following reason: when the evaluator applies a primitive procedure to arguments, it does so by applying the primitive procedure to the arguments; this is done in the underlying Scheme.  However, when we call (map fn lst), the procedure 'fn' passed as an argument to map is (hopefully) a "procedure" (i.e., some data with type 'procedure') in the implemented language, but in the underlying Scheme it's a list.  If the procedure is compound, the list is ('procedure parameters body env); if it's installed as a primitive in the implemented language, the list contains the symbol 'primitive and a pointer to the underlying Scheme's representation of the function (which might be a pointer to a memory location for primitive and compiled functions, or possibly some other representation for those installed by the user).  Now, lists beginning with 'primitive or 'procedure aren't legitimate ways of representing procedures in the underlying Scheme, so when map attempts to apply this object (still in the underlying Scheme, of course), an error is thrown.
;;2. of course, if we define map as a compound procedure within the implemented language, the application of map to a function and one or more lists proceeds according to the rules of the evaluator for applying a compound procedure to arguments.
