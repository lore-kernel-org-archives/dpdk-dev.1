Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E295C87FCC
	for <dpdk-dev@archiver.kernel.org>; Thu, 31 Jul 2025 16:01:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5D9E9402EE;
	Thu, 31 Jul 2025 18:01:26 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by mails.dpdk.org (Postfix) with ESMTP id 6BB76402AB
 for <dev@dpdk.org>; Thu, 31 Jul 2025 18:01:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1753977684; x=1785513684;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=tHblZJaA79cj8eGslOIH6Qee5NJqjsURx/tm/EHdo88=;
 b=dstECDaocsnufD4l0EJTWt0lD1a2LCtd9S/B+xdU3L2iuNNy0UNvqWkr
 6+KfWVEJnruPI7Pk5fdw2DFnxZBroWXLexY8Rm7i+4nCLDtL62UFgm/qq
 HiIdz1IZl3QstoAaAsMBL30AQcjCMHliBiqBHBR5dlk8Sp5bvz1SZCErF
 NC0ePPlCVNNhVtqfhrtmkrcIcmROMGgUKXzMnWBptOvl72jexIPNdh+YR
 8IUltMh6ewXmTgClQbngmIn9XjmnZfm71Tc4g0mbhuELBSpgmC1n1pcYv
 qqOB1GNJDYt9pISTWSLKz76he58m+vj7ijhYBCqtsta+2qkLA+ig91hsY w==;
X-CSE-ConnectionGUID: bKUMBdlNRFmxXWuF1bFcnQ==
X-CSE-MsgGUID: OAXv3kSSR2SJrhSRSLQG7Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11508"; a="78857956"
X-IronPort-AV: E=Sophos;i="6.17,254,1747724400"; d="scan'208";a="78857956"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jul 2025 09:00:59 -0700
X-CSE-ConnectionGUID: tnEcQitbSh+2BzHnT4+e7w==
X-CSE-MsgGUID: 1tvdAiQcTtKziZRIFKdptg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,254,1747724400"; d="scan'208";a="167543392"
Received: from silpixa00401874.ir.intel.com (HELO
 silpixa00401874.ger.corp.intel.com) ([10.55.129.54])
 by fmviesa005.fm.intel.com with ESMTP; 31 Jul 2025 09:00:57 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: stephen@networkplumber.org, andremue@linux.microsoft.com,
 Bruce Richardson <bruce.richardson@intel.com>,
 Tyler Retzlaff <roretzla@linux.microsoft.com>,
 Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>
Subject: [PATCH v4 1/4] eal: add basename function for common path manipulation
Date: Thu, 31 Jul 2025 16:00:38 +0000
Message-ID: <20250731160041.914837-2-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250731160041.914837-1-bruce.richardson@intel.com>
References: <20250704140551.4151993-1-bruce.richardson@intel.com>
 <20250731160041.914837-1-bruce.richardson@intel.com>
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

There is no standard, cross-platform function to get the basename of a
file path across all the supported DPDK platforms, Linux, BSD and
Windows. Both Linux and BSD have a "basename" function in standard
library, except:
* Linux has two different basename functions, a POSIX version (which may
  or may not modify args), and a GNU one which is guaranteed *not* to
  modify the input arg and returns pointer to internal storage.
* FreeBSD has just the one basename function, but, to be different, it is
  guaranteed *always* to modify the argument and re-use it for output.
* Windows just doesn't have a basename function, but provides _split_path
  as a similar function, but with many differences over basename, e.g.
  splitting off extension, returning empty basename if path ends in "/"
  etc. etc.

Therefore, rather than just trying to implement basename for windows,
which opens the question as to whether to emulate GNU and *never* modify
arg, or emulate BSD and *always* modify arg, this patchset introduces
"rte_basename" which should have defined behaviour on all platforms. The
patch also introduces a set of test cases to confirm consistent behaviour
on all platforms too.

