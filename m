Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 463B7CA0EFF
	for <dpdk-dev@archiver.kernel.org>; Thu, 28 Aug 2025 03:00:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7BE274027D;
	Thu, 28 Aug 2025 05:00:37 +0200 (CEST)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 by mails.dpdk.org (Postfix) with ESMTP id 05E6540263
 for <dev@dpdk.org>; Thu, 28 Aug 2025 05:00:35 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.19.163.48])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4cC5k22g4Kz14Mbt;
 Thu, 28 Aug 2025 11:00:26 +0800 (CST)
Received: from kwepemj100018.china.huawei.com (unknown [7.202.194.12])
 by mail.maildlp.com (Postfix) with ESMTPS id 995A4180080;
 Thu, 28 Aug 2025 11:00:33 +0800 (CST)
Received: from localhost.huawei.com (10.90.31.46) by
 kwepemj100018.china.huawei.com (7.202.194.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 28 Aug 2025 11:00:33 +0800
From: Xingui Yang <yangxingui@huawei.com>
To: <dev@dpdk.org>
CC: <chenbox@nvidia.com>, <nipun.gupta@amd.com>, <stephen@networkplumber.org>, 
 <huangdengdui@huawei.com>
Subject: [PATCH] bus/pci: print the return value when probe failed
Date: Thu, 28 Aug 2025 11:00:27 +0800
Message-ID: <20250828030027.1865866-1-yangxingui@huawei.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.90.31.46]
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemj100018.china.huawei.com (7.202.194.12)
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

The return value is not printed when probe failed, and it is not
convenient for locating the problem, so add it.

Signed-off-by: Xingui Yang <yangxingui@huawei.com>
---
 drivers/bus/pci/pci_common.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/bus/pci/pci_common.c b/drivers/bus/pci/pci_common.c
index c88634f790..adef4c16e1 100644
--- a/drivers/bus/pci/pci_common.c
+++ b/drivers/bus/pci/pci_common.c
@@ -410,9 +410,9 @@ pci_probe(void)
 		ret = pci_probe_all_drivers(dev);
 		if (ret < 0) {
 			if (ret != -EEXIST) {
-				PCI_LOG(ERR, "Requested device " PCI_PRI_FMT " cannot be used",
-					dev->addr.domain, dev->addr.bus,
-					dev->addr.devid, dev->addr.function);
+				PCI_LOG(ERR, "Requested device " PCI_PRI_FMT " cannot be used, ret = %d",
+					dev->addr.domain, dev->addr.bus, dev->addr.devid,
+					dev->addr.function, ret);
 				rte_errno = errno;
 				failed++;
 			}
-- 
2.33.0

