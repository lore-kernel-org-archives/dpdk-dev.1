Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9503CCD98F0
	for <dpdk-dev@archiver.kernel.org>; Sun, 21 Jun 2026 10:22:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BC2DD402CA;
	Sun, 21 Jun 2026 12:22:32 +0200 (CEST)
Received: from fout-a8-smtp.messagingengine.com
 (fout-a8-smtp.messagingengine.com [103.168.172.151])
 by mails.dpdk.org (Postfix) with ESMTP id A704E402B8
 for <dev@dpdk.org>; Sun, 21 Jun 2026 12:22:30 +0200 (CEST)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfout.phl.internal (Postfix) with ESMTP id 08249EC0174;
 Sun, 21 Jun 2026 06:22:30 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-01.internal (MEProxy); Sun, 21 Jun 2026 06:22:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to; s=fm1; t=1782037350; x=1782123750; bh=kWVrfIMWDd15TmfxbmSEN
 2eyV9rsEHNhKyPld8gF9nA=; b=o3ZQaeC6ir9fevv2Q+EVH4PQNQ1AngXa1Pz7/
 iWLWPVuDtqfzsslk2XcEx2KDodtY2WHWiFYXfS4x9B5kbtAJgXnJuG8vmvM16d26
 t0i2yOBNOEtjLWNIfS6+hFFF+7y8Wk6FhVubuygZyhsRa+2MxK3bjCg0iO4BO7f0
 ATigq4oTXAaGGcVB3/xj7WhNQZCYC65+rndHjNI/OpVX78AOfWUPs4WjhiZs9vZG
 W0caQDzkOdi5voUwiJOhVBSvLkQu4n5PGYCmAAVUNsPePP4j/kvcn27BwEEWV5xY
 n5FE8h3H2rlGnzY0dcsw8a5c6gZI3NwzHRO0uXc1kS5hT1IBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
 1782037350; x=1782123750; bh=kWVrfIMWDd15TmfxbmSEN2eyV9rsEHNhKyP
 ld8gF9nA=; b=i27ChDAJ7pkO0BUHYLJmtXpOdk0ELnUaBAuRktekKf7vxsXxp7i
 MmgkUxR16EYZ/h9oYOhIONqYBRU0StQ8/qeAuDCCD5ATgS25F46pENUVhqaKMGbM
 jLDsxyDAHpA9pbRfHS/SSRHRm/IzC0COKAXSKg2GE/mLdcAqnTbk0C3CpsHFORJx
 1KzVhiCTp7KG8Q6ry4wgcK4XHUbVrp/O7X1EEw7qiiuROfTqiY4bbyPiOFlOgvJw
 MSQgrYsqMdWKz1wIl/XDyDqM/sa/bhju4/NarMY5PTymhipWOU7MCVx6kXvuH8f/
 SdpyYcYjQsCNpbau+iIfa51ZLMbBHHk8AlQ==
X-ME-Sender: <xms:ZLs3ar4aSd0Eg2jUJtU1gdlVryarCcGSUIJoC3OV-4MTdOJAhhoRQQ>
 <xme:ZLs3as4UBzKIPv_cvN2ewFQfpqJWTJmGsz4c10mldlLfmKtBU2iRHY5qPeC_UsSY-
 BmPqV3boGiiWQtLrUXddt3fta-8Dh1NntTx8RVd_webvUo8H8vSQw>
