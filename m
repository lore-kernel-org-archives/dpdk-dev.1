Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB99D606A31E
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Nov 2026 18:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=PKSIZMvQ
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A29274067A;
	Thu, 26 Nov 2026 19:15:19 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTPS id 7B32A40685
 for <dev@dpdk.org>; Thu, 26 Nov 2026 19:15:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795716917; x=1827252917;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=vVGfiqddgxdKg8Ze6f7uWqGl0qifADAt7U10K6ndDQM=;
 b=PKSIZMvQu6EAHkKuCQ8hJdV/b24sDKBNbAGg/5bkqvc8m2FtHOTkoBfb
 0EDA/vAnzdUY31W+23PbgjdhsQi9t+AW6v4RzLFjfr0ffgSJZWeXP4rjM
 iVOeLAs2N7Fl3Vr9VD2GIJeACktlmoClLcS6sZrgMdOX/5Q6Wco/dK441
 jrBJXBYBo9BSNm8BnJn1aipATKEE1c+ceuvSkXYRtma5Jkx8TnDqEuSPL
 8PAl4qJGr3rrF/QPJBTQl7dzhyv+K/pjmb2mioGB5jZFjj9G690IEwqyF
 loxmsBLziTHZHT8FltV1K9SP+LbELhdtF4CF7iQ8HJmuohlWNx6iZ0aWG A==;
X-CSE-ConnectionGUID: f06ZmUBoQ1+e7W738sS5rA==
X-CSE-MsgGUID: VFriEjFgTG2CDyQTs4X/ww==
X-IronPort-AV: E=McAfee;i="6800,10657,11978"; a="4633614"
X-IronPort-AV: E=Sophos;i="6.27,235,1787036400"; 
   d="scan'208";a="4633614"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Nov 2026 10:15:17 -0800
X-CSE-ConnectionGUID: Iia9/9EaRT2xDN5g9r91Eg==
X-CSE-MsgGUID: bYR/2rPxSn+hkB6FxQmfkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,235,1787036400"; d="scan'208";a="12733084"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa001.fm.intel.com with ESMTP; 26 Nov 2026 10:15:15 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v3 22/39] eal: move IOVA mode and process type to runtime cfg
Date: Thu, 26 Nov 2026 18:13:55 +0000
Message-ID: <20261126181414.124094-23-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261126181414.124094-1-bruce.richardson@intel.com>
References: <20260721094555.2188496-1-bruce.richardson@intel.com>
 <20261126181414.124094-1-bruce.richardson@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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
index 86dbb0a1fe..5739939933 100644
--- a/lib/eal/common/eal_common_mcfg.c
+++ b/lib/eal/common/eal_common_mcfg.c
@@ -19,7 +19,7 @@ eal_mcfg_complete(void)
 	struct eal_runtime_state *runtime_state = eal_get_runtime_state();
 
 	/* ALL shared mem_config related INIT DONE */
-	if (cfg->process_type == RTE_PROC_PRIMARY)
+	if (runtime_state->process_type == RTE_PROC_PRIMARY)
 		mcfg->magic = RTE_MAGIC;
 
 	runtime_state->init_complete = 1;
diff --git a/lib/eal/common/eal_internal_cfg.h b/lib/eal/common/eal_internal_cfg.h
index 52822e4c2d..ad232a5b30 100644
--- a/lib/eal/common/eal_internal_cfg.h
+++ b/lib/eal/common/eal_internal_cfg.h
@@ -154,6 +154,8 @@ struct eal_runtime_state {
 	rte_cpuset_t ctrl_cpuset;         /**< cpuset for ctrl threads */
 	volatile unsigned int init_complete;
 	/**< indicates whether EAL has completed initialization */
+	enum rte_proc_type_t process_type; /**< primary or secondary process */
+	enum rte_iova_mode iova_mode; /**< PA or VA IOVA mapping mode */
 	uint32_t main_lcore;          /**< ID of the main lcore */
 	uint32_t lcore_count;         /**< Number of active lcore IDs (role != ROLE_OFF). */
 	struct lcore_cfg lcore_cfg[RTE_MAX_LCORE];
diff --git a/lib/eal/common/eal_private.h b/lib/eal/common/eal_private.h
index b146bd7f50..50b8e1653b 100644
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
index 2cda49ea2d..782514eb09 100644
--- a/lib/eal/freebsd/eal.c
+++ b/lib/eal/freebsd/eal.c
@@ -283,12 +283,12 @@ eal_proc_type_detect(void)
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
@@ -312,8 +312,7 @@ rte_config_init(void)
 		break;
 	case RTE_PROC_AUTO:
 	case RTE_PROC_INVALID:
-		EAL_LOG(ERR, "Invalid process type %d",
-			config->process_type);
+		EAL_LOG(ERR, "Invalid process type %d", runtime_state->process_type);
 		return -1;
 	}
 
@@ -559,7 +558,7 @@ rte_eal_init(int argc, char **argv)
 		goto err_out;
 	}
 
-	rte_eal_get_configuration()->iova_mode = iova_mode;
+	runtime_state->iova_mode = iova_mode;
 	EAL_LOG(INFO, "Selected IOVA mode '%s'",
 		rte_eal_iova_mode() == RTE_IOVA_PA ? "PA" : "VA");
 
diff --git a/lib/eal/linux/eal.c b/lib/eal/linux/eal.c
index cdb8fbb363..b44097d9bf 100644
--- a/lib/eal/linux/eal.c
+++ b/lib/eal/linux/eal.c
@@ -365,12 +365,12 @@ eal_proc_type_detect(void)
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
@@ -395,7 +395,7 @@ rte_config_init(void)
 	case RTE_PROC_AUTO:
 	case RTE_PROC_INVALID:
 		EAL_LOG(ERR, "Invalid process type %d",
-			config->process_type);
+			runtime_state->process_type);
 		return -1;
 	}
 
@@ -714,10 +714,9 @@ rte_eal_init(int argc, char **argv)
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
index ddbf39dbc4..9ff6fbec7a 100644
--- a/lib/eal/windows/eal.c
+++ b/lib/eal/windows/eal.c
@@ -309,7 +309,7 @@ rte_eal_init(int argc, char **argv)
 
 	EAL_LOG(DEBUG, "Selected IOVA mode '%s'",
 		iova_mode == RTE_IOVA_PA ? "PA" : "VA");
-	rte_eal_get_configuration()->iova_mode = iova_mode;
+	runtime_state->iova_mode = iova_mode;
 
 	if (rte_eal_memzone_init() < 0) {
 		rte_eal_init_alert("Cannot init memzone");
-- 
2.55.0

