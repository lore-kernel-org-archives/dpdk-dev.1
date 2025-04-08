Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88013C369A4
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Apr 2025 14:58:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5B33D40E3A;
	Tue,  8 Apr 2025 16:58:56 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id 2033F40264
 for <dev@dpdk.org>; Tue,  8 Apr 2025 16:58:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1744124334; x=1775660334;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ak7O6zOHqpG0moeiOsru/8rzBEaopIP3YM8CAb7Zwbc=;
 b=f99xxgAnlKGxmE1nlYoGwd/d4vKHSSJHwE4wGiMqFDk0m9p0z4QsNDYb
 2GLowLZhB8V3t3nHSxe4r/1lbYjJIQW3A/cDIh8OqllcpnudOdKNGxH0h
 rlDYjo+fqd8fJ34I+h87xq75QUe8kpnXgBC1ga4o2Aj5RwBH3Fw3foKIr
 m5yFGmr66514LRB+zFovQvPU70bA56anIyQL3a9ToaevW3nM9SUDOG1zJ
 QpzTgGS5Eya6iClQf6BAe2dMR0Od1NGfK2eqEncEYIxw232knc8MiYJc8
 O9vXS8JPpOXKG1jbeXktdKYz7dZ2HxeXRmxleGjxNQoK+YQYJB/kGyjYu Q==;
X-CSE-ConnectionGUID: 0uNFj7dTSL+6R2/qx4vPMg==
X-CSE-MsgGUID: dzr228akThePlQnNXlEuAA==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="45277992"
X-IronPort-AV: E=Sophos;i="6.15,198,1739865600"; d="scan'208";a="45277992"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Apr 2025 07:58:53 -0700
X-CSE-ConnectionGUID: t8qKkybTRdaP/x0962t81A==
X-CSE-MsgGUID: lKSrqfKKTBOb/KGcA6Zi5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,198,1739865600"; d="scan'208";a="133443679"
Received: from unknown (HELO silpixa00401385.ir.intel.com) ([10.237.214.31])
 by fmviesa004.fm.intel.com with ESMTP; 08 Apr 2025 07:58:52 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: getelson@nvidia.com,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [RFC PATCH] add rust binding support to DPDK
Date: Tue,  8 Apr 2025 15:58:38 +0100
Message-ID: <20250408145838.2501034-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250306133713.393057-1-getelson@nvidia.com>
References: <20250306133713.393057-1-getelson@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Unsubscribe: <https://mails.dpdk.org/options/dev>,
 <mailto:dev-request@dpdk.org?subject=unsubscribe>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
Errors-To: dev-bounces@dpdk.org

Add a Cargo.toml file in the root folder and a number of other scripts
and rust-related files into buildtools/rust, which then enables DPDK to
be cloned and built as a rust crate - all-be-it one with only two
functions: rte_eal_init and rte_eal_cleanup.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---

This RFC is proposed as an alternative approach to enabling rust support
in DPDK. The key difference vs previous is that we are taking the whole
DPDK project here as a rust "crate", which can then be used by other
higher-level crates as a dependency. Building the crate does a
(minimal) build of DPDK and statically links it in, so there is no
"install" step or anything needed - the Rust app just adds DPDK to their
Cargo.toml file and then should have everything they need.

---
 Cargo.toml                                | 16 +++++++
 buildtools/meson.build                    |  1 +
 buildtools/rust/build.rs                  | 45 ++++++++++++++++++++
 buildtools/rust/gen-cargo-bindgen-info.py | 52 +++++++++++++++++++++++
 buildtools/rust/lib.rs                    | 25 +++++++++++
 buildtools/rust/wrapper.h                 |  5 +++
 meson.build                               |  3 ++
 7 files changed, 147 insertions(+)
 create mode 100644 Cargo.toml
 create mode 100644 buildtools/rust/build.rs
 create mode 100644 buildtools/rust/gen-cargo-bindgen-info.py
 create mode 100644 buildtools/rust/lib.rs
 create mode 100644 buildtools/rust/wrapper.h

