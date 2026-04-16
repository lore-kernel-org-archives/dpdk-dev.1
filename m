Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B4CFF433D9
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Apr 2026 03:07:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CE62E406BB;
	Thu, 16 Apr 2026 05:06:34 +0200 (CEST)
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com
 [113.46.200.217])
 by mails.dpdk.org (Postfix) with ESMTP id 76BB0402B3
 for <dev@dpdk.org>; Thu, 16 Apr 2026 05:06:20 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=kSE7KAo7anz9S7KuNghCO8NR/3/xhspAMsU1S2H39Xw=;
 b=JjZVu4hWLL7xbclofK1e/fEEWMsgXECh8JLlWf3wpHrcb3YGWTptyorxHt807UiCJ1P2flovW
 rXgMnHyT3IUZTadkGDPIsnCETDUxKVAjSns44dgcfuAScwFt+BpiH7oBz5nxDoOBsY9tCEI8xon
 jxEO15JuWgE4Cx/wE9g+Z2k=
Received: from mail.maildlp.com (unknown [172.19.163.104])
 by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4fx2mf5TzWzcb19;
 Thu, 16 Apr 2026 10:59:46 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
 by mail.maildlp.com (Postfix) with ESMTPS id 37F9440570;
 Thu, 16 Apr 2026 11:06:18 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 16 Apr 2026 11:06:17 +0800
Received: from localhost.localdomain (10.50.163.32) by
 kwepemn100009.china.huawei.com (7.202.194.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 16 Apr 2026 11:06:16 +0800
From: Huisong Li <lihuisong@huawei.com>
To: <anatoly.burakov@intel.com>, <sivaprasad.tummala@amd.com>
CC: <dev@dpdk.org>, <thomas@monjalon.net>, <fengchengwen@huawei.com>,
 <yangxingui@huawei.com>, <zhanjie9@hisilicon.com>, <lihuisong@huawei.com>
Subject: [PATCH v1 11/15] power/acpi_cpufreq: remove the verification of lcore
 ID
Date: Thu, 16 Apr 2026 11:06:08 +0800
Message-ID: <20260416030612.2379407-12-lihuisong@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260416030612.2379407-1-lihuisong@huawei.com>
References: <20260416030612.2379407-1-lihuisong@huawei.com>
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

Now the lcore id has been verified in framework API, so remove
the verification in driver.

Signed-off-by: Huisong Li <lihuisong@huawei.com>
---
 drivers/power/acpi/acpi_cpufreq.c | 65 -------------------------------
 1 file changed, 65 deletions(-)

diff --git a/drivers/power/acpi/acpi_cpufreq.c b/drivers/power/acpi/acpi_cpufreq.c
index d22e0eb627..9c78b4cb1a 100644
--- a/drivers/power/acpi/acpi_cpufreq.c
+++ b/drivers/power/acpi/acpi_cpufreq.c
@@ -242,11 +242,6 @@ power_acpi_cpufreq_init(unsigned int lcore_id)
 		return -1;
 	}
 
