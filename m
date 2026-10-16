Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1B92CCA464
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Oct 2026 11:00:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5B2CA406B6;
	Fri, 16 Oct 2026 13:00:13 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id AF902402EE
 for <dev@dpdk.org>; Fri, 16 Oct 2026 13:00:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792148408; x=1823684408;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=R+yWseTMP2fns1cgG8/BRItGgV1fHcbufwm8lFnnykw=;
 b=T7dFYJqTzQf3nIqZtwCObRKUIDbHwHK2SNygX2HBicGipHhB1hrL774P
 cVDa3C3AylPgvRQlLhrAOzzbwxu8Bs/Bl0S2duYZgCNauv+k7qH3x/5uo
 feVCRp53S7nV7G8ohESBzj0fNbSqB1rqTOPz0PY4AYbSU2GswCTTvDW6P
 IjgYLHjjcfKrTaqYXpenvOItdQqsFYCVGVqP0Gp16aFzyyUIFeyKXTzJR
 JuW97wmRVTmkEbGyohVjhfa7HdoQG6MQfvvshwKrYh9Cwt9cCB9ZatNgQ
 9eXJNV1OjbGejL+v5R7H4cUeiEPylIePnthjk/UQxXxB3VmX4SVWiGWM8 Q==;
X-CSE-ConnectionGUID: HEAoyl6WQtKHEgCj1qeYvw==
X-CSE-MsgGUID: 9dLuBkwxTk6Rg8iUJbg42w==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="944136"
X-IronPort-AV: E=Sophos;i="6.27,161,1787036400"; 
   d="scan'208";a="944136"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Oct 2026 04:00:08 -0700
X-CSE-ConnectionGUID: OrCjn9vPSkmXYGyqRgVGfw==
X-CSE-MsgGUID: O7NM9879Soim1LswrLlGAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,161,1787036400"; 
   d="scan'208";a="3759387"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa011.fm.intel.com with ESMTP; 16 Oct 2026 04:00:07 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [RFC PATCH 06/12] build: add script to generate dependencies list
Date: Fri, 16 Oct 2026 11:59:44 +0100
Message-ID: <20261016105950.273068-7-bruce.richardson@intel.com>
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

At start of the build configuration, generate a list of all components
and their dependencies on other internal components. Future changes can
use this list to have smarter behaviour for enabling and disabling
drivers and libs.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 buildtools/get-deps.py | 203 +++++++++++++++++++++++++++++++++++++++++
 buildtools/meson.build |   1 +
 meson.build            |   7 ++
 3 files changed, 211 insertions(+)
 create mode 100644 buildtools/get-deps.py

