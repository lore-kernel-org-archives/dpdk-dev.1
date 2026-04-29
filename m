Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D91AFF887E
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Apr 2026 17:01:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8486940E4C;
	Wed, 29 Apr 2026 18:59:22 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id 60AFD40DD5;
 Wed, 29 Apr 2026 18:59:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777481960; x=1809017960;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=nTjcN4EbIEh6aIT+wyHnR4ZsfcLadcDKaDi7bai/Bco=;
 b=XsgEZC7AIuyg/0N/D5mQZpgKPeKouLMZ0SVv4SvMYdpYmhDZkrTTRLyD
 Z5Pu75uhao7ie6ktMD2o5mD9i4zhUwXHJplknmavRbm+p7i8siLbM4QdM
 GxKqcNBAonTpIq2nFmHpSTHAetb93Eh6tyIUaOicpxN8uiFmcT0jokn0u
 kj+5Bplyms/Je/TdH9wEv5/taW5O99aAH9pdGp1ErrNXlSpq91H8lnRYN
 QTQJG1J8TshBdr2/zn+t5Un9GOY1dhufran1Pmj6JFitaig5x5CIA18KV
 Ufu6yNCq+oAQh3hWNBBWc713roygjFk8bNfJYrB9/3biP4ZsX7UHUwq8c Q==;
X-CSE-ConnectionGUID: 0tGlLs+xRzWtN6+E4bYY9A==
X-CSE-MsgGUID: DU2CQCjKQ5OS3iYQNmwW0Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="88725329"
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; d="scan'208";a="88725329"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Apr 2026 09:59:20 -0700
X-CSE-ConnectionGUID: EQeQFB9JQ961AW3Doar1NQ==
X-CSE-MsgGUID: +JEIrUecSoSr9gz8l+2DBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; d="scan'208";a="264696995"
Received: from silpixa00401385.ir.intel.com (HELO
 localhost.ger.corp.intel.com) ([10.20.227.128])
 by orviesa002.jf.intel.com with ESMTP; 29 Apr 2026 09:59:18 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: techboard@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [RFC PATCH 19/44] eal: move iova mode and process type to runtime cfg
Date: Wed, 29 Apr 2026 17:58:11 +0100
Message-ID: <20260429165845.2136843-20-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260429165845.2136843-1-bruce.richardson@intel.com>
References: <20260429165845.2136843-1-bruce.richardson@intel.com>
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

Move two more fields, iova_mode and process_type from old rte_config to
eal_runtime_state struct.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 lib/eal/common/eal_common_config.c |  4 ++--
 lib/eal/common/eal_common_mcfg.c   |  2 +-
 lib/eal/common/eal_internal_cfg.h  |  2 ++
 lib/eal/common/eal_private.h       |  7 -------
 lib/eal/freebsd/eal.c              | 11 +++++------
 lib/eal/linux/eal.c                | 13 ++++++-------
 lib/eal/windows/eal.c              |  2 +-
 7 files changed, 17 insertions(+), 24 deletions(-)

diff --git a/lib/eal/common/eal_common_config.c b/lib/eal/common/eal_common_config.c
index f1a5e84aa9..7e6704a32d 100644
--- a/lib/eal/common/eal_common_config.c
+++ b/lib/eal/common/eal_common_config.c
@@ -88,7 +88,7 @@ RTE_EXPORT_SYMBOL(rte_eal_iova_mode)
 enum rte_iova_mode
 rte_eal_iova_mode(void)
 {
-	return rte_eal_get_configuration()->iova_mode;
+	return eal_get_runtime_state()->iova_mode;
 }
 
 /* Get the EAL base address */
@@ -105,7 +105,7 @@ RTE_EXPORT_SYMBOL(rte_eal_process_type)
 enum rte_proc_type_t
 rte_eal_process_type(void)
 {
-	return rte_config.process_type;
+	return eal_get_runtime_state()->process_type;
 }
 
 /* Return user provided mbuf pool ops name */
diff --git a/lib/eal/common/eal_common_mcfg.c b/lib/eal/common/eal_common_mcfg.c
index 497b0933c7..cc4107bbca 100644
--- a/lib/eal/common/eal_common_mcfg.c
+++ b/lib/eal/common/eal_common_mcfg.c
@@ -18,7 +18,7 @@ eal_mcfg_complete(void)
 	struct eal_runtime_state *runtime_state = eal_get_runtime_state();
 
 	/* ALL shared mem_config related INIT DONE */
-	if (cfg->process_type == RTE_PROC_PRIMARY)
+	if (runtime_state->process_type == RTE_PROC_PRIMARY)
 		mcfg->magic = RTE_MAGIC;
 
 	runtime_state->init_complete = 1;
