Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6AD0CD3436
	for <dpdk-dev@archiver.kernel.org>; Thu,  7 May 2026 02:43:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 860A340652;
	Thu,  7 May 2026 04:42:48 +0200 (CEST)
Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com
 [113.46.200.227])
 by mails.dpdk.org (Postfix) with ESMTP id 66EA94064C
 for <dev@dpdk.org>; Thu,  7 May 2026 04:42:37 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=Lw9KmLf8xcH3SqeBLV0e3mZNIWBR364byOvsKOYbB10=;
 b=pwoxqTqj5zQCOvNDyrKqvGlgr6pgTgwnY4X6KFPZCjGkWoZqysY/pB3W7GrDh8fKoozJ9FSEa
 qJqQtxu7nSvH08R7UCF6N6QY0mGsPQy2Rc5kMyeppyavtvlEwSIWcLotdsDaggmfz3zLeaVspAe
 i5Efj+lNK6+3ufBYLUeEuIs=
Received: from mail.maildlp.com (unknown [172.19.163.127])
 by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4g9xDx4Zx4znTtp;
 Thu,  7 May 2026 10:35:29 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
 by mail.maildlp.com (Postfix) with ESMTPS id 10514402AB;
 Thu,  7 May 2026 10:42:36 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 7 May 2026 10:42:35 +0800
Received: from localhost.localdomain (10.50.163.32) by
 kwepemn100009.china.huawei.com (7.202.194.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 7 May 2026 10:42:35 +0800
From: Huisong Li <lihuisong@huawei.com>
To: <anatoly.burakov@intel.com>, <sivaprasad.tummala@amd.com>,
 <stephen@networkplumber.org>
CC: <dev@dpdk.org>, <thomas@monjalon.net>, <fengchengwen@huawei.com>,
 <yangxingui@huawei.com>, <zhanjie9@hisilicon.com>, <lihuisong@huawei.com>
Subject: [PATCH V2 12/15] power/intel_pstate: remove the verification of lcore
 ID
Date: Thu, 7 May 2026 10:42:27 +0800
Message-ID: <20260507024230.1198111-13-lihuisong@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260507024230.1198111-1-lihuisong@huawei.com>
References: <20260416030612.2379407-1-lihuisong@huawei.com>
 <20260507024230.1198111-1-lihuisong@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.50.163.32]
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemn100009.china.huawei.com (7.202.194.112)
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

Now the lcore ID has been verified in framework API, so remove
the verification in driver.

Signed-off-by: Huisong Li <lihuisong@huawei.com>
---
 .../power/intel_pstate/intel_pstate_cpufreq.c | 65 -------------------
 1 file changed, 65 deletions(-)

diff --git a/drivers/power/intel_pstate/intel_pstate_cpufreq.c b/drivers/power/intel_pstate/intel_pstate_cpufreq.c
index 58be63fecc..e7ed9c8260 100644
--- a/drivers/power/intel_pstate/intel_pstate_cpufreq.c
+++ b/drivers/power/intel_pstate/intel_pstate_cpufreq.c
@@ -548,11 +548,6 @@ power_pstate_cpufreq_init(unsigned int lcore_id)
 		return -1;
 	}
 