diff --git a/buildtools/get-deps.py b/buildtools/get-deps.py
new file mode 100644
index 0000000000..ca3ee35ff7
--- /dev/null
+++ b/buildtools/get-deps.py
@@ -0,0 +1,203 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: BSD-3-Clause
+# Copyright(c) 2026 Intel Corporation
+
+"""Report the internal DPDK dependencies of every library, driver and app.
+
+Scans the meson.build file of each component for "deps" and "optional_deps"
+assignments, without needing to execute them.  This lets the build work out what
+each component requires before any component has been configured, which in turn
+allows enabling a component to also enable whatever it depends on.
+
+Output is one line per component:
+
+    kind|name|path|deps|optional_deps
+
+"kind" is one of lib, drv or app, and the two dependency fields are
+comma-separated and may be empty.  Dependency names are the names components are
+known by once built, i.e. a library is named after its directory, while a driver
+is "<class>_<name>".
+"""
+
+import re
+import sys
+from pathlib import Path
+from typing import NamedTuple
+
+# an assignment to one of the dependency variables, capturing the operator so
+# that "deps = " (replacing the class defaults) can be told from "deps += "
+ASSIGN = re.compile(r"^(deps|std_deps|optional_deps)\s*(\+?=)\s*(.*)$")
+# meson has no double-quoted strings, so anything quoted is quoted with '
+QUOTED = re.compile(r"'([^']+)'")
+
+
+class Component(NamedTuple):
+    kind: str  # lib, drv or app
+    name: str  # the name the component is known by once built
+    path: str  # source directory, relative to the DPDK root
+    deps: list
+    optional_deps: list
+
+
+def strip_comment(line):
+    """Remove a trailing comment. Dependency names never contain '#'."""
+    return line.split("#", 1)[0]
+
+
+def logical_lines(path):
+    """Yield (indent, text) with multi-line list literals joined into one line."""
+    if not path.is_file():
+        return
+    pending = ""
+    depth = 0
+    indent = 0
+    for raw in path.read_text().splitlines():
+        text = strip_comment(raw)
+        if not text.strip():
+            continue
+        # depth == 0 means we are not inside any brackets or parentheses
+        if depth == 0:
+            indent = len(text) - len(text.lstrip())
+            pending = text.strip()
+        else:
+            # inside a multi-line list or parentheses, so just append the stripped text
+            pending += " " + text.strip()
+        # brackets and the parentheses of calls such as files(...) may both span lines
+        depth = pending.count("[") - pending.count("]") + pending.count("(") - pending.count(")")
+        if depth <= 0:
+            depth = 0
+            yield indent, pending
+            pending = ""
+
+
+def dedup(items):
+    return list(dict.fromkeys(items))
+
+
+def list_variable(path, varname):
+    """Collect every value assigned or appended to a list variable."""
+    found = []
+    pattern = re.compile(r"^%s\s*\+?=\s*(.*)$" % re.escape(varname))
+    for _, line in logical_lines(path):
+        m = pattern.match(line)
+        if m:
+            found += QUOTED.findall(m.group(1))
+    return dedup(found)
+
+
+def scan(path):
+    """Return (deps, optional_deps, replaces_std_deps) for a component.
+
+    Conditions around an assignment are deliberately ignored: a dependency that
+    is only needed on some platforms is still recorded, which over-approximates
+    in the safe direction.  Use "optional_deps" for a dependency that should be
+    linked against only when it is already being built.
+    """
+    deps = []
+    optional = []
+    replaces = False
+
+    for indent, line in logical_lines(path):
+        m = ASSIGN.match(line)
+        if not m:
+            continue
+        var, op, rhs = m.groups()
+
+        items = QUOTED.findall(rhs)
+        if not items:
+            # a computed value such as "deps += some_variable" cannot be scanned
+            continue
+
+        if var == "optional_deps":
+            optional += items
+        elif op == "=" and var == "deps" and indent == 0:
+            # only a top-level "deps =" discards the class defaults; one inside a
+            # conditional may not run at all, so treat it as an addition
+            replaces = True
+            deps = list(items)
+        else:
+            deps += items
+
+    return dedup(deps), dedup(optional), replaces
+
+
+def scan_libs(root):
+    libdir = root / "lib"
+    for lib in list_variable(libdir / "meson.build", "libraries"):
+        deps, optional, _ = scan(libdir / lib / "meson.build")
+        yield Component("lib", lib, "lib/" + lib, deps, optional)
+
+
+def scan_drivers(root):
+    drvdir = root / "drivers"
+    for subpath in list_variable(drvdir / "meson.build", "subdirs"):
+        if "/" in subpath:
+            # a driver listed on its own gets no class-wide default dependencies
+            cls, rest = subpath.split("/", 1)
+            drivers, std_deps = [rest], []
+        else:
+            cls = subpath
+            classfile = drvdir / cls / "meson.build"
+            drivers = list_variable(classfile, "drivers")
+            std_deps, _, _ = scan(classfile)
+
+        for drv in drivers:
+            path = cls + "/" + drv
+            deps, optional, replaces = scan(drvdir / path / "meson.build")
+            if not replaces:
+                deps = dedup(std_deps + deps)
+            yield Component(
+                "drv", cls + "_" + drv.split("/")[-1], "drivers/" + path, deps, optional
+            )
+
+
+def scan_apps(root):
+    appdir = root / "app"
+    for app in list_variable(appdir / "meson.build", "apps"):
+        deps, optional, _ = scan(appdir / app / "meson.build")
+        yield Component("app", app, "app/" + app, deps, optional)
+
+
+def validate(components):
+    """Reject anything that would make the dependency graph unusable."""
+    errors = []
+    provider = {}
+    for c in components:
+        # apps are never depended upon, so they are outside the component namespace
+        if c.kind == "app":
+            continue
+        if c.name in provider:
+            errors.append(
+                '"%s" is provided by both %s and %s' % (c.name, provider[c.name], c.path)
+            )
+        provider[c.name] = c.path
+
+    for c in components:
+        for d in c.deps + c.optional_deps:
+            if d not in provider:
+                errors.append('%s depends on "%s", which is not a known component' % (c.path, d))
+    return errors
+
+
+def main():
+    if len(sys.argv) != 2:
+        sys.exit("usage: %s <dpdk-source-root>" % sys.argv[0])
+    root = Path(sys.argv[1])
+
+    components = list(scan_libs(root)) + list(scan_drivers(root)) + list(scan_apps(root))
+
+    errors = validate(components)
+    if errors:
+        for e in errors:
+            print("error: " + e, file=sys.stderr)
+        sys.exit(1)
+
+    for c in components:
+        print(
+            "%s|%s|%s|%s|%s"
+            % (c.kind, c.name, c.path, ",".join(c.deps), ",".join(c.optional_deps))
+        )
+
+
+if __name__ == "__main__":
+    main()
diff --git a/buildtools/meson.build b/buildtools/meson.build
index 32cea7cff7..02c66a5580 100644
--- a/buildtools/meson.build
+++ b/buildtools/meson.build
@@ -22,6 +22,7 @@ gen_version_map = py3 + files('gen-version-map.py')
 list_dir_globs = py3 + files('list-dir-globs.py')
 sphinx_wrapper = py3 + files('call-sphinx-build.py')
 get_cpu_count_cmd = py3 + files('get-cpu-count.py')
+get_deps_cmd = py3 + files('get-deps.py')
 get_numa_count_cmd = py3 + files('get-numa-count.py')
 get_min_meson_version_cmd = py3 + files('get-min-meson-version.py')
 get_test_suites_cmd = py3 + files('get-test-suites.py')
diff --git a/meson.build b/meson.build
index 6b8cfa8b2e..e153894ac7 100644
--- a/meson.build
+++ b/meson.build
@@ -88,6 +88,13 @@ if is_linux
     global_inc += include_directories('kernel/linux')
 endif
 
+# record what each component depends on, so that enabling a component can also
+# enable the components it needs
+dpdk_deps_graph = configure_file(
+        command: [get_deps_cmd, dpdk_source_root],
+        capture: true,
+        output: 'dependencies.txt')
+
 # build libs and drivers
 subdir('lib')
 subdir('drivers')
-- 
2.53.0

