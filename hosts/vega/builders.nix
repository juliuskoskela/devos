# hosts/vega/builders.nix
{
  sops.secrets."builders/awsarm/ssh_key" = {
    owner = "root";
    path = "/root/.ssh/awsarm";
  };

  sops.secrets."builders/awsarm/ssh_pubkey" = {
    owner = "root";
    path = "/root/.ssh/awsarm.pub";
  };

  nix = {
    buildMachines = [
      {
        hostName = "awsarm";
        system = "aarch64-linux";
        maxJobs = 32;
        sshUser = "juliuskoskela";
        supportedFeatures = ["kvm" "benchmark" "big-parallel" "nixos-test"];
        mandatoryFeatures = [];
        sshKey = "/root/.ssh/awsarm";
      }
    ];

    distributedBuilds = true;
  };
}
