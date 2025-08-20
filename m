Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1ECFCA0EDC
	for <dpdk-dev@archiver.kernel.org>; Wed, 20 Aug 2025 19:38:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 85B1540292;
	Wed, 20 Aug 2025 21:38:22 +0200 (CEST)
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com
 [209.85.222.182])
 by mails.dpdk.org (Postfix) with ESMTP id C7FCB4026C
 for <dev@dpdk.org>; Wed, 20 Aug 2025 21:38:21 +0200 (CEST)
Received: by mail-qk1-f182.google.com with SMTP id
 af79cd13be357-7e87031f560so31785285a.0
 for <dev@dpdk.org>; Wed, 20 Aug 2025 12:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1755718701; x=1756323501; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=1BuYv9v5gIwxoziMjk3+cWCGwb89n7Opjm1HZEK1zKA=;
 b=cnV57ioA4YuuXF/hUB8NCLPuSP5oq4JW2pEpzTwwGAIhYF5EiueAPiOQk2a8ooP62f
 6a+04cCaPL5WOcApxwy/iwy4GPf1JpoB/VTJIlDYu/X+2rKMBF5BvH0WX19L23t2DRzO
 16jxRbnbXHPuULDJiztcnLI9mHPLndUUh9ZNI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755718701; x=1756323501;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1BuYv9v5gIwxoziMjk3+cWCGwb89n7Opjm1HZEK1zKA=;
 b=ipsFTgSxUQA09h3cM5FkNZjk3b0uaPWmCqkoS+87mmE7WdrYf9cCVt5DGiKtiWVCL2
 u3K+jVO4aY5n1rOysIaNWfKkNv4Vu2WUstxXFBWl6KIoAlGxdR7HMSZCsEm4P24fLwEh
 oR7FpPDpcfG42fQsi5PTBpZKFlLUyYEZ8uQsXlT0BQeV3RzYb+TaVk4dUkBT+kS4014L
 bzqWcO3g36K6aWkokLW8QHNAY4J212o/BzS+qbYkyfZ3o7tQhCJVdxfM9kgBDPj8Hvq2
 VM1FYx2m2DADJY2li4vGDV1lUWEHCCkh/sPz1gE5waGO4YFlhHLj0LborSeGypvwC+FV
 VOvw==
X-Gm-Message-State: AOJu0YyLNZKouZ7GvWu8gEJm66IXbOh8/6HIp5OgI4dH1dxmuqi5E1zv
 HHa9JX4bpOr5mJ4VfwaC8AmJVuZuIVY0Zs2RRQmkfo3B1Unn/9HeLLePjl3zK9AVO3M=
X-Gm-Gg: ASbGnctMCpXhEQwhx8UxhqtJ7OZZ5ghutTXLzNNm9catrJ8GXH3GJvC/cj3M+zVS8Ib
 cdtBG1JCP4rpa7AX5a4hLg4BPwW6t2S0ZWjDVd7fgqcupC/kHhw2zqmEu6BXQsAPN+W+VcJYlY8
 VnvGZTSOfYuzDhmAD/07vcTqpJeBdPxXMnT2FTLzAFMOKPZYUbBSjsh4YaB7ehJkzHC2ltf9Hjo
 t7XRAKF1Qjuw+XuioHmQWpHN/4J78CfIc74h7MUFtBPEK6VGmj7Bhw0YTpUgniz2VZMZ2bJpJFC
 wYem17Ce3tkRV7wxTQNZ2LepH1nwKbv/ycARZj27eMTVd3XeYqYhcwvgH1+SBqFpK8pO6osvAJb
 OXReBn5cQVJeH+Q==
X-Google-Smtp-Source: AGHT+IGJXQKO3yq2SG780c/KJIGTa23mVgmk+F3O9h5/8iY8fwt2fkGobvbIJJ31JD4iWKD6qB4fHw==
X-Received: by 2002:a05:620a:198a:b0:7db:9b82:1276 with SMTP id
 af79cd13be357-7e9fcadf0c0mr578339185a.22.1755718697579; 
 Wed, 20 Aug 2025 12:38:17 -0700 (PDT)
Received: from d121016.iol.unh.edu ([2606:4100:3880:1210::202])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7e87e1c56e9sm979666885a.67.2025.08.20.12.38.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Aug 2025 12:38:17 -0700 (PDT)
From: Dean Marx <dmarx@iol.unh.edu>
To: probb@iol.unh.edu, luca.vizzarro@arm.com, yoan.picchi@foss.arm.com,
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com
Cc: dev@dpdk.org,
	Dean Marx <dmarx@iol.unh.edu>
Subject: [PATCH v1] dts: add test case docstring checks to format script
Date: Wed, 20 Aug 2025 15:38:15 -0400
Message-ID: <20250820193815.61078-1-dmarx@iol.unh.edu>
X-Mailer: git-send-email 2.50.1
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
 devtools/check-docstrings.py | 52 ++++++++++++++++++++++++++++++++++++
 devtools/dts-check-format.sh |  7 +++++
 2 files changed, 59 insertions(+)
 create mode 100755 devtools/check-docstrings.py

diff --git a/devtools/check-docstrings.py b/devtools/check-docstrings.py
new file mode 100755
index 0000000000..0baee6e383
--- /dev/null
+++ b/devtools/check-docstrings.py
@@ -0,0 +1,52 @@
+# SPDX-License-Identifier: BSD-3-Clause
+# Copyright(c) 2025 University of New Hampshire
+
+import sys
+from ast import FunctionDef, Name, walk, get_docstring, parse
+from pathlib import Path
+
+BASE_DIR = Path(__file__).resolve().parent  # dpdk/
+TESTS_DIR = BASE_DIR.parent / "dts" / "tests"  # dts/tests/
+
+
+def has_test_decorator(node: FunctionDef) -> bool:
+    """Return True if function has @func_test or @perf_test decorator."""
+    for decorator in node.decorator_list:
+        if isinstance(decorator, Name) and decorator.id in {"func_test", "perf_test"}:
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
index 907eed1293..5f93a11a16 100755
--- a/devtools/dts-check-format.sh
+++ b/devtools/dts-check-format.sh
@@ -86,7 +86,14 @@ if $lint; then
 		ruff check --fix
 		errors=$((errors + $?))
 
+		docstring_script_path=$(dirname "$0")
+		docstring_script_path=$(cd "$docstring_script_path" && pwd)
+		docstring_script="$docstring_script_path/check-docstrings.py"
+		python "$docstring_script"
+		errors=$((errors + $?))
+
 		git update-index --refresh
+
 		retval=$?
 		if [ $retval -ne 0 ]; then
 			echo 'The "needs update" files have been fixed by the linter.'
-- 
2.50.1

