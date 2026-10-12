Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3F80CA9ED1
	for <dpdk-dev@archiver.kernel.org>; Mon, 12 Oct 2026 14:10:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D782B40272;
	Mon, 12 Oct 2026 16:10:46 +0200 (CEST)
Received: from fout-a2-smtp.messagingengine.com
 (fout-a2-smtp.messagingengine.com [103.168.172.145])
 by mails.dpdk.org (Postfix) with ESMTP id AAC4F4026D
 for <dev@dpdk.org>; Mon, 12 Oct 2026 16:10:45 +0200 (CEST)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfout.phl.internal (Postfix) with ESMTP id 0FB47EC0835
 for <dev@dpdk.org>; Mon, 12 Oct 2026 10:10:45 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-02.internal (MEProxy); Mon, 12 Oct 2026 10:10:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:message-id:mime-version:reply-to
 :subject:subject:to:to; s=fm2; t=1791814245; x=1791900645; bh=G5
 cbhGEnTLClwg/ZXKq/KBtRl0AoaznJxrt0JtFq6ww=; b=Is3t+5hFDG0WqHbZk8
 KHzRhbZVNMkEWKdMAgsNum6+ea1rODCM9Sy/en0L5hUsxu3ZJt5YnVCtkv0n3jmr
 VjT7oL3MTCRgX3npgjjtC5hJuBoMy6MMf204G+e6FvsxL94dWEuO9LxX3ID5asud
 uyaVYIkLjiOi8ijz6K2k+MgxALgxfFMgN0tdh1qtQ1umyMbfTMELNoPjMsrZopND
 J0ewa4xSvPGq9LX8QNkJj/SSFZgFPTusFWk6tGn1KA7PX+5drDulFJsLIzYXrXW6
 26ltOjGCcnaTRxMKF7i+lESH0bwIek4ZuVdHBtp7D4BU2ITyXEo4ZOYdtw19d4zr
 k5Zw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm2; t=1791814245; x=1791900645; bh=G5cbhGEnTLClwg/ZXKq/KBtRl0Ao
 aznJxrt0JtFq6ww=; b=xpbKIKHKKwdmKlok1uVmdLC8RqicqKrlromlePJ8J1Ke
 pIXiUcQblTqAIqDYQRFdvxq/fJfGpxOOGw7zkZ4h6v0RDRYzH2ImP7/LHQXcQg+M
 VEdaUqG7a3EWqLVinRsCMRg28VE2c9FuqaSkJAxYBe0OTpksqsssoNwnjnnh5Bn2
 bYp7FRTdlMgte1kYVNmdMZdreHdRKKrO4qO30ma3/oNdLKmphxzjluiWmBC+2kAF
 /vyLtVbYI9YrD88XVlLtPeG2b2sneeyawucQ3+9surDavfgkioxi0vwXif9l98zC
 Xzc5f1r+1t7Fvg0RoKpYACUt1JK/3xRh5o5vF6pHsA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
 action=sign d=monjalon.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791814245; d=monjalon.net;
 mf=PHRob21hc0Btb25qYWxvbi5uZXQ+; rt=PGRldkBkcGRrLm9yZz4=;
 s=fm2:rsa-sha256:SWkqS+t5kw5UraHXy72UkPZtrzYbC7KlR6vTGmwUpU2p6sR
 GQL8Z5O5zRM0vHH3XHiNgbiwoB9u6hnipPyFs6oLqdU9Bx7wNYuiwl+j6LGyi7TJ
 FtsFapXT7UNZJPZLmgnnWh4zYqziK3pIiasf14XP5D1nb8V8rJz8dcAhjsqC35Ns
 PTG9jwhtRi/atI7qAZWSUcBtPEK4xLzJGIeKKdIptJDzUVS4YX+f12E7WLIPj+Fj
 3crUO48Jp6gE036v9MVyO6QI5vqjZPuOTV4ikAJcjFpAK29bJlfpnjYitZHc3uLq
 AVPQxRBVLfuBplAMOn3mHq5PQ2ehwWqXesnnhtA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
 action=mi-m=1; hc=10;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,message-id,mime-version,subject,to;
Message-Instance: m=1;
 h=sha256:Pc8AO3L64nYTBScxen31ArK44FUo8Bo9TMgkpmJwI+E=:EIxN8QjL9xFlDfK/iBl+sAnttanXmgNZyJn3yTWkHS4=;
