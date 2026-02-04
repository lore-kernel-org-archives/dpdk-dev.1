Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9021E8B364
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Feb 2026 03:07:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7B5B04065A;
	Wed,  4 Feb 2026 04:07:52 +0100 (CET)
Received: from out28-217.mail.aliyun.com (out28-217.mail.aliyun.com
 [115.124.28.217])
 by mails.dpdk.org (Postfix) with ESMTP id C5D234021E;
 Wed,  4 Feb 2026 04:07:42 +0100 (CET)
Received: from ubuntu.localdomain(mailfrom:dimon.zhao@nebula-matrix.com
 fp:SMTPD_---.gOD5rQh_1770174451 cluster:ay29) by smtp.aliyun-inc.com;
 Wed, 04 Feb 2026 11:07:31 +0800
From: Dimon Zhao <dimon.zhao@nebula-matrix.com>
To: dev@dpdk.org
Cc: Dimon Zhao <dimon.zhao@nebula-matrix.com>, stable@dpdk.org,
 Kyo Liu <kyo.liu@nebula-matrix.com>, Leon Yu <leon.yu@nebula-matrix.com>,
 Sam Chen <sam.chen@nebula-matrix.com>
Subject: [PATCH v4 2/3] net/nbl: fix null pointer dereferences issues
Date: Tue,  3 Feb 2026 19:07:21 -0800
Message-Id: <20260204030722.11716-3-dimon.zhao@nebula-matrix.com>
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

Move debug log statement after NULL pointer validation in
nbl_dev_configure() to prevent dereference of adapter before the
check.

Coverity issue: 490950
Fixes: 93b38df5a2ec ("net/nbl: support basic configuration")
Cc: stable@dpdk.org

Signed-off-by: Dimon Zhao <dimon.zhao@nebula-matrix.com>
---
 drivers/net/nbl/nbl_dev/nbl_dev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/nbl/nbl_dev/nbl_dev.c b/drivers/net/nbl/nbl_dev/nbl_dev.c
index e926c06456..8a56939aa7 100644
--- a/drivers/net/nbl/nbl_dev/nbl_dev.c
+++ b/drivers/net/nbl/nbl_dev/nbl_dev.c
@@ -18,11 +18,11 @@ int nbl_dev_configure(struct rte_eth_dev *eth_dev)
 	struct nbl_adapter *adapter = ETH_DEV_TO_NBL_DEV_PF_PRIV(eth_dev);
 	int ret;
 
-	NBL_LOG(DEBUG, "Begin to configure the device, state: %d", adapter->state);
-
 	if (dev_data == NULL || adapter == NULL)
 		return -EINVAL;
 
+	NBL_LOG(DEBUG, "Begin to configure the device, state: %d", adapter->state);
+
 	if (rx_mq_mode != RTE_ETH_MQ_RX_NONE && rx_mq_mode != RTE_ETH_MQ_RX_RSS) {
 		NBL_LOG(ERR, "Rx mq mode %d is not supported", rx_mq_mode);
 		return -ENOTSUP;
-- 
2.34.1

