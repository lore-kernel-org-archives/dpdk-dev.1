Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 273EACA0FE7
	for <dpdk-dev@archiver.kernel.org>; Tue, 26 Aug 2025 20:07:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E18D8402D6;
	Tue, 26 Aug 2025 22:07:25 +0200 (CEST)
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com
 [209.85.222.177])
 by mails.dpdk.org (Postfix) with ESMTP id 45A454029E
 for <dev@dpdk.org>; Tue, 26 Aug 2025 22:07:24 +0200 (CEST)
Received: by mail-qk1-f177.google.com with SMTP id
 af79cd13be357-7f74b42ec59so5903085a.2
 for <dev@dpdk.org>; Tue, 26 Aug 2025 13:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1756238843; x=1756843643; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XFIz12UkdHjYHkxg9dPutjasbzfhOegq/eLysmwDSKQ=;
 b=O22oFP910wDGh1xIXpIy1uiFL7sJi+87lqIzuDUmWgIhKVtDCbsJ7uZu9R6QmbD5qs
 Ff+9TkHUOVD3l5lRioDKOns26PaQBgfmfIuzfg4p+o2IYip0/YKUCb3I5P8xd7UDF30+
 BokfPfImqUgK6upt/Ggufe/dOJkkv9nU/WjQo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756238843; x=1756843643;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XFIz12UkdHjYHkxg9dPutjasbzfhOegq/eLysmwDSKQ=;
 b=XJDSQeVfKeVi9b4Mh//ygVuxFvSeIJHaB9RJWcTOx9XhZKJMmxV5G/kJBQ7ubc1M/r
 fdTsgTe4tOi5QbtA+H8SmAAmHeA6u3N08zCY/QCf7mCo7ksYzyLK/OHROdgJizqppU7J
 wOLQQ9LX9++JItFcctpFsF6fvVOQq1rFqoh9bRky6fyOk4aDwD1dkm34h957KWRyE2ue
 CHBZyFFsfDlupsRXk+JxxN0Ys7yiMK+E36E95Z+TzZX7GN6pHfd4VMY9ADOhCwnmXBw4
 Ggqv4Xanp7RgkkRPDd3TfRyt3beYl9DCriM/lYuAqOs6jPhz/SrI4qJxHOzhDctpu4EF
 fcdg==
X-Gm-Message-State: AOJu0YxJg7CJfPJ4cG3EKPNl1kv1nFvTBN0iQhKGEAQ638g257YzZFjU
 kCsWNa4qveAcmjkL8PzlH8vrBEHoqtVrEJ26yKny4V4aybOWLrtJM18k7lMcJ2DYJ18=
X-Gm-Gg: ASbGnctD1CGS7IsfYEz2lv98skZg+eWjxOBVbSZasij77Ns6yfMAm/2A3dzSEiEkdYu
 K7vQ6TLyhg0EQRQ7yBB5FMXy4vyc0EMjUIe2IugoGUiUzLLEzrYPlRTXUdIDtdW+RLjNLCNYiOD
 ad12oOs72xv+X0nE9TGd49R9RN4tKUIEjYA8mPUbzRB/klzd2ubb8LVPGFUW2DjnFN1fRkh5SQy
 7aigJwz2HQKw9k2ChjJFH3jmAuxbMV/57/z4NMelUNrBHIB1LUs4qLARuGQqvf3xMboOjjQWpJm
 Ek+f2NrIsJHELkOu6JsicLCsbqhOVhqVaCBA05l7cztk/irbnhCyvTLj8v2MRkI0BGgPh8jREMw
 WSNvrJUC2EHWdug==
X-Google-Smtp-Source: AGHT+IHfK/Br43hBW7dpqiMwKXwySVGtPqOlSlovPCo6hy2OS+2K2McP1sLlIM/XqgraKKW+VluX0w==
X-Received: by 2002:a05:620a:410b:b0:7e6:8bd4:8c70 with SMTP id
 af79cd13be357-7ea1104715cmr2052286585a.44.1756238843411; 
 Tue, 26 Aug 2025 13:07:23 -0700 (PDT)
Received: from d121016.iol.unh.edu ([2606:4100:3880:1210::202])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7f07c87a894sm484669185a.25.2025.08.26.13.07.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Aug 2025 13:07:22 -0700 (PDT)
From: Dean Marx <dmarx@iol.unh.edu>
To: probb@iol.unh.edu, luca.vizzarro@arm.com, yoan.picchi@foss.arm.com,
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com
Cc: dev@dpdk.org,
	Dean Marx <dmarx@iol.unh.edu>
Subject: [PATCH v2] dts: add test case docstring checks to format script
Date: Tue, 26 Aug 2025 16:07:20 -0400
Message-ID: <20250826200720.104443-1-dmarx@iol.unh.edu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250820193815.61078-1-dmarx@iol.unh.edu>
References: <20250820193815.61078-1-dmarx@iol.unh.edu>
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
 devtools/dts-check-docstrings.py | 52 ++++++++++++++++++++++++++++++++
 devtools/dts-check-format.sh     |  7 +++++
 2 files changed, 59 insertions(+)
 create mode 100755 devtools/dts-check-docstrings.py

diff --git a/devtools/dts-check-docstrings.py b/devtools/dts-check-docstrings.py
new file mode 100755
index 0000000000..0baee6e383
--- /dev/null
+++ b/devtools/dts-check-docstrings.py
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
index 907eed1293..da6e6f34ee 100755
--- a/devtools/dts-check-format.sh
+++ b/devtools/dts-check-format.sh
@@ -86,7 +86,14 @@ if $lint; then
 		ruff check --fix
 		errors=$((errors + $?))
 
+		docstring_script_path=$(dirname "$0")
+		docstring_script_path=$(cd "$docstring_script_path" && pwd)
+		docstring_script="$docstring_script_path/dts-check-docstrings.py"
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

