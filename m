Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2028CCD3436
	for <dpdk-dev@archiver.kernel.org>; Thu,  7 May 2026 02:43:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9B96440689;
	Thu,  7 May 2026 04:42:42 +0200 (CEST)
Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com
 [113.46.200.220])
 by mails.dpdk.org (Postfix) with ESMTP id 8796E4025A
 for <dev@dpdk.org>; Thu,  7 May 2026 04:42:35 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=JA9xMdkId/9f0pGW7+Sy1Zdlww+V3KfshYnI03D6tKk=;
 b=XM/NN9KsWt9cgkQLLpqhdUaCLqRF1mTzSB+XYWTrhK7K/TmIshyZkpGQO1yF3AzEQvc207o8h
 R/MXs40sah0CwzKb29Qqts+c1qWoobtMrGs5HdHIEc4nO6zO1VxO0rQw8sNttHXjgZqhnnBe8Us
 dH9b9d5QnVw35fwWDnyJTJ4=
Received: from mail.maildlp.com (unknown [172.19.162.140])
 by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4g9xDs3QMKz12LJG;
 Thu,  7 May 2026 10:35:25 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
 by mail.maildlp.com (Postfix) with ESMTPS id 5290D20333;
 Thu,  7 May 2026 10:42:34 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 7 May 2026 10:42:33 +0800
Received: from localhost.localdomain (10.50.163.32) by
 kwepemn100009.china.huawei.com (7.202.194.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 7 May 2026 10:42:33 +0800
From: Huisong Li <lihuisong@huawei.com>
To: <anatoly.burakov@intel.com>, <sivaprasad.tummala@amd.com>,
 <stephen@networkplumber.org>
CC: <dev@dpdk.org>, <thomas@monjalon.net>, <fengchengwen@huawei.com>,
 <yangxingui@huawei.com>, <zhanjie9@hisilicon.com>, <lihuisong@huawei.com>
Subject: [PATCH V2 06/15] power/intel_pstate: validate lcore role in cpufreq
 API
Date: Thu, 7 May 2026 10:42:21 +0800
Message-ID: <20260507024230.1198111-7-lihuisong@huawei.com>
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

Currently, the intel_pstate driver only checks if the lcore_id is
within the RTE_MAX_LCORE range, but fails to verify if the core is
actually active or managed by the application. This lacks sufficient
validation.

This patch add a lcore role check to the cpufreq-related APIs.
Although service cores do not typically invoke these APIs, they may
operate in polling states where power management is required.
To maintain compatibility with applications using service cores, the
validation logic now explicitly allows both ROLE_RTE and ROLE_SERVICE.

Signed-off-by: Huisong Li <lihuisong@huawei.com>
---
 .../power/intel_pstate/intel_pstate_cpufreq.c | 56 +++++++++----------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/drivers/power/intel_pstate/intel_pstate_cpufreq.c b/drivers/power/intel_pstate/intel_pstate_cpufreq.c
index 8e27570e3c..58be63fecc 100644
--- a/drivers/power/intel_pstate/intel_pstate_cpufreq.c
+++ b/drivers/power/intel_pstate/intel_pstate_cpufreq.c
@@ -548,9 +548,8 @@ power_pstate_cpufreq_init(unsigned int lcore_id)
 		return -1;
 	}
 
