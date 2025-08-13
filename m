Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78879CA0EE0
	for <dpdk-dev@archiver.kernel.org>; Wed, 13 Aug 2025 06:45:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 78B5140DDA;
	Wed, 13 Aug 2025 08:44:50 +0200 (CEST)
Received: from out28-97.mail.aliyun.com (out28-97.mail.aliyun.com
 [115.124.28.97]) by mails.dpdk.org (Postfix) with ESMTP id 1ED6240A6F
 for <dev@dpdk.org>; Wed, 13 Aug 2025 08:44:38 +0200 (CEST)
Received: from ubuntu.localdomain(mailfrom:dimon.zhao@nebula-matrix.com
 fp:SMTPD_---.eELCnlK_1755067476 cluster:ay29) by smtp.aliyun-inc.com;
 Wed, 13 Aug 2025 14:44:36 +0800
From: Dimon Zhao <dimon.zhao@nebula-matrix.com>
To: dimon.zhao@nebula-matrix.com,
	dev@dpdk.org
Cc: Kyo Liu <kyo.liu@nebula-matrix.com>, Leon Yu <leon.yu@nebula-matrix.com>,
 Sam Chen <sam.chen@nebula-matrix.com>
Subject: [PATCH v4 11/16] net/nbl: add nbl ethdev configuration
Date: Tue, 12 Aug 2025 23:44:05 -0700
Message-Id: <20250813064410.3894506-12-dimon.zhao@nebula-matrix.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250813064410.3894506-1-dimon.zhao@nebula-matrix.com>
References: <20250627014022.4019625-1-dimon.zhao@nebula-matrix.com>
 <20250813064410.3894506-1-dimon.zhao@nebula-matrix.com>
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

NBL device add ethdev configuration

Signed-off-by: Dimon Zhao <dimon.zhao@nebula-matrix.com>
---
 drivers/net/nbl/nbl_dev/nbl_dev.c         | 33 +++++++++++++++++++++--
 drivers/net/nbl/nbl_include/nbl_include.h |  3 ++-
 2 files changed, 33 insertions(+), 3 deletions(-)

diff --git a/drivers/net/nbl/nbl_dev/nbl_dev.c b/drivers/net/nbl/nbl_dev/nbl_dev.c
index c4fd2dbfd6..86defd621d 100644
--- a/drivers/net/nbl/nbl_dev/nbl_dev.c
+++ b/drivers/net/nbl/nbl_dev/nbl_dev.c
@@ -4,15 +4,44 @@
 
 #include "nbl_dev.h"
 
-int nbl_dev_configure(struct rte_eth_dev *eth_dev)
+static int nbl_dev_port_configure(struct nbl_adapter *adapter)
 {
-	RTE_SET_USED(eth_dev);
+	adapter->state = NBL_ETHDEV_CONFIGURED;
+
 	return 0;
 }
 
+int nbl_dev_configure(struct rte_eth_dev *eth_dev)
+{
+	struct rte_eth_dev_data *dev_data = eth_dev->data;
+	struct nbl_adapter *adapter = ETH_DEV_TO_NBL_DEV_PF_PRIV(eth_dev);
+	int ret;
+
+	NBL_LOG(INFO, "Begin to configure the device, state: %d", adapter->state);
+
+	if (dev_data == NULL || adapter == NULL)
+		return -EINVAL;
+
+	dev_data->dev_conf.intr_conf.lsc = 0;
+
+	switch (adapter->state) {
+	case NBL_ETHDEV_CONFIGURED:
+	case NBL_ETHDEV_INITIALIZED:
+		ret = nbl_dev_port_configure(adapter);
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	NBL_LOG(INFO, "configure the device done %d", ret);
+	return ret;
+}
+
 int nbl_dev_port_start(struct rte_eth_dev *eth_dev)
 {
 	RTE_SET_USED(eth_dev);
+
 	return 0;
 }
 
diff --git a/drivers/net/nbl/nbl_include/nbl_include.h b/drivers/net/nbl/nbl_include/nbl_include.h
index 8902c44972..e10fcc9254 100644
--- a/drivers/net/nbl/nbl_include/nbl_include.h
+++ b/drivers/net/nbl/nbl_include/nbl_include.h
@@ -132,9 +132,10 @@ struct nbl_common_info {
 	/* curr_network 0 means kernel network, 1 means user network */
 	u8 curr_network:1;
 	u8 is_vf:1;
+	u8 pf_start:1;
 	u8 specific_dma:1;
 	u8 dma_set_msb:1;
-	u8 rsv:3;
+	u8 rsv:2;
 	struct nbl_board_port_info board_info;
 };
 
-- 
2.34.1

