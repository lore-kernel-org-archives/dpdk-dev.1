Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC762D3EE9F
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 Jan 2026 17:47:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B6C994027A;
	Thu, 22 Jan 2026 18:47:46 +0100 (CET)
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com
 [209.85.219.52]) by mails.dpdk.org (Postfix) with ESMTP id 8DB2E4026F
 for <dev@dpdk.org>; Thu, 22 Jan 2026 18:47:45 +0100 (CET)
Received: by mail-qv1-f52.google.com with SMTP id
 6a1803df08f44-88fcc71dbf4so8988826d6.2
 for <dev@dpdk.org>; Thu, 22 Jan 2026 09:47:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1769104065; x=1769708865; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ujBzhvsIMkKaR/JAzfJJ5Q11K9CDw+rWzNHx3QHcYAM=;
 b=BfKkl/UlxTwNglCSjEJN3WX1i7t42YIFHYN8HRvuuATOsnANSo0btNJ2gF/+USMGpw
 16GxTzo3LhhgIt2gUWSirzEUB+z31PjL70cFUJUCtHmXc/uJSU44v2W0/0OKPXClBKhh
 WChEeoV4z1OitkjGzgTYzqXVAIf/Gs6FtQ+64=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769104065; x=1769708865;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ujBzhvsIMkKaR/JAzfJJ5Q11K9CDw+rWzNHx3QHcYAM=;
 b=eIR+3RnVkfr1WGpwvX7rdLmZwlb4vFZucmJkNbwT9VHr1h+q94fDaV7tApmyhzawXi
 NRa3H41PNxHJEgoew8aswLekC7FGhmqrgOBxgmzW/dhN4vqcRHwl+zjHe//4l0uU9NzY
 61uMf7lve4xKmun9LfKQy/QLmklfo4vcxj2iQY0GlgSq0uEkKW+hi6BbZ0RMrsHRv86V
 pfTKBONyFNgklAdLS9gD6GhAbziqZ7HEl/PAeLXNcBVVP/6IVfsvO9J6jfKECAOJlZ9l
 2gi1N16STqJz7uL/86gsAtotn0DsYmBxx5ZeTxqfg7+M4esW2itRuU8OlGG4XXDd28dh
 FseQ==
X-Gm-Message-State: AOJu0YyIi5H5Il+f3rjHpasQbVUk2JGsZuzQdtrnGLIvazIX7jitnZ+x
 mDHqCujYk5cx/gN9l3eqNGFyCV5jvKxDl6JuXzJVocAZy2JY6sjB3Ihyu/FzqhmJFV0=
X-Gm-Gg: AZuq6aKLJgdN6AF2QW/ijb7asJSs1LF94EDUtqmqbq3eMTCNV2n6MR5TjuR7+2/q/Cv
 chwBM84WnYNTtmLTsvmABPd9jYvcEf5kj3TfBzEN0s+g9AEolVe1CGL+cu9ynAUemUA9xQIKzZw
 hLxxqmXmof4wv8+uxjlmvWgzITeM2gyoRNADnT4S1w62pZYvxcwdLw2T34pmIagCGlNa0bQK3Ot
 /npHyyzrtjPEevtAejtb7kS+Efz2q+pu/qFK+XkkT6h8RiEjnOwHHLSWe/gz62owS611cLeHNF5
 PhNgZpxwqrQldCYmx6GwoKTc9tO5SEPIWaynzxb1u1Kcv7E8iQAdoUJV0DkN7M5niR2gqbKTzhC
 a+4zfuvDDrY/h3RaR09aQ1mYxn4L7QavfEUGaHsfpTXNTBDjvJ29K6PV5rtZFXJ02g7doGI+FP1
 Lrp74GsfWnacHSRzQ6zW9a3ky8/WLXmsqUFn6+gLRd4SafOdg/lN8B
X-Received: by 2002:ad4:5d62:0:b0:88a:41d9:23ac with SMTP id
 6a1803df08f44-8949020c9eemr4673616d6.36.1769104064733; 
 Thu, 22 Jan 2026 09:47:44 -0800 (PST)
