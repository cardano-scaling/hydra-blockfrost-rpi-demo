{
  hydra.demo = {
    network = "preview";
    blockfrost = true;
    heads = {
      a = {
        participants = with config.hydra.demo.parties; [ alice bob carol ];
      };
      b.participants = with config.hydra.demo.parties; [ alice ida ];
    };
  };
}