-	if (!rte_lcore_is_eal_managed(lcore_id)) {
-		POWER_LOG(ERR, "lcore id %u is invalid.", lcore_id);
-		return -1;
-	}
-
 	pi = &lcore_power_info[lcore_id];
 	exp_state = POWER_IDLE;
 	/* The power in use state works as a guard variable between
@@ -629,11 +624,6 @@ power_pstate_cpufreq_exit(unsigned int lcore_id)
 	struct pstate_power_info *pi;
 	uint32_t exp_state;
 
-	if (!rte_lcore_is_eal_managed(lcore_id)) {
-		POWER_LOG(ERR, "lcore id %u is invalid.", lcore_id);
-		return -1;
-	}
-
 	pi = &lcore_power_info[lcore_id];
 
 	exp_state = POWER_USED;
@@ -687,11 +677,6 @@ power_pstate_cpufreq_freqs(unsigned int lcore_id, uint32_t *freqs, uint32_t num)
 {
 	struct pstate_power_info *pi;
 
-	if (!rte_lcore_is_eal_managed(lcore_id)) {
-		POWER_LOG(ERR, "lcore id %u is invalid.", lcore_id);
-		return 0;
-	}
-
 	if (freqs == NULL) {
 		POWER_LOG(ERR, "NULL buffer supplied");
 		return 0;
@@ -710,11 +695,6 @@ power_pstate_cpufreq_freqs(unsigned int lcore_id, uint32_t *freqs, uint32_t num)
 uint32_t
 power_pstate_cpufreq_get_freq(unsigned int lcore_id)
 {
-	if (!rte_lcore_is_eal_managed(lcore_id)) {
-		POWER_LOG(ERR, "lcore id %u is invalid.", lcore_id);
-		return RTE_POWER_INVALID_FREQ_INDEX;
-	}
-
 	return lcore_power_info[lcore_id].curr_idx;
 }
 
@@ -722,11 +702,6 @@ power_pstate_cpufreq_get_freq(unsigned int lcore_id)
 int
 power_pstate_cpufreq_set_freq(unsigned int lcore_id, uint32_t index)
 {
-	if (!rte_lcore_is_eal_managed(lcore_id)) {
-		POWER_LOG(ERR, "lcore id %u is invalid.", lcore_id);
-		return -1;
-	}
-
 	return set_freq_internal(&(lcore_power_info[lcore_id]), index);
 }
 
@@ -735,11 +710,6 @@ power_pstate_cpufreq_freq_up(unsigned int lcore_id)
 {
 	struct pstate_power_info *pi;
 
-	if (!rte_lcore_is_eal_managed(lcore_id)) {
-		POWER_LOG(ERR, "lcore id %u is invalid.", lcore_id);
-		return -1;
-	}
-
 	pi = &lcore_power_info[lcore_id];
 	if (pi->curr_idx == 0 ||
 	    (pi->curr_idx == 1 && pi->turbo_available && !pi->turbo_enable))
@@ -754,11 +724,6 @@ power_pstate_cpufreq_freq_down(unsigned int lcore_id)
 {
 	struct pstate_power_info *pi;
 
-	if (!rte_lcore_is_eal_managed(lcore_id)) {
-		POWER_LOG(ERR, "lcore id %u is invalid.", lcore_id);
-		return -1;
-	}
-
 	pi = &lcore_power_info[lcore_id];
 	if (pi->curr_idx + 1 == pi->nb_freqs)
 		return 0;
@@ -770,11 +735,6 @@ power_pstate_cpufreq_freq_down(unsigned int lcore_id)
 int
 power_pstate_cpufreq_freq_max(unsigned int lcore_id)
 {
-	if (!rte_lcore_is_eal_managed(lcore_id)) {
-		POWER_LOG(ERR, "lcore id %u is invalid.", lcore_id);
-		return -1;
-	}
-
 	/* Frequencies in the array are from high to low. */
 	if (lcore_power_info[lcore_id].turbo_available) {
 		if (lcore_power_info[lcore_id].turbo_enable)
@@ -795,11 +755,6 @@ power_pstate_cpufreq_freq_min(unsigned int lcore_id)
 {
 	struct pstate_power_info *pi;
 
-	if (!rte_lcore_is_eal_managed(lcore_id)) {
-		POWER_LOG(ERR, "lcore id %u is invalid.", lcore_id);
-		return -1;
-	}
-
 	pi = &lcore_power_info[lcore_id];
 
 	/* Frequencies in the array are from high to low. */
@@ -812,11 +767,6 @@ power_pstate_turbo_status(unsigned int lcore_id)
 {
 	struct pstate_power_info *pi;
 
-	if (!rte_lcore_is_eal_managed(lcore_id)) {
-		POWER_LOG(ERR, "lcore id %u is invalid.", lcore_id);
-		return -1;
-	}
-
 	pi = &lcore_power_info[lcore_id];
 
 	return pi->turbo_enable;
@@ -827,11 +777,6 @@ power_pstate_enable_turbo(unsigned int lcore_id)
 {
 	struct pstate_power_info *pi;
 
-	if (!rte_lcore_is_eal_managed(lcore_id)) {
-		POWER_LOG(ERR, "lcore id %u is invalid.", lcore_id);
-		return -1;
-	}
-
 	pi = &lcore_power_info[lcore_id];
 
 	if (pi->turbo_available)
@@ -853,11 +798,6 @@ power_pstate_disable_turbo(unsigned int lcore_id)
 {
 	struct pstate_power_info *pi;
 
-	if (!rte_lcore_is_eal_managed(lcore_id)) {
-		POWER_LOG(ERR, "lcore id %u is invalid.", lcore_id);
-		return -1;
-	}
-
 	pi = &lcore_power_info[lcore_id];
 
 	pi->turbo_enable = 0;
@@ -881,11 +821,6 @@ int power_pstate_get_capabilities(unsigned int lcore_id,
 {
 	struct pstate_power_info *pi;
 
-	if (!rte_lcore_is_eal_managed(lcore_id)) {
-		POWER_LOG(ERR, "lcore id %u is invalid.", lcore_id);
-		return -1;
-	}
-
 	if (caps == NULL) {
 		POWER_LOG(ERR, "Invalid argument");
 		return -1;
-- 
2.33.0

