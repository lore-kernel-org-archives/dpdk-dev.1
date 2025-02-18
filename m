Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C200EC021AA
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Feb 2025 11:16:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7043A4064A;
	Tue, 18 Feb 2025 12:15:49 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id F01184060F
 for <dev@dpdk.org>; Tue, 18 Feb 2025 12:15:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739877348; x=1771413348;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=1pw2gvhQIht+ZTtmaolkZt7gpSCfIFFG8pMCHJLW1gg=;
 b=ISclkOhwFOK2km41PZlqASOIHH86EUi+i9tMITutGu5Hz5QRo43pyz3N
 gGjqBYt18Vti9rQTsLj6N6Okt9UwzHzuBWWLj/AT7j16NKGDGCX34edVf
 WZpQ8ip/dDtPpCGbpdjkdYTPFzN/K8SrM0ryoDnVFEEiEcHyko8h4lTo0
 EwIjUUgWlBfZQlHiyTZqzd26+GWmHs3/hYmevWVG05/JtvTvulR7tqeL3
 6hpkXUOmsmk8pM7YNid7DAfeCD+5gu5jI3WlPEh2LF4TQXYL0M9//K2ya
 A4xM8thBEYVBTwb/YQU6lvwmLyjJ6302lAOZCC9BAM8tgb2PwlZVZUvR3 A==;
X-CSE-ConnectionGUID: F0nQXjTFQSqvEGeLT3Bu7A==
X-CSE-MsgGUID: PyCNLX2WS468FNnb3J35ag==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="50780809"
X-IronPort-AV: E=Sophos;i="6.13,295,1732608000"; d="scan'208";a="50780809"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Feb 2025 03:15:47 -0800
X-CSE-ConnectionGUID: giXbeJaCSemDm9B9OFYLWw==
X-CSE-MsgGUID: DtI8CmriQ3+zPIt1NIq82g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,295,1732608000"; d="scan'208";a="119466258"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa004.fm.intel.com with ESMTP; 18 Feb 2025 03:15:45 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v6 3/8] devtools: add script to flag unneeded dependencies
Date: Tue, 18 Feb 2025 11:15:29 +0000
Message-ID: <f51337b644be32fe787ca8b4ba267c7f32ef8acf.1739877266.git.anatoly.burakov@intel.com>
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

While not a serious problem, DPDK components often list more
dependencies than are actually necessary to build, due to the use of
recursive dependencies. In extreme cases, such as with core libraries,
this can lead to longer configuration times due to meson having to
deduplicate long lists of dependencies. Therefore we can add a script to
identify when a component has got unnecessary dependencies listed.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 devtools/find-duplicate-deps.py | 62 +++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)
 create mode 100755 devtools/find-duplicate-deps.py

diff --git a/devtools/find-duplicate-deps.py b/devtools/find-duplicate-deps.py
new file mode 100755
index 0000000000..cbd0ca7196
--- /dev/null
+++ b/devtools/find-duplicate-deps.py
@@ -0,0 +1,62 @@
+#! /usr/bin/env python3
+# SPDX-License-Identifier: BSD-3-Clause
+# Copyright(c) 2024 Intel Corporation
+
+"""Identify any superfluous dependencies listed in DPDK deps graph."""
+
+import sys
+
+all_deps = {}
+
+
+class dep:
+    """Holds a component and its dependencies."""
+
+    def __init__(self, name, dep_names):
+        """Create and process a component and its deps."""
+        self.name = name.strip('" ')
+        self.base_deps = [all_deps[dn.strip('" ')] for dn in dep_names]
+        self.recursive_deps = []
+        for d in self.base_deps:
+            self.recursive_deps.extend(d.base_deps)
+            self.recursive_deps.extend(d.recursive_deps)
+        self.extra_deps = []
+        for d in self.base_deps:
+            if d in self.recursive_deps:
+                self.extra_deps.append(d.name)
+        if self.extra_deps:
+            print(f'{self.name}: extra deps {self.extra_deps}')
+
+    def dict_add(self, d):
+        """Add this object to a dictionary by name."""
+        d[self.name] = self
+
+
+def remove_attrs(ln):
+    """Remove attributes from a line."""
+    while ln.find("[") != -1:
+        start = ln.find("[")
+        end = ln.find("]")
+        ln = ln[:start] + ln[end + 1 :]
+    return ln.strip()
+
+
+def main(argv):
+    """Read the dependency tree from a dot file and process it."""
+    if len(argv) != 2:
+        print(f'Usage: {argv[0]} <build-directory>/deps.dot', file=sys.stderr)
+        sys.exit(1)
+
+    with open(argv[1]) as f:
+        for ln in f.readlines():
+            ln = remove_attrs(ln.strip())
+            if '->' in ln:
+                name, deps = ln.split('->')
+                deps = deps.strip(' {}')
+                dep(name, deps.split(',')).dict_add(all_deps)
+            elif ln.startswith('"') and ln.endswith('"'):
+                dep(ln.strip('"'), []).dict_add(all_deps)
+
+
+if __name__ == '__main__':
+    main(sys.argv)
-- 
2.43.5