The behaviour is as in doxygen docs. Essentially:
- does not modify input path buffer
- returns output in a separate output buffer
- uses snprintf and strlcpy style return value to indicate truncation

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 app/test/test_string_fns.c       | 111 +++++++++++++++++++++++++++++++
 lib/eal/include/rte_string_fns.h |  32 +++++++++
 lib/eal/unix/meson.build         |   1 +
 lib/eal/unix/rte_basename.c      |  37 +++++++++++
 lib/eal/windows/meson.build      |   1 +
 lib/eal/windows/rte_basename.c   |  53 +++++++++++++++
 6 files changed, 235 insertions(+)
 create mode 100644 lib/eal/unix/rte_basename.c
 create mode 100644 lib/eal/windows/rte_basename.c

diff --git a/app/test/test_string_fns.c b/app/test/test_string_fns.c
index 3b311325dc..1a2830575e 100644
--- a/app/test/test_string_fns.c
+++ b/app/test/test_string_fns.c
@@ -205,6 +205,115 @@ test_rte_str_skip_leading_spaces(void)
 	return 0;
 }
 
+static int
+test_rte_basename(void)
+{
+	/* Test case structure for positive cases */
+	struct {
+		const char *input_path;    /* Input path string */
+		const char *expected;      /* Expected result */
+	} test_cases[] = {
+		/* Test cases from man 3 basename */
+		{"/usr/lib", "lib"},
+		{"/usr/", "usr"},
+		{"usr", "usr"},
+		{"/", "/"},
+		{".", "."},
+		{"..", ".."},
+
+		/* Additional requested test cases */
+		{"/////", "/"},
+		{"/path/to/file.txt", "file.txt"},
+
+		/* Additional edge cases with trailing slashes */
+		{"///usr///", "usr"},
+		{"/a/b/c/", "c"},
+
+		/* Empty string case */
+		{"", "."},
+		{NULL, "."}  /* NULL path should return "." */
+	};
+
+	char buf[256];
+	size_t result;
+
+	/* Run positive test cases from table */
+	for (size_t i = 0; i < RTE_DIM(test_cases); i++) {
+		result = rte_basename(test_cases[i].input_path, buf, sizeof(buf));
+
+		if (strcmp(buf, test_cases[i].expected) != 0) {
+			LOG("FAIL [%zu]: '%s' - buf contains '%s', expected '%s'\n",
+			    i, test_cases[i].input_path, buf, test_cases[i].expected);
+			return -1;
+		}
+
+		/* Check that the return value matches the expected string length */
+		if (result != strlen(test_cases[i].expected)) {
+			LOG("FAIL [%zu]: '%s' - returned length %zu, expected %zu\n",
+			    i, test_cases[i].input_path, result, strlen(test_cases[i].expected));
+			return -1;
+		}
+
+		LOG("PASS [%zu]: '%s' -> '%s' (len=%zu)\n",
+				i, test_cases[i].input_path, buf, result);
+	}
+
+	/* re-run the table above verifying that for a NULL buffer, or zero length, we get
+	 * correct length returned.
+	 */
+	for (size_t i = 0; i < RTE_DIM(test_cases); i++) {
+		result = rte_basename(test_cases[i].input_path, NULL, 0);
+		if (result != strlen(test_cases[i].expected)) {
+			LOG("FAIL [%zu]: '%s' - returned length %zu, expected %zu\n",
+			    i, test_cases[i].input_path, result, strlen(test_cases[i].expected));
+			return -1;
+		}
+		LOG("PASS [%zu]: '%s' -> length %zu (NULL buffer case)\n",
+		    i, test_cases[i].input_path, result);
+	}
+
+	/* Test case: buffer too small for result should truncate and return full length */
+	const size_t small_size = 5;
+	result = rte_basename("/path/to/very_long_filename.txt", buf, small_size);
+	/* Should be truncated to fit in 5 bytes (4 chars + null terminator) */
+	if (strlen(buf) >= small_size) {
+		LOG("FAIL: small buffer test - result '%s' not properly truncated (len=%zu, buflen=%zu)\n",
+		    buf, strlen(buf), small_size);
+		return -1;
+	}
+	/* Return value should indicate truncation occurred (>= buflen) */
+	if (result != strlen("very_long_filename.txt")) {
+		LOG("FAIL: small buffer test - return value %zu doesn't indicate truncation (buflen=%zu)\n",
+		    result, small_size);
+		return -1;
+	}
+	LOG("PASS: small buffer truncation -> '%s' (returned len=%zu, actual len=%zu)\n",
+	    buf, result, strlen(buf));
+
+	/* extreme length test case -  check that even with paths longer than PATH_MAX we still
+	 * return the last component correctly. Use "/zzz...zzz/abc.txt" and check we get "abc.txt"
+	 */
+	char basename_val[] = "abc.txt";
+	char long_path[PATH_MAX + 50];
+	for (int i = 0; i < PATH_MAX + 20; i++)
+		long_path[i] = (i == 0) ? '/' : 'z';
+	sprintf(long_path + PATH_MAX + 20, "/%s", basename_val);
+
+	result = rte_basename(long_path, buf, sizeof(buf));
+	if (strcmp(buf, basename_val) != 0) {
+		LOG("FAIL: long path test - expected '%s', got '%s'\n",
+		    basename_val, buf);
+		return -1;
+	}
+	if (result != strlen(basename_val)) {
+		LOG("FAIL: long path test - expected length %zu, got %zu\n",
+		    strlen(basename_val), result);
+		return -1;
+	}
+	LOG("PASS: long path test -> '%s' (len=%zu)\n", buf, result);
+	return 0;
+}
+
 static int
 test_string_fns(void)
 {
@@ -214,6 +323,8 @@ test_string_fns(void)
 		return -1;
 	if (test_rte_str_skip_leading_spaces() < 0)
 		return -1;
+	if (test_rte_basename() < 0)
+		return -1;
 	return 0;
 }
 