X-ME-Sender: <xms:ZOrMart1ISA6gtXc2Gsq79buoMHmZGrJ61vPvxAa2Vlc-KXUMHs6Ug>
 <xme:ZOrMaocgIVHW3loL5HatuZJ-09l13ny29yGrsE6vZ0k1CP8Pgujlh1hAAKvIyhD2-
 B3xqNHEM5x4YNlgIkAVf2PrTSrF9RJ6PU44tS37mX2-Ep5tSnPNzPI>
X-ME-Received: <xmr:ZOrMag90i9-kZlJPyxyAwoHuTAFwpH5FPyh-vmuEOjgwJPy3GlREf3eoe1yA71NSi8AoOMj_15uwrctdQAkV6PX9PDew>
X-ME-Proxy-Cause: dmFkZTGRgNzj/OXowYkb9cn4khQRZL28fKXKEQ8uVcP6ySq0C9kx5K71MbVcEM1R0bQdWb
 Yw8DpLSgddLlc9gi33NdJFODLJJdTCnWq2Z81Q5nhdgD7YCBo2dzstALSKpLwPnurQLPh3
 4szNk8zf1pZ5xX+MHL4jg9kARCZ6YUjqSAS4S2Kp4eTU7yGcMtW1X4jJ5Kb/SLwX2x3ye0
 dDOEW8C1sEq0q8J9jODQ6UBRuYFcPo18cbEXhNy/lGwBbZRWZWSzglnvHH8WE/TkxPR90F
 kzFdy/21xy3es8Wuv17pxTvUk/XmgCOvApAoo8ZZOp1uuDluMVegEPc09Zw3VueJnV4Lkj
 l12Zk1Vnawt7K7G0XBaVDTLYnIQm42+9TYGOd6txovNhh26p+5eEM6nZMONm19AORAeGWC
 PvV5lilFRtG6f3RtPRvHYFVPzvd4iMAU8ejhLbnkXWFt3ObxqDuGfqss7SrLjigAY2eGiN
 ReB6jO2Z3c/Ooyn741J8/Kc/hY+oid5KgQZ0ippu1w21aVyOjDe6gq1dD+vspuapG0mV5W
 7ArQrl4uzebDfCBcE2YWCD/XEbh9Xj6GlvtGZhsDemSceELHM63vJYm/EfmTyKOx+FzvaB
 M1zZdvV9Wdm3p8HtdKWw5aHGGP9LdhzzGK3irwZGs1wpxSDLzKKKzKCZ5lbA
X-ME-Proxy: <xmx:ZOrMarTELas8aChhmUuy6mdDimvK-tQEBw8zrqUOI_01f4_hjKfiNg>
 <xmx:ZOrMappNRPYC7FxXHh4A8SheOsGCTKw7GDQfkzBIARRLMu4jVXcQPQ>
 <xmx:ZOrMagkcUly7eaOYNrNVRiy9MyZpNfOtW9-BbOBQBeGAUh11teoglg>
 <xmx:ZOrMaqc18jsfIJZbk-7rovaJupakANKot2-oNhYd_tknHEzWzvKNIA>
 <xmx:ZerMakGNzrZj0yaAeNsxqSM3IAz7KIAbemuTa6QVkxT1aRwR9MQkq6iV>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Oct 2026 10:10:42 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: Huisong Li <lihuisong@huawei.com>,
 =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Cristian Dumitrescu <cristian.dumitrescu@intel.com>,
 Jerin Jacob <jerinj@marvell.com>, Kiran Kumar K <kirankumark@marvell.com>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Zhirun Yan <yanzhirun_163@163.com>
Subject: [PATCH] eal: prefix lcore role values
Date: Mon, 12 Oct 2026 16:09:10 +0200
Message-ID: <20261012141037.1451851-1-thomas@monjalon.net>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Huisong Li <lihuisong@huawei.com>

Add the RTE_LCORE_ prefix to the lcore role enum values in
rte_lcore_role_t to follow DPDK naming conventions.

- ROLE_RTE      -> RTE_LCORE_ROLE_RTE
- ROLE_OFF      -> RTE_LCORE_ROLE_OFF
- ROLE_SERVICE  -> RTE_LCORE_ROLE_SERVICE
- ROLE_NON_EAL  -> RTE_LCORE_ROLE_NON_EAL

