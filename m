Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0A48CCF9E0
	for <dpdk-dev@archiver.kernel.org>; Mon, 27 Oct 2025 10:17:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6C3EA4028B;
	Mon, 27 Oct 2025 11:17:08 +0100 (CET)
Received: from out28-217.mail.aliyun.com (out28-217.mail.aliyun.com
 [115.124.28.217])
 by mails.dpdk.org (Postfix) with ESMTP id 748BE4028D
 for <dev@dpdk.org>; Mon, 27 Oct 2025 11:17:05 +0100 (CET)
Received: from ubuntu.localdomain(mailfrom:dimon.zhao@nebula-matrix.com
 fp:SMTPD_---.f8MxqOK_1761560222 cluster:ay29) by smtp.aliyun-inc.com;
 Mon, 27 Oct 2025 18:17:02 +0800
From: Dimon Zhao <dimon.zhao@nebula-matrix.com>
To: dimon.zhao@nebula-matrix.com,
	dev@dpdk.org
Cc: Kyo Liu <kyo.liu@nebula-matrix.com>, Leon Yu <leon.yu@nebula-matrix.com>,
 Sam Chen <sam.chen@nebula-matrix.com>
Subject: [PATCH v1 3/9] net/nbl: address nbl userdev error handling issues
 490947
Date: Mon, 27 Oct 2025 03:16:42 -0700
Message-Id: <20251027101649.3337618-4-dimon.zhao@nebula-matrix.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251027101649.3337618-1-dimon.zhao@nebula-matrix.com>
References: <20250627014022.4019625-1-dimon.zhao@nebula-matrix.com>
 <20251027101649.3337618-1-dimon.zhao@nebula-matrix.com>
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

Coverity issue: 490947

Signed-off-by: Dimon Zhao <dimon.zhao@nebula-matrix.com>
---
 drivers/net/nbl/nbl_common/nbl_userdev.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/nbl/nbl_common/nbl_userdev.c b/drivers/net/nbl/nbl_common/nbl_userdev.c
index 75e0e2884b..acae57020c 100644
--- a/drivers/net/nbl/nbl_common/nbl_userdev.c
+++ b/drivers/net/nbl/nbl_common/nbl_userdev.c
@@ -744,12 +744,15 @@ void nbl_pci_unmap_device(struct nbl_adapter *adapter)
 {
 	struct rte_pci_device *pci_dev = adapter->pci_dev;
 	struct nbl_common_info *common = &adapter->common;
+	int ret = 0;
 
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

