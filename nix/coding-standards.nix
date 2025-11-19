{
  perSystem = { lib, ... }: {
    coding.standards.hydra = {
      enable = true;
      haskellFormatter = "ormolu";
    };
    weeder.enable = lib.mkForce false;
  };

}
