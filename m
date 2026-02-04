Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E344EE8B396
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Feb 2026 03:13:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5D1ED40649;
	Wed,  4 Feb 2026 04:13:40 +0100 (CET)
Received: from out198-16.us.a.mail.aliyun.com (out198-16.us.a.mail.aliyun.com
 [47.90.198.16]) by mails.dpdk.org (Postfix) with ESMTP id 4693F4027F;
 Wed,  4 Feb 2026 04:13:36 +0100 (CET)
Received: from ubuntu.localdomain(mailfrom:dimon.zhao@nebula-matrix.com
 fp:SMTPD_---.gOD5rRX_1770174451 cluster:ay29) by smtp.aliyun-inc.com;
 Wed, 04 Feb 2026 11:07:32 +0800
From: Dimon Zhao <dimon.zhao@nebula-matrix.com>
To: dev@dpdk.org
Cc: Dimon Zhao <dimon.zhao@nebula-matrix.com>, stable@dpdk.org,
 Kyo Liu <kyo.liu@nebula-matrix.com>, Leon Yu <leon.yu@nebula-matrix.com>,
 Sam Chen <sam.chen@nebula-matrix.com>
Subject: [PATCH v4 3/3] net/nbl: fix error handling issues
Date: Tue,  3 Feb 2026 19:07:22 -0800
Message-Id: <20260204030722.11716-4-dimon.zhao@nebula-matrix.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260204030722.11716-1-dimon.zhao@nebula-matrix.com>
References: <20260115032744.62449-1-dimon.zhao@nebula-matrix.com>
 <20260204030722.11716-1-dimon.zhao@nebula-matrix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Check return values of ioctl() calls for NBL_DEV_USER_GET_BAR_SIZE
and NBL_DEV_USER_CLEAR_EVENTFD. The original code tested the return
value without capturing it from the ioctl call.

Coverity issue: 490947
Coverity issue: 490951
Fixes: dc955cd24c8f ("net/nbl: add coexistence mode")
Cc: stable@dpdk.org

Signed-off-by: Dimon Zhao <dimon.zhao@nebula-matrix.com>
---
 drivers/net/nbl/nbl_common/nbl_userdev.c | 25 ++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/net/nbl/nbl_common/nbl_userdev.c b/drivers/net/nbl/nbl_common/nbl_userdev.c
index 566f3a11ee..96f0d2e264 100644
--- a/drivers/net/nbl/nbl_common/nbl_userdev.c
+++ b/drivers/net/nbl/nbl_common/nbl_userdev.c
@@ -724,17 +724,19 @@ int nbl_pci_map_device(struct nbl_adapter *adapter)
 	}
 
 	common->eventfd = fd;
-	ioctl(common->devfd, NBL_DEV_USER_GET_BAR_SIZE, &bar_size);
+	ret = ioctl(common->devfd, NBL_DEV_USER_GET_BAR_SIZE, &bar_size);
+	if (ret) {
+		NBL_LOG(ERR, "nbl userdev get bar size failed");
+		goto close_eventfd;
+	}
 
-	if (!ret) {
-		pci_dev->mem_resource[0].addr = nbl_userdev_mmap(common->devfd, 0, bar_size);
-		pci_dev->mem_resource[0].phys_addr = 0;
-		pci_dev->mem_resource[0].len = bar_size;
-		pci_dev->mem_resource[2].addr = 0;
+	pci_dev->mem_resource[0].addr = nbl_userdev_mmap(common->devfd, 0, bar_size);
+	pci_dev->mem_resource[0].phys_addr = 0;
+	pci_dev->mem_resource[0].len = bar_size;
+	pci_dev->mem_resource[2].addr = 0;
 
-		common->ifindex = nbl_userdev_get_ifindex(common->devfd);
-		common->nl_socket_route = nbl_userdev_nl_init(NETLINK_ROUTE);
-	}
+	common->ifindex = nbl_userdev_get_ifindex(common->devfd);
+	common->nl_socket_route = nbl_userdev_nl_init(NETLINK_ROUTE);
 
 	return ret;
 
@@ -753,12 +755,15 @@ void nbl_pci_unmap_device(struct nbl_adapter *adapter)
 {
 	struct rte_pci_device *pci_dev = adapter->pci_dev;
 	struct nbl_common_info *common = &adapter->common;
+	int ret;
 
 	if (NBL_IS_NOT_COEXISTENCE(common))
 		return rte_pci_unmap_device(pci_dev);
 
 	rte_mem_unmap(pci_dev->mem_resource[0].addr, pci_dev->mem_resource[0].len);
-	ioctl(common->devfd, NBL_DEV_USER_CLEAR_EVENTFD, 0);
+	ret = ioctl(common->devfd, NBL_DEV_USER_CLEAR_EVENTFD, 0);
+	if (ret)
+		NBL_LOG(ERR, "nbl userdev set clear eventfd failed, ret: %d", ret);
 	close(common->eventfd);
 	close(common->nl_socket_route);
 
-- 
2.34.1

