Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8196DCAC5BB
	for <dpdk-dev@archiver.kernel.org>; Wed,  8 Oct 2025 20:44:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DB1E840B91;
	Wed,  8 Oct 2025 22:43:16 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTP id 5D4CC40B95
 for <dev@dpdk.org>; Wed,  8 Oct 2025 22:43:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1759956195; x=1791492195;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=mmVzz17kkkhCN6mjXvm55MXd7xQkQ/3rBYWnB+dGdj8=;
 b=Vmb/yQFDCmwpJrmmCoXkIJHKrOZl11p3Mm67ElK1RglkLamVksRqcZQt
 lT9bHhFzMxpq6kf/8HtsUcK+vuqNjllSM1Axxec1Y5oLZuceRGWrvQPic
 Ct8COXZBRmDRIVQ5jwOnypUBfEYVJeB+442zuSNa+nNVyfyf8wBGFfbiw
 2ARhdHAmNukagiMoWeoiBacoyIPKr1c0GiTGDU3GO4LrzivYlVuQA4bs2
 f5A+FilAu+D+zC1oscoSWnETWSxPhZH0JNH5DKnTtc4wK+9DXeX9UiL/w
 i8Yn++TGiEP9Trx5nqvIY5vgOBqEPF+4GtCOHBfP4XgfqYQdP5EYNmxAN Q==;
X-CSE-ConnectionGUID: Mo9ttBHHQbiKQ4qZW/d74A==
X-CSE-MsgGUID: jSp+VFYmQvq3TaNxT+OZsw==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="62079262"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; d="scan'208";a="62079262"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Oct 2025 13:43:14 -0700
X-CSE-ConnectionGUID: LLa2X1XyQb+dVPOuRm+ghw==
X-CSE-MsgGUID: x8vu/nztTnSgBHChKw7QHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,214,1754982000"; d="scan'208";a="179790678"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa010.jf.intel.com with ESMTP; 08 Oct 2025 13:43:13 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: david.marchand@redhat.com,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v10 16/21] eal: add internal fn for converting cpuset to string
Date: Wed,  8 Oct 2025 21:42:39 +0100
Message-ID: <20251008204244.2288583-17-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251008204244.2288583-1-bruce.richardson@intel.com>
References: <20250520164025.2055721-1-bruce.richardson@intel.com>
 <20251008204244.2288583-1-bruce.richardson@intel.com>
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
index 8e17230c37..3f26ecf513 100644
--- a/lib/eal/common/eal_common_options.c
+++ b/lib/eal/common/eal_common_options.c
@@ -1571,8 +1571,8 @@ eal_parse_base_virtaddr(const char *arg)
 }
 
 /* caller is responsible for freeing the returned string */
-static char *
-available_cores(void)
+char *
+eal_cpuset_to_str(const rte_cpuset_t *cpuset)
 {
 	char *str = NULL;
 	int previous;
@@ -1580,13 +1580,13 @@ available_cores(void)
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
@@ -1595,8 +1595,8 @@ available_cores(void)
 	previous = idx;
 	sequence = 0;
 
-	for (idx++ ; idx < RTE_MAX_LCORE; idx++) {
-		if (eal_cpu_detected(idx) == 0)
+	for (idx++ ; idx < CPU_SETSIZE; idx++) {
+		if (!CPU_ISSET(idx, cpuset))
 			continue;
 
 		if (idx == previous + 1) {
@@ -1639,6 +1639,23 @@ available_cores(void)
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

