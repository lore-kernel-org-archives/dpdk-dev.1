Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9FD2C5AD46
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Feb 2026 17:50:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 01D09402AA;
	Fri, 20 Feb 2026 18:50:00 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id 35C5E4026D
 for <dev@dpdk.org>; Fri, 20 Feb 2026 18:49:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771609798; x=1803145798;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=afCtdKtWOHdRtsIf+tWNVkdx/SWXXNgdlcDwmjMr4yU=;
 b=lZdxQlZh130McgOfdRTamtjadndLIQybCfLTdJMSPW8SR/ssyfZSfGKo
 AEsyyWdkVdvwl1eW/8125n09lupTgo2QmA1x305cq8Gf9yfh7ce5Qv8zA
 /pNX7jcLFpKLcWl2j+d0akhZVAvJMKVXpjU0fh40TfrUztzbNog7JNFnb
 0HjL262CojawHwAXLA7OKxfuh4d1xb+VKESFnx03gNlmCtQ0o/+8QtMMN
 MOa1RFLbRzXlJZ6mcpQs3UCdhyA3KF9OBC0Ql8JCQg8cdzX0FxPNYEgzG
 qfXgG/U8K/ZmP13oKGuHIroE9hpP3U4n44xZBzYWox9EnW8mc3RBbTtTU w==;
X-CSE-ConnectionGUID: YC0hnFKsQVGiu/boH/hfsA==
X-CSE-MsgGUID: TV0SbT7TRcy6oapFaq9rvQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11707"; a="71911712"
X-IronPort-AV: E=Sophos;i="6.21,302,1763452800"; d="scan'208";a="71911712"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Feb 2026 09:49:57 -0800
X-CSE-ConnectionGUID: /d/UzhMjRHa1X+nYYaacXg==
X-CSE-MsgGUID: tooNG0BqS8yECUzavYTXrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,302,1763452800"; d="scan'208";a="218615038"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa004.fm.intel.com with ESMTP; 20 Feb 2026 09:49:57 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: stephen@networkplumber.org, Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH] app/test: simplify getting the current file prefix
Date: Fri, 20 Feb 2026 17:49:52 +0000
Message-ID: <20260220174952.2647744-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
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

Rather than opening particular fd's in the /proc directory, just use the
rte_eal_get_runtime_dir() function to derive the file-prefix in use.
Since the runtime dir call cannot return NULL, we can simplify/remove
the error handling where it's used.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 app/test/process.h | 23 ++++-------------------
 1 file changed, 4 insertions(+), 19 deletions(-)

diff --git a/app/test/process.h b/app/test/process.h
index 402dc4f96f..1ab5671943 100644
--- a/app/test/process.h
+++ b/app/test/process.h
@@ -8,12 +8,11 @@
 #include <errno.h>  /* errno */
 #include <limits.h> /* PATH_MAX */
 #ifndef RTE_EXEC_ENV_WINDOWS
-#include <libgen.h> /* basename et al */
 #include <sys/wait.h>
 #endif
 #include <stdlib.h> /* NULL */
 #include <string.h> /* strerror */
-#include <unistd.h> /* readlink */
+#include <unistd.h>
 #include <dirent.h>
 
 #include <rte_string_fns.h> /* strlcpy */
@@ -239,17 +238,7 @@ file_prefix_arg(void)
 static inline char *
 get_current_prefix(char *prefix, int size)
 {
-	char buf[PATH_MAX];
-
-	/* get file for config (fd is always 3) return NULL on error */
-	if (readlink("/proc/self/fd/3", buf, sizeof(buf)) == -1)
-		return NULL;
-
-	/*
-	 * path should be something like "/var/run/dpdk/config"
-	 * which results in prefix of "dpdk"
-	 */
-	rte_basename(dirname(buf), prefix, size);
+	rte_basename(rte_eal_get_runtime_dir(), prefix, size);
 	return prefix;
 }
 
@@ -260,12 +249,8 @@ file_prefix_arg(void)
 	static char prefix[NAME_MAX + sizeof("--file-prefix=")];
 	char tmp[NAME_MAX];
 
-	if (get_current_prefix(tmp, sizeof(tmp)) == NULL) {
-		fprintf(stderr, "Error - unable to get current prefix!\n");
-		return NULL;
-	}
-
-	snprintf(prefix, sizeof(prefix), "--file-prefix=%s", tmp);
+	snprintf(prefix, sizeof(prefix), "--file-prefix=%s",
+			get_current_prefix(tmp, sizeof(tmp)));
 	return prefix;
 #endif
 }
-- 
2.51.0