diff --git a/lib/eal/include/rte_string_fns.h b/lib/eal/include/rte_string_fns.h
index 702bd81251..3713c94acb 100644
--- a/lib/eal/include/rte_string_fns.h
+++ b/lib/eal/include/rte_string_fns.h
@@ -149,6 +149,38 @@ rte_str_skip_leading_spaces(const char *src)
 	return p;
 }
 
+/**
+ * @warning
+ * @b EXPERIMENTAL: this API may change without prior notice.
+ *
+ * Provides the final component of a path, similar to POSIX basename function.
+ *
+ * This API provides the similar behaviour on all platforms, Linux, BSD, Windows,
+ * hiding the implementation differences.
+ * - It does not modify the input path.
+ * - The output buffer is passed as an argument, and the result is copied into it.
+ * - Expected output is the last component of the path, or the path itself if
+ *   it does not contain a directory separator.
+ * - If the final component is too long to fit in the output buffer, it will be truncated.
+ * - For empty or NULL input paths, output buffer will contain the string ".".
+ * - Supports up to PATH_MAX (BSD/Linux) or _MAX_PATH (Windows) characters in the input path.
+ *
+ * @param path
+ *   The input path string. Not modified by this function.
+ * @param buf
+ *   The buffer to hold the resultant basename.
+ *   Must be large enough to hold the result, otherwise basename will be truncated.
+ * @param buflen
+ *   The size of the buffer in bytes.
+ * @return
+ *   The number of bytes that were written to buf (excluding the terminating '\0').
+ *   If the return value is >= buflen, truncation occurred.
+ *   Return (size_t)-1 on error (Windows only)
+ */
+__rte_experimental
+size_t
+rte_basename(const char *path, char *buf, size_t buflen);
+
 #ifdef __cplusplus
 }
 #endif
diff --git a/lib/eal/unix/meson.build b/lib/eal/unix/meson.build
index f1eb82e16a..70af352dab 100644
--- a/lib/eal/unix/meson.build
+++ b/lib/eal/unix/meson.build
@@ -9,6 +9,7 @@ sources += files(
         'eal_unix_memory.c',
         'eal_unix_thread.c',
         'eal_unix_timer.c',
+        'rte_basename.c',
         'rte_thread.c',
 )
 
