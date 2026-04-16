Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14FB3F433D9
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Apr 2026 03:07:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DAAE540A6C;
	Thu, 16 Apr 2026 05:06:35 +0200 (CEST)
Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com
 [113.46.200.227])
 by mails.dpdk.org (Postfix) with ESMTP id 8BB164064E
 for <dev@dpdk.org>; Thu, 16 Apr 2026 05:06:20 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=kMDTPG2PJyfAMafu4/DUYBnMxaQf1WI/Rch7m9MGDnA=;
 b=oegbopi9GLIreG2c39QDyzK+KCushgBPRA0RwtzmC5qJu5IclIpbSFKoZ/5nlTUtUxNUlXZ6a
 th5S8enDRmaJdYjCVpJRlWy57vJ+C7jZjP2dvFKq4rmhQ0eF4GGSIT+PEpsR6NtvzM+8LnUVVDi
 F49ZRR82IaDVJS8S1srT3dA=
Received: from mail.maildlp.com (unknown [172.19.163.15])
 by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4fx2mx3qhQznTWw;
 Thu, 16 Apr 2026 11:00:01 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
 by mail.maildlp.com (Postfix) with ESMTPS id 1AB3B40573;
 Thu, 16 Apr 2026 11:06:19 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 16 Apr 2026 11:06:16 +0800
Received: from localhost.localdomain (10.50.163.32) by
 kwepemn100009.china.huawei.com (7.202.194.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 16 Apr 2026 11:06:15 +0800
From: Huisong Li <lihuisong@huawei.com>
To: <anatoly.burakov@intel.com>, <sivaprasad.tummala@amd.com>
CC: <dev@dpdk.org>, <thomas@monjalon.net>, <fengchengwen@huawei.com>,
 <yangxingui@huawei.com>, <zhanjie9@hisilicon.com>, <lihuisong@huawei.com>
Subject: [PATCH v1 08/15] power/pmd_mgmt: replace lcore ID verification with
 new macro
Date: Thu, 16 Apr 2026 11:06:05 +0800
Message-ID: <20260416030612.2379407-9-lihuisong@huawei.com>
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

Replace the duplicate code for validating the ID with
RTE_POWER_VALID_LCOREID_OR_ERR_RET.

Signed-off-by: Huisong Li <lihuisong@huawei.com>
---
 lib/power/rte_power_pmd_mgmt.c | 20 ++++----------------
 1 file changed, 4 insertions(+), 16 deletions(-)

diff --git a/lib/power/rte_power_pmd_mgmt.c b/lib/power/rte_power_pmd_mgmt.c
index a5fc1c3a94..393adba27f 100644
--- a/lib/power/rte_power_pmd_mgmt.c
+++ b/lib/power/rte_power_pmd_mgmt.c
@@ -730,10 +730,7 @@ RTE_EXPORT_SYMBOL(rte_power_pmd_mgmt_set_scaling_freq_min)
 int
 rte_power_pmd_mgmt_set_scaling_freq_min(unsigned int lcore, unsigned int min)
 {
-	if (!rte_lcore_is_enabled(lcore)) {
-		POWER_LOG(ERR, "lcore id %u is not enabled", lcore);
-		return -EINVAL;
-	}
+	RTE_POWER_VALID_LCOREID_OR_ERR_RET(lcore, -EINVAL);
 
 	if (min > scale_freq_max[lcore]) {
 		POWER_LOG(ERR, "Invalid min frequency: Cannot be greater than max frequency");
@@ -748,10 +745,7 @@ RTE_EXPORT_SYMBOL(rte_power_pmd_mgmt_set_scaling_freq_max)
 int
 rte_power_pmd_mgmt_set_scaling_freq_max(unsigned int lcore, unsigned int max)
 {
-	if (!rte_lcore_is_enabled(lcore)) {
-		POWER_LOG(ERR, "lcore id %u is not enabled", lcore);
-		return -EINVAL;
-	}
+	RTE_POWER_VALID_LCOREID_OR_ERR_RET(lcore, -EINVAL);
 
 	/* Zero means 'not set'. Use UINT32_MAX to enable RTE_MIN/MAX macro use when scaling. */
 	if (max == 0)
@@ -770,10 +764,7 @@ RTE_EXPORT_SYMBOL(rte_power_pmd_mgmt_get_scaling_freq_min)
 int
 rte_power_pmd_mgmt_get_scaling_freq_min(unsigned int lcore)
 {
-	if (!rte_lcore_is_enabled(lcore)) {
-		POWER_LOG(ERR, "lcore id %u is not enabled", lcore);
-		return -EINVAL;
-	}
+	RTE_POWER_VALID_LCOREID_OR_ERR_RET(lcore, -EINVAL);
 
 	if (scale_freq_max[lcore] == 0)
 		POWER_LOG(DEBUG, "Scaling freq min config not set. Using sysfs min freq.");
@@ -785,10 +776,7 @@ RTE_EXPORT_SYMBOL(rte_power_pmd_mgmt_get_scaling_freq_max)
 int
 rte_power_pmd_mgmt_get_scaling_freq_max(unsigned int lcore)
 {
-	if (!rte_lcore_is_enabled(lcore)) {
-		POWER_LOG(ERR, "lcore id %u is not enabled", lcore);
-		return -EINVAL;
-	}
+	RTE_POWER_VALID_LCOREID_OR_ERR_RET(lcore, -EINVAL);
 
 	if (scale_freq_max[lcore] == UINT32_MAX) {
 		POWER_LOG(DEBUG, "Scaling freq max config not set. Using sysfs max freq.");
-- 
2.33.0