X-ME-Received: <xmr:ZLs3akpAYP5FYMPFoX7hvbQ0mw_sYEt0Z9saoHp7WgP4SZ2H3eLCBbT8czME3IA9Qe9ii1WSiReEYMf6UczjAnyChhL8OY0>
X-ME-Proxy-Cause: dmFkZTEM0fGumU98rBPSZ1c8wrKJHknyCaT4AiMF6KsHKsfhzDQLKAwuSjmqU0+Uh9AaKW
 ILV43Dd1h22vu9FkYqvmvBRkrh9m2XAJ3/+n4AGKI3o0vJpnd9oeiMd0qxRr09vEs7MYM5
 FYCR2MRUySotZFS6UuJ4kAxPHRARfAdNVfgKdChFqRE1uJYdVu3ichfyMp/AvFSe52kBdT
 9imJ7PxM1F0Lw2trCeFuSJ5S0odT0qT8TFbDgCaqXUfHe4m4VZaowF+fKkffO4TQiYcSH1
 Aso7biQvKNLJLAlLghlo56qmhi7rzMpN9Rm95fgkvVQ5Q5nwr+rcZhFn5uWTX6W1Do/EDf
 xqwj3/hqXpz4HjpXm4NHM2iZr7f8+HQwku42rco2aVr8xu6wPJ5QUOImvEXsjjXyJe39HV
 eIQjA53lk+a7zywGomtqqUHmrOkatyk6SRifGxKe9eVvbWKg99OAbLD1pq8hpGfB/DXwX4
 xm5LeCQP9nKvlbwAjsxbsxwGY8/TXfU7zsoaWzIGxDSlyJxxTxuSHEbhJdILHf74JgcsGl
 ZqdIbbRBFTF5loCHkhWMZBCG1VjA3SZ3NXqkDhlT2nGXruQxA7b0kx+fH5Fs1PT3WWBIvo
 Hbotmnb5ivWgPFc6kY+OdqqX4DAJd0e1d/6IzcBrCZNnHfSRUz/9q53R39dg
X-ME-Proxy: <xmx:ZLs3atO7qWu-OwvEKHmUje8FaO3fz6R-ueCf32Ycc2x7bXDy3_SxUA>
 <xmx:ZLs3as1fpv3RSe0532iBo7Tdd6rcDOl5POVGk0lOAoxSu7-CNwbfGg>
 <xmx:ZLs3asCtcZ4A_V_sVV0lIh_idpPRxbDKpDLb-5b-AWQUAewY950HRA>
 <xmx:ZLs3apKqAcdm11sEmK93LajXGlABCTkYu8volCve4yZu6IyilsjWIQ>
 <xmx:Zrs3atjMZ3_OCEcjbVvdaFQ4mRbKEMrnly4eXx0OSN9iWS-ifXN7QGP0>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 21 Jun 2026 06:22:26 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>,
 Cristian Dumitrescu <cristian.dumitrescu@intel.com>,
 Jerin Jacob <jerinj@marvell.com>, Kiran Kumar K <kirankumark@marvell.com>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Zhirun Yan <yanzhirun_163@163.com>, Huisong Li <lihuisong@huawei.com>
Subject: [PATCH] eal: revert prefix of lcore roles
Date: Sun, 21 Jun 2026 12:14:06 +0200
Message-ID: <20260621101406.2776900-1-thomas@monjalon.net>
X-Mailer: git-send-email 2.54.0
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

The CI is not ready to accept changing the prefix of an enum
because some warnings are raised by old versions of abidiff.

Let's revert for now and take time to update the CI labs.

Fixes: c3640830470b ("eal: prefix lcore role values")

Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
---
 app/test/test_lcores.c                       |  2 +-
 app/test/test_mempool.c                      |  2 +-
 drivers/net/softnic/rte_eth_softnic_thread.c |  4 +--
 lib/eal/common/eal_common_lcore.c            | 34 ++++++++++----------
 lib/eal/common/eal_common_options.c          | 28 ++++++++--------
 lib/eal/common/eal_private.h                 |  4 +--
 lib/eal/common/rte_service.c                 | 12 +++----
 lib/eal/include/rte_lcore.h                  | 17 +++-------
 lib/graph/graph.c                            |  2 +-
 9 files changed, 49 insertions(+), 56 deletions(-)

diff --git a/app/test/test_lcores.c b/app/test/test_lcores.c
index 60354b3f7f..13842615d5 100644
--- a/app/test/test_lcores.c
+++ b/app/test/test_lcores.c
@@ -396,7 +396,7 @@ test_lcores(void)
 	unsigned int i;
 
 	for (i = 0; i < RTE_MAX_LCORE; i++) {
-		if (!rte_lcore_has_role(i, RTE_LCORE_ROLE_OFF))
+		if (!rte_lcore_has_role(i, ROLE_OFF))
 			eal_threads_count++;
 	}
 	if (eal_threads_count == 0) {
diff --git a/app/test/test_mempool.c b/app/test/test_mempool.c
index 38f0b6e712..e54249ce61 100644
--- a/app/test/test_mempool.c
+++ b/app/test/test_mempool.c
@@ -353,7 +353,7 @@ test_mempool_sp_sc(void)
 		ret = -1;
 		goto err;
 	}
