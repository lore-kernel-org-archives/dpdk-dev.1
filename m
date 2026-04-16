Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A40C0F433D9
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Apr 2026 03:06:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1FB924065C;
	Thu, 16 Apr 2026 05:06:24 +0200 (CEST)
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com
 [113.46.200.216])
 by mails.dpdk.org (Postfix) with ESMTP id 2B43340297
 for <dev@dpdk.org>; Thu, 16 Apr 2026 05:06:19 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=XzjE9zKUzyPU63z1IR/TnWBye/P2XAzOmWs1kWW0bFw=;
 b=lCBCYuvv4/SyX9sNZdb+mhioms2jD9YVgvJHCAB4JourZfVvUYEOtCYftyaq778OYm07DOFCg
 jVJpeuH7Jxua4rpaPhUcBKT5csnBJHCYfLc8Ae5hRjITOkUtfO6/ZDbEPbBsYGA1LwUz9D8ACYV
 oEYXJejLqD7V7dDtBibJyGM=
Received: from mail.maildlp.com (unknown [172.19.163.104])
 by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4fx2nD0yjcz1T4HC;
 Thu, 16 Apr 2026 11:00:16 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
 by mail.maildlp.com (Postfix) with ESMTPS id CFA5C40570;
 Thu, 16 Apr 2026 11:06:17 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 16 Apr 2026 11:06:13 +0800
Received: from localhost.localdomain (10.50.163.32) by
 kwepemn100009.china.huawei.com (7.202.194.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 16 Apr 2026 11:06:13 +0800
From: Huisong Li <lihuisong@huawei.com>
To: <anatoly.burakov@intel.com>, <sivaprasad.tummala@amd.com>
CC: <dev@dpdk.org>, <thomas@monjalon.net>, <fengchengwen@huawei.com>,
 <yangxingui@huawei.com>, <zhanjie9@hisilicon.com>, <lihuisong@huawei.com>
Subject: [PATCH v1 01/15] power/kvm_vm: enforce enabled lcore ID check
Date: Thu, 16 Apr 2026 11:05:58 +0800
Message-ID: <20260416030612.2379407-2-lihuisong@huawei.com>
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
 drivers/power/kvm_vm/kvm_vm.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/power/kvm_vm/kvm_vm.c b/drivers/power/kvm_vm/kvm_vm.c
index 5754a441cd..816863da7a 100644
--- a/drivers/power/kvm_vm/kvm_vm.c
+++ b/drivers/power/kvm_vm/kvm_vm.c
@@ -24,11 +24,11 @@ power_kvm_vm_check_supported(void)
 int
 power_kvm_vm_init(unsigned int lcore_id)
 {
-	if (lcore_id >= RTE_MAX_LCORE) {
-		POWER_LOG(ERR, "Core(%u) is out of range 0...%d",
-				lcore_id, RTE_MAX_LCORE-1);
+	if (!rte_lcore_is_enabled(lcore_id)) {
+		POWER_LOG(ERR, "lcore id %u is not enabled", lcore_id);
 		return -1;
 	}
+
 	pkt[lcore_id].command = RTE_POWER_CPU_POWER;
 	pkt[lcore_id].resource_id = lcore_id;
 	return guest_channel_host_connect(FD_PATH, lcore_id);
@@ -73,11 +73,11 @@ send_msg(unsigned int lcore_id, uint32_t scale_direction)
 {
 	int ret;
 
-	if (lcore_id >= RTE_MAX_LCORE) {
-		POWER_LOG(ERR, "Core(%u) is out of range 0...%d",
-				lcore_id, RTE_MAX_LCORE-1);
+	if (!rte_lcore_is_enabled(lcore_id)) {
+		POWER_LOG(ERR, "lcore id %u is not enabled", lcore_id);
 		return -1;
 	}
+
 	pkt[lcore_id].unit = scale_direction;
 	ret = guest_channel_send_msg(&pkt[lcore_id], lcore_id);
 	if (ret == 0)
-- 
2.33.0

