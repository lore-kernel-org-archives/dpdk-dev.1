Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82223C021AA
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Feb 2025 11:15:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 52A08402E9;
	Tue, 18 Feb 2025 12:15:48 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id 9F78B40609
 for <dev@dpdk.org>; Tue, 18 Feb 2025 12:15:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739877346; x=1771413346;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=qaUTOngNIRN4uhqTDK0HVpCKNEAlzS/2+L5CJEec6yc=;
 b=K172XiFrFsJ2s/VvviHeyUViw4/bhh3ZsO3EtvYguJNh9USexuNXpnsC
 JH4Roqfgv4rugoBY6ZOwQkDCrxDG38Lnxw+iAFziZMozyL18gdf6C0CW6
 pAwganpaa1CJ5LE3jZKnmv2/sLOzp9x7vbDnYhTg4MaIEWYDRcKZiUaXk
 GIFym/Cjq2mM2fGqzcjjlXlGlH6NTqKcEdTZKTXVue7501kFevmm/TBVl
 00gpGMB9yPuI/T9RNlygZhvZk/xPuI95/wzSdxc5daQmkBwP7K3GnKp9V
 eCcjpbNu8HEtY7/4j9BjNAhIca3SrhxtOj7OAbYGuozZ9w9DPJfHSpINr g==;
X-CSE-ConnectionGUID: 8f7VCR05Rey85v/4/jJUzg==
X-CSE-MsgGUID: EiKuIGI0Qve2uxksmpd+TQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="50780808"
X-IronPort-AV: E=Sophos;i="6.13,295,1732608000"; d="scan'208";a="50780808"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Feb 2025 03:15:46 -0800
X-CSE-ConnectionGUID: ipc9KgF3SIWjoRJklcV5Mw==
X-CSE-MsgGUID: 6//rdrm4SamIHAT/Gr992A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,295,1732608000"; d="scan'208";a="119466253"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa004.fm.intel.com with ESMTP; 18 Feb 2025 03:15:44 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v6 2/8] build: output a dependency log in build directory
Date: Tue, 18 Feb 2025 11:15:28 +0000
Message-ID: <e9fb1adcce9464882d38414ce2e87c5f337e32b1.1739877266.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1739877265.git.anatoly.burakov@intel.com>
References: <cover.1725462264.git.anatoly.burakov@intel.com>
 <cover.1739877265.git.anatoly.burakov@intel.com>
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

From: Bruce Richardson <bruce.richardson@intel.com>

As meson processes our DPDK source tree it manages dependencies
specified by each individual driver. To enable future analysis of the
dependency links between components, log the dependencies of each DPDK
component as it gets processed. This could potentially allow other tools
to automatically enable or disable components based on the desired end
components to be built, e.g. if the user requests net/ice, ensure that
common/iavf is also enabled in the drivers.

The output file produced is in "dot" or "graphviz" format, which allows
producing a graphical representation of the DPDK dependency tree if so
desired. For example: "dot -Tpng -O build/deps.dot" to produce the
image file "build/deps.dot.png".

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>
Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---

Notes:
    v4 -> v5:
    - Change output format to include display name

 app/meson.build        | 17 +++++++-
 buildtools/log-deps.py | 94 ++++++++++++++++++++++++++++++++++++++++++
 buildtools/meson.build |  2 +
 drivers/meson.build    | 14 +++++++
 examples/meson.build   | 18 +++++++-
 lib/meson.build        | 14 +++++++
 6 files changed, 157 insertions(+), 2 deletions(-)
 create mode 100644 buildtools/log-deps.py

diff --git a/app/meson.build b/app/meson.build
index 61202495bd..a971738d40 100644
--- a/app/meson.build
+++ b/app/meson.build
@@ -77,7 +77,22 @@ foreach app:apps
     endif
 
     if build
+        # call into subdir may update name so record it here
+        display_name = name
+
         subdir(name)
