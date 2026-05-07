Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C311CD342C
	for <dpdk-dev@archiver.kernel.org>; Thu,  7 May 2026 02:42:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1C3A8402E8;
	Thu,  7 May 2026 04:42:36 +0200 (CEST)
Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com
 [113.46.200.220])
 by mails.dpdk.org (Postfix) with ESMTP id 794BC4025A
 for <dev@dpdk.org>; Thu,  7 May 2026 04:42:34 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=8/ygOAjIRweiJyKhTBLz9p8ll6id+CHyWYUPAGFGCgs=;
 b=Pa3RAbJI+Ag9kk1wmGtZkU3IOO49udO+JWTxIgbe5zNvbroOQZQm6/MfnRRWPEI4uPVzlg3YE
 IWObY3i6zltVd/KCPK3/MjuXC4kQSIY09OYbeYv5cM5XLKw0jSaeOVklK9Ecv1qzIzk1xnFEaRT
 K0MGLEAVI8bnEYkdkZjv7sE=
Received: from mail.maildlp.com (unknown [172.19.162.197])
 by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4g9xDr0K03z12LFZ;
 Thu,  7 May 2026 10:35:24 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
 by mail.maildlp.com (Postfix) with ESMTPS id DB18F40569;
 Thu,  7 May 2026 10:42:32 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 7 May 2026 10:42:32 +0800
Received: from localhost.localdomain (10.50.163.32) by
 kwepemn100009.china.huawei.com (7.202.194.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 7 May 2026 10:42:31 +0800
From: Huisong Li <lihuisong@huawei.com>
To: <anatoly.burakov@intel.com>, <sivaprasad.tummala@amd.com>,
 <stephen@networkplumber.org>
CC: <dev@dpdk.org>, <thomas@monjalon.net>, <fengchengwen@huawei.com>,
 <yangxingui@huawei.com>, <zhanjie9@hisilicon.com>, <lihuisong@huawei.com>
Subject: [PATCH V2 02/15] power/kvm_vm: validate lcore role in cpufreq API
Date: Thu, 7 May 2026 10:42:17 +0800
Message-ID: <20260507024230.1198111-3-lihuisong@huawei.com>
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

Currently, the kvm_vm driver only checks if the lcore_id is within
the RTE_MAX_LCORE range, but fails to verify if the core is actually
active or managed by the application. This lacks sufficient validation.

This patch add a lcore role check to the cpufreq-related APIs.
Although service cores do not typically invoke these APIs, they may
operate in polling states where power management is required.
To maintain compatibility with applications using service cores, the
validation logic now explicitly allows both ROLE_RTE and ROLE_SERVICE.

Signed-off-by: Huisong Li <lihuisong@huawei.com>
---
 drivers/power/kvm_vm/kvm_vm.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/power/kvm_vm/kvm_vm.c b/drivers/power/kvm_vm/kvm_vm.c
index 5754a441cd..133d1f0882 100644
--- a/drivers/power/kvm_vm/kvm_vm.c
+++ b/drivers/power/kvm_vm/kvm_vm.c
@@ -24,11 +24,11 @@ power_kvm_vm_check_supported(void)
 int
 power_kvm_vm_init(unsigned int lcore_id)
 {
-	if (lcore_id >= RTE_MAX_LCORE) {
-		POWER_LOG(ERR, "Core(%u) is out of range 0...%d",
-				lcore_id, RTE_MAX_LCORE-1);
+	if (!rte_lcore_is_eal_managed(lcore_id)) {
+		POWER_LOG(ERR, "lcore id %u is invalid.", lcore_id);
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
+	if (!rte_lcore_is_eal_managed(lcore_id)) {
+		POWER_LOG(ERR, "lcore id %u is invalid.", lcore_id);
 		return -1;
 	}
+
 	pkt[lcore_id].unit = scale_direction;
 	ret = guest_channel_send_msg(&pkt[lcore_id], lcore_id);
 	if (ret == 0)
-- 
2.33.0

