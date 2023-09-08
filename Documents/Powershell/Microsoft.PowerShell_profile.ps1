
try { $null = gcm pshazz -ea stop; pshazz init } catch { }
function conf { git --git-dir=$HOME\.conf.git --work-tree=$HOME $args }