diff --git a/Cargo.toml b/Cargo.toml
new file mode 100644
index 0000000000..fe0843975a
--- /dev/null
+++ b/Cargo.toml
@@ -0,0 +1,16 @@
+# SPDX-License-Identifier: BSD-3-Clause
+# Copyright(c) 2025 Intel Corporation
+
+[package]
+name = "dpdk-c"
+version = "25.0.7"
+build = "buildtools/rust/build.rs"
+edition = "2021"
+
+[lib]
+path = "buildtools/rust/lib.rs"
+doctest = false
+
+[build-dependencies]
+bindgen = "0.71"
+meson-next = "1"
diff --git a/buildtools/meson.build b/buildtools/meson.build
index 4e2c1217a2..a13b5189c1 100644
--- a/buildtools/meson.build
+++ b/buildtools/meson.build
@@ -26,6 +26,7 @@ header_gen_cmd = py3 + files('gen-header.py')
 has_hugepages_cmd = py3 + files('has-hugepages.py')
 cmdline_gen_cmd = py3 + files('dpdk-cmdline-gen.py')
 check_dts_requirements = py3 + files('check-dts-requirements.py')
+gen_cargo_bindgen_info = py3 + files('rust/gen-cargo-bindgen-info.py')

 # install any build tools that end-users might want also
 install_data([
diff --git a/buildtools/rust/build.rs b/buildtools/rust/build.rs
new file mode 100644
index 0000000000..1ffdf03d2f
--- /dev/null
+++ b/buildtools/rust/build.rs
@@ -0,0 +1,45 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2025 Intel Corporation
+ */
+
+extern crate meson_next as meson;
+use std::collections::HashMap;
+use std::env;
+use std::path::PathBuf;
+
+fn main() {
+    let out_path = PathBuf::from(env::var("OUT_DIR").unwrap());
+    let build_dir = out_path.join("build");
+
+    let meson_cfg = meson::Config::new().options(HashMap::from([
+        ("enable_libs", "eal"),
+        ("enable_drivers", "net/*,net/intel/*"),
+        ("enable_apps", "test")
+    ]));
+    meson::build(".", build_dir.to_str().unwrap(), meson_cfg);
+
+    /* open and print file 'cargo_rules.txt' from build_dir */
+    let cargo_ldflags_file = build_dir.join("cargo_ldflags.txt");
+    println!("cargo:rerun-if-changed={}", cargo_ldflags_file.display());
+    print!("{}", std::fs::read_to_string(cargo_ldflags_file).unwrap());
+
+    let bindgen_include_file = build_dir.join("bindgen_cflags.txt");
+    let mut bindings = bindgen::Builder::default();
+    for line in std::fs::read_to_string(bindgen_include_file).unwrap().lines() {
+            bindings = bindings.clang_arg(line);
+    }
+
+    let bindings = bindings.header("buildtools/rust/wrapper.h")
+        .derive_default(true)
+        .allowlist_function("rte_eal_init")
+        .allowlist_function("rte_eal_cleanup")
+        // Tell cargo to invalidate the built crate whenever any of the
+        // included header files changed.
+        .parse_callbacks(Box::new(bindgen::CargoCallbacks::new()))
+        .generate()
+        .expect("Unable to generate bindings");
+
+    bindings
+        .write_to_file(out_path.join("bindings.rs"))
+        .expect("Couldn't write bindings!");
+}
diff --git a/buildtools/rust/gen-cargo-bindgen-info.py b/buildtools/rust/gen-cargo-bindgen-info.py
new file mode 100644
index 0000000000..bea432ead3
--- /dev/null
+++ b/buildtools/rust/gen-cargo-bindgen-info.py
@@ -0,0 +1,52 @@
+# SPDX-License-Identifier: BSD-3-Clause
+# Copyright(c) 2025 Intel Corporation
+
+# Script to generate cargo rules for static linking in rust builds
+# outputs one line per library, for drivers and libraries
+
+import os
+import os.path
+import sys
+import subprocess
+
+if 'MESON_BUILD_ROOT' not in os.environ:
+    print('This script must be called from a meson build environment')
+    sys.exit(1)
+
+pkgconf = sys.argv[1]
+os.environ['PKG_CONFIG_PATH'] = os.path.join(os.environ['MESON_BUILD_ROOT'], 'meson-uninstalled')
+linker_flags = subprocess.check_output([pkgconf, '--libs', '--static', 'libdpdk']).decode('utf-8')
+cflags = subprocess.check_output([pkgconf, '--cflags', 'libdpdk']).decode('utf-8')
+
+whole_archive = False
+with open(os.path.join(os.environ['MESON_BUILD_ROOT'], 'cargo_ldflags.txt'), 'w') as dst:
+    for flag in linker_flags.split():
+        if flag == '-pthread':
+            continue
+        elif flag == '-Wl,--whole-archive':
+            whole_archive = True
+        elif flag == '-Wl,--no-whole-archive':
+            whole_archive = False
+        elif flag.startswith('-L'):
+            dst.write(f'cargo:rustc-link-search=native={flag[2:]}\n')
+        elif flag.startswith('-l:'):
+            libname = flag[3:]
+            if libname.startswith('lib'):
+                libname = libname[3:]
+            if libname.endswith('.a'):
+                libname = libname[:-2]
+            if whole_archive:
+                dst.write(f'cargo:rustc-link-lib=static:+whole-archive={libname}\n')
+            else:
+                dst.write(f'cargo:rustc-link-lib=static={libname}\n')
+        elif flag.startswith('-lrte_'):
+            # skip any other DPDK lib flags, we already have them above
+            continue
+        elif flag.startswith('-l'):
+            dst.write(f'cargo:rustc-link-lib={flag[2:]}\n')
+        else:
+            print(f'Warning: Unknown flag: {flag}', file=sys.stderr)
+
+with open(os.path.join(os.environ['MESON_BUILD_ROOT'], 'bindgen_cflags.txt'), 'w') as dst:
+    for flag in cflags.split():
+        dst.write(f'{flag}\n')
diff --git a/buildtools/rust/lib.rs b/buildtools/rust/lib.rs
new file mode 100644
index 0000000000..f99c54ac42
--- /dev/null
+++ b/buildtools/rust/lib.rs
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2025 Intel Corporation
+ */
+
+#![allow(non_upper_case_globals)]
+#![allow(non_camel_case_types)]
+#![allow(non_snake_case)]
+
+include!(concat!(env!("OUT_DIR"), "/bindings.rs"));
+
+#[cfg(test)]
+mod tests {
+    use super::*;
+
+    #[test]
+    fn test_helloworld() {
+	let appname = std::ffi::CString::new("test-rs").unwrap();
+	let mut argv = [appname.into_raw()];
+	let ret = unsafe {
+		rte_eal_init(argv.len().try_into().unwrap(), argv.as_mut_ptr())
+	};
+	assert!(ret >= 0, "rte_eal_init failed");
+        unsafe { rte_eal_cleanup() };
+    }
+}
diff --git a/buildtools/rust/wrapper.h b/buildtools/rust/wrapper.h
new file mode 100644
index 0000000000..25f5bf94e2
--- /dev/null
+++ b/buildtools/rust/wrapper.h
@@ -0,0 +1,5 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2025 Intel Corporation
+ */
+
+#include <rte_eal.h>
diff --git a/meson.build b/meson.build
index 8436d1dff8..72c82178e1 100644
--- a/meson.build
+++ b/meson.build
@@ -114,6 +114,9 @@ configure_file(output: build_cfg,
 # build pkg-config files for dpdk
 subdir('buildtools/pkg-config')

+# output a list of cargo parameters if DPDK is being built for rust use
+run_command([gen_cargo_bindgen_info, pkgconf], check: true)
+
 if meson.is_subproject()
     subdir('buildtools/subproject')
 endif
--
2.45.2

