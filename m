Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FAE2CCA470
	for <dpdk-dev@archiver.kernel.org>; Fri,  3 Oct 2025 08:16:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 036F14067C;
	Fri,  3 Oct 2025 10:15:32 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id 118F7406B7
 for <dev@dpdk.org>; Fri,  3 Oct 2025 10:15:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1759479329; x=1791015329;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=vvj7erkZAIWakmz8IPS7/hZ8Qaf+8e9ZRRylcg7+gSY=;
 b=TopAVnUoOUYsrhUNP8PW3le4GgMvmkfYeyZzTIkU7EqXDllDIX+ex+FO
 SWyCoZ+aHPyVAYnyN4tI6W60lz2d+l3hG5txOpw5nOttCi3AyVbU40CjA
 QKHIzXDmVh2LLp1axPOeaTjFa1gJFCBS8ExNuANezdUY8lwcPJAE5l+4f
 1hKHtiaNXm4r34ZLeYGog8oKrEta3myvdRBPrhXmVwJMfVppcdQGUrHLL
 qSL5IIzoEPBqs42Tu+9AVJ3Gw17VuTfeXWb1bQCDqwTQiPNEhuAJyo4uL
 YTQHfWhzfEM7XLnC5BofJmSN/CBFb5fX6ONFXLYIAWeCamj741REnM7Kf Q==;
X-CSE-ConnectionGUID: fXtXTpTWTk6VANedZvkugw==
X-CSE-MsgGUID: 7Lk2aZb+TwC2ynFSXeta+Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11570"; a="61473593"
X-IronPort-AV: E=Sophos;i="6.18,312,1751266800"; d="scan'208";a="61473593"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Oct 2025 01:15:28 -0700
X-CSE-ConnectionGUID: ZEWCUIrJQyeptXXsgLhFpA==
X-CSE-MsgGUID: 9OOgUm/CRMiapYo3p+Ng1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,312,1751266800"; d="scan'208";a="184525874"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa004.fm.intel.com with ESMTP; 03 Oct 2025 01:15:26 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: david.marchand@redhat.com,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v9 13/18] eal: add internal fn for converting cpuset to string
Date: Fri,  3 Oct 2025 09:15:05 +0100
Message-ID: <20251003081510.1197166-14-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251003081510.1197166-1-bruce.richardson@intel.com>
References: <20250520164025.2055721-1-bruce.richardson@intel.com>
 <20251003081510.1197166-1-bruce.richardson@intel.com>
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

