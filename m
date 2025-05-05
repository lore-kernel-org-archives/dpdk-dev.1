Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A36B3C3ABB6
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 May 2025 20:40:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 91A764025D;
	Mon,  5 May 2025 22:40:21 +0200 (CEST)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 12FD64003C
 for <dev@dpdk.org>; Mon,  5 May 2025 22:40:20 +0200 (CEST)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id E9DA72115DBD; Mon,  5 May 2025 13:40:18 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E9DA72115DBD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1746477618;
 bh=iIIFiy0G25LZKeA96vSLXzFcbjwrSm8IoQgbDA1R1FQ=;
 h=From:To:Cc:Subject:Date:From;
 b=dxAUE1h8tVU7Qv8L9v16IUUuIpMXPefoSjffa89aW2aJTIyYWExxqXdQyLPXBqfxv
 S8GDZsqElvf8ZYNCTUZmFpRKtnixnnccl2AtCEHIOh7lo1wa4K3kgzGKBHumilQDxj
 +iOGpZcPeapYgeem67IMqbh7vVUDc6DDqeQLiX+M=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>,
 Tyler Retzlaff <roretzla@linux.microsoft.com>,
 Thomas Monjalon <thomas@monjalon.net>
Cc: dev@dpdk.org,
	Andre Muezerie <andremue@linux.microsoft.com>
Subject: [PATCH] eal: add getline() function for Windows
Date: Mon,  5 May 2025 13:40:07 -0700
Message-Id: <1746477607-14961-1-git-send-email-andremue@linux.microsoft.com>
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

Existing DPDK code uses getline(), which is a POSIX function and is
not available in the Windows APIs.

Instead of rewriting it or coming up with some other replacement, this
patch makes use of the implementation provided by NetBSD to make it
possible to compile code dependent on getline on Windows.

Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
---
 lib/eal/windows/getline.c         | 61 +++++++++++++++++++++++++++++++
 lib/eal/windows/include/getline.h | 28 ++++++++++++++
 lib/eal/windows/meson.build       |  1 +
 license/exceptions.txt            |  2 +
 4 files changed, 92 insertions(+)
 create mode 100644 lib/eal/windows/getline.c
 create mode 100644 lib/eal/windows/include/getline.h

diff --git a/lib/eal/windows/getline.c b/lib/eal/windows/getline.c
new file mode 100644
index 0000000000..955452b50e
--- /dev/null
+++ b/lib/eal/windows/getline.c
@@ -0,0 +1,61 @@
+/* SPDX-License-Identifier: BSD-2-Clause
+ * Copyright (c) 2011 The NetBSD Foundation, Inc.
+ * All rights reserved.
+ *
+ * This code is derived from software contributed to The NetBSD Foundation
+ * by Christos Zoulas.
+ */
+
+#include <malloc.h>
+
+#include "getline.h"
+
+ssize_t
+getdelim(char **buf, size_t *bufsiz, int delimiter, FILE *fp)
+{
+	char *ptr, *eptr;
+
+	if (*buf == NULL || *bufsiz == 0) {
+		*bufsiz = BUFSIZ;
+		*buf = malloc(*bufsiz);
+		if (buf == NULL)
+			return -1;
+	}
+
+	for (ptr = *buf, eptr = *buf + *bufsiz;;) {
+		int c = fgetc(fp);
+		if (c == -1) {
+			if (feof(fp)) {
+				ssize_t diff = (ssize_t)(ptr - *buf);
+				if (diff != 0) {
+					*ptr = '\0';
+					return diff;
+				}
+			}
+			return -1;
+		}
+		*ptr++ = c;
+		if (c == delimiter) {
+			*ptr = '\0';
+			return ptr - *buf;
+		}
+		if (ptr + 2 >= eptr) {
+			char *nbuf;
+			size_t nbufsiz = *bufsiz * 2;
+			ssize_t d = ptr - *buf;
+			nbuf = realloc(*buf, nbufsiz);
+			if (nbuf == NULL)
+				return -1;
+			*buf = nbuf;
+			*bufsiz = nbufsiz;
+			eptr = nbuf + nbufsiz;
+			ptr = nbuf + d;
+		}
+	}
+}
+
+ssize_t
+getline(char **buf, size_t *bufsiz, FILE *fp)
+{
+	return getdelim(buf, bufsiz, '\n', fp);
+}
diff --git a/lib/eal/windows/include/getline.h b/lib/eal/windows/include/getline.h
new file mode 100644
index 0000000000..2931ce2a02
--- /dev/null
+++ b/lib/eal/windows/include/getline.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: BSD-2-Clause
+ * Copyright (c) 2011 The NetBSD Foundation, Inc.
+ * All rights reserved.
+ *
+ * This code is derived from software contributed to The NetBSD Foundation
+ * by Christos Zoulas.
+ */
+
+/**
+ * @file
+ * getline compat.
+ *
+ * This module provides getline() and getdelim().
+ */
+
+#pragma once
+
+#include <stdio.h>
+
+#ifndef ssize_t
+#define ssize_t ptrdiff_t
+#endif
+
+ssize_t
+getdelim(char **buf, size_t *bufsiz, int delimiter, FILE *fp);
+
+ssize_t
+getline(char **buf, size_t *bufsiz, FILE *fp);
diff --git a/lib/eal/windows/meson.build b/lib/eal/windows/meson.build
index 7756d417be..c526ede405 100644
--- a/lib/eal/windows/meson.build
+++ b/lib/eal/windows/meson.build
@@ -17,6 +17,7 @@ sources += files(
         'eal_mp.c',
         'eal_thread.c',
         'eal_timer.c',
+        'getline.c',
         'getopt.c',
         'rte_thread.c',
 )
diff --git a/license/exceptions.txt b/license/exceptions.txt
index d12fac2034..2785a4f335 100644
--- a/license/exceptions.txt
+++ b/license/exceptions.txt
@@ -16,4 +16,6 @@ MIT                  | 10/23/2019       | 02/10/2020       | lib/eal/windows/inc
 BSD-2-Clause         | 10/23/2019       | 12/18/2019       | lib/eal/windows/include/getopt.h
 ISC AND BSD-2-Clause | 10/23/2019       | 12/18/2019       | lib/eal/windows/getopt.c
 MIT                  | 10/19/2022       | 10/18/2022       | drivers/net/gve/base/*
+BSD-2-Clause         | XX/XX/XXXX       | XX/XX/XXXX       | lib/eal/windows/include/getline.h
+BSD-2-Clause         | XX/XX/XXXX       | XX/XX/XXXX       | lib/eal/windows/getline.c
 ---------------------------------------------------------------------------------------------------
-- 
2.49.0.vfs.0.0

