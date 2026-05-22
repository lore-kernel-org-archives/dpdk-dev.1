Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 092CFCD4F5B
	for <dpdk-dev@archiver.kernel.org>; Fri, 22 May 2026 04:12:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 52B0A40696;
	Fri, 22 May 2026 06:11:27 +0200 (CEST)
Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com
 [113.46.200.226])
 by mails.dpdk.org (Postfix) with ESMTP id 7E25640650
 for <dev@dpdk.org>; Fri, 22 May 2026 06:11:17 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=rrQJN0xIDcTq4++Geq7d7BMxjU1ulW+87Jr7fp8Ld3k=;
 b=XmzSNPt8TrBtUOryCLL9vtxRDh31zmsWQSC10fhs2ChNWhswiM59S8iC55AXvQ8xij2Aqf3s4
 tpqFH72HP3nYAnd30p3n9itzs3hmL4ZzNVheR85xTcYP2La6Xxlh6dkky/1O5lS1s27+zSDsfj8
 B3shOATmCQLLwAyO9mpZ4qY=
Received: from mail.maildlp.com (unknown [172.19.162.92])
 by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4gMBTb3w1czKm4p;
 Fri, 22 May 2026 12:03:31 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
 by mail.maildlp.com (Postfix) with ESMTPS id 7960A40565;
 Fri, 22 May 2026 12:11:16 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 22 May 2026 12:11:16 +0800
Received: from localhost.localdomain (10.50.163.32) by
 kwepemn100009.china.huawei.com (7.202.194.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Fri, 22 May 2026 12:11:15 +0800
From: Huisong Li <lihuisong@huawei.com>
To: <anatoly.burakov@intel.com>, <sivaprasad.tummala@amd.com>
CC: <dev@dpdk.org>, <thomas@monjalon.net>, <stephen@networkplumber.org>,
 <fengchengwen@huawei.com>, <yangxingui@huawei.com>, <zhanjie9@hisilicon.com>, 
 <lihuisong@huawei.com>
Subject: [PATCH v3 10/10] power: add lcore ID check for PMD mgmt
Date: Fri, 22 May 2026 12:11:10 +0800
Message-ID: <20260522041110.2023062-11-lihuisong@huawei.com>
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

The pmd_mgmt lib is mainly used together with the data plane of ethdev
PMD. The core in data plane is ROLE_RTE. So use rte_lcore_is_enabled
to verify it.

Fixes: 426511683762 ("power: add get/set min/max scaling frequencies API")
Cc: stable@dpdk.org

Signed-off-by: Huisong Li <lihuisong@huawei.com>
---
 lib/power/rte_power_pmd_mgmt.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/lib/power/rte_power_pmd_mgmt.c b/lib/power/rte_power_pmd_mgmt.c
index a4d53aac2a..a5fc1c3a94 100644
--- a/lib/power/rte_power_pmd_mgmt.c
+++ b/lib/power/rte_power_pmd_mgmt.c
@@ -511,7 +511,8 @@ rte_power_ethdev_pmgmt_queue_enable(unsigned int lcore_id, uint16_t port_id,
 
 	RTE_ETH_VALID_PORTID_OR_ERR_RET(port_id, -EINVAL);
 
-	if (queue_id >= RTE_MAX_QUEUES_PER_PORT || lcore_id >= RTE_MAX_LCORE) {
+	if (queue_id >= RTE_MAX_QUEUES_PER_PORT ||
+	    !rte_lcore_is_enabled(lcore_id)) {
 		ret = -EINVAL;
 		goto end;
 	}
@@ -627,7 +628,7 @@ rte_power_ethdev_pmgmt_queue_disable(unsigned int lcore_id,
 
 	RTE_ETH_VALID_PORTID_OR_ERR_RET(port_id, -EINVAL);
 
-	if (lcore_id >= RTE_MAX_LCORE || queue_id >= RTE_MAX_QUEUES_PER_PORT)
+	if (!rte_lcore_is_enabled(lcore_id) || queue_id >= RTE_MAX_QUEUES_PER_PORT)
 		return -EINVAL;
 
 	/* check if the queue is stopped */
@@ -729,8 +730,8 @@ RTE_EXPORT_SYMBOL(rte_power_pmd_mgmt_set_scaling_freq_min)
 int
 rte_power_pmd_mgmt_set_scaling_freq_min(unsigned int lcore, unsigned int min)
 {
-	if (lcore >= RTE_MAX_LCORE) {
-		POWER_LOG(ERR, "Invalid lcore ID: %u", lcore);
+	if (!rte_lcore_is_enabled(lcore)) {
+		POWER_LOG(ERR, "lcore id %u is not enabled", lcore);
 		return -EINVAL;
 	}
 
@@ -747,8 +748,8 @@ RTE_EXPORT_SYMBOL(rte_power_pmd_mgmt_set_scaling_freq_max)
 int
 rte_power_pmd_mgmt_set_scaling_freq_max(unsigned int lcore, unsigned int max)
 {
-	if (lcore >= RTE_MAX_LCORE) {
-		POWER_LOG(ERR, "Invalid lcore ID: %u", lcore);
+	if (!rte_lcore_is_enabled(lcore)) {
+		POWER_LOG(ERR, "lcore id %u is not enabled", lcore);
 		return -EINVAL;
 	}
 
@@ -769,8 +770,8 @@ RTE_EXPORT_SYMBOL(rte_power_pmd_mgmt_get_scaling_freq_min)
 int
 rte_power_pmd_mgmt_get_scaling_freq_min(unsigned int lcore)
 {
-	if (lcore >= RTE_MAX_LCORE) {
-		POWER_LOG(ERR, "Invalid lcore ID: %u", lcore);
+	if (!rte_lcore_is_enabled(lcore)) {
+		POWER_LOG(ERR, "lcore id %u is not enabled", lcore);
 		return -EINVAL;
 	}
 
@@ -784,8 +785,8 @@ RTE_EXPORT_SYMBOL(rte_power_pmd_mgmt_get_scaling_freq_max)
 int
 rte_power_pmd_mgmt_get_scaling_freq_max(unsigned int lcore)
 {
-	if (lcore >= RTE_MAX_LCORE) {
-		POWER_LOG(ERR, "Invalid lcore ID: %u", lcore);
+	if (!rte_lcore_is_enabled(lcore)) {
+		POWER_LOG(ERR, "lcore id %u is not enabled", lcore);
 		return -EINVAL;
 	}
 
-- 
2.33.0

