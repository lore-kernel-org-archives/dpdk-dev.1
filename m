Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38425CD98E4
	for <dpdk-dev@archiver.kernel.org>; Wed, 17 Jun 2026 10:31:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3F2B340696;
	Wed, 17 Jun 2026 12:31:15 +0200 (CEST)
Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com
 [113.46.200.223])
 by mails.dpdk.org (Postfix) with ESMTP id 3219840674
 for <dev@dpdk.org>; Wed, 17 Jun 2026 12:31:12 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=HU/9rPwJRiF5zWhEFT3kdxRMOB1WQa00SQiAClP0pZ0=;
 b=ctio32RLaRf84WRNnfoBGmNrDzJh6edPAp0v+UApWrdgznJV3SvyipX+dYtUiHqF2cyEk4hoL
 emX8pgICpS9ay58phuruxzYWoh0qa5YjzKGJesM6ywl7G1kTGhjq0MIUljGaSNS8fSf1sA62tFs
 ZXS8bSPn9+ZQlCMAWdFebvc=
Received: from mail.maildlp.com (unknown [172.19.163.200])
 by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4ggKgd1kpyzmV8N;
 Wed, 17 Jun 2026 18:23:09 +0800 (CST)
Received: from kwepemo100005.china.huawei.com (unknown [7.202.195.212])
 by mail.maildlp.com (Postfix) with ESMTPS id 095074056A;
 Wed, 17 Jun 2026 18:31:09 +0800 (CST)
Received: from localhost.localdomain (10.90.31.46) by
 kwepemo100005.china.huawei.com (7.202.195.212) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Wed, 17 Jun 2026 18:31:08 +0800
From: Huisong Li <lihuisong@huawei.com>
To: <thomas@monjalon.net>
CC: <mb@smartsharesystems.com>, <andrew.rybchenko@oktetlabs.ru>,
 <dev@dpdk.org>, <zhanjie9@hisilicon.com>, <lihuisong@huawei.com>
Subject: [PATCH v1 2/5] eal: use new lcore role enum names
Date: Wed, 17 Jun 2026 18:28:31 +0800
Message-ID: <20260617102834.2343356-3-lihuisong@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20260617102834.2343356-1-lihuisong@huawei.com>
References: <20260617102834.2343356-1-lihuisong@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.90.31.46]
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemo100005.china.huawei.com (7.202.195.212)
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

Replace old lcore role enum names with new RTE_LCORE_ prefixed names
in EAL common code.

Signed-off-by: Huisong Li <lihuisong@huawei.com>
---
 lib/eal/common/eal_common_lcore.c   | 34 ++++++++++++++---------------
 lib/eal/common/eal_common_options.c | 28 ++++++++++++------------
 lib/eal/common/eal_private.h        |  4 ++--
 lib/eal/common/rte_service.c        | 12 +++++-----
 4 files changed, 39 insertions(+), 39 deletions(-)

diff --git a/lib/eal/common/eal_common_lcore.c b/lib/eal/common/eal_common_lcore.c
index 39411f9370..021687599b 100644
--- a/lib/eal/common/eal_common_lcore.c
+++ b/lib/eal/common/eal_common_lcore.c
@@ -76,7 +76,7 @@ rte_eal_lcore_role(unsigned int lcore_id)
 	struct rte_config *cfg = rte_eal_get_configuration();
 
 	if (lcore_id >= RTE_MAX_LCORE)
-		return ROLE_OFF;
+		return RTE_LCORE_ROLE_OFF;
 	return cfg->lcore_role[lcore_id];
 }
 
@@ -99,7 +99,7 @@ int rte_lcore_is_enabled(unsigned int lcore_id)
 
 	if (lcore_id >= RTE_MAX_LCORE)
 		return 0;
-	return cfg->lcore_role[lcore_id] == ROLE_RTE;
+	return cfg->lcore_role[lcore_id] == RTE_LCORE_ROLE_RTE;
 }
 
 RTE_EXPORT_SYMBOL(rte_get_next_lcore)
