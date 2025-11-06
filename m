Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A632CCFA13
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Nov 2025 18:14:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6DA2A4021F;
	Thu,  6 Nov 2025 19:13:59 +0100 (CET)
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com
 [209.85.222.180])
 by mails.dpdk.org (Postfix) with ESMTP id DD4FD4013F
 for <dev@dpdk.org>; Thu,  6 Nov 2025 19:13:57 +0100 (CET)
Received: by mail-qk1-f180.google.com with SMTP id
 af79cd13be357-85a4ceb4c3dso140860885a.3
 for <dev@dpdk.org>; Thu, 06 Nov 2025 10:13:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1762452837; x=1763057637; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O6BJP0gak6o7I0TXFx+7IVRDvE/jKpTaAYDY/JTgl3Y=;
 b=iHn/K2VtrTNECVr2X5CPjRVLypRD2VIC6LyvBDsJigQe1VBfSysczNY8wMDmKWeaL2
 P6Bm0HzDuZyOfCm2jLOxp0E0G/qWxFMe8OxDxQdO+CQSvo0ucvf6Cuirem7ROQ8bHfO/
 58/GISPtxH599iJjp0Xme9ie/F4PoSL8/ktBo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762452837; x=1763057637;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=O6BJP0gak6o7I0TXFx+7IVRDvE/jKpTaAYDY/JTgl3Y=;
 b=em3qw+VsTsh7Z/Zw6FtMFD6W55cH+TysPjKo9nd1kNYmWJZza6apl3Xi7PXREwdR9C
 TsT5FBETHpCGekNoZjJbrY2gTtGsnduMiRZkcTnuQvQdL9l27w7gGrc3Hg1N0eKvigbh
 jsCm47uv8PlW0ULCIH3qQiy7oQ4tPz7S56TlBYYAM9dTG7kiGA8UHOxbug9+jhRa1+t+
 QjZUUwAueZQ8n6kOhqDmBv48XQvHrF+tsUSyRFxqAPmTJzT6kvAyfR0hrvA1t1tG2ghs
 su05ZJQN0fxa1+D9ElawlHxiCcCzKk7vdFtIkPvFE/Z4GnYVnxGaon9OrJheMgtaHmdh
 sJNQ==
X-Gm-Message-State: AOJu0YxKXHUTiF9rGykmkq6v6rMnIV9TOeb6lSWffIAFUXRxxBVdPcMi
 gNd5x7BebSdxfyU6gKzUN2MlmtJ0DHnfK38fwPDBdyH2PfyRbZc4ixOjW6nG5TbNq7U=
X-Gm-Gg: ASbGnctt5N7aqlN9GTuEbUnGYDqS1eGbW1G36eb30N1o/V76L3n5ggxEcwKvD1Qnl6S
 RdbeB0QeSpqMH7150jB9nYU3AKgfhiEr9z/82gSlIKZEBLUHUd39QzVaq+amXAUM6izmqaULzTg
 PxX9PmfbIOnhhesyny6HoHKD5dyJ0IOLtDTePi3Zs7hHPZoIiVp4MjrvelivgLZOoJgp3Xa5y9Z
 OGb/DjVAQzo6v3115IFvrgsS2OPF9w7t21poDk997jNWnUNzYv/ix/I3vrnAG9W8M3RWva17Sq+
 56hxY32/UG5WTGgGzdybfbeQTpn57tSxl/8yS8SCc9LwLHdMjyMvP/4ujSwivzoOdxtoNjOzWUq
 Tox/BE6yyodWE5U4YBxtJHUgQR/htCrph5eqz/C9rnZUTolcXc18kMw4RtNN037oCGrcEsZt00i
 mRJ9BM/DhMwslD
X-Google-Smtp-Source: AGHT+IF5NQSHP/fXykGY9AZM9nKpDNjVvIqaSrWy5rDuxsyOqce4YCy6u7dYnD8rVKgIHKxL7fLpQA==
X-Received: by 2002:a05:622a:14e:b0:4b5:e8ae:2c4f with SMTP id
 d75a77b69052e-4ed94a27723mr1927491cf.51.1762452837228; 
 Thu, 06 Nov 2025 10:13:57 -0800 (PST)
Received: from d121016.iol.unh.edu ([2606:4100:3880:1271:ac5d:4186:4dc6:47eb])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4ed813f8a7dsm21316201cf.37.2025.11.06.10.13.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Nov 2025 10:13:56 -0800 (PST)
From: Dean Marx <dmarx@iol.unh.edu>
To: probb@iol.unh.edu, luca.vizzarro@arm.com, yoan.picchi@foss.arm.com,
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com
Cc: dev@dpdk.org,
	Dean Marx <dmarx@iol.unh.edu>
Subject: [PATCH v3] dts: add test case docstring checks to format script
Date: Thu,  6 Nov 2025 13:13:55 -0500
Message-ID: <20251106181355.209706-1-dmarx@iol.unh.edu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250826200720.104443-1-dmarx@iol.unh.edu>
References: <20250826200720.104443-1-dmarx@iol.unh.edu>
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
---
 devtools/dts-check-docstrings.py | 54 ++++++++++++++++++++++++++++++++
 devtools/dts-check-format.sh     |  8 +++++
 2 files changed, 62 insertions(+)
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
index 907eed1293..f2cd5a56a1 100755
--- a/devtools/dts-check-format.sh
+++ b/devtools/dts-check-format.sh
@@ -13,6 +13,7 @@ usage() {
 format=true
 lint=true
 typecheck=true
+docstringcheck=true
 
 # Comments after args serve as documentation; must be present
 while getopts "hflt" arg; do
@@ -97,6 +98,13 @@ if $lint; then
 		echo "ruff not found, unable to run linter"
 		errors=$((errors + 1))
 	fi
+	if $docstringcheck; then
+		docstring_script_path=$(dirname "$0")
+		docstring_script_path=$(cd "$docstring_script_path" && pwd)
+		docstring_script="$docstring_script_path/dts-check-docstrings.py"
+		$docstring_script
+		errors=$((errors + $?))
+	fi
 fi
 
 if $typecheck; then
-- 
2.51.0

