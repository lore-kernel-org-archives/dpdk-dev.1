Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9B56F433D9
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Apr 2026 03:06:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0B78E40671;
	Thu, 16 Apr 2026 05:06:28 +0200 (CEST)
Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com
 [113.46.200.220])
 by mails.dpdk.org (Postfix) with ESMTP id 8C851402B3
 for <dev@dpdk.org>; Thu, 16 Apr 2026 05:06:19 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=rwfXelJLQ6GPM1IVgfctos+R/Indtv0kG4IYsfaq/Yo=;
 b=j2fiJu9slFB6256ITq7+XX3T5iYMmHmskKY6pysN5iwRmsfodhBz1Pilb/KEzt2JF9QjYwVS+
 q3U1Rfyd8n34cQ6ySpzcm4AQPMcgrJJOIJysRKNtf7ttl1vQTUkslpQIwYX4pdcn1Gy63O9JoTR
 Ufr6gZxHAquoXVGC7b4R/ms=
Received: from mail.maildlp.com (unknown [172.19.163.104])
 by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4fx2mw29b2z12LDS;
 Thu, 16 Apr 2026 11:00:00 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
 by mail.maildlp.com (Postfix) with ESMTPS id D5C2940571;
 Thu, 16 Apr 2026 11:06:17 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 16 Apr 2026 11:06:14 +0800
Received: from localhost.localdomain (10.50.163.32) by
 kwepemn100009.china.huawei.com (7.202.194.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 16 Apr 2026 11:06:13 +0800
From: Huisong Li <lihuisong@huawei.com>
To: <anatoly.burakov@intel.com>, <sivaprasad.tummala@amd.com>
CC: <dev@dpdk.org>, <thomas@monjalon.net>, <fengchengwen@huawei.com>,
 <yangxingui@huawei.com>, <zhanjie9@hisilicon.com>, <lihuisong@huawei.com>
Subject: [PATCH v1 02/15] power/acpi_cpufreq: enforce enabled lcore ID check
Date: Thu, 16 Apr 2026 11:05:59 +0800
Message-ID: <20260416030612.2379407-3-lihuisong@huawei.com>
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

The locre ID in cpufreq power must be enabled core in application.
Use rte_lcore_is_enabled to verify lcore_id.

Fixes: 6f987b594fa6 ("power: refactor core power management")
Cc: stable@dpdk.org

Signed-off-by: Huisong Li <lihuisong@huawei.com>
---
 drivers/power/acpi/acpi_cpufreq.c | 56 +++++++++++++++----------------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/drivers/power/acpi/acpi_cpufreq.c b/drivers/power/acpi/acpi_cpufreq.c
index 81a5e3f6ea..d22e0eb627 100644
--- a/drivers/power/acpi/acpi_cpufreq.c
+++ b/drivers/power/acpi/acpi_cpufreq.c
@@ -242,9 +242,8 @@ power_acpi_cpufreq_init(unsigned int lcore_id)
 		return -1;
 	}
 
