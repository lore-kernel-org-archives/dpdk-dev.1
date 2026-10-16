Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8FD3CC6B38
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Oct 2026 11:00:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1C75440A79;
	Fri, 16 Oct 2026 13:00:14 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id CC1B44069D
 for <dev@dpdk.org>; Fri, 16 Oct 2026 13:00:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792148410; x=1823684410;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=3G2VJkAqbiW09AxIW/tgviWmNAig0FRx13jFdrwfreA=;
 b=Ou3dHOTLWjpfkipAwuW8qF9DyDkAw8NkSRoGKyzaBSWGlRctnta7BeDr
 05C4lkvqYsjsEuAk1muW9VDjhqqU15PWrAuSXZbHw0FfZJo3bHVgq2g7g
 Mncj6qYSpF3R7pJgTEhmm2pTJxrg1QIsbkLNp+aB8bHFMbfoNDwpjIXnj
 u3wnf67I/W/KkvhtYFmlZkYc2djQemifgW/or9mB+yqeq/q/fTwKvvi24
 1mfrhSACTgVI8xwkyJua6DEPjjKnN5xE2SqeSh8WalsSXUnHjXMgAKidO
 JEZu/QxLEVoBvlr4BolFRgGRU2t2IsN5GXYTJHnrnmMxKDLYpPeWPQ9+V w==;
X-CSE-ConnectionGUID: bbaB55/wS6iXLpnjwbWRLg==
X-CSE-MsgGUID: ZWwnQzJQQDah4GIqtvVTqg==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="944137"
X-IronPort-AV: E=Sophos;i="6.27,161,1787036400"; 
   d="scan'208";a="944137"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Oct 2026 04:00:09 -0700
X-CSE-ConnectionGUID: BFFi9HArQIWLLNiiF7z9uA==
X-CSE-MsgGUID: cRhkunz1RpqNgO3lWuu3Lw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,161,1787036400"; 
   d="scan'208";a="3759394"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa011.fm.intel.com with ESMTP; 16 Oct 2026 04:00:08 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [RFC PATCH 07/12] build: use recursive addition for enabled libraries
 option
Date: Fri, 16 Oct 2026 11:59:45 +0100
Message-ID: <20261016105950.273068-8-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261016105950.273068-1-bruce.richardson@intel.com>
References: <20261016105950.273068-1-bruce.richardson@intel.com>
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

When a user configures the build using "--enable_libs" there is no
automatic handling of dependencies for the requested libraries. For
example, if "ipsec" is a requested library, the user must know that
security and cryptodev libs must also be in the enabled set.

Fix this omission by using a python script to parse the previously
generated dependency set for the DPDK components and report out the
necessary libraries. This allows for the automatic addition of extra
libraries if they are needed to enable an explicitly-requested library.
If a dependency of a requested lib is explicitly in the disable list,
then error out.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 buildtools/meson.build     |  1 +
 buildtools/resolve-deps.py | 80 ++++++++++++++++++++++++++++++++++++++
 lib/meson.build            | 18 +++++----
 3 files changed, 91 insertions(+), 8 deletions(-)
 create mode 100644 buildtools/resolve-deps.py

diff --git a/buildtools/meson.build b/buildtools/meson.build
index 02c66a5580..b3aa7197f9 100644
--- a/buildtools/meson.build
+++ b/buildtools/meson.build
@@ -26,6 +26,7 @@ get_deps_cmd = py3 + files('get-deps.py')
 get_numa_count_cmd = py3 + files('get-numa-count.py')
 get_min_meson_version_cmd = py3 + files('get-min-meson-version.py')
 get_test_suites_cmd = py3 + files('get-test-suites.py')
+resolve_deps_cmd = py3 + files('resolve-deps.py')
 header_gen_cmd = py3 + files('gen-header.py')
 has_hugepages_cmd = py3 + files('has-hugepages.py')
 cmdline_gen_cmd = py3 + files('dpdk-cmdline-gen.py')
