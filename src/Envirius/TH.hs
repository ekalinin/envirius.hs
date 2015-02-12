module Envirius.TH where

import Language.Haskell.TH

constructorName :: Con -> String
constructorName (NormalC name _fields) = nameBase name
constructorName (_) = "Not used"

listConstructors :: Name -> Q Exp
listConstructors t = do
    -- Get list of constructors for type
    TyConI (DataD _ _typeName _ constructors _) <- reify t
    -- Get list of string representations for constructors
    let names = map constructorName constructors
    --[| ["Mk", "Ls"] |]
    --[ LitE (StringL "Mk"), LitE (StringL "Ls")]
    return $ ListE $ map (\n -> LitE (StringL n)) names
