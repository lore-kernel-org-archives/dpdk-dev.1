Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B46AFCD4F5B
	for <dpdk-dev@archiver.kernel.org>; Fri, 22 May 2026 04:11:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 08A504066B;
	Fri, 22 May 2026 06:11:22 +0200 (CEST)
Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com
 [113.46.200.220])
 by mails.dpdk.org (Postfix) with ESMTP id 3BB0A402A2
 for <dev@dpdk.org>; Fri, 22 May 2026 06:11:16 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=sypBrVwy5n5wluD9sfAHmW93rrVW5JNqyw6s/u18XZc=;
 b=Z+nxjrdvohYUGaQtfiNQcZSqeVY07frT/RfsGjpcF4sp+7ncSYEbkSpJW00ijrhx5LNZbqstP
 JQJKzQL5lCcqR8PEkuFjN416aKZB0+LVJZHFqgVdpwb53pMqpl+r2iiIk7wSYLad6RQriSH3xGc
 KUL4nCCT6BIMY5gt3CTKzG4=
Received: from mail.maildlp.com (unknown [172.19.163.104])
 by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4gMBTC1S2yz12LFT;
 Fri, 22 May 2026 12:03:11 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
 by mail.maildlp.com (Postfix) with ESMTPS id EBF4D4056A;
 Fri, 22 May 2026 12:11:13 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 22 May 2026 12:11:13 +0800
Received: from localhost.localdomain (10.50.163.32) by
 kwepemn100009.china.huawei.com (7.202.194.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Fri, 22 May 2026 12:11:13 +0800
From: Huisong Li <lihuisong@huawei.com>
To: <anatoly.burakov@intel.com>, <sivaprasad.tummala@amd.com>
CC: <dev@dpdk.org>, <thomas@monjalon.net>, <stephen@networkplumber.org>,
 <fengchengwen@huawei.com>, <yangxingui@huawei.com>, <zhanjie9@hisilicon.com>, 
 <lihuisong@huawei.com>
Subject: [PATCH v3 04/10] power/acpi: remove redundant lcore ID checks
Date: Fri, 22 May 2026 12:11:04 +0800
Message-ID: <20260522041110.2023062-5-lihuisong@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260522041110.2023062-1-lihuisong@huawei.com>
References: <20260522041110.2023062-1-lihuisong@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.50.163.32]
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
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

Now that the cpufreq framework validates the lcore ID using
rte_lcore_is_eal_managed() before dispatching to any driver,
each individual cpufreq driver no longer needs its own range
check against RTE_MAX_LCORE.

Remove the duplicated lcore ID checks from the acpi cpufreq
driver ops.

Signed-off-by: Huisong Li <lihuisong@huawei.com>
---
 drivers/power/acpi/acpi_cpufreq.c | 65 -------------------------------
 1 file changed, 65 deletions(-)

diff --git a/drivers/power/acpi/acpi_cpufreq.c b/drivers/power/acpi/acpi_cpufreq.c
index 81a5e3f6ea..9c78b4cb1a 100644
--- a/drivers/power/acpi/acpi_cpufreq.c
+++ b/drivers/power/acpi/acpi_cpufreq.c
@@ -242,12 +242,6 @@ power_acpi_cpufreq_init(unsigned int lcore_id)
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
@@ -319,11 +313,6 @@ power_acpi_cpufreq_exit(unsigned int lcore_id)
 	struct acpi_power_info *pi;
 	uint32_t exp_state;
 
