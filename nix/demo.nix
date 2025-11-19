{ inputs, ... }:
{

  perSystem = { pkgs, ... }:
    {
      process-compose."alice" = {
        package = pkgs.process-compose;
        settings = {
          log_location = "devnet/logs/process-compose.log";
          log_level = "debug";

          processes = {
            hydra-node = {
              log_location = "./devnet/alice-logs.txt";
              command = pkgs.writeShellApplication {
                name = "hydra-node-alice";
                checkPhase = "";
                text = ''
                  set -a; [ -f .env ] && source .env; set +a
                  ${pkgs.hydra-node}/bin/hydra-node \
                    --node-id 1 \
                    --listen 127.0.0.1:5001 \
                    --api-port 4001 \
                    --monitoring-port 6001 \
                    --hydra-signing-key "${inputs.hydra}/demo/alice.sk" \
                    --hydra-scripts-tx-id ''$HYDRA_SCRIPTS_TX_ID \
                    --cardano-signing-key "${self}/demo/credentials/alice.sk" \
                    --peer 127.0.0.1:5002 \
                    --hydra-verification-key "${inputs.hydra}/demo/alice.vk" \
                    --cardano-verification-key "${self}/demo/credentials/alice.vk" \
                    --ledger-protocol-parameters "${self}/demo/protocol-parameters.json" \
                    --blockfrost blockfrost-project.txt \
                    --persistence-dir devnet/persistence/alice \
                    --contestation-period 3s
                '';
              };
              working_dir = ".";
              ready_log_line = "NodeIsLeader";
            };
          };
        };
      };
    };
}
