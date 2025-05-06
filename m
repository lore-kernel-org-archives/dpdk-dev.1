Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC105C3ABB6
	for <dpdk-dev@archiver.kernel.org>; Tue,  6 May 2025 01:43:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 722654025D;
	Tue,  6 May 2025 03:43:18 +0200 (CEST)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 79EA74003C
 for <dev@dpdk.org>; Tue,  6 May 2025 03:43:16 +0200 (CEST)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 71E6E2115DC2; Mon,  5 May 2025 18:43:15 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 71E6E2115DC2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1746495795;
 bh=xuta9sPuBvI9ksyQlp68fPXGtCdoJLR9/bQuCiwUups=;
 h=From:To:Cc:Subject:Date:From;
 b=h6yJRaqgpcUhEwduVtlhRbiQvlAAPvOGAH3Gdm5JwwaFSS8At/dKDXcb0OlzdNxN9
 o3vstiIf7kxiAM6ENKQwr9qhYw+rC2A72swcSoIGko78+XGJRk+GT2lIBMEfMtkc5J
 hkiXldbk6yR2qx2FbQGQQ4moimawPKahE7dWNk/A=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>,
 Tyler Retzlaff <roretzla@linux.microsoft.com>,
 Thomas Monjalon <thomas@monjalon.net>
Cc: dev@dpdk.org,
	Andre Muezerie <andremue@linux.microsoft.com>
Subject: [PATCH] eal: add asprintf() function for Windows
Date: Mon,  5 May 2025 18:43:09 -0700
Message-Id: <1746495789-14101-1-git-send-email-andremue@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
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

The asprintf function is not part of the C standard library but is a
GNU extension commonly available in Unix-like systems. It dynamically
allocates memory to store the formatted output string, similar to
sprintf, but avoids buffer overflow issues by automatically sizing
the buffer.

Instead of rewriting it or coming up with some other replacement, this
patch makes use of the implementation provided by Neved4.

Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
---
 lib/eal/windows/asprintf.c         | 48 ++++++++++++++++++++++++++++++
 lib/eal/windows/include/asprintf.h | 21 +++++++++++++
 lib/eal/windows/meson.build        |  1 +
 license/exceptions.txt             |  2 ++
 4 files changed, 72 insertions(+)
 create mode 100644 lib/eal/windows/asprintf.c
 create mode 100644 lib/eal/windows/include/asprintf.h

diff --git a/lib/eal/windows/asprintf.c b/lib/eal/windows/asprintf.c
new file mode 100644
index 0000000000..6ebc9d0f0a
--- /dev/null
+++ b/lib/eal/windows/asprintf.c
@@ -0,0 +1,48 @@
+/* SPDX-License-Identifier: MIT
+ * Copyright(C) 2023 - 2025 Neved4
+ * https://github.com/Neved4/asprintf/tree/main
+ */
+
+#include <stdio.h>
+#include <stdlib.h>
+
+#include "asprintf.h"
+
+#ifndef RTE_TOOLCHAIN_GCC
+int vasprintf(char **strp, const char *fmt, va_list ap)
+{
+	int size, res;
+	va_list cp;
+
+	va_copy(cp, ap);
+	size = vsnprintf(NULL, 0, fmt, cp);
+	va_end(cp);
+
+	if (size < 0)
+		return -1;
+
+	*strp = malloc(size + 1);
+	if (*strp == NULL)
+		return -1;
+
+	res = vsnprintf(*strp, size + 1, fmt, ap);
+	if (res < 0) {
+		free(*strp);
+		return -1;
+	}
+
+	return res;
+}
+
+int asprintf(char **s, const char *fmt, ...)
+{
+	int ret;
+	va_list ap;
+
+	va_start(ap, fmt);
+	ret = vasprintf(s, fmt, ap);
+	va_end(ap);
+
+	return ret;
+}
+#endif
diff --git a/lib/eal/windows/include/asprintf.h b/lib/eal/windows/include/asprintf.h
new file mode 100644
index 0000000000..36d052b808
--- /dev/null
+++ b/lib/eal/windows/include/asprintf.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: MIT
+ * Copyright(C) 2023 - 2025 Neved4
+ * https://github.com/Neved4/asprintf/tree/main
+ */
+
+/**
+ * @file
+ * asprintf compat.
+ *
+ * This module provides asprintf() and vasprintf().
+ */
+
+#pragma once
+
+#include <stdarg.h>
+
+#ifndef RTE_TOOLCHAIN_GCC
+int vasprintf(char **strp, const char *fmt, va_list ap);
+
+int asprintf(char **s, const char *fmt, ...);
+#endif
diff --git a/lib/eal/windows/meson.build b/lib/eal/windows/meson.build
index 7756d417be..06b25a3a09 100644
--- a/lib/eal/windows/meson.build
+++ b/lib/eal/windows/meson.build
@@ -4,6 +4,7 @@
 subdir('include')
 
 sources += files(
+        'asprintf.c',
         'eal.c',
         'eal_alarm.c',
         'eal_debug.c',
diff --git a/license/exceptions.txt b/license/exceptions.txt
index d12fac2034..5ea0de5308 100644
--- a/license/exceptions.txt
+++ b/license/exceptions.txt
@@ -16,4 +16,6 @@ MIT                  | 10/23/2019       | 02/10/2020       | lib/eal/windows/inc
 BSD-2-Clause         | 10/23/2019       | 12/18/2019       | lib/eal/windows/include/getopt.h
 ISC AND BSD-2-Clause | 10/23/2019       | 12/18/2019       | lib/eal/windows/getopt.c
 MIT                  | 10/19/2022       | 10/18/2022       | drivers/net/gve/base/*
+MIT                  | XX/XX/XXXX       | XX/XX/XXXX       | lib/eal/windows/include/asprintf.h
+MIT                  | XX/XX/XXXX       | XX/XX/XXXX       | lib/eal/windows/asprintf.c
 ---------------------------------------------------------------------------------------------------
-- 
2.49.0.vfs.0.2