-	if (lcore_id >= RTE_MAX_LCORE) {
-		POWER_LOG(ERR, "Lcore id %u can not exceed %u",
-				lcore_id, RTE_MAX_LCORE - 1U);
+	if (!rte_lcore_is_eal_managed(lcore_id)) {
+		POWER_LOG(ERR, "lcore id %u is invalid.", lcore_id);
 		return -1;
 	}
 
@@ -630,11 +629,11 @@ power_pstate_cpufreq_exit(unsigned int lcore_id)
 	struct pstate_power_info *pi;
 	uint32_t exp_state;
 
-	if (lcore_id >= RTE_MAX_LCORE) {
-		POWER_LOG(ERR, "Lcore id %u can not exceeds %u",
-				lcore_id, RTE_MAX_LCORE - 1U);
+	if (!rte_lcore_is_eal_managed(lcore_id)) {
+		POWER_LOG(ERR, "lcore id %u is invalid.", lcore_id);
 		return -1;
 	}
+
 	pi = &lcore_power_info[lcore_id];
 
 	exp_state = POWER_USED;
@@ -688,8 +687,8 @@ power_pstate_cpufreq_freqs(unsigned int lcore_id, uint32_t *freqs, uint32_t num)
 {
 	struct pstate_power_info *pi;
 
-	if (lcore_id >= RTE_MAX_LCORE) {
-		POWER_LOG(ERR, "Invalid lcore ID");
+	if (!rte_lcore_is_eal_managed(lcore_id)) {
+		POWER_LOG(ERR, "lcore id %u is invalid.", lcore_id);
 		return 0;
 	}
 
@@ -711,8 +710,8 @@ power_pstate_cpufreq_freqs(unsigned int lcore_id, uint32_t *freqs, uint32_t num)
 uint32_t
 power_pstate_cpufreq_get_freq(unsigned int lcore_id)
 {
-	if (lcore_id >= RTE_MAX_LCORE) {
-		POWER_LOG(ERR, "Invalid lcore ID");
+	if (!rte_lcore_is_eal_managed(lcore_id)) {
+		POWER_LOG(ERR, "lcore id %u is invalid.", lcore_id);
 		return RTE_POWER_INVALID_FREQ_INDEX;
 	}
 
@@ -723,8 +722,8 @@ power_pstate_cpufreq_get_freq(unsigned int lcore_id)
 int
 power_pstate_cpufreq_set_freq(unsigned int lcore_id, uint32_t index)
 {
-	if (lcore_id >= RTE_MAX_LCORE) {
-		POWER_LOG(ERR, "Invalid lcore ID");
+	if (!rte_lcore_is_eal_managed(lcore_id)) {
+		POWER_LOG(ERR, "lcore id %u is invalid.", lcore_id);
 		return -1;
 	}
 
@@ -736,8 +735,8 @@ power_pstate_cpufreq_freq_up(unsigned int lcore_id)
 {
 	struct pstate_power_info *pi;
 
-	if (lcore_id >= RTE_MAX_LCORE) {
-		POWER_LOG(ERR, "Invalid lcore ID");
+	if (!rte_lcore_is_eal_managed(lcore_id)) {
+		POWER_LOG(ERR, "lcore id %u is invalid.", lcore_id);
 		return -1;
 	}
 
@@ -755,8 +754,8 @@ power_pstate_cpufreq_freq_down(unsigned int lcore_id)
 {
 	struct pstate_power_info *pi;
 
-	if (lcore_id >= RTE_MAX_LCORE) {
-		POWER_LOG(ERR, "Invalid lcore ID");
+	if (!rte_lcore_is_eal_managed(lcore_id)) {
+		POWER_LOG(ERR, "lcore id %u is invalid.", lcore_id);
 		return -1;
 	}
 
@@ -771,8 +770,8 @@ power_pstate_cpufreq_freq_down(unsigned int lcore_id)
 int
 power_pstate_cpufreq_freq_max(unsigned int lcore_id)
 {
-	if (lcore_id >= RTE_MAX_LCORE) {
-		POWER_LOG(ERR, "Invalid lcore ID");
+	if (!rte_lcore_is_eal_managed(lcore_id)) {
+		POWER_LOG(ERR, "lcore id %u is invalid.", lcore_id);
 		return -1;
 	}
 
@@ -796,8 +795,8 @@ power_pstate_cpufreq_freq_min(unsigned int lcore_id)
 {
 	struct pstate_power_info *pi;
 
-	if (lcore_id >= RTE_MAX_LCORE) {
-		POWER_LOG(ERR, "Invalid lcore ID");
+	if (!rte_lcore_is_eal_managed(lcore_id)) {
+		POWER_LOG(ERR, "lcore id %u is invalid.", lcore_id);
 		return -1;
 	}
 
@@ -813,8 +812,8 @@ power_pstate_turbo_status(unsigned int lcore_id)
 {
 	struct pstate_power_info *pi;
 
-	if (lcore_id >= RTE_MAX_LCORE) {
-		POWER_LOG(ERR, "Invalid lcore ID");
+	if (!rte_lcore_is_eal_managed(lcore_id)) {
+		POWER_LOG(ERR, "lcore id %u is invalid.", lcore_id);
 		return -1;
 	}
 
@@ -828,8 +827,8 @@ power_pstate_enable_turbo(unsigned int lcore_id)
 {
 	struct pstate_power_info *pi;
 
-	if (lcore_id >= RTE_MAX_LCORE) {
-		POWER_LOG(ERR, "Invalid lcore ID");
+	if (!rte_lcore_is_eal_managed(lcore_id)) {
+		POWER_LOG(ERR, "lcore id %u is invalid.", lcore_id);
 		return -1;
 	}
 
@@ -854,8 +853,8 @@ power_pstate_disable_turbo(unsigned int lcore_id)
 {
 	struct pstate_power_info *pi;
 
-	if (lcore_id >= RTE_MAX_LCORE) {
-		POWER_LOG(ERR, "Invalid lcore ID");
+	if (!rte_lcore_is_eal_managed(lcore_id)) {
+		POWER_LOG(ERR, "lcore id %u is invalid.", lcore_id);
 		return -1;
 	}
 
@@ -882,10 +881,11 @@ int power_pstate_get_capabilities(unsigned int lcore_id,
 {
 	struct pstate_power_info *pi;
 
-	if (lcore_id >= RTE_MAX_LCORE) {
-		POWER_LOG(ERR, "Invalid lcore ID");
+	if (!rte_lcore_is_eal_managed(lcore_id)) {
+		POWER_LOG(ERR, "lcore id %u is invalid.", lcore_id);
 		return -1;
 	}
+
 	if (caps == NULL) {
 		POWER_LOG(ERR, "Invalid argument");
 		return -1;
-- 
2.33.0

