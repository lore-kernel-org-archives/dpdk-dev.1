Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BA47F433D9
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Apr 2026 03:07:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D792440697;
	Thu, 16 Apr 2026 05:06:31 +0200 (CEST)
Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com
 [113.46.200.227])
 by mails.dpdk.org (Postfix) with ESMTP id 8AF8A402DD
 for <dev@dpdk.org>; Thu, 16 Apr 2026 05:06:20 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=Hs8zRTPpjQdLBxYk+DZeXxjdVZrqX+KHUU3lccvh1ZU=;
 b=Fwxq4qQ2k3z8cvTMHBUg1WxZTI2qkTwndyUYfgS7K5ojcBzr3EmUsRQclRHlDUyViYhbAEokA
 dyOnNSFfUZ2tmVdw6NpXB3dr0Qcf41L/87jjCEMFpvTTGodNHqWwGru5u+AB/EeplumHCgPAxyP
 frOOmRV4tCtd7+/DIv+v/Rg=
Received: from mail.maildlp.com (unknown [172.19.163.15])
 by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4fx2mx4JxtznTWw;
 Thu, 16 Apr 2026 11:00:01 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
 by mail.maildlp.com (Postfix) with ESMTPS id 2A21740575;
 Thu, 16 Apr 2026 11:06:19 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 16 Apr 2026 11:06:18 +0800
Received: from localhost.localdomain (10.50.163.32) by
 kwepemn100009.china.huawei.com (7.202.194.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 16 Apr 2026 11:06:18 +0800
From: Huisong Li <lihuisong@huawei.com>
To: <anatoly.burakov@intel.com>, <sivaprasad.tummala@amd.com>
CC: <dev@dpdk.org>, <thomas@monjalon.net>, <fengchengwen@huawei.com>,
 <yangxingui@huawei.com>, <zhanjie9@hisilicon.com>, <lihuisong@huawei.com>
Subject: [PATCH v1 15/15] power/kvm_vm: remove the verification of lcore ID
Date: Thu, 16 Apr 2026 11:06:12 +0800
Message-ID: <20260416030612.2379407-16-lihuisong@huawei.com>
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

Now the lcore ID has been verified in framework API, so remove
the verification in driver.

Signed-off-by: Huisong Li <lihuisong@huawei.com>
---
 drivers/power/kvm_vm/kvm_vm.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/power/kvm_vm/kvm_vm.c b/drivers/power/kvm_vm/kvm_vm.c
index 816863da7a..e8b454bb55 100644
--- a/drivers/power/kvm_vm/kvm_vm.c
+++ b/drivers/power/kvm_vm/kvm_vm.c
@@ -24,11 +24,6 @@ power_kvm_vm_check_supported(void)
 int
 power_kvm_vm_init(unsigned int lcore_id)
 {
-	if (!rte_lcore_is_enabled(lcore_id)) {
-		POWER_LOG(ERR, "lcore id %u is not enabled", lcore_id);
-		return -1;
-	}
-
 	pkt[lcore_id].command = RTE_POWER_CPU_POWER;
 	pkt[lcore_id].resource_id = lcore_id;
 	return guest_channel_host_connect(FD_PATH, lcore_id);
@@ -73,11 +68,6 @@ send_msg(unsigned int lcore_id, uint32_t scale_direction)
 {
 	int ret;
 
-	if (!rte_lcore_is_enabled(lcore_id)) {
-		POWER_LOG(ERR, "lcore id %u is not enabled", lcore_id);
-		return -1;
-	}
-
 	pkt[lcore_id].unit = scale_direction;
 	ret = guest_channel_send_msg(&pkt[lcore_id], lcore_id);
 	if (ret == 0)
-- 
2.33.0

