Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B2AEC282EC
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Mar 2025 15:33:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8C904402E6;
	Tue, 11 Mar 2025 16:33:30 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id DFAB740263
 for <dev@dpdk.org>; Tue, 11 Mar 2025 16:33:27 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 35BFC2111430; Tue, 11 Mar 2025 08:33:27 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 35BFC2111430
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1741707207;
 bh=z6fRILFr2SP0KfK3DrbR/Q3nGSkmip4pal9t84zMDZQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=qUP+6bmmMHlA6VCgLU1wnYUlSa3JBv9tfLcwNM6ZdBslGHppHbSpVsqCucZ4bzsHi
 DNERenrFdUbCYA26c1eFtiP483ISimlGJzKpWIfpEDJgG1RE/pjGmX3ztO5Lrxtuou
 y99ZkmaKkYOyB1Pv9WPYlvyXQR9/RvLEQbvSYRig=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: andremue@linux.microsoft.com
Cc: bruce.richardson@intel.com, dev@dpdk.org, sameh.gobriel@intel.com,
 vladimir.medvedkin@intel.com, yipeng1.wang@intel.com
Subject: [PATCH v2 1/3] eal: add function rte_size_to_str
Date: Tue, 11 Mar 2025 08:33:13 -0700
Message-Id: <1741707195-26880-1-git-send-email-andremue@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1741291408-26509-1-git-send-email-andremue@linux.microsoft.com>
References: <1741291408-26509-1-git-send-email-andremue@linux.microsoft.com>
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

It's common to use %' in the printf format specifier to make large numbers
more easily readable by having the thousands grouped. However, this
grouping does not work on Windows. Therefore, a function is needed to make
uint64_t numbers more easily readable. There are at least two tests that
can benefit from this new function.

Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
---
 lib/eal/common/eal_common_string_fns.c | 44 ++++++++++++++++++++++++++
 lib/eal/include/rte_common.h           | 21 ++++++++++++
 2 files changed, 65 insertions(+)

diff --git a/lib/eal/common/eal_common_string_fns.c b/lib/eal/common/eal_common_string_fns.c
index 9ca2045b18..b658d68eac 100644
--- a/lib/eal/common/eal_common_string_fns.c
+++ b/lib/eal/common/eal_common_string_fns.c
@@ -4,6 +4,7 @@
 
 #include <ctype.h>
 #include <errno.h>
+#include <inttypes.h>
 #include <stdio.h>
 #include <stdlib.h>
 
@@ -87,6 +88,12 @@ rte_str_to_size(const char *str)
 		endptr++; /* allow 1 space gap */
 
 	switch (*endptr) {
+	case 'E': case 'e':
+		size *= 1024; /* fall-through */
+	case 'P': case 'p':
+		size *= 1024; /* fall-through */
+	case 'T': case 't':
+		size *= 1024; /* fall-through */
 	case 'G': case 'g':
 		size *= 1024; /* fall-through */
 	case 'M': case 'm':
@@ -98,3 +105,40 @@ rte_str_to_size(const char *str)
 	}
 	return size;
 }
+
+int
+rte_size_to_str(char *buf, int buf_size,
+		uint64_t count, bool use_iec)
+{
+	const char *prefix = "kMGTPE";
+	const unsigned int base = use_iec ? 1024 : 1000;
+	uint64_t powi = 1;
+	uint16_t powj = 1;
+	uint8_t precision = 2;
+
+	if (count < base)
+		return snprintf(buf, buf_size, "%"PRIu64" ", count);
+
+	/* increase value by a factor of 1000/1024 and store
+	 * if result is something a human can read
+	 */
+	for (;;) {
+		powi *= base;
+		if (count / base < powi)
+			break;
+
+		if (!prefix[1])
+			break;
+		++prefix;
+	}
+
+	/* try to guess a good number of digits for precision */
+	for (; precision > 0; precision--) {
+		powj *= 10;
+		if (count / powi < powj)
+			break;
+	}
+
+	return snprintf(buf, buf_size, "%.*f%c%s", precision,
+			(double)count / powi, *prefix, use_iec ? "i" : "");
+}
diff --git a/lib/eal/include/rte_common.h b/lib/eal/include/rte_common.h
index 386f11ae40..81fa4d3c34 100644
--- a/lib/eal/include/rte_common.h
+++ b/lib/eal/include/rte_common.h
@@ -14,6 +14,7 @@
 
 #include <assert.h>
 #include <limits.h>
+#include <stdbool.h>
 #include <stdint.h>
 #include <stdalign.h>
 
@@ -919,6 +920,26 @@ __extension__ typedef uint64_t RTE_MARKER64[0];
 uint64_t
 rte_str_to_size(const char *str);
 
+/**
+ * Converts the uint64_t value provided to a human-readable string.
+ * It null-terminates the string, truncating the data if needed.
+ *
+ * @param buf
+ *     Buffer to write the string to.
+ * @param buf_size
+ *     Size of the buffer.
+ * @param count
+ *     Number to convert.
+ * @param use_iec
+ *     If true, use IEC units (1024-based), otherwise use SI units (1000-based).
+ * @return
+ *     Number of characters written (not including the null-terminator),
+ *     or that would have been required when the buffer is too small.
+ */
+int
+rte_size_to_str(char *buf, int buf_size,
+		uint64_t count, bool use_iec);
+
 /**
  * Function to terminate the application immediately, printing an error
  * message and returning the exit_code back to the shell.
-- 
2.48.1.vfs.0.1

