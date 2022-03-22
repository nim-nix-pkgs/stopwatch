{
  description = ''A simple timing library for benchmarking code and other things.'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs.src-stopwatch-master.flake = false;
  inputs.src-stopwatch-master.owner = "define-private-public";
  inputs.src-stopwatch-master.ref   = "master";
  inputs.src-stopwatch-master.repo  = "stopwatch";
  inputs.src-stopwatch-master.type  = "gitlab";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@deps:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib" "src-stopwatch-master"];
  in lib.mkRefOutput {
    inherit self nixpkgs ;
    src  = deps."src-stopwatch-master";
    deps = builtins.removeAttrs deps args;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
  };
}