Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20F08CAC5B0
	for <dpdk-dev@archiver.kernel.org>; Thu,  2 Oct 2025 17:44:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3E579410E8;
	Thu,  2 Oct 2025 19:43:45 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id A3A8540EE5
 for <dev@dpdk.org>; Thu,  2 Oct 2025 19:43:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1759427021; x=1790963021;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=XvnyExZQ6t/Hn8B9+1+NKnVkATNSEQ9OetgwVtwGi38=;
 b=c/FS40yjWUK7z3jY3h0flIj/r42eFbY03TgxpSEUfGijv4+/GXKU5hQP
 JnQpM5k/Wy8ytaRXRM54V0gvU6f7xAUR2p6ZI14cuZU7hzGOJ6moGo3QZ
 hZlFIIQnJrOH6l9g9Qx62s2LZkHdSKNFohBAz51DZCL8xOlX3mkpjT2YX
 bPTfHH+xOaYyu/CN7kbs0gUNITpoXPbsLSncEBeEABwqE0qUFaNG/7byS
 1k3IlZ8m8chbCxQEKIBxxPxEjhIx1r1J+AXR0b6K4NXRn3DDgtk10YLAh
 ildoUmNgcaZt5cEJQIPbU+9l4PC9B+VcQUwHHpM73mqPgT9PypkEVfwX5 A==;
X-CSE-ConnectionGUID: WRB/axcuTZSbMP8Pp2Z5Gw==
X-CSE-MsgGUID: yR/PS8RfRnqzNMCioXIoww==
X-IronPort-AV: E=McAfee;i="6800,10657,11570"; a="49271883"
X-IronPort-AV: E=Sophos;i="6.18,310,1751266800"; d="scan'208";a="49271883"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Oct 2025 10:43:40 -0700
X-CSE-ConnectionGUID: AeJSuCaKRGq0Om5LgyVoIg==
X-CSE-MsgGUID: aILQ28ROQXOuZAThoik5FA==
X-ExtLoop1: 1
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa003.fm.intel.com with ESMTP; 02 Oct 2025 10:43:39 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: david.marchand@redhat.com,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v8 14/18] eal: use common cpuset to string function
Date: Thu,  2 Oct 2025 18:43:11 +0100
Message-ID: <20251002174315.962992-15-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251002174315.962992-1-bruce.richardson@intel.com>
References: <20250520164025.2055721-1-bruce.richardson@intel.com>
 <20251002174315.962992-1-bruce.richardson@intel.com>
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
index e89ca615b8..0f3db158f6 100644
--- a/lib/eal/common/eal_common_options.c
+++ b/lib/eal/common/eal_common_options.c
@@ -1049,6 +1049,21 @@ eal_parse_service_corelist(const char *corelist)
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
 
@@ -2195,6 +2210,13 @@ compute_ctrl_threads_cpuset(struct internal_config *internal_cfg)
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
index c0622c5c23..8877747c23 100644
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
+	if (ret < 0 || (unsigned)ret >= size)
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