@@ -176,7 +176,7 @@ rte_eal_cpu_init(void)
 		lcore_to_socket_id[lcore_id] = socket_id;
 
 		if (eal_cpu_detected(lcore_id) == 0) {
-			config->lcore_role[lcore_id] = ROLE_OFF;
+			config->lcore_role[lcore_id] = RTE_LCORE_ROLE_OFF;
 			lcore_config[lcore_id].core_index = -1;
 			continue;
 		}
@@ -185,8 +185,8 @@ rte_eal_cpu_init(void)
 		CPU_SET(lcore_id, &lcore_config[lcore_id].cpuset);
 
 		/* By default, each detected core is enabled */
-		config->lcore_role[lcore_id] = ROLE_RTE;
-		lcore_config[lcore_id].core_role = ROLE_RTE;
+		config->lcore_role[lcore_id] = RTE_LCORE_ROLE_RTE;
+		lcore_config[lcore_id].core_role = RTE_LCORE_ROLE_RTE;
 		lcore_config[lcore_id].core_id = eal_cpu_core_id(lcore_id);
 		lcore_config[lcore_id].numa_id = socket_id;
 		EAL_LOG(DEBUG, "Detected lcore %u as "
@@ -314,7 +314,7 @@ rte_lcore_callback_register(const char *name, rte_lcore_init_cb init,
 	if (callback->init == NULL)
 		goto no_init;
 	for (lcore_id = 0; lcore_id < RTE_MAX_LCORE; lcore_id++) {
-		if (cfg->lcore_role[lcore_id] == ROLE_OFF)
+		if (cfg->lcore_role[lcore_id] == RTE_LCORE_ROLE_OFF)
 			continue;
 		if (callback_init(callback, lcore_id) == 0)
 			continue;
@@ -322,7 +322,7 @@ rte_lcore_callback_register(const char *name, rte_lcore_init_cb init,
 		 * previous lcore.
 		 */
 		while (lcore_id-- != 0) {
-			if (cfg->lcore_role[lcore_id] == ROLE_OFF)
+			if (cfg->lcore_role[lcore_id] == RTE_LCORE_ROLE_OFF)
 				continue;
 			callback_uninit(callback, lcore_id);
 		}
@@ -354,7 +354,7 @@ rte_lcore_callback_unregister(void *handle)
 	if (callback->uninit == NULL)
 		goto no_uninit;
 	for (lcore_id = 0; lcore_id < RTE_MAX_LCORE; lcore_id++) {
-		if (cfg->lcore_role[lcore_id] == ROLE_OFF)
+		if (cfg->lcore_role[lcore_id] == RTE_LCORE_ROLE_OFF)
 			continue;
 		callback_uninit(callback, lcore_id);
 	}
@@ -376,9 +376,9 @@ eal_lcore_non_eal_allocate(void)
 
 	rte_rwlock_write_lock(&lcore_lock);
 	for (lcore_id = 0; lcore_id < RTE_MAX_LCORE; lcore_id++) {
-		if (cfg->lcore_role[lcore_id] != ROLE_OFF)
+		if (cfg->lcore_role[lcore_id] != RTE_LCORE_ROLE_OFF)
 			continue;
-		cfg->lcore_role[lcore_id] = ROLE_NON_EAL;
+		cfg->lcore_role[lcore_id] = RTE_LCORE_ROLE_NON_EAL;
 		cfg->lcore_count++;
 		break;
 	}
@@ -399,7 +399,7 @@ eal_lcore_non_eal_allocate(void)
 		}
 		EAL_LOG(DEBUG, "Initialization refused for lcore %u.",
 			lcore_id);
-		cfg->lcore_role[lcore_id] = ROLE_OFF;
+		cfg->lcore_role[lcore_id] = RTE_LCORE_ROLE_OFF;
 		cfg->lcore_count--;
 		lcore_id = RTE_MAX_LCORE;
 		goto out;
@@ -416,11 +416,11 @@ eal_lcore_non_eal_release(unsigned int lcore_id)
 	struct lcore_callback *callback;
 
 	rte_rwlock_write_lock(&lcore_lock);
-	if (cfg->lcore_role[lcore_id] != ROLE_NON_EAL)
+	if (cfg->lcore_role[lcore_id] != RTE_LCORE_ROLE_NON_EAL)
 		goto out;
 	TAILQ_FOREACH(callback, &lcore_callbacks, next)
 		callback_uninit(callback, lcore_id);
-	cfg->lcore_role[lcore_id] = ROLE_OFF;
+	cfg->lcore_role[lcore_id] = RTE_LCORE_ROLE_OFF;
 	cfg->lcore_count--;
 out:
 	rte_rwlock_write_unlock(&lcore_lock);
@@ -436,7 +436,7 @@ rte_lcore_iterate(rte_lcore_iterate_cb cb, void *arg)
 
 	rte_rwlock_read_lock(&lcore_lock);
 	for (lcore_id = 0; lcore_id < RTE_MAX_LCORE; lcore_id++) {
-		if (cfg->lcore_role[lcore_id] == ROLE_OFF)
+		if (cfg->lcore_role[lcore_id] == RTE_LCORE_ROLE_OFF)
 			continue;
 		ret = cb(lcore_id, arg);
 		if (ret != 0)
@@ -450,11 +450,11 @@ static const char *
 lcore_role_str(enum rte_lcore_role_t role)
 {
 	switch (role) {
-	case ROLE_RTE:
+	case RTE_LCORE_ROLE_RTE:
 		return "RTE";
-	case ROLE_SERVICE:
+	case RTE_LCORE_ROLE_SERVICE:
 		return "SERVICE";
-	case ROLE_NON_EAL:
+	case RTE_LCORE_ROLE_NON_EAL:
 		return "NON_EAL";
 	default:
 		return "UNKNOWN";
diff --git a/lib/eal/common/eal_common_options.c b/lib/eal/common/eal_common_options.c
index 1049838d73..6dd748e37e 100644
--- a/lib/eal/common/eal_common_options.c
+++ b/lib/eal/common/eal_common_options.c
@@ -898,10 +898,10 @@ eal_parse_service_coremask(const char *coremask)
 					return -1;
 				}
 
-				if (cfg->lcore_role[idx] == ROLE_RTE)
+				if (cfg->lcore_role[idx] == RTE_LCORE_ROLE_RTE)
 					taken_lcore_count++;
 
-				lcore_config[idx].core_role = ROLE_SERVICE;
+				lcore_config[idx].core_role = RTE_LCORE_ROLE_SERVICE;
 				count++;
 			}
 		}
@@ -938,7 +938,7 @@ update_lcore_config(const rte_cpuset_t *cpuset, bool remap, uint16_t remap_base)
 
 	/* set everything to disabled first, then set up values */
 	for (i = 0; i < RTE_MAX_LCORE; i++) {
-		cfg->lcore_role[i] = ROLE_OFF;
+		cfg->lcore_role[i] = RTE_LCORE_ROLE_OFF;
 		lcore_config[i].core_index = -1;
 	}
 
@@ -966,7 +966,7 @@ update_lcore_config(const rte_cpuset_t *cpuset, bool remap, uint16_t remap_base)
 				continue;
 			}
 
-			cfg->lcore_role[lcore_id] = ROLE_RTE;
+			cfg->lcore_role[lcore_id] = RTE_LCORE_ROLE_RTE;
 			lcore_config[lcore_id].core_index = count;
 			CPU_ZERO(&lcore_config[lcore_id].cpuset);
 			CPU_SET(i, &lcore_config[lcore_id].cpuset);
@@ -1138,12 +1138,12 @@ eal_parse_service_corelist(const char *corelist)
 			if (min == RTE_MAX_LCORE)
 				min = idx;
 			for (idx = min; idx <= max; idx++) {
-				if (cfg->lcore_role[idx] != ROLE_SERVICE) {
-					if (cfg->lcore_role[idx] == ROLE_RTE)
+				if (cfg->lcore_role[idx] != RTE_LCORE_ROLE_SERVICE) {
+					if (cfg->lcore_role[idx] == RTE_LCORE_ROLE_RTE)
 						taken_lcore_count++;
 
 					lcore_config[idx].core_role =
-							ROLE_SERVICE;
+							RTE_LCORE_ROLE_SERVICE;
 					count++;
 				}
 			}
@@ -1166,7 +1166,7 @@ eal_parse_service_corelist(const char *corelist)
 	rte_cpuset_t service_cpuset;
 	CPU_ZERO(&service_cpuset);
 	for (i = 0; i < RTE_MAX_LCORE; i++) {
-		if (lcore_config[i].core_role == ROLE_SERVICE)
+		if (lcore_config[i].core_role == RTE_LCORE_ROLE_SERVICE)
 			CPU_SET(i, &service_cpuset);
 	}
 	if (CPU_COUNT(&service_cpuset) > 0) {
@@ -1195,12 +1195,12 @@ eal_parse_main_lcore(const char *arg)
 		return -1;
 
 	/* ensure main core is not used as service core */
-	if (lcore_config[cfg->main_lcore].core_role == ROLE_SERVICE) {
+	if (lcore_config[cfg->main_lcore].core_role == RTE_LCORE_ROLE_SERVICE) {
 		EAL_LOG(ERR, "Error: Main lcore is used as a service core");
 		return -1;
 	}
 	/* check that we have the core recorded in the core list */
-	if (cfg->lcore_role[cfg->main_lcore] != ROLE_RTE) {
+	if (cfg->lcore_role[cfg->main_lcore] != RTE_LCORE_ROLE_RTE) {
 		EAL_LOG(ERR, "Error: Main lcore is not enabled for DPDK");
 		return -1;
 	}
@@ -1389,7 +1389,7 @@ eal_parse_lcores(const char *lcores)
 
 	/* Reset lcore config */
 	for (idx = 0; idx < RTE_MAX_LCORE; idx++) {
-		cfg->lcore_role[idx] = ROLE_OFF;
+		cfg->lcore_role[idx] = RTE_LCORE_ROLE_OFF;
 		lcore_config[idx].core_index = -1;
 		CPU_ZERO(&lcore_config[idx].cpuset);
 	}
@@ -1451,9 +1451,9 @@ eal_parse_lcores(const char *lcores)
 				continue;
 			set_count--;
 
-			if (cfg->lcore_role[idx] != ROLE_RTE) {
+			if (cfg->lcore_role[idx] != RTE_LCORE_ROLE_RTE) {
 				lcore_config[idx].core_index = count;
-				cfg->lcore_role[idx] = ROLE_RTE;
+				cfg->lcore_role[idx] = RTE_LCORE_ROLE_RTE;
 				count++;
 			}
 
@@ -2432,7 +2432,7 @@ compute_ctrl_threads_cpuset(struct internal_config *internal_cfg)
 	unsigned int lcore_id;
 
 	for (lcore_id = 0; lcore_id < RTE_MAX_LCORE; lcore_id++) {
-		if (rte_lcore_has_role(lcore_id, ROLE_OFF))
+		if (rte_lcore_has_role(lcore_id, RTE_LCORE_ROLE_OFF))
 			continue;
 		RTE_CPU_OR(cpuset, cpuset, &lcore_config[lcore_id].cpuset);
 	}
diff --git a/lib/eal/common/eal_private.h b/lib/eal/common/eal_private.h
index 0c0544beaf..dff3565099 100644
--- a/lib/eal/common/eal_private.h
+++ b/lib/eal/common/eal_private.h
@@ -430,7 +430,7 @@ uint64_t get_tsc_freq_arch(void);
  * Allocate a free lcore to associate to a non-EAL thread.
  *
  * @return
- *   - the id of a lcore with role ROLE_NON_EAL on success.
+ *   - the id of a lcore with role RTE_LCORE_ROLE_NON_EAL on success.
  *   - RTE_MAX_LCORE if none was available or initializing was refused (see
  *     rte_lcore_callback_register).
  */
@@ -441,7 +441,7 @@ unsigned int eal_lcore_non_eal_allocate(void);
  * Counterpart of eal_lcore_non_eal_allocate().
  *
  * @param lcore_id
- *   The lcore with role ROLE_NON_EAL to release.
+ *   The lcore with role RTE_LCORE_ROLE_NON_EAL to release.
  */
 void eal_lcore_non_eal_release(unsigned int lcore_id);
 
diff --git a/lib/eal/common/rte_service.c b/lib/eal/common/rte_service.c
index d2ac9d3f14..5c3a350ae8 100644
--- a/lib/eal/common/rte_service.c
+++ b/lib/eal/common/rte_service.c
@@ -107,7 +107,7 @@ rte_service_init(void)
 	int i;
 	struct rte_config *cfg = rte_eal_get_configuration();
 	for (i = 0; i < RTE_MAX_LCORE; i++) {
-		if (lcore_config[i].core_role == ROLE_SERVICE) {
+		if (lcore_config[i].core_role == RTE_LCORE_ROLE_SERVICE) {
 			if ((unsigned int)i == cfg->main_lcore)
 				continue;
 			rte_service_lcore_add(i);
@@ -718,7 +718,7 @@ set_lcore_state(uint32_t lcore, int32_t state)
 	lcore_config[lcore].core_role = state;
 
 	/* update per-lcore optimized state tracking */
-	cs->is_service_core = (state == ROLE_SERVICE);
+	cs->is_service_core = (state == RTE_LCORE_ROLE_SERVICE);
 
 	rte_eal_trace_service_lcore_state_change(lcore, state);
 }
@@ -734,7 +734,7 @@ rte_service_lcore_reset_all(void)
 
 		if (cs->is_service_core) {
 			rte_bitset_clear_all(cs->mapped_services, RTE_SERVICE_NUM_MAX);
-			set_lcore_state(i, ROLE_RTE);
+			set_lcore_state(i, RTE_LCORE_ROLE_RTE);
 			/* runstate act as guard variable Use
 			 * store-release memory order here to synchronize
 			 * with load-acquire in runstate read functions.
@@ -761,7 +761,7 @@ rte_service_lcore_add(uint32_t lcore)
 	if (cs->is_service_core)
 		return -EALREADY;
 
-	set_lcore_state(lcore, ROLE_SERVICE);
+	set_lcore_state(lcore, RTE_LCORE_ROLE_SERVICE);
 
 	/* ensure that after adding a core the mask and state are defaults */
 	rte_bitset_clear_all(cs->mapped_services, RTE_SERVICE_NUM_MAX);
@@ -793,7 +793,7 @@ rte_service_lcore_del(uint32_t lcore)
 			RUNSTATE_STOPPED)
 		return -EBUSY;
 
-	set_lcore_state(lcore, ROLE_RTE);
+	set_lcore_state(lcore, RTE_LCORE_ROLE_RTE);
 
 	rte_smp_wmb();
 	return 0;
@@ -1126,7 +1126,7 @@ rte_service_dump(FILE *f, uint32_t id)
 
 	fprintf(f, "Service Cores Summary\n");
 	for (i = 0; i < RTE_MAX_LCORE; i++) {
-		if (lcore_config[i].core_role != ROLE_SERVICE)
+		if (lcore_config[i].core_role != RTE_LCORE_ROLE_SERVICE)
 			continue;
 
 		service_dump_calls_per_lcore(f, i);
-- 
2.33.0