Old names are kept as macros aliasing to the new names to preserve
backward compatibility.

Suggested-by: Thomas Monjalon <thomas@monjalon.net>
Signed-off-by: Huisong Li <lihuisong@huawei.com>
Acked-by: Morten Brørup <mb@smartsharesystems.com>
---
This patch has been reverted in June because our CI was not ready.
Applying it in 26.11 will be easier because there is no ABI check.
---
 app/test/test_lcores.c                       |  2 +-
 app/test/test_mempool.c                      |  2 +-
 drivers/net/softnic/rte_eth_softnic_thread.c |  4 +--
 lib/eal/common/eal_common_lcore.c            | 34 ++++++++++----------
 lib/eal/common/eal_common_options.c          | 28 ++++++++--------
 lib/eal/common/eal_private.h                 |  4 +--
 lib/eal/common/rte_service.c                 | 12 +++----
 lib/eal/include/rte_lcore.h                  | 17 +++++++---
 lib/graph/graph.c                            |  2 +-
 9 files changed, 56 insertions(+), 49 deletions(-)

diff --git a/app/test/test_lcores.c b/app/test/test_lcores.c
index 13842615d5..60354b3f7f 100644
--- a/app/test/test_lcores.c
+++ b/app/test/test_lcores.c
@@ -396,7 +396,7 @@ test_lcores(void)
 	unsigned int i;
 
 	for (i = 0; i < RTE_MAX_LCORE; i++) {
-		if (!rte_lcore_has_role(i, ROLE_OFF))
+		if (!rte_lcore_has_role(i, RTE_LCORE_ROLE_OFF))
 			eal_threads_count++;
 	}
 	if (eal_threads_count == 0) {
diff --git a/app/test/test_mempool.c b/app/test/test_mempool.c
index f1e8adeef9..58ca51ffe8 100644
--- a/app/test/test_mempool.c
+++ b/app/test/test_mempool.c
@@ -355,7 +355,7 @@ test_mempool_sp_sc(void)
 		ret = -1;
 		goto err;
 	}
-	if (rte_eal_lcore_role(lcore_next) != ROLE_RTE) {
+	if (rte_eal_lcore_role(lcore_next) != RTE_LCORE_ROLE_RTE) {
 		ret = -1;
 		goto err;
 	}
diff --git a/drivers/net/softnic/rte_eth_softnic_thread.c b/drivers/net/softnic/rte_eth_softnic_thread.c
index f72c836199..a6d47c8b33 100644
--- a/drivers/net/softnic/rte_eth_softnic_thread.c
+++ b/drivers/net/softnic/rte_eth_softnic_thread.c
@@ -98,9 +98,9 @@ thread_is_valid(struct pmd_internals *softnic, uint32_t thread_id)
 	if (thread_id == rte_get_main_lcore())
 		return 0; /* FALSE */
 
-	if (softnic->params.sc && rte_lcore_has_role(thread_id, ROLE_SERVICE))
+	if (softnic->params.sc && rte_lcore_has_role(thread_id, RTE_LCORE_ROLE_SERVICE))
 		return 1; /* TRUE */
-	if (!softnic->params.sc && rte_lcore_has_role(thread_id, ROLE_RTE))
+	if (!softnic->params.sc && rte_lcore_has_role(thread_id, RTE_LCORE_ROLE_RTE))
 		return 1; /* TRUE */
 
 	return 0; /* FALSE */
diff --git a/lib/eal/common/eal_common_lcore.c b/lib/eal/common/eal_common_lcore.c
index 1b6d77d8bc..3ddacdb8ce 100644
--- a/lib/eal/common/eal_common_lcore.c
+++ b/lib/eal/common/eal_common_lcore.c
@@ -78,7 +78,7 @@ rte_eal_lcore_role(unsigned int lcore_id)
 	struct rte_config *cfg = rte_eal_get_configuration();
 
 	if (lcore_id >= RTE_MAX_LCORE)
-		return ROLE_OFF;
+		return RTE_LCORE_ROLE_OFF;
 	return cfg->lcore_role[lcore_id];
 }
 
@@ -101,7 +101,7 @@ int rte_lcore_is_enabled(unsigned int lcore_id)
 
 	if (lcore_id >= RTE_MAX_LCORE)
 		return 0;