-	if (lcore_id >= RTE_MAX_LCORE) {
-		POWER_LOG(ERR, "Lcore id %u can not exceeds %u",
-				lcore_id, RTE_MAX_LCORE - 1U);
-		return -1;
-	}
 	pi = &lcore_power_info[lcore_id];
 	exp_state = POWER_USED;
 	/* The power in use state works as a guard variable between
@@ -373,11 +362,6 @@ power_acpi_cpufreq_freqs(unsigned int lcore_id, uint32_t *freqs, uint32_t num)
 {
 	struct acpi_power_info *pi;
 
-	if (lcore_id >= RTE_MAX_LCORE) {
-		POWER_LOG(ERR, "Invalid lcore ID");
-		return 0;
-	}
-
 	if (freqs == NULL) {
 		POWER_LOG(ERR, "NULL buffer supplied");
 		return 0;
@@ -396,22 +380,12 @@ power_acpi_cpufreq_freqs(unsigned int lcore_id, uint32_t *freqs, uint32_t num)
 uint32_t
 power_acpi_cpufreq_get_freq(unsigned int lcore_id)
 {
-	if (lcore_id >= RTE_MAX_LCORE) {
-		POWER_LOG(ERR, "Invalid lcore ID");
-		return RTE_POWER_INVALID_FREQ_INDEX;
-	}
-
 	return lcore_power_info[lcore_id].curr_idx;
 }
 
 int
 power_acpi_cpufreq_set_freq(unsigned int lcore_id, uint32_t index)
 {
-	if (lcore_id >= RTE_MAX_LCORE) {
-		POWER_LOG(ERR, "Invalid lcore ID");
-		return -1;
-	}
-
 	return set_freq_internal(&(lcore_power_info[lcore_id]), index);
 }
 
@@ -420,11 +394,6 @@ power_acpi_cpufreq_freq_down(unsigned int lcore_id)
 {
 	struct acpi_power_info *pi;
 
-	if (lcore_id >= RTE_MAX_LCORE) {
-		POWER_LOG(ERR, "Invalid lcore ID");
-		return -1;
-	}
-
 	pi = &lcore_power_info[lcore_id];
 	if (pi->curr_idx + 1 == pi->nb_freqs)
 		return 0;
@@ -438,11 +407,6 @@ power_acpi_cpufreq_freq_up(unsigned int lcore_id)
 {
 	struct acpi_power_info *pi;
 
-	if (lcore_id >= RTE_MAX_LCORE) {
-		POWER_LOG(ERR, "Invalid lcore ID");
-		return -1;
-	}
-
 	pi = &lcore_power_info[lcore_id];
 	if (pi->curr_idx == 0 ||
 	    (pi->curr_idx == 1 && pi->turbo_available && !pi->turbo_enable))
@@ -455,11 +419,6 @@ power_acpi_cpufreq_freq_up(unsigned int lcore_id)
 int
 power_acpi_cpufreq_freq_max(unsigned int lcore_id)
 {
-	if (lcore_id >= RTE_MAX_LCORE) {
-		POWER_LOG(ERR, "Invalid lcore ID");
-		return -1;
-	}
-
 	/* Frequencies in the array are from high to low. */
 	if (lcore_power_info[lcore_id].turbo_available) {
 		if (lcore_power_info[lcore_id].turbo_enable)
@@ -479,11 +438,6 @@ power_acpi_cpufreq_freq_min(unsigned int lcore_id)
 {
 	struct acpi_power_info *pi;
 
-	if (lcore_id >= RTE_MAX_LCORE) {
-		POWER_LOG(ERR, "Invalid lcore ID");
-		return -1;
-	}
-
 	pi = &lcore_power_info[lcore_id];
 
 	/* Frequencies in the array are from high to low. */
@@ -496,11 +450,6 @@ power_acpi_turbo_status(unsigned int lcore_id)
 {
 	struct acpi_power_info *pi;
 
-	if (lcore_id >= RTE_MAX_LCORE) {
-		POWER_LOG(ERR, "Invalid lcore ID");
-		return -1;
-	}
-
 	pi = &lcore_power_info[lcore_id];
 
 	return pi->turbo_enable;
@@ -512,11 +461,6 @@ power_acpi_enable_turbo(unsigned int lcore_id)
 {
 	struct acpi_power_info *pi;
 
-	if (lcore_id >= RTE_MAX_LCORE) {
-		POWER_LOG(ERR, "Invalid lcore ID");
-		return -1;
-	}
-
 	pi = &lcore_power_info[lcore_id];
 
 	if (pi->turbo_available)
@@ -545,11 +489,6 @@ power_acpi_disable_turbo(unsigned int lcore_id)
 {
 	struct acpi_power_info *pi;
 
-	if (lcore_id >= RTE_MAX_LCORE) {
-		POWER_LOG(ERR, "Invalid lcore ID");
-		return -1;
-	}
-
 	pi = &lcore_power_info[lcore_id];
 
 	 pi->turbo_enable = 0;
@@ -572,10 +511,6 @@ int power_acpi_get_capabilities(unsigned int lcore_id,
 {
 	struct acpi_power_info *pi;
 
-	if (lcore_id >= RTE_MAX_LCORE) {
-		POWER_LOG(ERR, "Invalid lcore ID");
-		return -1;
-	}
 	if (caps == NULL) {
 		POWER_LOG(ERR, "Invalid argument");
 		return -1;
-- 
2.33.0

