Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A81CC83F27
	for <dpdk-dev@archiver.kernel.org>; Tue, 22 Jul 2025 16:38:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 70F3340269;
	Tue, 22 Jul 2025 18:38:57 +0200 (CEST)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 7B1024003C
 for <dev@dpdk.org>; Tue, 22 Jul 2025 18:38:56 +0200 (CEST)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id C80D7212689D; Tue, 22 Jul 2025 09:38:55 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C80D7212689D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1753202335;
 bh=rfZbFVVysNNnLk0E9aLNw7OfMkUdtRhcrDYhju9th/0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=k1nlZ9vTiU5m+sghQP3ZLSAP9qQpJNCHbaIw5tFAK+APnhexmIAbDJDJDaR9lF+qK
 QsZ+JgGo4s1/kkqMKzzmqkbUk8TNKE2xLotm2BkdB+HR/5zVVkUEzOuKfEb4UfmSVM
 YC3xYrVmws+Y0lEiKXrQttm0kq/on1qzK9mmNGsk=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: andremue@linux.microsoft.com
Cc: dev@dpdk.org,
	dmitry.kozliuk@gmail.com,
	roretzla@linux.microsoft.com
Subject: [PATCH v3 1/2] eal: add strsep() for Windows builds
Date: Tue, 22 Jul 2025 09:38:53 -0700
Message-Id: <1753202334-27615-1-git-send-email-andremue@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1747401734-6303-1-git-send-email-andremue@linux.microsoft.com>
References: <1747401734-6303-1-git-send-email-andremue@linux.microsoft.com>
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

Function strsep() is used by DPDK code but is not available on Windows.

This patch adds an implementation from NetBSD, unblocking code depending
on it from being compiled on Windows.

Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
---
 lib/eal/windows/include/rte_os_shim.h |  1 +
 lib/eal/windows/include/strsep.h      | 12 +++++++
 lib/eal/windows/meson.build           |  1 +
 lib/eal/windows/strsep.c              | 47 +++++++++++++++++++++++++++
 4 files changed, 61 insertions(+)
 create mode 100644 lib/eal/windows/include/strsep.h
 create mode 100644 lib/eal/windows/strsep.c

diff --git a/lib/eal/windows/include/rte_os_shim.h b/lib/eal/windows/include/rte_os_shim.h
index 0e74eb19c7..9c3da554da 100644
--- a/lib/eal/windows/include/rte_os_shim.h
+++ b/lib/eal/windows/include/rte_os_shim.h
@@ -7,6 +7,7 @@
 
 #include <rte_os.h>
 #include <rte_windows.h>
+#include <strsep.h>
 
 /**
  * @file
diff --git a/lib/eal/windows/include/strsep.h b/lib/eal/windows/include/strsep.h
new file mode 100644
index 0000000000..1ff93f8cd0
--- /dev/null
+++ b/lib/eal/windows/include/strsep.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (c) 1990, 1993
+ * The Regents of the University of California.  All rights reserved.
+ */
+
+#ifndef _STRSEP_
+#define _STRSEP_
+
+char *
+strsep(char **stringp, const char *delim);
+
+#endif
diff --git a/lib/eal/windows/meson.build b/lib/eal/windows/meson.build
index c526ede405..b7c880d6b7 100644
--- a/lib/eal/windows/meson.build
+++ b/lib/eal/windows/meson.build
@@ -20,6 +20,7 @@ sources += files(
         'getline.c',
         'getopt.c',
         'rte_thread.c',
+        'strsep.c',
 )
 
 dpdk_conf.set10('RTE_EAL_NUMA_AWARE_HUGEPAGES', true)
diff --git a/lib/eal/windows/strsep.c b/lib/eal/windows/strsep.c
new file mode 100644
index 0000000000..fdc0688a07
--- /dev/null
+++ b/lib/eal/windows/strsep.c
@@ -0,0 +1,47 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (c) 1990, 1993
+ * The Regents of the University of California.  All rights reserved.
+ */
+
+#include <string.h>
+
+#include "strsep.h"
+
+/* Get next token from string *stringp, where tokens are possibly empty
+ * strings separated by characters from delim.
+ *
+ * Writes NULLs into the string at *stringp to end tokens.
+ * delim need not remain constant from call to call.
+ * On return, *stringp points past the last NULL written (if there might
+ * be further tokens), or is NULL (if there are definitely no more tokens).
+ *
+ * If *stringp is NULL, strsep returns NULL.
+ */
+char *
+strsep(char **stringp, const char *delim)
+{
+	char *s;
+	const char *spanp;
+	int c, sc;
+	char *tok;
+
+	s = *stringp;
+	if (s == NULL)
+		return NULL;
+	for (tok = s;;) {
+		c = *s++;
+		spanp = delim;
+		do {
+			sc = *spanp++;
+			if (sc == c) {
+				if (c == 0)
+					s = NULL;
+				else
+					s[-1] = 0;
+				*stringp = s;
+				return tok;
+			}
+		} while (sc != 0);
+	}
+	/* NOTREACHED */
+}
-- 
2.50.1.vfs.0.0

