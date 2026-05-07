Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D54E6CD3436
	for <dpdk-dev@archiver.kernel.org>; Thu,  7 May 2026 02:42:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 85F1C4060A;
	Thu,  7 May 2026 04:42:39 +0200 (CEST)
Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com
 [113.46.200.224])
 by mails.dpdk.org (Postfix) with ESMTP id C1AA0402BC
 for <dev@dpdk.org>; Thu,  7 May 2026 04:42:34 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=FfyrGLdB6PC67mVwku2ts+mXYnmQNsx/4UxOQH2ZJI8=;
 b=Jl16dlTsLRDPLMK1oEqeErtFHRZHbKjd5ljKLLXfF6SJHOH/pkcC8hxaYHD1MJfpQF9ITpeTx
 qaREy0+8l8Bxsi/4Xsd2OA+LACnAh1evKKqoxZPfmCBNu9M7TYdr5kenaPRAYd5VtfUO3s8IoXK
 SEYohDgSzVkDZGiQKlqQ8HI=
Received: from mail.maildlp.com (unknown [172.19.162.92])
 by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4g9xDP3WVWz1cyVf;
 Thu,  7 May 2026 10:35:01 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
 by mail.maildlp.com (Postfix) with ESMTPS id 7954640565;
 Thu,  7 May 2026 10:42:33 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 7 May 2026 10:42:33 +0800
Received: from localhost.localdomain (10.50.163.32) by
 kwepemn100009.china.huawei.com (7.202.194.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 7 May 2026 10:42:32 +0800
From: Huisong Li <lihuisong@huawei.com>
To: <anatoly.burakov@intel.com>, <sivaprasad.tummala@amd.com>,
 <stephen@networkplumber.org>
CC: <dev@dpdk.org>, <thomas@monjalon.net>, <fengchengwen@huawei.com>,
 <yangxingui@huawei.com>, <zhanjie9@hisilicon.com>, <lihuisong@huawei.com>
Subject: [PATCH V2 05/15] power/cppc_cpufreq: validate lcore role in cpufreq
 API
Date: Thu, 7 May 2026 10:42:20 +0800
Message-ID: <20260507024230.1198111-6-lihuisong@huawei.com>
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

Currently, the cppc_cpufreq driver only checks if the lcore_id is
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
 drivers/power/cppc/cppc_cpufreq.c | 56 +++++++++++++++----------------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/drivers/power/cppc/cppc_cpufreq.c b/drivers/power/cppc/cppc_cpufreq.c
index 3cd4165c83..7e1298110a 100644
--- a/drivers/power/cppc/cppc_cpufreq.c
+++ b/drivers/power/cppc/cppc_cpufreq.c
@@ -346,9 +346,8 @@ power_cppc_cpufreq_init(unsigned int lcore_id)
 		return -1;
 	}
 
