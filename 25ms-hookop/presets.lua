-- This Script is Part of the Prometheus Obfuscator by Levno_710
--
-- pipeline.lua
--
-- This Script Provides some configuration presets

return {
    ["ol"] = {
        LuaVersion = "LuaU";
        VarNamePrefix = "";
        NameGenerator = "Random";
        PrettyPrint = false;
        Seed = 0;
        Steps = {
            {
                Name = "Vmify";
                Settings = {
                    VM = "random";
                };
            };
            {
                Name = "AddVararg";
                Settings = {

                };
            };
            {
                Name = "EncryptStrings";
                Settings = {

                };
            };
            {
                Name = "SplitStrings";
                Settings = {

                }
            };
            {
                Name = "AntiTamper";
                Settings = {

                }
            };
            {
                Name = "WatermarkCheck",
                Settings = {
                    Content =
                    "CrackGuard by 25ms",
                    CustomVariable = "lmao"
                }
            };
            {
                Name = "ConstantArray",
                Settings = {

                }
            };
            {
                Name = "NumbersToExpressions",
                Settings = {

                }
            };
            {
                Name = "ProxifyLocals",
                Settings = {

                }
            };
        }
    };
    ["Normal"] = {
        LuaVersion = "LuaU";
        VarNamePrefix = "";
        NameGenerator = (math.random()<.8 and"MangledShuffled") or "Ad";
        PrettyPrint = false;
        Seed = 0;
        Steps = {
            {
                Name = "Vmify";
                Settings = {
                    VM = "random";
                };
            };
            {
                Name = "AddVararg";
                Settings = {

                };
            };
            {
                Name = "EncryptStrings";
                Settings = {

                };
            };
            {
                Name = "SplitStrings";
                Settings = {

                }
            };
            {
                Name = "AntiTamper";
                Settings = {

                }
            };
            {
                Name = "ConstantArray",
                Settings = {

                }
            };
            {
                Name = "NumbersToExpressions",
                Settings = {

                }
            };
            {
                Name = "ProxifyLocals",
                Settings = {

                }
            };
            {
                Name = "WrapInFunction";
                Settings = {

                }
            };
        }
    };
    ["Vmify"] = {
        LuaVersion = "LuaU";
        VarNamePrefix = "";
        NameGenerator = "MangledShuffled";
        PrettyPrint = false;
        Seed = 0;
        Steps = {
            {
                Name = "Vmify";
                Settings = {
                    -- VM = "random";
                };
            };
        }
    };
    ["Minify"] = {
        -- The default LuaVersion is Lua51
        LuaVersion = "LuaU";
        -- For minifying no VarNamePrefix is applied
        VarNamePrefix = "";
        NameGenerator = "MangledShuffled";
        -- No pretty printing
        PrettyPrint = false;
        -- Seed is generated based on current time
        Seed = 0;
        -- No obfuscation steps
        Steps = {

        }
    };
    ["me"] = {
        -- The default LuaVersion is Lua51
        LuaVersion = "LuaU";
        -- For minifying no VarNamePrefix is applied
        VarNamePrefix = "";
        NameGenerator = "MangledShuffled";
        -- No pretty printing
        PrettyPrint = false;
        -- Seed is generated based on current time
        Seed = 0;
        -- No obfuscation steps
        Steps = {
            {
                Name = "EncryptStrings";
                Settings = {
                };
            };
        }
    };
    ["Weak"] = {
        LuaVersion = "LuaU";
        VarNamePrefix = "";
        NameGenerator = "MangledShuffled";
        PrettyPrint = false;
        Seed = 0;
        Steps = {
            {
                Name = "Vmify";
                Settings = {
                    
                };
            };
            {
                Name = "ConstantArray";
                Settings = {
                    Treshold    = 1;
                    StringsOnly = true;
                }
            };
            {
                Name = "EncryptStrings";
                Settings = {

                };
            };
            {
                Name = "WrapInFunction";
                Settings = {

                }
            };
        }
    };
    ["doubled"] = {
        LuaVersion = "Lua51";
        VarNamePrefix = "";
        NameGenerator = "MangledShuffled";
        PrettyPrint = false;
        Seed = 0;
        Steps = {
            -- {
            --     Name = "NumbersToExpressions";
            --     Settings = {

            --     }
            -- };
            {
                Name = "AddVararg";
                Settings = {

                }
            };
        }
    };
    ["Medium"] = {
        -- The default LuaVersion is Lua51
        LuaVersion = "luaU";
        -- For minifying no VarNamePrefix is applied
        VarNamePrefix = "";
        -- Name Generator for Variables
        NameGenerator = "MangledShuffled";
        -- No pretty printing
        PrettyPrint = false;
        -- Seed is generated based on current time
        Seed = 0;
        -- Obfuscation steps
        Steps = {
            {
                Name = "EncryptStrings";
                Settings = {

                };
            };
            {
                Name = "AntiTamper";
                Settings = {
                    UseDebug = false;
                };
            };
            {
                Name = "Vmify";
                Settings = {
                    
                };
            };
            {
                Name = "ConstantArray";
                Settings = {
                    Treshold    = 1;
                    StringsOnly = true;
                    Shuffle     = true;
                    Rotate      = true;
                    LocalWrapperTreshold = 0;
                }
            };
            {
                Name = "NumbersToExpressions";
                Settings = {

                }
            };
            {
                Name = "WrapInFunction";
                Settings = {

                }
            };
        }
    };
    ["Strong"] = {
        -- The default LuaVersion is Lua51
        LuaVersion = "Lua51";
        -- For minifying no VarNamePrefix is applied
        VarNamePrefix = "";
        -- Name Generator for Variables that look like this: IlI1lI1l
        NameGenerator = "MangledShuffled";
        -- No pretty printing
        PrettyPrint = false;
        -- Seed is generated based on current time
        Seed = 0;
        -- Obfuscation steps
        Steps = {
            {
                Name = "Vmify";
                Settings = {
                    
                };
            };
            {
                Name = "EncryptStrings";
                Settings = {

                };
            };
            {
                Name = "AntiTamper";
                Settings = {

                };
            };
            {
                Name = "Vmify";
                Settings = {
                    
                };
            };
            {
                Name = "ConstantArray";
                Settings = {
                    Treshold    = 1;
                    StringsOnly = true;
                    Shuffle     = true;
                    Rotate      = true;
                    LocalWrapperTreshold = 0;
                }
            };
            {
                Name = "NumbersToExpressions";
                Settings = {

                }
            };
            {
                Name = "WrapInFunction";
                Settings = {

                }
            };
        }
    };
}