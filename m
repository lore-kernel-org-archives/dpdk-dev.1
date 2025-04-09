Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AACEC369A2
	for <dpdk-dev@archiver.kernel.org>; Wed,  9 Apr 2025 01:21:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B33C84060F;
	Wed,  9 Apr 2025 03:21:08 +0200 (CEST)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id B5A5840265
 for <dev@dpdk.org>; Wed,  9 Apr 2025 03:21:04 +0200 (CEST)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 103802113E99; Tue,  8 Apr 2025 18:21:03 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 103802113E99
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1744161664;
 bh=4Q+OWuiXApGPk6w3MQEaMaVqeKM8XGmU8PLcDdokxco=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=kRziQCf2By/mvmXPnB0mq5SOkSHCt6VjkEk6KLiAJSuOkZqNMF5T/xxhxI2TK79wH
 vmS5Wdb/hC74MW1pAYZaIyEn2Ol+Sn6Kz47iLPRwsKl2AB2w8uzumH0RxjokGTPm5p
 MIf/IrK7/atHMhN/IFhgHYj324JYQJ09panlt0FY=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: andremue@linux.microsoft.com
Cc: bruce.richardson@intel.com, dev@dpdk.org, sameh.gobriel@intel.com,
 vladimir.medvedkin@intel.com, yipeng1.wang@intel.com
Subject: [PATCH v5 1/3] eal: add function rte_size_to_str
Date: Tue,  8 Apr 2025 18:20:56 -0700
Message-Id: <1744161658-7874-2-git-send-email-andremue@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1744161658-7874-1-git-send-email-andremue@linux.microsoft.com>
References: <1741291408-26509-1-git-send-email-andremue@linux.microsoft.com>
 <1744161658-7874-1-git-send-email-andremue@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

It's common to use %' in the printf format specifier to make large numbers
more easily readable by having the thousands grouped. However, this
grouping does not work on Windows. Therefore, a function is needed to make
uint64_t numbers more easily readable. There are at least two tests that
can benefit from this new function.

Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
Acked-by: Morten Brørup <mb@smartsharesystems.com>
---
 lib/eal/common/eal_common_string_fns.c | 54 ++++++++++++++++++++++++++
 lib/eal/include/rte_common.h           | 34 ++++++++++++++++
 2 files changed, 88 insertions(+)

diff --git a/lib/eal/common/eal_common_string_fns.c b/lib/eal/common/eal_common_string_fns.c
index 020603fe8b..ec17382487 100644
--- a/lib/eal/common/eal_common_string_fns.c
+++ b/lib/eal/common/eal_common_string_fns.c
@@ -4,6 +4,7 @@
 
 #include <ctype.h>
 #include <errno.h>
+#include <inttypes.h>
 #include <stdio.h>
 #include <stdlib.h>
 
@@ -91,6 +92,12 @@ rte_str_to_size(const char *str)
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
@@ -102,3 +109,50 @@ rte_str_to_size(const char *str)
 	}
 	return size;
 }
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_size_to_str, 25.07)
+char*
+rte_size_to_str(char *buf, int buf_size, uint64_t count, bool use_iec, const char *unit)
+{
+	/* https://en.wikipedia.org/wiki/International_System_of_Units */
+	const char *prefix = "kMGTPE";
+	const unsigned int base = use_iec ? 1024 : 1000;
+	uint64_t powi = 1;
+	uint16_t powj = 1;
+	uint8_t precision = 2;
+	int result;
+
+	if (count < base) {
+		if (unit != NULL && *unit != '\0')
+			result = snprintf(buf, buf_size, "%"PRIu64" %s", count, unit);
+		else
+			result = snprintf(buf, buf_size, "%"PRIu64, count);
+
+		return result < buf_size ? buf : NULL;
+	}
+
+	/* increase value by a factor of 1000/1024 and store
+	 * if result is something a human can read
+	 */
+	for (;;) {
+		powi *= base;
+		if (count / powi < base)
+			break;
+
+		if (prefix[1] == '\0')
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
+	result = snprintf(buf, buf_size, "%.*f %c%s%s", precision,
+			  (double)count / powi, *prefix, use_iec ? "i" : "",
+			  (unit != NULL) ? unit : "");
+	return result < buf_size ? buf : NULL;
+}
diff --git a/lib/eal/include/rte_common.h b/lib/eal/include/rte_common.h
index 386f11ae40..a6085dce27 100644
--- a/lib/eal/include/rte_common.h
+++ b/lib/eal/include/rte_common.h
@@ -14,9 +14,11 @@
 
 #include <assert.h>
 #include <limits.h>
+#include <stdbool.h>
 #include <stdint.h>
 #include <stdalign.h>
 
+#include <rte_compat.h>
 #include <rte_config.h>
 
 /* OS specific include */
@@ -919,6 +921,38 @@ __extension__ typedef uint64_t RTE_MARKER64[0];
 uint64_t
 rte_str_to_size(const char *str);
 
+/**
+ * Converts the uint64_t value provided to a human-readable string.
+ * It null-terminates the string, truncating the data if needed.
+ * An optional unit (like "B") can be provided as a string. It will be
+ * appended to the number, and a space will be inserted before the unit if needed.
+ *
+ * Sample outputs: (1) "use_iec" disabled, (2) "use_iec" enabled,
+ *                 (3) "use_iec" enabled and "B" as unit.
+ * 0 : "0", "0", "0 B"
+ * 700 : "700", "700", "700 B"
+ * 1000 : "1.00 k", "1000", "1000 B"
+ * 1024 : "1.02 k", "1.00 ki", "1.00 kiB"
+ * 21474836480 : "21.5 G", "20.0 Gi", "20.0 GiB"
+ * 109951162777600 : "110 T", "100 Ti", "100 TiB"
+ *
+ * @param buf
+ *     Buffer to write the string to.
+ * @param buf_size
+ *     Size of the buffer.
+ * @param count
+ *     Number to convert.
+ * @param use_iec
+ *     If true, use IEC units (1024-based), otherwise use SI units (1000-based).
+ * @param unit
+ *     Unit to append to the string (Like "B" for bytes). Can be NULL.
+ * @return
+ *     buf on success, NULL if the buffer is too small.
+ */
+__rte_experimental
+char *
+rte_size_to_str(char *buf, int buf_size, uint64_t count, bool use_iec, const char *unit);
+
 /**
  * Function to terminate the application immediately, printing an error
  * message and returning the exit_code back to the shell.
-- 
2.49.0.vfs.0.0

