Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEA19C021B0
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Feb 2025 08:09:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D69A44014F;
	Thu, 20 Feb 2025 09:09:12 +0100 (CET)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
 by mails.dpdk.org (Postfix) with ESMTP id E1A2640041
 for <dev@dpdk.org>; Thu, 20 Feb 2025 09:09:11 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.19.163.44])
 by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Yz5Qw171wz2Jklm;
 Thu, 20 Feb 2025 16:05:12 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 147A8140360;
 Thu, 20 Feb 2025 16:09:08 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 20 Feb 2025 16:09:07 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <thomas@monjalon.net>, Chenbo Xia <chenbox@nvidia.com>, Nipun Gupta
 <nipun.gupta@amd.com>, Long Li <longli@microsoft.com>, Wei Hu
 <weh@microsoft.com>, =?UTF-8?q?Morten=20Br=C3=B8rup?=
 <mb@smartsharesystems.com>, Kevin Laatz <kevin.laatz@intel.com>, Bruce
 Richardson <bruce.richardson@intel.com>, Huisong Li <lihuisong@huawei.com>,
 Zhangfei Gao <zhangfei.gao@linaro.org>
CC: <dev@dpdk.org>
Subject: [PATCH] bus: invoke TAILQ_REMOVE when bus cleanup
Date: Thu, 20 Feb 2025 16:09:06 +0800
Message-ID: <20250220080906.49705-1-fengchengwen@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.50.165.33]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemk500009.china.huawei.com (7.202.194.94)
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

Although eal_bus_cleanup() is not invoked for multiple times, this is a
good programming habit to remove the device object from list when
cleanup bus.

Fixes: 1cab1a40ea9b ("bus: cleanup devices on shutdown")
Fixes: 62b906cf06ba ("bus/uacce: introduce UACCE bus")
Fixes: 65780eada9d9 ("bus/vmbus: support cleanup")
Cc: stable@dpdk.org

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 drivers/bus/pci/pci_common.c     | 1 +
 drivers/bus/uacce/uacce.c        | 1 +
 drivers/bus/vdev/vdev.c          | 1 +
 drivers/bus/vmbus/vmbus_common.c | 1 +
 4 files changed, 4 insertions(+)

diff --git a/drivers/bus/pci/pci_common.c b/drivers/bus/pci/pci_common.c
index 1173f0887c..2e6d7e43dc 100644
--- a/drivers/bus/pci/pci_common.c
+++ b/drivers/bus/pci/pci_common.c
@@ -459,6 +459,7 @@ pci_cleanup(void)
 		rte_intr_instance_free(dev->vfio_req_intr_handle);
 		dev->vfio_req_intr_handle = NULL;
 
+		TAILQ_REMOVE(&rte_pci_bus.device_list, dev, next);
 		pci_free(RTE_PCI_DEVICE_INTERNAL(dev));
 	}
 
diff --git a/drivers/bus/uacce/uacce.c b/drivers/bus/uacce/uacce.c
index 9ca048122d..75a07957bf 100644
--- a/drivers/bus/uacce/uacce.c
+++ b/drivers/bus/uacce/uacce.c
@@ -454,6 +454,7 @@ uacce_cleanup(void)
 		dev->device.driver = NULL;
 
 free:
+		TAILQ_REMOVE(&uacce_bus.device_list, dev, next);
 		memset(dev, 0, sizeof(*dev));
 		free(dev);
 	}
diff --git a/drivers/bus/vdev/vdev.c b/drivers/bus/vdev/vdev.c
index ec7abe7cda..ae79cfd049 100644
--- a/drivers/bus/vdev/vdev.c
+++ b/drivers/bus/vdev/vdev.c
@@ -596,6 +596,7 @@ vdev_cleanup(void)
 
 		dev->device.driver = NULL;
 free:
+		TAILQ_REMOVE(&vdev_device_list, dev, next);
 		free(dev);
 	}
 
diff --git a/drivers/bus/vmbus/vmbus_common.c b/drivers/bus/vmbus/vmbus_common.c
index 8a965d10d9..4dac5a6298 100644
--- a/drivers/bus/vmbus/vmbus_common.c
+++ b/drivers/bus/vmbus/vmbus_common.c
@@ -238,6 +238,7 @@ rte_vmbus_cleanup(void)
 
 		dev->driver = NULL;
 		dev->device.driver = NULL;
+		TAILQ_REMOVE(&rte_vmbus_bus.device_list, dev, next);
 		free(dev);
 	}
 
-- 
2.17.1

