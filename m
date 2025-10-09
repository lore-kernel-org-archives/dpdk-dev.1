Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2800CCD185
	for <dpdk-dev@archiver.kernel.org>; Thu,  9 Oct 2025 13:03:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6FAEB4064F;
	Thu,  9 Oct 2025 15:01:33 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 84BC640B9A
 for <dev@dpdk.org>; Thu,  9 Oct 2025 15:01:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760014891; x=1791550891;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=mBRx6xM7QgNnfg9OmPk2ICpNxQ0nySybHsLkl8Uw9nk=;
 b=lsPCit3KAhio8vaf1Bcht3HfWTC5OIAl9LjbIWrX57vG5ppCmwagYmMj
 a0uotWi42p47a7DInXjnouz8VbPAtL+V1v5QjUlXvqJiXLeZIKE1BsGFv
 I7SUA5TM3nE2Q1qVl4CSHNNA7MvL9uXrJ+qZJntsBMQAHEmgjoAvH/RKx
 GjXbmPW6EebUOKCKgYnqrvjiUOhYYUtfq9K4QqNr5WGuQClJxmYUujADY
 c+5TPY+832Sc0NVMNbfLGx9is5rxaBC/OqJ3VYFY9zFt0G5lTeyNBA2o3
 l46kkQQHLt6p3uTbIzew3FrYw07v5QuKy6RUTRVsKRaDlHPpUyuco40Tk g==;
X-CSE-ConnectionGUID: nO6b+ZbOSDKgQroJBg4nGw==
X-CSE-MsgGUID: eM5r0PUjRFitvALL+vmHUw==
X-IronPort-AV: E=McAfee;i="6800,10657,11577"; a="79663139"
X-IronPort-AV: E=Sophos;i="6.19,216,1754982000"; d="scan'208";a="79663139"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Oct 2025 06:01:31 -0700
X-CSE-ConnectionGUID: z3kjZn4JTiauwN8VoChqVQ==
X-CSE-MsgGUID: zyhIabAgTYWQHwb50FJAFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,216,1754982000"; d="scan'208";a="179951659"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa010.jf.intel.com with ESMTP; 09 Oct 2025 06:01:29 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: david.marchand@redhat.com,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v11 17/21] eal: use common cpuset to string function
Date: Thu,  9 Oct 2025 14:00:52 +0100
Message-ID: <20251009130056.2630343-18-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251009130056.2630343-1-bruce.richardson@intel.com>
References: <20250520164025.2055721-1-bruce.richardson@intel.com>
 <20251009130056.2630343-1-bruce.richardson@intel.com>
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

Use the new cpuset to string function to replace other thread-specific
functions which did similar work. Also use it for additional debug logs.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 lib/eal/common/eal_common_lcore.c   | 13 ++++-----
 lib/eal/common/eal_common_options.c | 22 +++++++++++++++
 lib/eal/common/eal_common_thread.c  | 43 ++++++++---------------------
 lib/eal/common/eal_thread.h         | 13 ++-------
 4 files changed, 42 insertions(+), 49 deletions(-)

diff --git a/lib/eal/common/eal_common_lcore.c b/lib/eal/common/eal_common_lcore.c
index 5c8b0f9aa2..39411f9370 100644
--- a/lib/eal/common/eal_common_lcore.c
+++ b/lib/eal/common/eal_common_lcore.c
@@ -481,12 +481,11 @@ static int
 lcore_dump_cb(unsigned int lcore_id, void *arg)
 {
 	struct rte_config *cfg = rte_eal_get_configuration();
-	char cpuset[RTE_CPU_AFFINITY_STR_LEN];
+	char *cpuset;
 	struct rte_lcore_usage usage;
 	rte_lcore_usage_cb usage_cb;
 	char *usage_str = NULL;
 	FILE *f = arg;
-	int ret;
 
 	/* The callback may not set all the fields in the structure, so clear it here. */
 	memset(&usage, 0, sizeof(usage));
@@ -499,12 +498,12 @@ lcore_dump_cb(unsigned int lcore_id, void *arg)
 			return -ENOMEM;
 		}
 	}
-	ret = eal_thread_dump_affinity(&lcore_config[lcore_id].cpuset, cpuset,
-		sizeof(cpuset));
-	fprintf(f, "lcore %u, socket %u, role %s, cpuset %s%s%s\n", lcore_id,
+	cpuset = eal_cpuset_to_str(&lcore_config[lcore_id].cpuset);
+	fprintf(f, "lcore %u, socket %u, role %s, cpuset %s\n", lcore_id,
 		rte_lcore_to_socket_id(lcore_id),
-		lcore_role_str(cfg->lcore_role[lcore_id]), cpuset,
-		ret == 0 ? "" : "...", usage_str != NULL ? usage_str : "");
+		lcore_role_str(cfg->lcore_role[lcore_id]),
+		cpuset != NULL ? cpuset : "<unknown>");
+	free(cpuset);
 	free(usage_str);
 
 	return 0;