-	if (rte_eal_lcore_role(lcore_next) != RTE_LCORE_ROLE_RTE) {
+	if (rte_eal_lcore_role(lcore_next) != ROLE_RTE) {
 		ret = -1;
 		goto err;
 	}
diff --git a/drivers/net/softnic/rte_eth_softnic_thread.c b/drivers/net/softnic/rte_eth_softnic_thread.c
index a6d47c8b33..f72c836199 100644
--- a/drivers/net/softnic/rte_eth_softnic_thread.c
+++ b/drivers/net/softnic/rte_eth_softnic_thread.c
@@ -98,9 +98,9 @@ thread_is_valid(struct pmd_internals *softnic, uint32_t thread_id)
 	if (thread_id == rte_get_main_lcore())
 		return 0; /* FALSE */
 
-	if (softnic->params.sc && rte_lcore_has_role(thread_id, RTE_LCORE_ROLE_SERVICE))
+	if (softnic->params.sc && rte_lcore_has_role(thread_id, ROLE_SERVICE))
 		return 1; /* TRUE */
-	if (!softnic->params.sc && rte_lcore_has_role(thread_id, RTE_LCORE_ROLE_RTE))
+	if (!softnic->params.sc && rte_lcore_has_role(thread_id, ROLE_RTE))
 		return 1; /* TRUE */
 
 	return 0; /* FALSE */
diff --git a/lib/eal/common/eal_common_lcore.c b/lib/eal/common/eal_common_lcore.c
index 13999cd527..b5f59a6380 100644
--- a/lib/eal/common/eal_common_lcore.c
+++ b/lib/eal/common/eal_common_lcore.c
@@ -77,7 +77,7 @@ rte_eal_lcore_role(unsigned int lcore_id)
 	struct rte_config *cfg = rte_eal_get_configuration();
 
 	if (lcore_id >= RTE_MAX_LCORE)
-		return RTE_LCORE_ROLE_OFF;
+		return ROLE_OFF;
 	return cfg->lcore_role[lcore_id];
 }
 
@@ -100,7 +100,7 @@ int rte_lcore_is_enabled(unsigned int lcore_id)
 
 	if (lcore_id >= RTE_MAX_LCORE)
 		return 0;
-	return cfg->lcore_role[lcore_id] == RTE_LCORE_ROLE_RTE;
+	return cfg->lcore_role[lcore_id] == ROLE_RTE;
 }
 
 RTE_EXPORT_SYMBOL(rte_get_next_lcore)
@@ -177,7 +177,7 @@ rte_eal_cpu_init(void)
 		lcore_to_socket_id[lcore_id] = socket_id;
 
 		if (eal_cpu_detected(lcore_id) == 0) {
-			config->lcore_role[lcore_id] = RTE_LCORE_ROLE_OFF;
+			config->lcore_role[lcore_id] = ROLE_OFF;
 			lcore_config[lcore_id].core_index = -1;
 			continue;
 		}
@@ -189,8 +189,8 @@ rte_eal_cpu_init(void)
 		rte_bitset_set(config->core_indices, count);
 
 		/* By default, each detected core is enabled */
