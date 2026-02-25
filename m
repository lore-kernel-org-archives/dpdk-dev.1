Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 656B3FD3770
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Feb 2026 16:20:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AA89C402C5;
	Wed, 25 Feb 2026 17:20:53 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id 8256A400D6;
 Wed, 25 Feb 2026 17:20:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772036453; x=1803572453;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=0yHZmiMt6LwZpU7zrjLXfMCsNcnMuHZZ7VS5EVQ/hzw=;
 b=Q9n01u/rvgJynPHmIQ0GH7C3d2R5G7ng4PRW7+TAvUlXJTq9InSmXqfn
 RGMb19NZGz5d4DJVch9R0Mmtx8AmWH0jlpe3wXac/DY5OXFjjD1Hasq+l
 borHnqdXg5E3GOQxMGezxrNOaRG96BGJHMYDFR1Q7H7i1yCEDud01r19F
 xZt6PgqEqyqxS3JPH8sr3LE2lx/IOS06Nm8AAk4jgti5nxyxbAQRGzhFD
 btM44Jbwo247bJCQ4p1JvcRRtccsVqV6PsbHZYCCRecMzGiDLVMMv1lsP
 A5DLAeUUyJ4OZlDYlPWX00qxzlWUFWzw5DbWP+yy0sdwXQQ/kvbalTViO A==;
X-CSE-ConnectionGUID: cbLu0ZqoSnadaLdX89QzLQ==
X-CSE-MsgGUID: AD6EEyIvQz6Zlhlc/spBUA==
X-IronPort-AV: E=McAfee;i="6800,10657,11712"; a="75686029"
X-IronPort-AV: E=Sophos;i="6.21,310,1763452800"; d="scan'208";a="75686029"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Feb 2026 08:20:50 -0800
X-CSE-ConnectionGUID: D7gFQSvXQ9eOPq3DFn5tCg==
X-CSE-MsgGUID: QlX65ku6T7+9GfbrNke8Og==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,310,1763452800"; d="scan'208";a="216163423"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa009.jf.intel.com with ESMTP; 25 Feb 2026 08:20:50 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
	stable@dpdk.org
Subject: [PATCH v2 1/2] app/test: fix ifdefs in header for managing
 subprocesses
Date: Wed, 25 Feb 2026 16:20:43 +0000
Message-ID: <20260225162044.3670045-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260220174952.2647744-1-bruce.richardson@intel.com>
References: <20260220174952.2647744-1-bruce.richardson@intel.com>
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

The #endif for the #ifdef Linux block to add the "get_current_prefix()"
and the "file_prefix_arg()" functions to process.h was on the wrong
line, leaving a stray "}" outside the block. Fix this and in the process
(no pun intended) simplify the #ifdefs to just a non-Linux and a Linux
block, removing one level of #ifdefs.

Fixes: f17b6eacf00a ("test: avoid file prefix overflow")
Cc: stable@dpdk.org

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 app/test/process.h | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/app/test/process.h b/app/test/process.h
index 402dc4f96f..a21cdfd46d 100644
--- a/app/test/process.h
+++ b/app/test/process.h
@@ -225,17 +225,14 @@ process_dup(const char *const argv[], int numargs, const char *env_value)
 	return status;
 }
 
-/* FreeBSD doesn't support file prefixes, so no argument passed. */
-#ifdef RTE_EXEC_ENV_FREEBSD
+/* Only Linux supports file prefixes. */
+#ifndef RTE_EXEC_ENV_LINUX
 static inline const char *
 file_prefix_arg(void)
 {
-	/* BSD target doesn't support prefixes at this point */
 	return "";
 }
-#else
-
-#ifdef RTE_EXEC_ENV_LINUX
+#else /* RTE_EXEC_ENV_LINUX */
 static inline char *
 get_current_prefix(char *prefix, int size)
 {
@@ -253,7 +250,7 @@ get_current_prefix(char *prefix, int size)
 	return prefix;
 }
 
-/* Return a --file-prefix=XXXX argument or NULL */
+/* Return a --file-prefix=XXXX argument */
 static inline const char *
 file_prefix_arg(void)
 {
@@ -267,8 +264,7 @@ file_prefix_arg(void)
 
 	snprintf(prefix, sizeof(prefix), "--file-prefix=%s", tmp);
 	return prefix;
-#endif
 }
-#endif
+#endif /* RTE_EXEC_ENV_LINUX */
 
 #endif /* _PROCESS_H_ */
-- 
2.51.0

