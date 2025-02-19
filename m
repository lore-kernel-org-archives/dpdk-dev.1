Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3D3BC021AA
	for <dpdk-dev@archiver.kernel.org>; Wed, 19 Feb 2025 10:58:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C199F40E27;
	Wed, 19 Feb 2025 11:58:10 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id 42C1540E26
 for <dev@dpdk.org>; Wed, 19 Feb 2025 11:58:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739962687; x=1771498687;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=1pw2gvhQIht+ZTtmaolkZt7gpSCfIFFG8pMCHJLW1gg=;
 b=hvzo3t/qacmVembeaa+fbaEzLF66FXyaPmIdauTIBQelr/Cipaduvhjy
 9gu7Jbsscr8EBleCTXYH8f/oD/W6a3BaxNflFdVZjw648OYywcfmUtfYU
 OQ72KjILjGRS4BWDOJ+dGkVZby4QujwSx8rEMOLqUYB8AAPVwgwI6GUff
 puK0wGMMaVMBcdRYhQ8qlvVfU5uDSmEAevtHPMzGBcVoY57zdGxzGA2Wb
 A/oT8ZsyEEyuXRY6fET3eDfVSDlTvuimXG6eKtqNeD02NRFjgDJ1dByPh
 Kl78cXGshshDNvO6foTWlUvZsKgxroZxGdxld1br9scV2Yll34g2f+iDy g==;
X-CSE-ConnectionGUID: UyjPwqfnS3y/sUCMkKZYzA==
X-CSE-MsgGUID: j+7Cty6WSlOEyRJ5DQRq0w==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="44609955"
X-IronPort-AV: E=Sophos;i="6.13,298,1732608000"; d="scan'208";a="44609955"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Feb 2025 02:58:07 -0800
X-CSE-ConnectionGUID: e5pPZrZpTKiac/5Ux5LszA==
X-CSE-MsgGUID: qoovmel1TE2KfjRZXmNKWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,298,1732608000"; d="scan'208";a="145533476"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by orviesa002.jf.intel.com with ESMTP; 19 Feb 2025 02:58:06 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v7 3/8] devtools: add script to flag unneeded dependencies
Date: Wed, 19 Feb 2025 10:57:49 +0000
Message-ID: <a41608f5e99d852bf648f83e716cd737bcd16326.1739962646.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1739962645.git.anatoly.burakov@intel.com>
References: <cover.1725462264.git.anatoly.burakov@intel.com>
 <cover.1739962645.git.anatoly.burakov@intel.com>
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

