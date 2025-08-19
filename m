Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D53FCA0EF5
	for <dpdk-dev@archiver.kernel.org>; Tue, 19 Aug 2025 10:24:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8ADF2406BC;
	Tue, 19 Aug 2025 12:23:22 +0200 (CEST)
Received: from out28-99.mail.aliyun.com (out28-99.mail.aliyun.com
 [115.124.28.99]) by mails.dpdk.org (Postfix) with ESMTP id 08F6940650
 for <dev@dpdk.org>; Tue, 19 Aug 2025 12:23:12 +0200 (CEST)
Received: from ubuntu.localdomain(mailfrom:dimon.zhao@nebula-matrix.com
 fp:SMTPD_---.eJiaSSl_1755598990 cluster:ay29) by smtp.aliyun-inc.com;
 Tue, 19 Aug 2025 18:23:11 +0800
From: Dimon Zhao <dimon.zhao@nebula-matrix.com>
To: dimon.zhao@nebula-matrix.com,
	dev@dpdk.org
Cc: Kyo Liu <kyo.liu@nebula-matrix.com>, Leon Yu <leon.yu@nebula-matrix.com>,
 Sam Chen <sam.chen@nebula-matrix.com>
Subject: [PATCH v5 11/17] net/nbl: add nbl ethdev configuration
Date: Tue, 19 Aug 2025 03:22:31 -0700
Message-Id: <20250819102237.3067518-12-dimon.zhao@nebula-matrix.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250819102237.3067518-1-dimon.zhao@nebula-matrix.com>
References: <20250627014022.4019625-1-dimon.zhao@nebula-matrix.com>
 <20250819102237.3067518-1-dimon.zhao@nebula-matrix.com>
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
 drivers/net/nbl/nbl_dev/nbl_dev.c | 39 +++++++++++++++++++++++++++++--
 1 file changed, 37 insertions(+), 2 deletions(-)

diff --git a/drivers/net/nbl/nbl_dev/nbl_dev.c b/drivers/net/nbl/nbl_dev/nbl_dev.c
index ffad3061f1..214ba84ce8 100644
--- a/drivers/net/nbl/nbl_dev/nbl_dev.c
+++ b/drivers/net/nbl/nbl_dev/nbl_dev.c
@@ -4,12 +4,47 @@
 
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
+	enum rte_eth_rx_mq_mode rx_mq_mode = eth_dev->data->dev_conf.rxmode.mq_mode;
+	struct nbl_adapter *adapter = ETH_DEV_TO_NBL_DEV_PF_PRIV(eth_dev);
+	int ret;
+
+	NBL_LOG(INFO, "Begin to configure the device, state: %d", adapter->state);
+
+	if (dev_data == NULL || adapter == NULL)
+		return -EINVAL;
+
+
+	if (rx_mq_mode != RTE_ETH_MQ_RX_NONE && rx_mq_mode != RTE_ETH_MQ_RX_RSS) {
+		NBL_LOG(INFO, "Rx mq mode %d is not supported", rx_mq_mode);
+		return -EINVAL;
+	}
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
-- 
2.34.1