-	if (lcore_id >= RTE_MAX_LCORE) {
-		POWER_LOG(ERR, "Lcore id %u can not exceeds %u",
-				lcore_id, RTE_MAX_LCORE - 1U);
+	if (!rte_lcore_is_eal_managed(lcore_id)) {
+		POWER_LOG(ERR, "lcore id %u is invalid.", lcore_id);
 		return -1;
 	}
 
@@ -429,11 +428,11 @@ power_cppc_cpufreq_exit(unsigned int lcore_id)
 	struct cppc_power_info *pi;
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
 	/* The power in use state works as a guard variable between
@@ -479,8 +478,8 @@ power_cppc_cpufreq_freqs(unsigned int lcore_id, uint32_t *freqs, uint32_t num)
 {
 	struct cppc_power_info *pi;
 
-	if (lcore_id >= RTE_MAX_LCORE) {
-		POWER_LOG(ERR, "Invalid lcore ID");
+	if (!rte_lcore_is_eal_managed(lcore_id)) {
+		POWER_LOG(ERR, "lcore id %u is invalid.", lcore_id);
 		return 0;
 	}
 
@@ -502,8 +501,8 @@ power_cppc_cpufreq_freqs(unsigned int lcore_id, uint32_t *freqs, uint32_t num)
 uint32_t
 power_cppc_cpufreq_get_freq(unsigned int lcore_id)
 {
-	if (lcore_id >= RTE_MAX_LCORE) {
-		POWER_LOG(ERR, "Invalid lcore ID");
+	if (!rte_lcore_is_eal_managed(lcore_id)) {
+		POWER_LOG(ERR, "lcore id %u is invalid.", lcore_id);
 		return RTE_POWER_INVALID_FREQ_INDEX;
 	}
 
@@ -513,8 +512,8 @@ power_cppc_cpufreq_get_freq(unsigned int lcore_id)
 int
 power_cppc_cpufreq_set_freq(unsigned int lcore_id, uint32_t index)
 {
-	if (lcore_id >= RTE_MAX_LCORE) {
-		POWER_LOG(ERR, "Invalid lcore ID");
+	if (!rte_lcore_is_eal_managed(lcore_id)) {
+		POWER_LOG(ERR, "lcore id %u is invalid.", lcore_id);
 		return -1;
 	}
 
@@ -526,8 +525,8 @@ power_cppc_cpufreq_freq_down(unsigned int lcore_id)
 {
 	struct cppc_power_info *pi;
 
-	if (lcore_id >= RTE_MAX_LCORE) {
-		POWER_LOG(ERR, "Invalid lcore ID");
+	if (!rte_lcore_is_eal_managed(lcore_id)) {
+		POWER_LOG(ERR, "lcore id %u is invalid.", lcore_id);
 		return -1;
 	}
 
@@ -544,8 +543,8 @@ power_cppc_cpufreq_freq_up(unsigned int lcore_id)
 {
 	struct cppc_power_info *pi;
 
-	if (lcore_id >= RTE_MAX_LCORE) {
-		POWER_LOG(ERR, "Invalid lcore ID");
+	if (!rte_lcore_is_eal_managed(lcore_id)) {
+		POWER_LOG(ERR, "lcore id %u is invalid.", lcore_id);
 		return -1;
 	}
 
@@ -561,8 +560,8 @@ power_cppc_cpufreq_freq_up(unsigned int lcore_id)
 int
 power_cppc_cpufreq_freq_max(unsigned int lcore_id)
 {
-	if (lcore_id >= RTE_MAX_LCORE) {
-		POWER_LOG(ERR, "Invalid lcore ID");
+	if (!rte_lcore_is_eal_managed(lcore_id)) {
+		POWER_LOG(ERR, "lcore id %u is invalid.", lcore_id);
 		return -1;
 	}
 
@@ -585,8 +584,8 @@ power_cppc_cpufreq_freq_min(unsigned int lcore_id)
 {
 	struct cppc_power_info *pi;
 
-	if (lcore_id >= RTE_MAX_LCORE) {
-		POWER_LOG(ERR, "Invalid lcore ID");
+	if (!rte_lcore_is_eal_managed(lcore_id)) {
+		POWER_LOG(ERR, "lcore id %u is invalid.", lcore_id);
 		return -1;
 	}
 
@@ -601,8 +600,8 @@ power_cppc_turbo_status(unsigned int lcore_id)
 {
 	struct cppc_power_info *pi;
 
-	if (lcore_id >= RTE_MAX_LCORE) {
-		POWER_LOG(ERR, "Invalid lcore ID");
+	if (!rte_lcore_is_eal_managed(lcore_id)) {
+		POWER_LOG(ERR, "lcore id %u is invalid.", lcore_id);
 		return -1;
 	}
 
@@ -616,8 +615,8 @@ power_cppc_enable_turbo(unsigned int lcore_id)
 {
 	struct cppc_power_info *pi;
 
-	if (lcore_id >= RTE_MAX_LCORE) {
-		POWER_LOG(ERR, "Invalid lcore ID");
+	if (!rte_lcore_is_eal_managed(lcore_id)) {
+		POWER_LOG(ERR, "lcore id %u is invalid.", lcore_id);
 		return -1;
 	}
 
@@ -652,8 +651,8 @@ power_cppc_disable_turbo(unsigned int lcore_id)
 {
 	struct cppc_power_info *pi;
 
-	if (lcore_id >= RTE_MAX_LCORE) {
-		POWER_LOG(ERR, "Invalid lcore ID");
+	if (!rte_lcore_is_eal_managed(lcore_id)) {
+		POWER_LOG(ERR, "lcore id %u is invalid.", lcore_id);
 		return -1;
 	}
 
@@ -680,10 +679,11 @@ power_cppc_get_capabilities(unsigned int lcore_id,
 {
 	struct cppc_power_info *pi;
 
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

