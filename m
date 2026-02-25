Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F389FD3772
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Feb 2026 16:21:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9610E402E6;
	Wed, 25 Feb 2026 17:20:55 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id 54ED4400D6
 for <dev@dpdk.org>; Wed, 25 Feb 2026 17:20:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772036453; x=1803572453;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Ot9PRGG1k8GKIWDaMIDHIfhi+7olf1zrRJmK9ab3eSY=;
 b=KBLaG83Sy9kJVDHZRzYlQH3c2neqm0YvSfBrYLSFyqvTw5jdu4j+k4fp
 8lKUfXnl3xOsgy/13Kd5x2yzu2cl0Ttj+CoDnMGXgUSdGge6JoPmbiYyQ
 xjCsC91kFhVxDCxVFjs10dwa6qz/kkpSgXyIdlCxPdoTcG8slEIHdBF6V
 ObTgcEOLwXXoYIwjJMpvSoKe1aqPEOUIPeV85gQUwQPid/9A+lXAqIlIZ
 QzVGRIj2uWSWQa5KJH40PEJ7B4Z+Iv+TEiUwBR8wOXZlBTWINV8WabpnA
 3bPc9/x9WvmkHA/Dw8YsofSVZ0xgM4ludR0gn99ddoN9MvTwn3A9lwJnb A==;
X-CSE-ConnectionGUID: nh27rtMxRQCpjBK3+K3lvw==
X-CSE-MsgGUID: lC6+yxptQLqWrybeVMuzkw==
X-IronPort-AV: E=McAfee;i="6800,10657,11712"; a="75686031"
X-IronPort-AV: E=Sophos;i="6.21,310,1763452800"; d="scan'208";a="75686031"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Feb 2026 08:20:52 -0800
X-CSE-ConnectionGUID: +OD4h9C7S0yyFXeL4JhiRQ==
X-CSE-MsgGUID: uJLku2EgTYmi/TzHZja4VQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,310,1763452800"; d="scan'208";a="216163439"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa009.jf.intel.com with ESMTP; 25 Feb 2026 08:20:52 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Marat Khalili <marat.khalili@huawei.com>
Subject: [PATCH v2 2/2] app/test: simplify getting the current file prefix
Date: Wed, 25 Feb 2026 16:20:44 +0000
Message-ID: <20260225162044.3670045-2-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260225162044.3670045-1-bruce.richardson@intel.com>
References: <20260220174952.2647744-1-bruce.richardson@intel.com>
 <20260225162044.3670045-1-bruce.richardson@intel.com>
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
Acked-by: Marat Khalili <marat.khalili@huawei.com>
Tested-by: Marat Khalili <marat.khalili@huawei.com>
---
 app/test/process.h | 23 ++++-------------------
 1 file changed, 4 insertions(+), 19 deletions(-)

diff --git a/app/test/process.h b/app/test/process.h
index a21cdfd46d..df43966a2a 100644
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
@@ -236,17 +235,7 @@ file_prefix_arg(void)
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
 
@@ -257,12 +246,8 @@ file_prefix_arg(void)
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
 }
 #endif /* RTE_EXEC_ENV_LINUX */
-- 
2.51.0