+        app_name = 'dpdk-' + name
+
+        # log mandatory dependencies
+        cmds = ['--type', 'app']
+        cmds += ['--display-name', display_name]
+        run_command([log_deps_cmd, cmds, app_name, deps], check: false)
+
+        # log optional dependencies, if any
+        if optional_deps.length() > 0
+            cmds += ['--optional']
+            run_command([log_deps_cmd, cmds, app_name, optional_deps], check: false)
+        endif
         if not build and require_apps
             error('Cannot build explicitly requested app "@0@".\n'.format(name)
                   + '\tReason: ' + reason)
@@ -125,7 +140,7 @@ foreach app:apps
         link_libs = dpdk_static_libraries + dpdk_drivers
     endif
 
-    exec = executable('dpdk-' + name,
+    exec = executable(app_name,
             [ sources, resources ],
             c_args: cflags,
             link_args: ldflags,
diff --git a/buildtools/log-deps.py b/buildtools/log-deps.py
new file mode 100644
index 0000000000..7a99b129d7
--- /dev/null
+++ b/buildtools/log-deps.py
@@ -0,0 +1,94 @@
+#! /usr/bin/env python3
+# SPDX-License-Identifier: BSD-3-Clause
+# Copyright(c) 2024 Intel Corporation
+
+"""Utility script to build up a list of dependencies from meson."""
+
+import os
+import sys
+import argparse
+import typing as T
+
+
+def file_to_list(filename: str) -> T.List[str]:
+    """Read file into a list of strings."""
+    with open(filename, encoding="utf-8") as f:
+        return f.readlines()
+
+
+def list_to_file(filename: str, lines: T.List[str]):
+    """Write a list of strings out to a file."""
+    with open(filename, "w", encoding="utf-8") as f:
+        f.writelines(lines)
+
+
+def gen_deps(
+    component_type: str,
+    optional: bool,
+    component: str,
+    display_name: T.Optional[str],
+    deps: T.List[str],
+) -> str:
+    """Generate a dependency graph for meson."""
+    dep_list_str = '", "'.join(deps)
+    deps_str = "" if not deps else f' -> {{ "{dep_list_str}" }}'
+    # we define custom attributes for the nodes
+    attr_str = f'dpdk_componentType="{component_type}"'
+    if optional:
+        # we use a dotted line to represent optional dependencies
+        attr_str += ',style="dotted"'
+    if display_name is not None:
+        attr_str += f',dpdk_displayName="{display_name}"'
+    return f'"{component}"{deps_str} [{attr_str}]\n'
+
+
+def _main():
+    depsfile = f'{os.environ["MESON_BUILD_ROOT"]}/deps.dot'
+
+    # to reset the deps file on each build, the script is called without any params
+    if len(sys.argv) == 1:
+        os.remove(depsfile)
+        sys.exit(0)
+
+    # we got arguments, parse them
+    parser = argparse.ArgumentParser(
+        description="Generate a dependency graph for meson."
+    )
+    # type is required
+    parser.add_argument(
+        "--type", required=True, help="Type of dependency (lib, examples, etc.)"
+    )
+    parser.add_argument(
+        "--optional", action="store_true", help="Whether the dependency is optional"
+    )
+    parser.add_argument(
+        "--display-name",
+        help="Component name as it is used in the build system",
+    )
+    # component is required
+    parser.add_argument("component", help="The component to add to the graph")
+    parser.add_argument("deps", nargs="*", help="The dependencies of the component")
+
+    parsed = parser.parse_args()
+
+    try:
+        contents = file_to_list(depsfile)
+    except FileNotFoundError:
+        contents = ["digraph {\n", "}\n"]
+
+    # occasionally, component binary name may be different from what it appears in Meson.
+    display_name = parsed.display_name
+
+    c_type = parsed.type
+    optional = parsed.optional
+    component = parsed.component
+    deps = parsed.deps
+    contents[-1] = gen_deps(c_type, optional, component, display_name, deps)
+
+    contents.append("}\n")
+
+    list_to_file(depsfile, contents)
+
+
+if __name__ == "__main__":
+    _main()
diff --git a/buildtools/meson.build b/buildtools/meson.build
index 4e2c1217a2..13a0477245 100644
--- a/buildtools/meson.build
+++ b/buildtools/meson.build
@@ -26,6 +26,8 @@ header_gen_cmd = py3 + files('gen-header.py')
 has_hugepages_cmd = py3 + files('has-hugepages.py')
 cmdline_gen_cmd = py3 + files('dpdk-cmdline-gen.py')
 check_dts_requirements = py3 + files('check-dts-requirements.py')
+log_deps_cmd = py3 + files('log-deps.py')
+run_command(log_deps_cmd, check: false)  # call with no parameters to reset the file
 
 # install any build tools that end-users might want also
 install_data([
diff --git a/drivers/meson.build b/drivers/meson.build
index fb48e11eaf..e9698373e2 100644
--- a/drivers/meson.build
+++ b/drivers/meson.build
@@ -162,6 +162,8 @@ foreach subpath:subdirs
         endif
 
         if build
+            # call into subdir may update name so record it here
+            display_name = '@0@/@1@'.format(class, name)
             # pull in driver directory which should update all the local variables
             subdir(drv_path)
 
@@ -176,6 +178,18 @@ foreach subpath:subdirs
                         +'\tReason: ' + reason)
             endif
 
+            # log mandatory dependencies
+            cmds = ['--type', 'drivers']
+            cmds += ['--display-name', display_name]
+            drv_name = class + '_' + name
+            run_command([log_deps_cmd, cmds, drv_name, deps], check: false)
+
+            # log optional dependencies, if any
+            if optional_deps.length() > 0
+                cmds += ['--optional']
+                run_command([log_deps_cmd, cmds, drv_name, optional_deps], check: false)
+            endif
+
             # get dependency objs from strings
             shared_deps = ext_deps
             static_deps = ext_deps
diff --git a/examples/meson.build b/examples/meson.build
index 14b8aadf68..d1856dbafc 100644
--- a/examples/meson.build
+++ b/examples/meson.build
@@ -99,11 +99,27 @@ foreach example: examples
     includes = [include_directories(example, 'common')]
     deps = ['eal', 'mempool', 'net', 'mbuf', 'ethdev', 'cmdline']
     optional_deps = []
+
+    # call into subdir may update name so record it here
+    display_name = example
+
     subdir(example)
+    example_name = 'dpdk-' + name
 
     if build
         dep_objs = ext_deps
 
+        # log mandatory dependencies
+        cmds = ['--type', 'examples']
+        cmds += ['--display-name', display_name]
+        run_command([log_deps_cmd, cmds, example_name, deps], check: false)
+
+        # log optional dependencies, if any
+        if optional_deps.length() > 0
+            cmds += ['--optional']
+            run_command([log_deps_cmd, cmds, example_name, optional_deps], check: false)
+        endif
+
         # resolve any optional internal dependencies
         def_lib = get_option('default_library')
         foreach d: optional_deps
@@ -135,7 +151,7 @@ foreach example: examples
     if allow_experimental_apis
         cflags += '-DALLOW_EXPERIMENTAL_API'
     endif
-    executable('dpdk-' + name, sources,
+    executable(example_name, sources,
             include_directories: includes,
             link_whole: link_whole_libs,
             link_args: ldflags,
diff --git a/lib/meson.build b/lib/meson.build
index 76bf849852..db0d121b3c 100644
--- a/lib/meson.build
+++ b/lib/meson.build
@@ -160,7 +160,21 @@ foreach l:libraries
     endif
 
     if build
+        # as per warning below, directory name should match library name but it is not considered an error
+        display_name = name
+
         subdir(l)
+
+        # log mandatory dependencies
+        cmds = ['--type', 'lib']
+        cmds += ['--display-name', display_name]
+        run_command([log_deps_cmd, cmds, name, deps], check: false)
+
+        # log optional dependencies, if any
+        if optional_deps.length() > 0
+            cmds += ['--optional']
+            run_command([log_deps_cmd, cmds, name, optional_deps], check: false)
+        endif
         if not build and require_libs
             error('Cannot build explicitly requested lib "@0@".\n'.format(name)
                     +'\tReason: ' + reason)
-- 
2.43.5