-	if (lcore_id >= RTE_MAX_LCORE) {
-		POWER_LOG(ERR, "Lcore id %u can not exceeds %u",
-				lcore_id, RTE_MAX_LCORE - 1U);
+	if (!rte_lcore_is_enabled(lcore_id)) {
+		POWER_LOG(ERR, "lcore id %u is not enabled", lcore_id);
 		return -1;
 	}
 
@@ -319,11 +318,11 @@ power_acpi_cpufreq_exit(unsigned int lcore_id)
 	struct acpi_power_info *pi;
 	uint32_t exp_state;
 
-	if (lcore_id >= RTE_MAX_LCORE) {
-		POWER_LOG(ERR, "Lcore id %u can not exceeds %u",
-				lcore_id, RTE_MAX_LCORE - 1U);
+	if (!rte_lcore_is_enabled(lcore_id)) {
+		POWER_LOG(ERR, "lcore id %u is not enabled", lcore_id);
 		return -1;
 	}
+
 	pi = &lcore_power_info[lcore_id];
 	exp_state = POWER_USED;
 	/* The power in use state works as a guard variable between
@@ -373,8 +372,8 @@ power_acpi_cpufreq_freqs(unsigned int lcore_id, uint32_t *freqs, uint32_t num)
 {
 	struct acpi_power_info *pi;
 
-	if (lcore_id >= RTE_MAX_LCORE) {
-		POWER_LOG(ERR, "Invalid lcore ID");
+	if (!rte_lcore_is_enabled(lcore_id)) {
+		POWER_LOG(ERR, "lcore id %u is not enabled", lcore_id);
 		return 0;
 	}
 
@@ -396,8 +395,8 @@ power_acpi_cpufreq_freqs(unsigned int lcore_id, uint32_t *freqs, uint32_t num)
 uint32_t
 power_acpi_cpufreq_get_freq(unsigned int lcore_id)
 {
-	if (lcore_id >= RTE_MAX_LCORE) {
-		POWER_LOG(ERR, "Invalid lcore ID");
+	if (!rte_lcore_is_enabled(lcore_id)) {
+		POWER_LOG(ERR, "lcore id %u is not enabled", lcore_id);
 		return RTE_POWER_INVALID_FREQ_INDEX;
 	}
 
@@ -407,8 +406,8 @@ power_acpi_cpufreq_get_freq(unsigned int lcore_id)
 int
 power_acpi_cpufreq_set_freq(unsigned int lcore_id, uint32_t index)
 {
-	if (lcore_id >= RTE_MAX_LCORE) {
-		POWER_LOG(ERR, "Invalid lcore ID");
+	if (!rte_lcore_is_enabled(lcore_id)) {
+		POWER_LOG(ERR, "lcore id %u is not enabled", lcore_id);
 		return -1;
 	}
 
@@ -420,8 +419,8 @@ power_acpi_cpufreq_freq_down(unsigned int lcore_id)
 {
 	struct acpi_power_info *pi;
 
-	if (lcore_id >= RTE_MAX_LCORE) {
-		POWER_LOG(ERR, "Invalid lcore ID");
+	if (!rte_lcore_is_enabled(lcore_id)) {
+		POWER_LOG(ERR, "lcore id %u is not enabled", lcore_id);
 		return -1;
 	}
 
@@ -438,8 +437,8 @@ power_acpi_cpufreq_freq_up(unsigned int lcore_id)
 {
 	struct acpi_power_info *pi;
 
-	if (lcore_id >= RTE_MAX_LCORE) {
-		POWER_LOG(ERR, "Invalid lcore ID");
+	if (!rte_lcore_is_enabled(lcore_id)) {
+		POWER_LOG(ERR, "lcore id %u is not enabled", lcore_id);
 		return -1;
 	}
 
@@ -455,8 +454,8 @@ power_acpi_cpufreq_freq_up(unsigned int lcore_id)
 int
 power_acpi_cpufreq_freq_max(unsigned int lcore_id)
 {
-	if (lcore_id >= RTE_MAX_LCORE) {
-		POWER_LOG(ERR, "Invalid lcore ID");
+	if (!rte_lcore_is_enabled(lcore_id)) {
+		POWER_LOG(ERR, "lcore id %u is not enabled", lcore_id);
 		return -1;
 	}
 
@@ -479,8 +478,8 @@ power_acpi_cpufreq_freq_min(unsigned int lcore_id)
 {
 	struct acpi_power_info *pi;
 
-	if (lcore_id >= RTE_MAX_LCORE) {
-		POWER_LOG(ERR, "Invalid lcore ID");
+	if (!rte_lcore_is_enabled(lcore_id)) {
+		POWER_LOG(ERR, "lcore id %u is not enabled", lcore_id);
 		return -1;
 	}
 
@@ -496,8 +495,8 @@ power_acpi_turbo_status(unsigned int lcore_id)
 {
 	struct acpi_power_info *pi;
 
-	if (lcore_id >= RTE_MAX_LCORE) {
-		POWER_LOG(ERR, "Invalid lcore ID");
+	if (!rte_lcore_is_enabled(lcore_id)) {
+		POWER_LOG(ERR, "lcore id %u is not enabled", lcore_id);
 		return -1;
 	}
 
@@ -512,8 +511,8 @@ power_acpi_enable_turbo(unsigned int lcore_id)
 {
 	struct acpi_power_info *pi;
 
-	if (lcore_id >= RTE_MAX_LCORE) {
-		POWER_LOG(ERR, "Invalid lcore ID");
+	if (!rte_lcore_is_enabled(lcore_id)) {
+		POWER_LOG(ERR, "lcore id %u is not enabled", lcore_id);
 		return -1;
 	}
 
@@ -545,8 +544,8 @@ power_acpi_disable_turbo(unsigned int lcore_id)
 {
 	struct acpi_power_info *pi;
 
-	if (lcore_id >= RTE_MAX_LCORE) {
-		POWER_LOG(ERR, "Invalid lcore ID");
+	if (!rte_lcore_is_enabled(lcore_id)) {
+		POWER_LOG(ERR, "lcore id %u is not enabled", lcore_id);
 		return -1;
 	}
 
@@ -572,10 +571,11 @@ int power_acpi_get_capabilities(unsigned int lcore_id,
 {
 	struct acpi_power_info *pi;
 
-	if (lcore_id >= RTE_MAX_LCORE) {
-		POWER_LOG(ERR, "Invalid lcore ID");
+	if (!rte_lcore_is_enabled(lcore_id)) {
+		POWER_LOG(ERR, "lcore id %u is not enabled", lcore_id);
 		return -1;
 	}
+
 	if (caps == NULL) {
 		POWER_LOG(ERR, "Invalid argument");
 		return -1;
-- 
2.33.0