-	if (!rte_lcore_is_enabled(lcore_id)) {
-		POWER_LOG(ERR, "lcore id %u is not enabled", lcore_id);
-		return -1;
-	}
-
 	pi = &lcore_power_info[lcore_id];
 	exp_state = POWER_IDLE;
 	/* The power in use state works as a guard variable between
@@ -318,11 +313,6 @@ power_acpi_cpufreq_exit(unsigned int lcore_id)
 	struct acpi_power_info *pi;
 	uint32_t exp_state;
 
-	if (!rte_lcore_is_enabled(lcore_id)) {
-		POWER_LOG(ERR, "lcore id %u is not enabled", lcore_id);
-		return -1;
-	}
-
 	pi = &lcore_power_info[lcore_id];
 	exp_state = POWER_USED;
 	/* The power in use state works as a guard variable between
@@ -372,11 +362,6 @@ power_acpi_cpufreq_freqs(unsigned int lcore_id, uint32_t *freqs, uint32_t num)
 {
 	struct acpi_power_info *pi;
 
-	if (!rte_lcore_is_enabled(lcore_id)) {
-		POWER_LOG(ERR, "lcore id %u is not enabled", lcore_id);
-		return 0;
-	}
-
 	if (freqs == NULL) {
 		POWER_LOG(ERR, "NULL buffer supplied");
 		return 0;
@@ -395,22 +380,12 @@ power_acpi_cpufreq_freqs(unsigned int lcore_id, uint32_t *freqs, uint32_t num)
 uint32_t
 power_acpi_cpufreq_get_freq(unsigned int lcore_id)
 {
-	if (!rte_lcore_is_enabled(lcore_id)) {
-		POWER_LOG(ERR, "lcore id %u is not enabled", lcore_id);
-		return RTE_POWER_INVALID_FREQ_INDEX;
-	}
-
 	return lcore_power_info[lcore_id].curr_idx;
 }
 
 int
 power_acpi_cpufreq_set_freq(unsigned int lcore_id, uint32_t index)
 {
-	if (!rte_lcore_is_enabled(lcore_id)) {
-		POWER_LOG(ERR, "lcore id %u is not enabled", lcore_id);
-		return -1;
-	}
-
 	return set_freq_internal(&(lcore_power_info[lcore_id]), index);
 }
 
@@ -419,11 +394,6 @@ power_acpi_cpufreq_freq_down(unsigned int lcore_id)
 {
 	struct acpi_power_info *pi;
 
-	if (!rte_lcore_is_enabled(lcore_id)) {
-		POWER_LOG(ERR, "lcore id %u is not enabled", lcore_id);
-		return -1;
-	}
-
 	pi = &lcore_power_info[lcore_id];
 	if (pi->curr_idx + 1 == pi->nb_freqs)
 		return 0;
@@ -437,11 +407,6 @@ power_acpi_cpufreq_freq_up(unsigned int lcore_id)
 {
 	struct acpi_power_info *pi;
 
-	if (!rte_lcore_is_enabled(lcore_id)) {
-		POWER_LOG(ERR, "lcore id %u is not enabled", lcore_id);
-		return -1;
-	}
-
 	pi = &lcore_power_info[lcore_id];
 	if (pi->curr_idx == 0 ||
 	    (pi->curr_idx == 1 && pi->turbo_available && !pi->turbo_enable))
@@ -454,11 +419,6 @@ power_acpi_cpufreq_freq_up(unsigned int lcore_id)
 int
 power_acpi_cpufreq_freq_max(unsigned int lcore_id)
 {
-	if (!rte_lcore_is_enabled(lcore_id)) {
-		POWER_LOG(ERR, "lcore id %u is not enabled", lcore_id);
-		return -1;
-	}
-
 	/* Frequencies in the array are from high to low. */
 	if (lcore_power_info[lcore_id].turbo_available) {
 		if (lcore_power_info[lcore_id].turbo_enable)
@@ -478,11 +438,6 @@ power_acpi_cpufreq_freq_min(unsigned int lcore_id)
 {
 	struct acpi_power_info *pi;
 
-	if (!rte_lcore_is_enabled(lcore_id)) {
-		POWER_LOG(ERR, "lcore id %u is not enabled", lcore_id);
-		return -1;
-	}
-
 	pi = &lcore_power_info[lcore_id];
 
 	/* Frequencies in the array are from high to low. */
@@ -495,11 +450,6 @@ power_acpi_turbo_status(unsigned int lcore_id)
 {
 	struct acpi_power_info *pi;
 
-	if (!rte_lcore_is_enabled(lcore_id)) {
-		POWER_LOG(ERR, "lcore id %u is not enabled", lcore_id);
-		return -1;
-	}
-
 	pi = &lcore_power_info[lcore_id];
 
 	return pi->turbo_enable;
@@ -511,11 +461,6 @@ power_acpi_enable_turbo(unsigned int lcore_id)
 {
 	struct acpi_power_info *pi;
 
-	if (!rte_lcore_is_enabled(lcore_id)) {
-		POWER_LOG(ERR, "lcore id %u is not enabled", lcore_id);
-		return -1;
-	}
-
 	pi = &lcore_power_info[lcore_id];
 
 	if (pi->turbo_available)
@@ -544,11 +489,6 @@ power_acpi_disable_turbo(unsigned int lcore_id)
 {
 	struct acpi_power_info *pi;
 
-	if (!rte_lcore_is_enabled(lcore_id)) {
-		POWER_LOG(ERR, "lcore id %u is not enabled", lcore_id);
-		return -1;
-	}
-
 	pi = &lcore_power_info[lcore_id];
 
 	 pi->turbo_enable = 0;
@@ -571,11 +511,6 @@ int power_acpi_get_capabilities(unsigned int lcore_id,
 {
 	struct acpi_power_info *pi;
 
-	if (!rte_lcore_is_enabled(lcore_id)) {
-		POWER_LOG(ERR, "lcore id %u is not enabled", lcore_id);
-		return -1;
-	}
-
 	if (caps == NULL) {
 		POWER_LOG(ERR, "Invalid argument");
 		return -1;
-- 
2.33.0