Received: from d121016.iol.unh.edu ([2606:4100:3880:1210::202])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8942e605f93sm147943676d6.24.2026.01.22.09.47.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jan 2026 09:47:44 -0800 (PST)
From: Dean Marx <dmarx@iol.unh.edu>
To: probb@iol.unh.edu, luca.vizzarro@arm.com, yoan.picchi@foss.arm.com,
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com
Cc: dev@dpdk.org,
	Dean Marx <dmarx@iol.unh.edu>
Subject: [PATCH v4 1/2] dts: add test case docstring checks to format script
Date: Thu, 22 Jan 2026 12:47:41 -0500
Message-ID: <20260122174742.237855-1-dmarx@iol.unh.edu>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251106181355.209706-1-dmarx@iol.unh.edu>
References: <20251106181355.209706-1-dmarx@iol.unh.edu>
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

Add a python script that checks all test cases
to ensure each docstring contains a steps and
verify section in accordance with coding guidelines.
Add a section within the check-format script which
calls the docstring script after linting with ruff.

Bugzilla ID: 1623

Signed-off-by: Dean Marx <dmarx@iol.unh.edu>
Reviewed-by: Patrick Robb <probb@iol.unh.edu>
---
 devtools/dts-check-docstrings.py | 54 ++++++++++++++++++++++++++++++++
 devtools/dts-check-format.sh     |  5 +++
 2 files changed, 59 insertions(+)
 create mode 100755 devtools/dts-check-docstrings.py

diff --git a/devtools/dts-check-docstrings.py b/devtools/dts-check-docstrings.py
new file mode 100755
index 0000000000..3b0d2a42a1
--- /dev/null
+++ b/devtools/dts-check-docstrings.py
@@ -0,0 +1,54 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: BSD-3-Clause
+# Copyright(c) 2025 University of New Hampshire
+
+import sys
+from ast import FunctionDef, Name, walk, get_docstring, parse
+from pathlib import Path
+
+BASE_DIR = Path(__file__).resolve().parent.parent  # dpdk/
+TESTS_DIR = BASE_DIR / "dts" / "tests"  # dts/tests/
+DECORATOR_NAMES = {"func_test", "perf_test"}
+
+
+def has_test_decorator(node: FunctionDef) -> bool:
+    """Return True if function has @func_test or @perf_test decorator."""
+    for decorator in node.decorator_list:
+        if isinstance(decorator, Name) and decorator.id in DECORATOR_NAMES:
+            return True
+    return False
+
+
+def check_file(path: Path) -> bool:
+    """Return True if file has steps and verify sections in each test case docstring."""
+    source = path.read_text(encoding="utf-8")
+    tree = parse(source, filename=str(path))
+    ok = True
+
+    for node in walk(tree):
+        if isinstance(node, FunctionDef):
+            if has_test_decorator(node):
+                doc = get_docstring(node)
+                if not doc:
+                    print(f"{path}:{node.lineno} missing docstring for test case")
+                    ok = False
+                else:
+                    if "Steps:" not in doc:
+                        print(f"{path}:{node.lineno} missing 'Steps:' section")
+                        ok = False
+                    if "Verify:" not in doc:
+                        print(f"{path}:{node.lineno} missing 'Verify:' section")
+                        ok = False
+    return ok
+
+
+def main():
+    all_ok = True
+    for path in TESTS_DIR.rglob("*.py"):
+        if not check_file(path):
+            all_ok = False
+    sys.exit(0 if all_ok else 1)
+
+
+if __name__ == "__main__":
+    main()
diff --git a/devtools/dts-check-format.sh b/devtools/dts-check-format.sh
index 907eed1293..23c0a5f1da 100755
--- a/devtools/dts-check-format.sh
+++ b/devtools/dts-check-format.sh
@@ -13,6 +13,7 @@ usage() {
 format=true
 lint=true
 typecheck=true
+docstringcheck=true
 
 # Comments after args serve as documentation; must be present
 while getopts "hflt" arg; do
@@ -97,6 +98,10 @@ if $lint; then
 		echo "ruff not found, unable to run linter"
 		errors=$((errors + 1))
 	fi
+	if $docstringcheck; then
+		python3 ../devtools/dts-check-docstrings.py
+		errors=$((errors + $?))
+	fi
 fi
 
 if $typecheck; then
-- 
2.52.0

