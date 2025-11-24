Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 092DBCFA466
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Nov 2025 03:40:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 78B6C402ED;
	Mon, 24 Nov 2025 04:40:53 +0100 (CET)
Received: from out28-51.mail.aliyun.com (out28-51.mail.aliyun.com
 [115.124.28.51]) by mails.dpdk.org (Postfix) with ESMTP id E32B5402D0
 for <dev@dpdk.org>; Mon, 24 Nov 2025 04:40:47 +0100 (CET)
Received: from ubuntu.localdomain(mailfrom:dimon.zhao@nebula-matrix.com
 fp:SMTPD_---.fUE8AtM_1763955643 cluster:ay29) by smtp.aliyun-inc.com;
 Mon, 24 Nov 2025 11:40:44 +0800
From: Dimon Zhao <dimon.zhao@nebula-matrix.com>
To: dimon.zhao@nebula-matrix.com,
	dev@dpdk.org
Cc: Kyo Liu <kyo.liu@nebula-matrix.com>, Leon Yu <leon.yu@nebula-matrix.com>,
 Sam Chen <sam.chen@nebula-matrix.com>
Subject: [PATCH v1 1/1] net/nbl: add VLAN offload set interface
Date: Sun, 23 Nov 2025 19:40:26 -0800
Message-Id: <20251124034026.3680873-2-dimon.zhao@nebula-matrix.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251124034026.3680873-1-dimon.zhao@nebula-matrix.com>
References: <20251111113144.3567291-1-dimon.zhao@nebula-matrix.com>
 <20251124034026.3680873-1-dimon.zhao@nebula-matrix.com>
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

The rte_eth_dev_set_vlan_offload function internally calls
the vlan_offload_set interface, so we must implement this function.
Otherwise, an error will occur when
executing the vlan set strip on command.

Fixes: 9d7757dce874 ("net/nbl: simulate VLAN offload")

Signed-off-by: Dimon Zhao <dimon.zhao@nebula-matrix.com>
---
 drivers/net/nbl/nbl_dev/nbl_dev.c | 5 +++++
 drivers/net/nbl/nbl_dev/nbl_dev.h | 1 +
 drivers/net/nbl/nbl_ethdev.c      | 1 +
 3 files changed, 7 insertions(+)

diff --git a/drivers/net/nbl/nbl_dev/nbl_dev.c b/drivers/net/nbl/nbl_dev/nbl_dev.c
index 58eb1c6231..923de2e9d0 100644
--- a/drivers/net/nbl/nbl_dev/nbl_dev.c
+++ b/drivers/net/nbl/nbl_dev/nbl_dev.c
@@ -758,6 +758,11 @@ int nbl_promiscuous_disable(struct rte_eth_dev *eth_dev)
 	return 0;
 }
 
+int nbl_vlan_offload_set(__rte_unused struct rte_eth_dev *dev, __rte_unused int mask)
+{
+	return 0;
+}
+
 static int nbl_dev_setup_chan_queue(struct nbl_adapter *adapter)
 {
 	struct nbl_dev_mgt *dev_mgt = NBL_ADAPTER_TO_DEV_MGT(adapter);
diff --git a/drivers/net/nbl/nbl_dev/nbl_dev.h b/drivers/net/nbl/nbl_dev/nbl_dev.h
index c8a5a4670b..21d87a372d 100644
--- a/drivers/net/nbl/nbl_dev/nbl_dev.h
+++ b/drivers/net/nbl/nbl_dev/nbl_dev.h
@@ -95,5 +95,6 @@ int nbl_xstats_reset(struct rte_eth_dev *eth_dev);
 int nbl_mtu_set(struct rte_eth_dev *eth_dev, uint16_t mtu);
 int nbl_promiscuous_enable(struct rte_eth_dev *eth_dev);
 int nbl_promiscuous_disable(struct rte_eth_dev *eth_dev);
+int nbl_vlan_offload_set(__rte_unused struct rte_eth_dev *dev, __rte_unused int mask);
 
 #endif
diff --git a/drivers/net/nbl/nbl_ethdev.c b/drivers/net/nbl/nbl_ethdev.c
index a3b963e9cc..d269ea8058 100644
--- a/drivers/net/nbl/nbl_ethdev.c
+++ b/drivers/net/nbl/nbl_ethdev.c
@@ -45,6 +45,7 @@ const struct eth_dev_ops nbl_eth_dev_ops = {
 	.mtu_set = nbl_mtu_set,
 	.promiscuous_enable = nbl_promiscuous_enable,
 	.promiscuous_disable = nbl_promiscuous_disable,
+	.vlan_offload_set = nbl_vlan_offload_set,
 };
 
 static int nbl_eth_dev_init(struct rte_eth_dev *eth_dev)
-- 
2.34.1

