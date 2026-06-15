Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA380CD98C5
	for <dpdk-dev@archiver.kernel.org>; Mon, 15 Jun 2026 07:33:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F1DB9436D1;
	Mon, 15 Jun 2026 09:33:33 +0200 (CEST)
Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com
 [113.46.200.226])
 by mails.dpdk.org (Postfix) with ESMTP id A28EE436C9
 for <dev@dpdk.org>; Mon, 15 Jun 2026 09:33:31 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=vnMKzccdmu16PhNlkrMxrkUTwY7buyXF0rwUgqNZg6k=;
 b=lvDgY8LZa21LLFrROzqlz2UWPPOzOcTkt1tp64iJQNouOsJ8FSk4mJyEfJiZginsmdOBZeohq
 PgEcZwtyEL8SDXLsuShgZLbTJksrcAUZdsQ4P0xgFOLBUbwVfdM/4mQO7LxYn21ZxEJINI/9tBW
 M1d5ZhYvecLEJeYNM2zDxkg=
Received: from mail.maildlp.com (unknown [172.19.163.214])
 by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4gf1qZ0cqhzKm5V;
 Mon, 15 Jun 2026 15:25:30 +0800 (CST)
Received: from kwepemo100005.china.huawei.com (unknown [7.202.195.212])
 by mail.maildlp.com (Postfix) with ESMTPS id C825D40561;
 Mon, 15 Jun 2026 15:33:29 +0800 (CST)
Received: from localhost.localdomain (10.90.31.46) by
 kwepemo100005.china.huawei.com (7.202.195.212) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Mon, 15 Jun 2026 15:33:29 +0800
From: Huisong Li <lihuisong@huawei.com>
To: <thomas@monjalon.net>, <anatoly.burakov@intel.com>,
 <sivaprasad.tummala@amd.com>
CC: <dev@dpdk.org>, <stephen@networkplumber.org>, <fengchengwen@huawei.com>,
 <yangxingui@huawei.com>, <zhanjie9@hisilicon.com>, <lihuisong@huawei.com>
Subject: [PATCH v4 4/9] power/amd_pstate: remove redundant lcore ID checks
Date: Mon, 15 Jun 2026 15:30:45 +0800
Message-ID: <20260615073050.1996063-5-lihuisong@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20260615073050.1996063-1-lihuisong@huawei.com>
References: <20260615073050.1996063-1-lihuisong@huawei.com>
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

Now that the cpufreq framework validates the lcore ID using
RTE_POWER_VALID_LCOREID_OR_ERR_RET() before dispatching to any driver,
each individual cpufreq driver no longer needs its own range
check against RTE_MAX_LCORE.

Remove the duplicated lcore ID checks from the amd_pstate
cpufreq driver ops.

Signed-off-by: Huisong Li <lihuisong@huawei.com>
---
 drivers/power/amd_pstate/amd_pstate_cpufreq.c | 65 -------------------
 1 file changed, 65 deletions(-)

diff --git a/drivers/power/amd_pstate/amd_pstate_cpufreq.c b/drivers/power/amd_pstate/amd_pstate_cpufreq.c
index bc67981d71..af9c1309f3 100644
--- a/drivers/power/amd_pstate/amd_pstate_cpufreq.c
+++ b/drivers/power/amd_pstate/amd_pstate_cpufreq.c
@@ -351,12 +351,6 @@ power_amd_pstate_cpufreq_init(unsigned int lcore_id)
 		return -1;
 	}
 