-		config->lcore_role[lcore_id] = RTE_LCORE_ROLE_RTE;
-		lcore_config[lcore_id].core_role = RTE_LCORE_ROLE_RTE;
+		config->lcore_role[lcore_id] = ROLE_RTE;
+		lcore_config[lcore_id].core_role = ROLE_RTE;
 		lcore_config[lcore_id].core_id = eal_cpu_core_id(lcore_id);
 		lcore_config[lcore_id].numa_id = socket_id;
 		EAL_LOG(DEBUG, "Detected lcore %u as "
@@ -318,7 +318,7 @@ rte_lcore_callback_register(const char *name, rte_lcore_init_cb init,
 	if (callback->init == NULL)
 		goto no_init;
 	for (lcore_id = 0; lcore_id < RTE_MAX_LCORE; lcore_id++) {
-		if (cfg->lcore_role[lcore_id] == RTE_LCORE_ROLE_OFF)
+		if (cfg->lcore_role[lcore_id] == ROLE_OFF)
 			continue;
 		if (callback_init(callback, lcore_id) == 0)
 			continue;
@@ -326,7 +326,7 @@ rte_lcore_callback_register(const char *name, rte_lcore_init_cb init,
 		 * previous lcore.
 		 */
 		while (lcore_id-- != 0) {
-			if (cfg->lcore_role[lcore_id] == RTE_LCORE_ROLE_OFF)
+			if (cfg->lcore_role[lcore_id] == ROLE_OFF)
 				continue;
 			callback_uninit(callback, lcore_id);
 		}
@@ -358,7 +358,7 @@ rte_lcore_callback_unregister(void *handle)
 	if (callback->uninit == NULL)
 		goto no_uninit;
 	for (lcore_id = 0; lcore_id < RTE_MAX_LCORE; lcore_id++) {
-		if (cfg->lcore_role[lcore_id] == RTE_LCORE_ROLE_OFF)
+		if (cfg->lcore_role[lcore_id] == ROLE_OFF)
 			continue;
 		callback_uninit(callback, lcore_id);
 	}
@@ -387,11 +387,11 @@ eal_lcore_non_eal_allocate(void)
 		goto out;
 	}
 	for (lcore_id = 0; lcore_id < RTE_MAX_LCORE; lcore_id++) {
-		if (cfg->lcore_role[lcore_id] != RTE_LCORE_ROLE_OFF)
+		if (cfg->lcore_role[lcore_id] != ROLE_OFF)
 			continue;
 		rte_bitset_set(cfg->core_indices, core_index);
 		lcore_config[lcore_id].core_index = core_index;
-		cfg->lcore_role[lcore_id] = RTE_LCORE_ROLE_NON_EAL;
+		cfg->lcore_role[lcore_id] = ROLE_NON_EAL;
 		cfg->lcore_count++;
 		break;
 	}
@@ -414,7 +414,7 @@ eal_lcore_non_eal_allocate(void)
 			lcore_id);
 		rte_bitset_clear(cfg->core_indices, lcore_config[lcore_id].core_index);
 		lcore_config[lcore_id].core_index = -1;
-		cfg->lcore_role[lcore_id] = RTE_LCORE_ROLE_OFF;
+		cfg->lcore_role[lcore_id] = ROLE_OFF;
 		cfg->lcore_count--;
 		lcore_id = RTE_MAX_LCORE;
 		goto out;
@@ -431,13 +431,13 @@ eal_lcore_non_eal_release(unsigned int lcore_id)
 	struct lcore_callback *callback;
 
 	rte_rwlock_write_lock(&lcore_lock);
-	if (cfg->lcore_role[lcore_id] != RTE_LCORE_ROLE_NON_EAL)
+	if (cfg->lcore_role[lcore_id] != ROLE_NON_EAL)
 		goto out;
 	TAILQ_FOREACH(callback, &lcore_callbacks, next)
 		callback_uninit(callback, lcore_id);
 	rte_bitset_clear(cfg->core_indices, lcore_config[lcore_id].core_index);
 	lcore_config[lcore_id].core_index = -1;
-	cfg->lcore_role[lcore_id] = RTE_LCORE_ROLE_OFF;
+	cfg->lcore_role[lcore_id] = ROLE_OFF;
 	cfg->lcore_count--;
 out:
 	rte_rwlock_write_unlock(&lcore_lock);
@@ -453,7 +453,7 @@ rte_lcore_iterate(rte_lcore_iterate_cb cb, void *arg)
 
 	rte_rwlock_read_lock(&lcore_lock);
 	for (lcore_id = 0; lcore_id < RTE_MAX_LCORE; lcore_id++) {
-		if (cfg->lcore_role[lcore_id] == RTE_LCORE_ROLE_OFF)
+		if (cfg->lcore_role[lcore_id] == ROLE_OFF)
 			continue;
 		ret = cb(lcore_id, arg);
 		if (ret != 0)
@@ -467,11 +467,11 @@ static const char *
 lcore_role_str(enum rte_lcore_role_t role)
 {
 	switch (role) {
-	case RTE_LCORE_ROLE_RTE:
+	case ROLE_RTE:
 		return "RTE";
-	case RTE_LCORE_ROLE_SERVICE:
+	case ROLE_SERVICE:
 		return "SERVICE";
-	case RTE_LCORE_ROLE_NON_EAL:
+	case ROLE_NON_EAL:
 		return "NON_EAL";
 	default:
 		return "UNKNOWN";
diff --git a/lib/eal/common/eal_common_options.c b/lib/eal/common/eal_common_options.c
index 9c50da6075..42cdef632f 100644
--- a/lib/eal/common/eal_common_options.c
+++ b/lib/eal/common/eal_common_options.c
@@ -898,10 +898,10 @@ eal_parse_service_coremask(const char *coremask)
 					return -1;
 				}
 
-				if (cfg->lcore_role[idx] == RTE_LCORE_ROLE_RTE)
+				if (cfg->lcore_role[idx] == ROLE_RTE)
 					taken_lcore_count++;
 
-				lcore_config[idx].core_role = RTE_LCORE_ROLE_SERVICE;
+				lcore_config[idx].core_role = ROLE_SERVICE;
 				count++;
 			}
 		}
@@ -940,7 +940,7 @@ update_lcore_config(const rte_cpuset_t *cpuset, bool remap, uint16_t remap_base)
 	/* set everything to disabled first, then set up values */
 	rte_bitset_clear_all(cfg->core_indices, RTE_MAX_LCORE);
 	for (i = 0; i < RTE_MAX_LCORE; i++) {
-		cfg->lcore_role[i] = RTE_LCORE_ROLE_OFF;
+		cfg->lcore_role[i] = ROLE_OFF;
 		lcore_config[i].core_index = -1;
 	}
 
@@ -969,7 +969,7 @@ update_lcore_config(const rte_cpuset_t *cpuset, bool remap, uint16_t remap_base)
 			}
 
 			rte_bitset_set(cfg->core_indices, count);
-			cfg->lcore_role[lcore_id] = RTE_LCORE_ROLE_RTE;
+			cfg->lcore_role[lcore_id] = ROLE_RTE;
 			lcore_config[lcore_id].core_index = count;
 			CPU_ZERO(&lcore_config[lcore_id].cpuset);
 			CPU_SET(i, &lcore_config[lcore_id].cpuset);
@@ -1141,12 +1141,12 @@ eal_parse_service_corelist(const char *corelist)
 			if (min == RTE_MAX_LCORE)
 				min = idx;
 			for (idx = min; idx <= max; idx++) {
-				if (cfg->lcore_role[idx] != RTE_LCORE_ROLE_SERVICE) {
-					if (cfg->lcore_role[idx] == RTE_LCORE_ROLE_RTE)
+				if (cfg->lcore_role[idx] != ROLE_SERVICE) {
+					if (cfg->lcore_role[idx] == ROLE_RTE)
 						taken_lcore_count++;
 
 					lcore_config[idx].core_role =
-							RTE_LCORE_ROLE_SERVICE;
+							ROLE_SERVICE;
 					count++;
 				}
 			}
@@ -1169,7 +1169,7 @@ eal_parse_service_corelist(const char *corelist)
 	rte_cpuset_t service_cpuset;
 	CPU_ZERO(&service_cpuset);
 	for (i = 0; i < RTE_MAX_LCORE; i++) {
-		if (lcore_config[i].core_role == RTE_LCORE_ROLE_SERVICE)
+		if (lcore_config[i].core_role == ROLE_SERVICE)
 			CPU_SET(i, &service_cpuset);
 	}
 	if (CPU_COUNT(&service_cpuset) > 0) {
@@ -1198,12 +1198,12 @@ eal_parse_main_lcore(const char *arg)
 		return -1;
 
 	/* ensure main core is not used as service core */
-	if (lcore_config[cfg->main_lcore].core_role == RTE_LCORE_ROLE_SERVICE) {
+	if (lcore_config[cfg->main_lcore].core_role == ROLE_SERVICE) {
 		EAL_LOG(ERR, "Error: Main lcore is used as a service core");
 		return -1;
 	}
 	/* check that we have the core recorded in the core list */
-	if (cfg->lcore_role[cfg->main_lcore] != RTE_LCORE_ROLE_RTE) {
+	if (cfg->lcore_role[cfg->main_lcore] != ROLE_RTE) {
 		EAL_LOG(ERR, "Error: Main lcore is not enabled for DPDK");
 		return -1;
 	}
@@ -1393,7 +1393,7 @@ eal_parse_lcores(const char *lcores)
 	/* Reset lcore config */
 	rte_bitset_clear_all(cfg->core_indices, RTE_MAX_LCORE);
 	for (idx = 0; idx < RTE_MAX_LCORE; idx++) {
-		cfg->lcore_role[idx] = RTE_LCORE_ROLE_OFF;
+		cfg->lcore_role[idx] = ROLE_OFF;
 		lcore_config[idx].core_index = -1;
 		CPU_ZERO(&lcore_config[idx].cpuset);
 	}
@@ -1455,10 +1455,10 @@ eal_parse_lcores(const char *lcores)
 				continue;
 			set_count--;
 
-			if (cfg->lcore_role[idx] != RTE_LCORE_ROLE_RTE) {
+			if (cfg->lcore_role[idx] != ROLE_RTE) {
 				rte_bitset_set(cfg->core_indices, count);
 				lcore_config[idx].core_index = count;
-				cfg->lcore_role[idx] = RTE_LCORE_ROLE_RTE;
+				cfg->lcore_role[idx] = ROLE_RTE;
 				count++;
 			}
 
@@ -2437,7 +2437,7 @@ compute_ctrl_threads_cpuset(struct internal_config *internal_cfg)
 	unsigned int lcore_id;
 
 	for (lcore_id = 0; lcore_id < RTE_MAX_LCORE; lcore_id++) {
-		if (rte_lcore_has_role(lcore_id, RTE_LCORE_ROLE_OFF))
+		if (rte_lcore_has_role(lcore_id, ROLE_OFF))
 			continue;
 		RTE_CPU_OR(cpuset, cpuset, &lcore_config[lcore_id].cpuset);
 	}
diff --git a/lib/eal/common/eal_private.h b/lib/eal/common/eal_private.h
index d2336fbe49..6340bab8be 100644
--- a/lib/eal/common/eal_private.h
+++ b/lib/eal/common/eal_private.h
@@ -433,7 +433,7 @@ uint64_t get_tsc_freq_arch(void);
  * Allocate a free lcore to associate to a non-EAL thread.
  *
  * @return
- *   - the id of a lcore with role RTE_LCORE_ROLE_NON_EAL on success.
+ *   - the id of a lcore with role ROLE_NON_EAL on success.
  *   - RTE_MAX_LCORE if none was available or initializing was refused (see
  *     rte_lcore_callback_register).
  */
@@ -444,7 +444,7 @@ unsigned int eal_lcore_non_eal_allocate(void);
  * Counterpart of eal_lcore_non_eal_allocate().
  *
  * @param lcore_id
- *   The lcore with role RTE_LCORE_ROLE_NON_EAL to release.
+ *   The lcore with role ROLE_NON_EAL to release.
  */
 void eal_lcore_non_eal_release(unsigned int lcore_id);
 
diff --git a/lib/eal/common/rte_service.c b/lib/eal/common/rte_service.c
index 5c3a350ae8..d2ac9d3f14 100644
--- a/lib/eal/common/rte_service.c
+++ b/lib/eal/common/rte_service.c
@@ -107,7 +107,7 @@ rte_service_init(void)
 	int i;
 	struct rte_config *cfg = rte_eal_get_configuration();
 	for (i = 0; i < RTE_MAX_LCORE; i++) {
-		if (lcore_config[i].core_role == RTE_LCORE_ROLE_SERVICE) {
+		if (lcore_config[i].core_role == ROLE_SERVICE) {
 			if ((unsigned int)i == cfg->main_lcore)
 				continue;
 			rte_service_lcore_add(i);
@@ -718,7 +718,7 @@ set_lcore_state(uint32_t lcore, int32_t state)
 	lcore_config[lcore].core_role = state;
 
 	/* update per-lcore optimized state tracking */
-	cs->is_service_core = (state == RTE_LCORE_ROLE_SERVICE);
+	cs->is_service_core = (state == ROLE_SERVICE);
 
 	rte_eal_trace_service_lcore_state_change(lcore, state);
 }
@@ -734,7 +734,7 @@ rte_service_lcore_reset_all(void)
 
 		if (cs->is_service_core) {
 			rte_bitset_clear_all(cs->mapped_services, RTE_SERVICE_NUM_MAX);
-			set_lcore_state(i, RTE_LCORE_ROLE_RTE);
+			set_lcore_state(i, ROLE_RTE);
 			/* runstate act as guard variable Use
 			 * store-release memory order here to synchronize
 			 * with load-acquire in runstate read functions.
@@ -761,7 +761,7 @@ rte_service_lcore_add(uint32_t lcore)
 	if (cs->is_service_core)
 		return -EALREADY;
 
-	set_lcore_state(lcore, RTE_LCORE_ROLE_SERVICE);
+	set_lcore_state(lcore, ROLE_SERVICE);
 
 	/* ensure that after adding a core the mask and state are defaults */
 	rte_bitset_clear_all(cs->mapped_services, RTE_SERVICE_NUM_MAX);
@@ -793,7 +793,7 @@ rte_service_lcore_del(uint32_t lcore)
 			RUNSTATE_STOPPED)
 		return -EBUSY;
 
-	set_lcore_state(lcore, RTE_LCORE_ROLE_RTE);
+	set_lcore_state(lcore, ROLE_RTE);
 
 	rte_smp_wmb();
 	return 0;
@@ -1126,7 +1126,7 @@ rte_service_dump(FILE *f, uint32_t id)
 
 	fprintf(f, "Service Cores Summary\n");
 	for (i = 0; i < RTE_MAX_LCORE; i++) {
-		if (lcore_config[i].core_role != RTE_LCORE_ROLE_SERVICE)
+		if (lcore_config[i].core_role != ROLE_SERVICE)
 			continue;
 
 		service_dump_calls_per_lcore(f, i);
diff --git a/lib/eal/include/rte_lcore.h b/lib/eal/include/rte_lcore.h
index 2fc4d0b15b..10f965b4f0 100644
--- a/lib/eal/include/rte_lcore.h
+++ b/lib/eal/include/rte_lcore.h
@@ -31,18 +31,12 @@ RTE_DECLARE_PER_LCORE(unsigned, _lcore_id);  /**< Per thread "lcore id". */
  * The lcore role (used in RTE or not).
  */
 enum rte_lcore_role_t {
-	RTE_LCORE_ROLE_RTE,
-	RTE_LCORE_ROLE_OFF,
-	RTE_LCORE_ROLE_SERVICE,
-	RTE_LCORE_ROLE_NON_EAL,
+	ROLE_RTE,
+	ROLE_OFF,
+	ROLE_SERVICE,
+	ROLE_NON_EAL,
 };
 
-/* Old lcore role aliases for backward compatibility. */
-#define ROLE_RTE	RTE_LCORE_ROLE_RTE
-#define ROLE_OFF	RTE_LCORE_ROLE_OFF
-#define ROLE_SERVICE	RTE_LCORE_ROLE_SERVICE
-#define ROLE_NON_EAL	RTE_LCORE_ROLE_NON_EAL
-
 /**
  * Get a lcore's role.
  *
@@ -314,8 +308,7 @@ rte_lcore_callback_unregister(void *handle);
 typedef int (*rte_lcore_iterate_cb)(unsigned int lcore_id, void *arg);
 
 /**
- * Iterate on all active lcores (RTE_LCORE_ROLE_RTE, RTE_LCORE_ROLE_SERVICE
- * and RTE_LCORE_ROLE_NON_EAL).
+ * Iterate on all active lcores (ROLE_RTE, ROLE_SERVICE and ROLE_NON_EAL).
  * No modification on the lcore states is allowed in the callback.
  *
  * Note: as opposed to init/uninit callbacks, iteration callbacks can be
diff --git a/lib/graph/graph.c b/lib/graph/graph.c
index 8165a0a932..5f8ada2185 100644
--- a/lib/graph/graph.c
+++ b/lib/graph/graph.c
@@ -359,7 +359,7 @@ rte_graph_model_mcore_dispatch_core_bind(rte_graph_t id, int lcore)
 		goto fail;
 	}
 
-	if (rte_lcore_has_role(lcore, RTE_LCORE_ROLE_OFF))
+	if (rte_lcore_has_role(lcore, ROLE_OFF))
 		SET_ERR_JMP(ENOLINK, fail, "lcore %d is invalid", lcore);
 
 	STAILQ_FOREACH(graph, &graph_list, next)
-- 
2.54.0