diff --git a/lib/eal/unix/rte_basename.c b/lib/eal/unix/rte_basename.c
new file mode 100644
index 0000000000..a72d6bb3c9
--- /dev/null
+++ b/lib/eal/unix/rte_basename.c
@@ -0,0 +1,37 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2025 Intel Corporation
+ */
+
+#include <string.h>
+#include <stdlib.h>
+#include <libgen.h>
+#include <limits.h>
+
+#include <eal_export.h>
+#include <rte_string_fns.h>
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_basename, 25.11)
+size_t
+rte_basename(const char *path, char *buf, size_t buflen)
+{
+	char copy[PATH_MAX + 1];
+	size_t retval = 0;
+
+	if (path == NULL)
+		return (buf == NULL) ? strlen(".") : strlcpy(buf, ".", buflen);
+
+	/* basename is on the end, so if path is too long, use only last PATH_MAX bytes */
+	const size_t pathlen = strlen(path);
+	if (pathlen > PATH_MAX)
+		path = &path[pathlen - PATH_MAX];
+
+	/* make a copy of buffer since basename may modify it */
+	strlcpy(copy, path, sizeof(copy));
+
+	/* if passed a null buffer, just return length of basename, otherwise strlcpy it */
+	retval = (buf == NULL) ?
+			strlen(basename(copy)) :
+			strlcpy(buf, basename(copy), buflen);
+
+	return retval;
+}
diff --git a/lib/eal/windows/meson.build b/lib/eal/windows/meson.build
index c526ede405..e7fad1f010 100644
--- a/lib/eal/windows/meson.build
+++ b/lib/eal/windows/meson.build
@@ -19,6 +19,7 @@ sources += files(
         'eal_timer.c',
         'getline.c',
         'getopt.c',
+        'rte_basename.c',
         'rte_thread.c',
 )
 
diff --git a/lib/eal/windows/rte_basename.c b/lib/eal/windows/rte_basename.c
new file mode 100644
index 0000000000..f4dfc08a0a
--- /dev/null
+++ b/lib/eal/windows/rte_basename.c
@@ -0,0 +1,53 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2025 Intel Corporation
+ */
+
+#include <string.h>
+#include <stdlib.h>
+#include <rte_string_fns.h>
+
+size_t
+rte_basename(const char *path, char *buf, size_t buflen)
+{
+	char fname[_MAX_FNAME + 1];
+	char ext[_MAX_EXT + 1];
+	char dir[_MAX_DIR + 1];
+
+	if (path == NULL || path[0] == '\0')
+		return (buf == NULL) ? strlen(".") : strlcpy(buf, ".", buflen);
+
+	/* basename is on the end, so if path is too long, use only last PATH_MAX bytes */
+	const size_t pathlen = strlen(path);
+	if (pathlen > _MAX_PATH)
+		path = &path[pathlen - _MAX_PATH];
+
+
+	/* Use _splitpath_s to separate the path into components */
+	int ret = _splitpath_s(path, NULL, 0, dir, sizeof(dir),
+			fname, sizeof(fname), ext, sizeof(ext));
+	if (ret != 0)
+		return (size_t)-1;
+
+	/* if there is a trailing slash, then split_path returns no basename, but
+	 * we want to return the last component of the path in all cases.
+	 * Therefore re-run removing trailing slash from path.
+	 */
+	if (fname[0] == '\0' && ext[0] == '\0') {
+		size_t dirlen = strlen(dir);
+		while (dirlen > 0 && (dir[dirlen - 1] == '\\' || dir[dirlen - 1] == '/')) {
+			/* special case for "/" to keep *nix compatibility */
+			if (strcmp(dir, "/") == 0)
+				return (buf == NULL) ? strlen(dir) : strlcpy(buf, dir, buflen);
+
+			/* Remove trailing backslash */
+			dir[--dirlen] = '\0';
+		}
+		_splitpath_s(dir, NULL, 0, NULL, 0, fname, sizeof(fname), ext, sizeof(ext));
+	}
+
+	if (buf == NULL)
+		return strlen(fname) + strlen(ext);
+
+	/* Combine the filename and extension into output */
+	return snprintf(buf, buflen, "%s%s", fname, ext);
+}
-- 
2.48.1