diff --git a/buildtools/resolve-deps.py b/buildtools/resolve-deps.py
new file mode 100644
index 0000000000..ac2f9c63d9
--- /dev/null
+++ b/buildtools/resolve-deps.py
@@ -0,0 +1,80 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: BSD-3-Clause
+# Copyright(c) 2026 Intel Corporation
+
+"""List everything needed in order to build the given components.
+
+Reads the dependency graph produced by get-deps.py and prints, as a single
+comma-separated list, the named components plus everything they depend on,
+directly or indirectly.
+
+"""
+
+import argparse
+from collections import namedtuple
+
+Component = namedtuple("Component", ["kind", "name", "key", "deps"])
+
+
+def read_graph(filename):
+    """Load every component that can be depended upon.
+
+    Apps are never depended upon and may share a name with a library, e.g. graph
+    and pdump, so they are left out of the graph entirely.
+    """
+    components = []
+    with open(filename) as f:
+        for line in f:
+            kind, name, path, deps, _ = line.strip().split("|")
+            if kind == "app":
+                continue
+            # the option key is the path without its category directory
+            key = path.split("/", 1)[1]
+            components.append(Component(kind, name, key, [d for d in deps.split(",") if d]))
+    return components
+
+
+def needed(components, roots, kinds):
+    """Return the keys, of the wanted kinds, of everything the roots need."""
+    by_name = {c.name: c for c in components}
+    by_key = {c.key: c for c in components}
+
+    pending = []
+    for r in roots:
+        comp = by_key.get(r) or by_name.get(r)
+        if comp is not None:
+            pending.append(comp.name)
+
+    seen = set()
+    while pending:
+        comp = by_name[pending.pop()]
+        if comp.name in seen:
+            continue
+        seen.add(comp.name)
+        pending += [d for d in comp.deps if d in by_name]
+
+    return sorted(c.key for c in components if c.name in seen and c.kind in kinds)
+
+
+def main():
+    parser = argparse.ArgumentParser(description=__doc__)
+    parser.add_argument("graph", help="dependency graph file from get-deps.py")
+    parser.add_argument("--libs", action="store_true", help="report only libraries")
+    parser.add_argument("--drivers", action="store_true", help="report only drivers")
+    parser.add_argument("component", nargs="+", help="components to be built")
+    args = parser.parse_args()
+
+    kinds = []
+    if args.libs:
+        kinds.append("lib")
+    if args.drivers:
+        kinds.append("drv")
+    if not kinds:
+        kinds = ["lib", "drv"]
+
+    components = read_graph(args.graph)
+    print(",".join(needed(components, args.component, kinds)))
+
+
+if __name__ == "__main__":
+    main()
diff --git a/lib/meson.build b/lib/meson.build
index 87bfb914e8..f7705d7ebe 100644
--- a/lib/meson.build
+++ b/lib/meson.build
@@ -100,18 +100,20 @@ endforeach
 
 disable_libs = run_command(list_dir_globs, get_option('disable_libs'), check: true).stdout().split()
 
-enable_libs = run_command(list_dir_globs, get_option('enable_libs'), check: true).stdout().split()
-foreach l:enable_libs
+requested_libs = run_command(list_dir_globs, get_option('enable_libs'), check: true).stdout().split()
+foreach l:requested_libs
     if disable_libs.contains(l)
         error('Library "@0@" is in both "enable_libs" and "disable_libs".'.format(l))
     endif
 endforeach
-require_libs = true
-if enable_libs.length() == 0
-    require_libs = false
-    enable_libs = libraries
-else
-    enable_libs += always_enable
+require_libs = requested_libs.length() != 0
+
+# expand the requested libraries to also include the libraries they depend on,
+# with an empty request meaning every library is wanted
+enable_libs = libraries
+if requested_libs.length() > 0
+    enable_libs = run_command(resolve_deps_cmd, dpdk_deps_graph, '--libs',
+            requested_libs + always_enable, check: true).stdout().strip().split(',')
 endif
 
 default_cflags = machine_args
-- 
2.53.0