-	return cfg->lcore_role[lcore_id] == ROLE_RTE;
+	return cfg->lcore_role[lcore_id] == RTE_LCORE_ROLE_RTE;
 }
 
 RTE_EXPORT_SYMBOL(rte_get_next_lcore)
@@ -188,7 +188,7 @@ rte_eal_cpu_init(void)
 		lcore_to_socket_id[lcore_id] = socket_id;
 
 		if (eal_cpu_detected(lcore_id) == 0) {
-			config->lcore_role[lcore_id] = ROLE_OFF;
+			config->lcore_role[lcore_id] = RTE_LCORE_ROLE_OFF;
 			lcore_config[lcore_id].core_index = -1;
 			continue;
 		}
@@ -200,8 +200,8 @@ rte_eal_cpu_init(void)
 		rte_bitset_set(config->core_indices, count);
 
 		/* By default, each detected core is enabled */
-		config->lcore_role[lcore_id] = ROLE_RTE;
-		lcore_config[lcore_id].core_role = ROLE_RTE;
+		config->lcore_role[lcore_id] = RTE_LCORE_ROLE_RTE;
+		lcore_config[lcore_id].core_role = RTE_LCORE_ROLE_RTE;
 		lcore_config[lcore_id].core_id = eal_cpu_core_id(lcore_id);
 		lcore_config[lcore_id].numa_id = socket_id;
 		EAL_LOG(DEBUG, "Detected lcore %u as "
@@ -329,7 +329,7 @@ rte_lcore_callback_register(const char *name, rte_lcore_init_cb init,
 	if (callback->init == NULL)
 		goto no_init;
 	for (lcore_id = 0; lcore_id < RTE_MAX_LCORE; lcore_id++) {
-		if (cfg->lcore_role[lcore_id] == ROLE_OFF)
+		if (cfg->lcore_role[lcore_id] == RTE_LCORE_ROLE_OFF)
 			continue;
 		if (callback_init(callback, lcore_id) == 0)
 			continue;
@@ -337,7 +337,7 @@ rte_lcore_callback_register(const char *name, rte_lcore_init_cb init,
 		 * previous lcore.
 		 */
 		while (lcore_id-- != 0) {
-			if (cfg->lcore_role[lcore_id] == ROLE_OFF)
+			if (cfg->lcore_role[lcore_id] == RTE_LCORE_ROLE_OFF)
 				continue;
 			callback_uninit(callback, lcore_id);
 		}
@@ -369,7 +369,7 @@ rte_lcore_callback_unregister(void *handle)
 	if (callback->uninit == NULL)
 		goto no_uninit;
 	for (lcore_id = 0; lcore_id < RTE_MAX_LCORE; lcore_id++) {
-		if (cfg->lcore_role[lcore_id] == ROLE_OFF)
+		if (cfg->lcore_role[lcore_id] == RTE_LCORE_ROLE_OFF)
 			continue;
 		callback_uninit(callback, lcore_id);
 	}
@@ -398,11 +398,11 @@ eal_lcore_non_eal_allocate(void)
 		goto out;
 	}
 	for (lcore_id = 0; lcore_id < RTE_MAX_LCORE; lcore_id++) {
-		if (cfg->lcore_role[lcore_id] != ROLE_OFF)
+		if (cfg->lcore_role[lcore_id] != RTE_LCORE_ROLE_OFF)
 			continue;
 		rte_bitset_set(cfg->core_indices, core_index);
 		lcore_config[lcore_id].core_index = core_index;
-		cfg->lcore_role[lcore_id] = ROLE_NON_EAL;
+		cfg->lcore_role[lcore_id] = RTE_LCORE_ROLE_NON_EAL;
 		cfg->lcore_count++;
 		break;
 	}
@@ -425,7 +425,7 @@ eal_lcore_non_eal_allocate(void)
 			lcore_id);
 		rte_bitset_clear(cfg->core_indices, lcore_config[lcore_id].core_index);
 		lcore_config[lcore_id].core_index = -1;
-		cfg->lcore_role[lcore_id] = ROLE_OFF;
+		cfg->lcore_role[lcore_id] = RTE_LCORE_ROLE_OFF;
 		cfg->lcore_count--;
 		lcore_id = RTE_MAX_LCORE;
 		goto out;
@@ -442,13 +442,13 @@ eal_lcore_non_eal_release(unsigned int lcore_id)
 	struct lcore_callback *callback;
 
 	rte_rwlock_write_lock(&lcore_lock);
-	if (cfg->lcore_role[lcore_id] != ROLE_NON_EAL)
+	if (cfg->lcore_role[lcore_id] != RTE_LCORE_ROLE_NON_EAL)
 		goto out;
 	TAILQ_FOREACH(callback, &lcore_callbacks, next)
 		callback_uninit(callback, lcore_id);
 	rte_bitset_clear(cfg->core_indices, lcore_config[lcore_id].core_index);
 	lcore_config[lcore_id].core_index = -1;
-	cfg->lcore_role[lcore_id] = ROLE_OFF;
+	cfg->lcore_role[lcore_id] = RTE_LCORE_ROLE_OFF;
 	cfg->lcore_count--;
 out:
 	rte_rwlock_write_unlock(&lcore_lock);
@@ -464,7 +464,7 @@ rte_lcore_iterate(rte_lcore_iterate_cb cb, void *arg)
 
 	rte_rwlock_read_lock(&lcore_lock);
 	for (lcore_id = 0; lcore_id < RTE_MAX_LCORE; lcore_id++) {
-		if (cfg->lcore_role[lcore_id] == ROLE_OFF)
+		if (cfg->lcore_role[lcore_id] == RTE_LCORE_ROLE_OFF)
 			continue;
 		ret = cb(lcore_id, arg);
 		if (ret != 0)
@@ -478,11 +478,11 @@ static const char *
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
index aa91d76355..b2c0744447 100644
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
@@ -940,7 +940,7 @@ update_lcore_config(const rte_cpuset_t *cpuset, bool remap, uint16_t remap_base)
 	/* set everything to disabled first, then set up values */
 	rte_bitset_clear_all(cfg->core_indices, RTE_MAX_LCORE);
 	for (i = 0; i < RTE_MAX_LCORE; i++) {
-		cfg->lcore_role[i] = ROLE_OFF;
+		cfg->lcore_role[i] = RTE_LCORE_ROLE_OFF;
 		lcore_config[i].core_index = -1;
 	}
 
@@ -969,7 +969,7 @@ update_lcore_config(const rte_cpuset_t *cpuset, bool remap, uint16_t remap_base)
 			}
 
 			rte_bitset_set(cfg->core_indices, count);
-			cfg->lcore_role[lcore_id] = ROLE_RTE;
+			cfg->lcore_role[lcore_id] = RTE_LCORE_ROLE_RTE;
 			lcore_config[lcore_id].core_index = count;
 			CPU_ZERO(&lcore_config[lcore_id].cpuset);
 			CPU_SET(i, &lcore_config[lcore_id].cpuset);
@@ -1141,12 +1141,12 @@ eal_parse_service_corelist(const char *corelist)
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
@@ -1169,7 +1169,7 @@ eal_parse_service_corelist(const char *corelist)
 	rte_cpuset_t service_cpuset;
 	CPU_ZERO(&service_cpuset);
 	for (i = 0; i < RTE_MAX_LCORE; i++) {
-		if (lcore_config[i].core_role == ROLE_SERVICE)
+		if (lcore_config[i].core_role == RTE_LCORE_ROLE_SERVICE)
 			CPU_SET(i, &service_cpuset);
 	}
 	if (CPU_COUNT(&service_cpuset) > 0) {
@@ -1198,12 +1198,12 @@ eal_parse_main_lcore(const char *arg)
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
@@ -1393,7 +1393,7 @@ eal_parse_lcores(const char *lcores)
 	/* Reset lcore config */
 	rte_bitset_clear_all(cfg->core_indices, RTE_MAX_LCORE);
 	for (idx = 0; idx < RTE_MAX_LCORE; idx++) {
-		cfg->lcore_role[idx] = ROLE_OFF;
+		cfg->lcore_role[idx] = RTE_LCORE_ROLE_OFF;
 		lcore_config[idx].core_index = -1;
 		CPU_ZERO(&lcore_config[idx].cpuset);
 	}
@@ -1455,10 +1455,10 @@ eal_parse_lcores(const char *lcores)
 				continue;
 			set_count--;
 
-			if (cfg->lcore_role[idx] != ROLE_RTE) {
+			if (cfg->lcore_role[idx] != RTE_LCORE_ROLE_RTE) {
 				rte_bitset_set(cfg->core_indices, count);
 				lcore_config[idx].core_index = count;
-				cfg->lcore_role[idx] = ROLE_RTE;
+				cfg->lcore_role[idx] = RTE_LCORE_ROLE_RTE;
 				count++;
 			}
 
@@ -2436,7 +2436,7 @@ compute_ctrl_threads_cpuset(struct internal_config *internal_cfg)
 	unsigned int lcore_id;
 
 	for (lcore_id = 0; lcore_id < RTE_MAX_LCORE; lcore_id++) {
-		if (rte_lcore_has_role(lcore_id, ROLE_OFF))
+		if (rte_lcore_has_role(lcore_id, RTE_LCORE_ROLE_OFF))
 			continue;
 		RTE_CPU_OR(cpuset, cpuset, &lcore_config[lcore_id].cpuset);
 	}
diff --git a/lib/eal/common/eal_private.h b/lib/eal/common/eal_private.h
index 8507791ec2..03563eb04d 100644
--- a/lib/eal/common/eal_private.h
+++ b/lib/eal/common/eal_private.h
@@ -419,7 +419,7 @@ uint64_t get_tsc_freq_arch(void);
  * Allocate a free lcore to associate to a non-EAL thread.
  *
  * @return
- *   - the id of a lcore with role ROLE_NON_EAL on success.
+ *   - the id of a lcore with role RTE_LCORE_ROLE_NON_EAL on success.
  *   - RTE_MAX_LCORE if none was available or initializing was refused (see
  *     rte_lcore_callback_register).
  */
@@ -430,7 +430,7 @@ unsigned int eal_lcore_non_eal_allocate(void);
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
diff --git a/lib/eal/include/rte_lcore.h b/lib/eal/include/rte_lcore.h
index 696ae9ec95..1b192a6727 100644
--- a/lib/eal/include/rte_lcore.h
+++ b/lib/eal/include/rte_lcore.h
@@ -31,12 +31,18 @@ RTE_DECLARE_PER_LCORE(unsigned, _lcore_id);  /**< Per thread "lcore id". */
  * The lcore role (used in RTE or not).
  */
 enum rte_lcore_role_t {
-	ROLE_RTE,
-	ROLE_OFF,
-	ROLE_SERVICE,
-	ROLE_NON_EAL,
+	RTE_LCORE_ROLE_RTE,
+	RTE_LCORE_ROLE_OFF,
+	RTE_LCORE_ROLE_SERVICE,
+	RTE_LCORE_ROLE_NON_EAL,
 };
 
+/* Old lcore role aliases for backward compatibility. */
+#define ROLE_RTE	RTE_LCORE_ROLE_RTE
+#define ROLE_OFF	RTE_LCORE_ROLE_OFF
+#define ROLE_SERVICE	RTE_LCORE_ROLE_SERVICE
+#define ROLE_NON_EAL	RTE_LCORE_ROLE_NON_EAL
+
 /**
  * Get a lcore's role.
  *
@@ -327,7 +333,8 @@ rte_lcore_callback_unregister(void *handle);
 typedef int (*rte_lcore_iterate_cb)(unsigned int lcore_id, void *arg);
 
 /**
- * Iterate on all active lcores (ROLE_RTE, ROLE_SERVICE and ROLE_NON_EAL).
+ * Iterate on all active lcores (RTE_LCORE_ROLE_RTE, RTE_LCORE_ROLE_SERVICE
+ * and RTE_LCORE_ROLE_NON_EAL).
  * No modification on the lcore states is allowed in the callback.
  *
  * Note: as opposed to init/uninit callbacks, iteration callbacks can be
diff --git a/lib/graph/graph.c b/lib/graph/graph.c
index 5f8ada2185..8165a0a932 100644
--- a/lib/graph/graph.c
+++ b/lib/graph/graph.c
@@ -359,7 +359,7 @@ rte_graph_model_mcore_dispatch_core_bind(rte_graph_t id, int lcore)
 		goto fail;
 	}
 
-	if (rte_lcore_has_role(lcore, ROLE_OFF))
+	if (rte_lcore_has_role(lcore, RTE_LCORE_ROLE_OFF))
 		SET_ERR_JMP(ENOLINK, fail, "lcore %d is invalid", lcore);
 
 	STAILQ_FOREACH(graph, &graph_list, next)
-- 
2.55.0

