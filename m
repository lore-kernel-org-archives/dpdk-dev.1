Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FC80C5DF7D
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Aug 2026 13:36:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 970FF40E26;
	Tue, 18 Aug 2026 15:34:11 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id EA6BF40E0F
 for <dev@dpdk.org>; Tue, 18 Aug 2026 15:34:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787060046; x=1818596046;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=LMQ5aAPvehIR4pJMBx3TDesGJC/LYzxI6n08n5wQ7hs=;
 b=NEmL6v5GXgCoTlOUdZ5flI5omktNF0NnCMWgk9mwvP7QTiKojRi3seDL
 uDmX3UCwKs47rOSMf36v7eWtpa0St0MwDoIUJUy5WS47f/iPv6J6Kpqqm
 o5Me8sspwqkkm7Y1REMPwDh6TIga7mBNBjQsiffwAfaiDXT12xiqP50J0
 HYDgGlq4OFNrNqY+lnxo/KxXjjCryz8GjvqD9L4y9deoy59xXO2ofOgWV
 oIuUPDyPgKM5BUyG9n67m+RXrGCivhLp9HKHOJcj35URg2TbVGq4PCZBh
 HOBBThzoFFnbnE1y3RwzroiaxgccSbGShyT2UVh1VdEtEoclAox0F4ErT w==;
X-CSE-ConnectionGUID: qWF1PzVcTJ63mAd/ibQqgg==
X-CSE-MsgGUID: APTq9kAUQvW6LHhQboblbg==
X-IronPort-AV: E=McAfee;i="6800,10657,11878"; a="87757657"
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; d="scan'208";a="87757657"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Aug 2026 06:34:05 -0700
X-CSE-ConnectionGUID: ha+fjuDAS/at9SGng5MQ8A==
X-CSE-MsgGUID: 9eQxOhzpTjOFjqiJAt0OQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; d="scan'208";a="288736706"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa002.fm.intel.com with ESMTP; 18 Aug 2026 06:34:03 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v2 22/39] eal: move IOVA mode and process type to runtime cfg
Date: Tue, 18 Aug 2026 14:33:15 +0100
Message-ID: <20260818133334.2620165-23-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260818133334.2620165-1-bruce.richardson@intel.com>
References: <20260429165845.2136843-1-bruce.richardson@intel.com>
 <20260818133334.2620165-1-bruce.richardson@intel.com>
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
index efb7126b0e..60936ec62b 100644
--- a/lib/eal/common/eal_internal_cfg.h
+++ b/lib/eal/common/eal_internal_cfg.h
@@ -148,6 +148,8 @@ struct eal_runtime_state {
 	rte_cpuset_t ctrl_cpuset;         /**< cpuset for ctrl threads */
 	volatile unsigned int init_complete;
 	/**< indicates whether EAL has completed initialization */
+	enum rte_proc_type_t process_type; /**< primary or secondary process */
+	enum rte_iova_mode iova_mode; /**< PA or VA IOVA mapping mode */
 	uint32_t main_lcore;          /**< ID of the main lcore */
 	uint32_t lcore_count;         /**< Number of active lcore IDs (role != ROLE_OFF). */
 	struct lcore_cfg lcore_cfg[RTE_MAX_LCORE];
diff --git a/lib/eal/common/eal_private.h b/lib/eal/common/eal_private.h
index 11f1571466..b0e0bf2e00 100644
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
index eeeffd08a5..3b78c98ff8 100644
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
index 361af0c1ed..acfefc71f8 100644
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
index 82b3886d9e..22e0b9c620 100644
--- a/lib/eal/windows/eal.c
+++ b/lib/eal/windows/eal.c
@@ -304,7 +304,7 @@ rte_eal_init(int argc, char **argv)
 
 	EAL_LOG(DEBUG, "Selected IOVA mode '%s'",
 		iova_mode == RTE_IOVA_PA ? "PA" : "VA");
-	rte_eal_get_configuration()->iova_mode = iova_mode;
+	runtime_state->iova_mode = iova_mode;
 
 	if (rte_eal_memzone_init() < 0) {
 		rte_eal_init_alert("Cannot init memzone");
-- 
2.53.0