diff --git a/lib/eal/common/eal_common_options.c b/lib/eal/common/eal_common_options.c
index 3f26ecf513..1faad61e37 100644
--- a/lib/eal/common/eal_common_options.c
+++ b/lib/eal/common/eal_common_options.c
@@ -1050,6 +1050,21 @@ eal_parse_service_corelist(const char *corelist)
 			"Please ensure -c or -l includes service cores");
 	}
 
+	/* log the configured service cores for debugging */
+	rte_cpuset_t service_cpuset;
+	CPU_ZERO(&service_cpuset);
+	for (i = 0; i < RTE_MAX_LCORE; i++) {
+		if (lcore_config[i].core_role == ROLE_SERVICE)
+			CPU_SET(i, &service_cpuset);
+	}
+	if (CPU_COUNT(&service_cpuset) > 0) {
+		char *cpuset_str = eal_cpuset_to_str(&service_cpuset);
+		if (cpuset_str != NULL) {
+			EAL_LOG(DEBUG, "Service cores configured: %s", cpuset_str);
+			free(cpuset_str);
+		}
+	}
+
 	return 0;
 }
 
@@ -2196,6 +2211,13 @@ compute_ctrl_threads_cpuset(struct internal_config *internal_cfg)
 		memcpy(cpuset, &lcore_config[rte_get_main_lcore()].cpuset,
 			sizeof(*cpuset));
 	}
+
+	/* log the computed control thread cpuset for debugging */
+	char *cpuset_str = eal_cpuset_to_str(cpuset);
+	if (cpuset_str != NULL) {
+		EAL_LOG(DEBUG, "Control threads will use cores: %s", cpuset_str);
+		free(cpuset_str);
+	}
 }
 
 int
diff --git a/lib/eal/common/eal_common_thread.c b/lib/eal/common/eal_common_thread.c
index c0622c5c23..dcd81f9e32 100644
--- a/lib/eal/common/eal_common_thread.c
+++ b/lib/eal/common/eal_common_thread.c
@@ -109,43 +109,24 @@ rte_thread_get_affinity(rte_cpuset_t *cpusetp)
 }
 
 int
-eal_thread_dump_affinity(rte_cpuset_t *cpuset, char *str, unsigned int size)
+eal_thread_dump_current_affinity(char *str, unsigned int size)
 {
-	unsigned cpu;
+	rte_cpuset_t cpuset;
+	char *cpuset_str;
 	int ret;
-	unsigned int out = 0;
-
-	for (cpu = 0; cpu < CPU_SETSIZE; cpu++) {
-		if (!CPU_ISSET(cpu, cpuset))
-			continue;
-
-		ret = snprintf(str + out,
-			       size - out, "%u,", cpu);
-		if (ret < 0 || (unsigned)ret >= size - out) {
-			/* string will be truncated */
-			ret = -1;
-			goto exit;
-		}
 
-		out += ret;
-	}
+	rte_thread_get_affinity(&cpuset);
+	cpuset_str = eal_cpuset_to_str(&cpuset);
+	if (cpuset_str == NULL)
+		return -1;
 
-	ret = 0;
-exit:
-	/* remove the last separator */
-	if (out > 0)
-		str[out - 1] = '\0';
+	ret = snprintf(str, size, "%s", cpuset_str);
+	free(cpuset_str);
 
-	return ret;
-}
-
-int
-eal_thread_dump_current_affinity(char *str, unsigned int size)
-{
-	rte_cpuset_t cpuset;
+	if (ret < 0 || (unsigned int)ret >= size)
+		return -1;
 
-	rte_thread_get_affinity(&cpuset);
-	return eal_thread_dump_affinity(&cpuset, str, size);
+	return 0;
 }
 
 void
diff --git a/lib/eal/common/eal_thread.h b/lib/eal/common/eal_thread.h
index 1c3c3442d3..586de05081 100644
--- a/lib/eal/common/eal_thread.h
+++ b/lib/eal/common/eal_thread.h
@@ -33,28 +33,19 @@ unsigned eal_cpu_socket_id(unsigned cpu_id);
 #define RTE_CPU_AFFINITY_STR_LEN            256
 
 /**
- * Dump the cpuset as a human readable string.
+ * Dump the current thread cpuset as a human readable string.
  * This function is private to EAL.
  *
  * Note:
  *   If the dump size is greater than the size of given buffer,
  *   the string will be truncated and with '\0' at the end.
  *
- * @param cpuset
- *   The CPU affinity object to dump.
  * @param str
  *   The string buffer the cpuset will dump to.
  * @param size
  *   The string buffer size.
  * @return
- *   0 for success, -1 if truncation happens.
- */
-int
-eal_thread_dump_affinity(rte_cpuset_t *cpuset, char *str, unsigned int size);
-
-/**
- * Dump the current thread cpuset.
- * This is a wrapper on eal_thread_dump_affinity().
+ *   0 for success, -1 if error or truncation happens.
  */
 int
 eal_thread_dump_current_affinity(char *str, unsigned int size);
-- 
2.48.1