diff --git a/lib/eal/common/eal_internal_cfg.h b/lib/eal/common/eal_internal_cfg.h
index 5572af28af..e229f82c1e 100644
--- a/lib/eal/common/eal_internal_cfg.h
+++ b/lib/eal/common/eal_internal_cfg.h
@@ -139,6 +139,8 @@ struct eal_runtime_state {
 	rte_cpuset_t ctrl_cpuset;         /**< cpuset for ctrl threads */
 	volatile unsigned int init_complete;
 	/**< indicates whether EAL has completed initialization */
+	enum rte_proc_type_t process_type; /**< primary or secondary process */
+	enum rte_iova_mode iova_mode; /**< PA or VA IOVA mapping mode */
 	uint32_t main_lcore;          /**< ID of the main lcore */
 	uint32_t lcore_count;         /**< Number of active lcore IDs (role != ROLE_OFF). */
 	struct lcore_cfg lcore_cfg[RTE_MAX_LCORE];
diff --git a/lib/eal/common/eal_private.h b/lib/eal/common/eal_private.h
index ffbaba6add..a905632cbe 100644
--- a/lib/eal/common/eal_private.h
+++ b/lib/eal/common/eal_private.h
@@ -21,13 +21,6 @@
  * The global RTE configuration structure.
  */
 struct rte_config {
-
-	/** Primary or secondary configuration */
-	enum rte_proc_type_t process_type;
-
-	/** PA or VA mapping mode */
-	enum rte_iova_mode iova_mode;
-
 	/**
 	 * Pointer to memory configuration, which may be shared across multiple
 	 * DPDK instances
diff --git a/lib/eal/freebsd/eal.c b/lib/eal/freebsd/eal.c
index 30702f5b20..5271614e4a 100644
--- a/lib/eal/freebsd/eal.c
+++ b/lib/eal/freebsd/eal.c
@@ -284,12 +284,12 @@ eal_proc_type_detect(void)
 static int
 rte_config_init(void)
 {
-	struct rte_config *config = rte_eal_get_configuration();
+	struct eal_runtime_state *runtime_state = eal_get_runtime_state();
 	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 
-	config->process_type = user_cfg->process_type;
+	runtime_state->process_type = user_cfg->process_type;
 
-	switch (config->process_type) {
+	switch (runtime_state->process_type) {
 	case RTE_PROC_PRIMARY:
 		if (rte_eal_config_create() < 0)
 			return -1;
@@ -313,8 +313,7 @@ rte_config_init(void)
 		break;
 	case RTE_PROC_AUTO:
 	case RTE_PROC_INVALID:
-		EAL_LOG(ERR, "Invalid process type %d",
-			config->process_type);
+		EAL_LOG(ERR, "Invalid process type %d", runtime_state->process_type);
 		return -1;
 	}
 
@@ -560,7 +559,7 @@ rte_eal_init(int argc, char **argv)
 		goto err_out;
 	}
 
-	rte_eal_get_configuration()->iova_mode = iova_mode;
+	runtime_state->iova_mode = iova_mode;
 	EAL_LOG(INFO, "Selected IOVA mode '%s'",
 		rte_eal_iova_mode() == RTE_IOVA_PA ? "PA" : "VA");
 
diff --git a/lib/eal/linux/eal.c b/lib/eal/linux/eal.c
index 71c15d1ad5..2ac2546391 100644
--- a/lib/eal/linux/eal.c
+++ b/lib/eal/linux/eal.c
@@ -368,12 +368,12 @@ eal_proc_type_detect(void)
 static int
 rte_config_init(void)
 {
-	struct rte_config *config = rte_eal_get_configuration();
+	struct eal_runtime_state *runtime_state = eal_get_runtime_state();
 	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 
-	config->process_type = user_cfg->process_type;
+	runtime_state->process_type = user_cfg->process_type;
 
-	switch (config->process_type) {
+	switch (runtime_state->process_type) {
 	case RTE_PROC_PRIMARY:
 		if (rte_eal_config_create() < 0)
 			return -1;
@@ -398,7 +398,7 @@ rte_config_init(void)
 	case RTE_PROC_AUTO:
 	case RTE_PROC_INVALID:
 		EAL_LOG(ERR, "Invalid process type %d",
-			config->process_type);
+			runtime_state->process_type);
 		return -1;
 	}
 
@@ -707,10 +707,9 @@ rte_eal_init(int argc, char **argv)
 				EAL_LOG(DEBUG, "IOMMU is not available, selecting IOVA as PA mode.");
 			}
 		}
-		rte_eal_get_configuration()->iova_mode = iova_mode;
+		runtime_state->iova_mode = iova_mode;
 	} else {
-		rte_eal_get_configuration()->iova_mode =
-			user_cfg->iova_mode;
+		runtime_state->iova_mode = user_cfg->iova_mode;
 	}
 
 	if (rte_eal_iova_mode() == RTE_IOVA_PA && !phys_addrs) {
diff --git a/lib/eal/windows/eal.c b/lib/eal/windows/eal.c
index 0d1ba3aaeb..72df9163f0 100644
--- a/lib/eal/windows/eal.c
+++ b/lib/eal/windows/eal.c
@@ -298,7 +298,7 @@ rte_eal_init(int argc, char **argv)
 
 	EAL_LOG(DEBUG, "Selected IOVA mode '%s'",
 		iova_mode == RTE_IOVA_PA ? "PA" : "VA");
-	rte_eal_get_configuration()->iova_mode = iova_mode;
+	runtime_state->iova_mode = iova_mode;
 
 	if (rte_eal_memzone_init() < 0) {
 		rte_eal_init_alert("Cannot init memzone");
-- 
2.51.0

