Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10B18CAC5B0
	for <dpdk-dev@archiver.kernel.org>; Thu,  2 Oct 2025 17:44:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 18FF640EDB;
	Thu,  2 Oct 2025 19:43:44 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id 954F040E64
 for <dev@dpdk.org>; Thu,  2 Oct 2025 19:43:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1759427020; x=1790963020;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=vvj7erkZAIWakmz8IPS7/hZ8Qaf+8e9ZRRylcg7+gSY=;
 b=fWwcp3eGcfu9jSGJC223JrlAJnS/MDNYsJgRO2Y0CVSLTKMEdsSaLNNa
 bTjCzN4/QYB12xonZmeYwcsC1p/3ICinos/xWZPc/atCbtqOh5FQs5EKZ
 UwEfbS2cgxEQSKnTeEg3OgMZI2wlZsCQk/aAZE3a8VbPX1SB7FH2JRF7m
 Omgojm3gQ3ETJtcMYdWiw7jOEwWmRXy7Qf+RewN2Eb3CXKre8dWXOaTMn
 9r7yxbDw9LPW59YVaRxyCdkoUGt/7myxXS54E0F7XkyFR0WsBtgvicUHX
 x4SjEGaUmoA3bNwXJUxBTjQ+VRjPsZYcSH4lJRE4WJ/6exDIqx9cTBmiz Q==;
X-CSE-ConnectionGUID: NdDS6rCYQ1O8QypoXiEhLQ==
X-CSE-MsgGUID: LmpNSKWGT3m3L913AOSRrw==
X-IronPort-AV: E=McAfee;i="6800,10657,11570"; a="49271876"
X-IronPort-AV: E=Sophos;i="6.18,310,1751266800"; d="scan'208";a="49271876"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Oct 2025 10:43:39 -0700
X-CSE-ConnectionGUID: 6UPt+E7jSY6whOeIq2U+Ew==
X-CSE-MsgGUID: HlfWDIP/StWSDwlNktdJyA==
X-ExtLoop1: 1
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa003.fm.intel.com with ESMTP; 02 Oct 2025 10:43:38 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: david.marchand@redhat.com,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v8 13/18] eal: add internal fn for converting cpuset to string
Date: Thu,  2 Oct 2025 18:43:10 +0100
Message-ID: <20251002174315.962992-14-bruce.richardson@intel.com>
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

The existing "available_cores" function in eal_common_options.c has
general code for converting a set of cores to a printable string.
Generalize this code into an "eal_cpuset_to_str" function which takes a
cpuset as parameter, and create a new "available_cores" function using
this new utility function.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 lib/eal/common/eal_common_options.c | 33 ++++++++++++++++++++++-------
 lib/eal/common/eal_private.h        | 10 +++++++++
 2 files changed, 35 insertions(+), 8 deletions(-)

diff --git a/lib/eal/common/eal_common_options.c b/lib/eal/common/eal_common_options.c
index d7a8263f08..e89ca615b8 100644
--- a/lib/eal/common/eal_common_options.c
+++ b/lib/eal/common/eal_common_options.c
@@ -1570,8 +1570,8 @@ eal_parse_base_virtaddr(const char *arg)
 }
 
 /* caller is responsible for freeing the returned string */
-static char *
-available_cores(void)
+char *
+eal_cpuset_to_str(const rte_cpuset_t *cpuset)
 {
 	char *str = NULL;
 	int previous;
@@ -1579,13 +1579,13 @@ available_cores(void)
 	char *tmp;
 	int idx;
 
-	/* find the first available cpu */
-	for (idx = 0; idx < RTE_MAX_LCORE; idx++) {
-		if (eal_cpu_detected(idx) == 0)
+	/* find the first set cpu */
+	for (idx = 0; idx < CPU_SETSIZE; idx++) {
+		if (!CPU_ISSET(idx, cpuset))
 			continue;
 		break;
 	}
-	if (idx >= RTE_MAX_LCORE)
+	if (idx >= CPU_SETSIZE)
 		return NULL;
 
 	/* first sequence */
@@ -1594,8 +1594,8 @@ available_cores(void)
 	previous = idx;
 	sequence = 0;
 
-	for (idx++ ; idx < RTE_MAX_LCORE; idx++) {
-		if (eal_cpu_detected(idx) == 0)
+	for (idx++ ; idx < CPU_SETSIZE; idx++) {
+		if (!CPU_ISSET(idx, cpuset))
 			continue;
 
 		if (idx == previous + 1) {
@@ -1638,6 +1638,23 @@ available_cores(void)
 	return str;
 }
 
+/* caller is responsible for freeing the returned string */
+static char *
+available_cores(void)
+{
+	rte_cpuset_t cpuset;
+	int idx;
+
+	/* build cpuset of available cores */
+	CPU_ZERO(&cpuset);
+	for (idx = 0; idx < RTE_MAX_LCORE; idx++) {
+		if (eal_cpu_detected(idx))
+			CPU_SET(idx, &cpuset);
+	}
+
+	return eal_cpuset_to_str(&cpuset);
+}
+
 #define HUGE_UNLINK_NEVER "never"
 
 static int
diff --git a/lib/eal/common/eal_private.h b/lib/eal/common/eal_private.h
index ab8b37b956..e032dd10c9 100644
--- a/lib/eal/common/eal_private.h
+++ b/lib/eal/common/eal_private.h
@@ -83,6 +83,16 @@ struct rte_config *rte_eal_get_configuration(void);
  */
 int eal_collate_args(int argc, char **argv);
 
+/**
+ * Convert an rte_cpuset_t to string form suitable for parsing by argparse.
+ *
+ * @param cpuset
+ *   The cpuset to convert to string form.
+ * @return
+ *   String representation of the cpuset (caller must free), or NULL on error.
+ */
+char *eal_cpuset_to_str(const rte_cpuset_t *cpuset);
+
 /**
  * Initialize the memzone subsystem (private to eal).
  *
-- 
2.48.1