-	if (lcore_id >= RTE_MAX_LCORE) {
-		POWER_LOG(ERR, "Lcore id %u can not exceeds %u",
-				lcore_id, RTE_MAX_LCORE - 1U);
-		return -1;
-	}
-
 	pi = &lcore_power_info[lcore_id];
 	exp_state = POWER_IDLE;
 	/* The power in use state works as a guard variable between
@@ -434,11 +428,6 @@ power_amd_pstate_cpufreq_exit(unsigned int lcore_id)
 	struct amd_pstate_power_info *pi;
 	uint32_t exp_state;
 
-	if (lcore_id >= RTE_MAX_LCORE) {
-		POWER_LOG(ERR, "Lcore id %u can not exceeds %u",
-				lcore_id, RTE_MAX_LCORE - 1U);
-		return -1;
-	}
 	pi = &lcore_power_info[lcore_id];
 	exp_state = POWER_USED;
 	/* The power in use state works as a guard variable between
@@ -484,11 +473,6 @@ power_amd_pstate_cpufreq_freqs(unsigned int lcore_id, uint32_t *freqs, uint32_t
 {
 	struct amd_pstate_power_info *pi;
 
-	if (lcore_id >= RTE_MAX_LCORE) {
-		POWER_LOG(ERR, "Invalid lcore ID");
-		return 0;
-	}
-
 	if (freqs == NULL) {
 		POWER_LOG(ERR, "NULL buffer supplied");
 		return 0;
@@ -507,22 +491,12 @@ power_amd_pstate_cpufreq_freqs(unsigned int lcore_id, uint32_t *freqs, uint32_t
 uint32_t
 power_amd_pstate_cpufreq_get_freq(unsigned int lcore_id)
 {
-	if (lcore_id >= RTE_MAX_LCORE) {
-		POWER_LOG(ERR, "Invalid lcore ID");
-		return RTE_POWER_INVALID_FREQ_INDEX;
-	}
-
 	return lcore_power_info[lcore_id].curr_idx;
 }
 
 int
 power_amd_pstate_cpufreq_set_freq(unsigned int lcore_id, uint32_t index)
 {
-	if (lcore_id >= RTE_MAX_LCORE) {
-		POWER_LOG(ERR, "Invalid lcore ID");
-		return -1;
-	}
-
 	return set_freq_internal(&(lcore_power_info[lcore_id]), index);
 }
 
@@ -531,11 +505,6 @@ power_amd_pstate_cpufreq_freq_down(unsigned int lcore_id)
 {
 	struct amd_pstate_power_info *pi;
 
-	if (lcore_id >= RTE_MAX_LCORE) {
-		POWER_LOG(ERR, "Invalid lcore ID");
-		return -1;
-	}
-
 	pi = &lcore_power_info[lcore_id];
 	if (pi->curr_idx + 1 == pi->nb_freqs)
 		return 0;
@@ -549,11 +518,6 @@ power_amd_pstate_cpufreq_freq_up(unsigned int lcore_id)
 {
 	struct amd_pstate_power_info *pi;
 
-	if (lcore_id >= RTE_MAX_LCORE) {
-		POWER_LOG(ERR, "Invalid lcore ID");
-		return -1;
-	}
-
 	pi = &lcore_power_info[lcore_id];
 	if (pi->curr_idx == 0 || (pi->curr_idx == pi->nom_idx &&
 		pi->turbo_available && !pi->turbo_enable))
@@ -566,11 +530,6 @@ power_amd_pstate_cpufreq_freq_up(unsigned int lcore_id)
 int
 power_amd_pstate_cpufreq_freq_max(unsigned int lcore_id)
 {
-	if (lcore_id >= RTE_MAX_LCORE) {
-		POWER_LOG(ERR, "Invalid lcore ID");
-		return -1;
-	}
-
 	/* Frequencies in the array are from high to low. */
 	if (lcore_power_info[lcore_id].turbo_available) {
 		if (lcore_power_info[lcore_id].turbo_enable)
@@ -591,11 +550,6 @@ power_amd_pstate_cpufreq_freq_min(unsigned int lcore_id)
 {
 	struct amd_pstate_power_info *pi;
 
-	if (lcore_id >= RTE_MAX_LCORE) {
-		POWER_LOG(ERR, "Invalid lcore ID");
-		return -1;
-	}
-
 	pi = &lcore_power_info[lcore_id];
 
 	/* Frequencies in the array are from high to low. */
@@ -607,11 +561,6 @@ power_amd_pstate_turbo_status(unsigned int lcore_id)
 {
 	struct amd_pstate_power_info *pi;
 
-	if (lcore_id >= RTE_MAX_LCORE) {
-		POWER_LOG(ERR, "Invalid lcore ID");
-		return -1;
-	}
-
 	pi = &lcore_power_info[lcore_id];
 
 	return pi->turbo_enable;
@@ -622,11 +571,6 @@ power_amd_pstate_enable_turbo(unsigned int lcore_id)
 {
 	struct amd_pstate_power_info *pi;
 
-	if (lcore_id >= RTE_MAX_LCORE) {
-		POWER_LOG(ERR, "Invalid lcore ID");
-		return -1;
-	}
-
 	pi = &lcore_power_info[lcore_id];
 
 	if (pi->turbo_available)
@@ -658,11 +602,6 @@ power_amd_pstate_disable_turbo(unsigned int lcore_id)
 {
 	struct amd_pstate_power_info *pi;
 
-	if (lcore_id >= RTE_MAX_LCORE) {
-		POWER_LOG(ERR, "Invalid lcore ID");
-		return -1;
-	}
-
 	pi = &lcore_power_info[lcore_id];
 
 	pi->turbo_enable = 0;
@@ -686,10 +625,6 @@ power_amd_pstate_get_capabilities(unsigned int lcore_id,
 {
 	struct amd_pstate_power_info *pi;
 
-	if (lcore_id >= RTE_MAX_LCORE) {
-		POWER_LOG(ERR, "Invalid lcore ID");
-		return -1;
-	}
 	if (caps == NULL) {
 		POWER_LOG(ERR, "Invalid argument");
 		return -1;
-- 
2.33.0

