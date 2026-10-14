Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16285CC6B1D
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Oct 2026 15:11:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D25A4406BA;
	Wed, 14 Oct 2026 17:10:06 +0200 (CEST)
Received: from mail-m16.vip.163.com (mail-m16.vip.163.com [220.197.30.223])
 by mails.dpdk.org (Postfix) with ESMTP id 227AE40A67
 for <dev@dpdk.org>; Wed, 14 Oct 2026 17:09:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vip.163.com; s=s110527; h=From:To:Subject:Date:Message-ID:
 MIME-Version; bh=3FIyrU5fi5Y0Q4uZ269DgDwNZnXXknq2rIHeIgYgVwM=;
 b=lekuswlLa5GDIhcSUvCizwC/jt4quwGHXgWwMySHKM5QRCLMb4goxiRHG1p9rD
 JDHg6brUiKea0bZhH5JIwgsRISQrjFY0vEGEWpH3SU+yeoNQjfhIouaI4W6bMPfs
 vQ14ZaB6brsiOvRp7UdfvddZEqKKQ6eER7D6DnKxHSgUk=
From: Jiacheng Ye <yejiacheng4@h-partners.com>
To: dev@dpdk.org
Cc: Feifei Wang <wangfeifei40@huawei.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v2 21/26] net/hinic3: ensure queue depth and state consistency
Date: Wed, 14 Oct 2026 23:09:17 +0800
Message-ID: <20261014150923.838-22-yejiacheng4@h-partners.com>
X-Mailer: git-send-email 2.53.0.windows.2
In-Reply-To: <20261014150923.838-1-yejiacheng4@h-partners.com>
References: <20261010144509.2731-1-yejiacheng4@h-partners.com>
 <20261014150923.838-1-yejiacheng4@h-partners.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: As8vCgAXMEEym89qB_SFAw--.62919S23
X-Coremail-Antispam: 1Uf129KBjvJXoWxJF4xKFW7KFWDAryfAF1DWrg_yoW5Xw1UpF
 WDGa9xta4IqrsrJwnIka13Za43XanxtryUWFyxt34Y9r15ZF40y345tFWFqrnrt395AF42
 vr4jyw4vg342q37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07URMKZUUUUU=
Sender: wff_light@vip.163.com
X-CM-SenderInfo: pziiszhljk3qxylshiywtou0bp/1tbiNByEjmrPmzwcogAA3e
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

The hardware tracks a single queue depth across all Tx queues, so each
queue must be validated against the first one and forced to match on
mismatch instead of silently diverging. Also reset the rx/tx queue states
in dev_stop and clear the cached depths so the queue state reflects the
stopped device before the next start.

Signed-off-by: Jiacheng Ye <yejiacheng4@h-partners.com>
---
 drivers/net/hinic3/hinic3_ethdev.c | 16 ++++++++++++++--
 drivers/net/hinic3/hinic3_ethdev.h |  4 ++++
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/net/hinic3/hinic3_ethdev.c b/drivers/net/hinic3/hinic3_ethdev.c
index b64746664d..b2f1d618c0 100644
--- a/drivers/net/hinic3/hinic3_ethdev.c
+++ b/drivers/net/hinic3/hinic3_ethdev.c
@@ -316,8 +316,6 @@ hinic3_xstats_calc_num(struct hinic3_nic_dev *nic_dev)
 	}
 }
 
-#define HINIC3_MAX_QUEUE_DEPTH 16384
-#define HINIC3_MIN_QUEUE_DEPTH 128
 #define HINIC3_TXD_ALIGN       1
 #define HINIC3_RXD_ALIGN       1
 
@@ -1322,6 +1320,14 @@ hinic3_tx_queue_setup(struct rte_eth_dev *dev, uint16_t qid, uint16_t nb_desc,
 
 	nic_dev = HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev);
 	hwdev = nic_dev->hwdev;
+	/* Queue depth must be equal to first queue */
+	if (nic_dev->txq_depth == 0) {
+		nic_dev->txq_depth = nb_desc;
+	} else if (nb_desc != nic_dev->txq_depth) {
+		PMD_DRV_LOG(WARNING, "txq%u depth:%u is not equal to first queue depth:%u.",
+			qid, nb_desc, nic_dev->txq_depth);
+		nb_desc = nic_dev->txq_depth;
+	}
 
 	/* Queue depth must be power of 2, otherwise will be aligned up. */
 	sq_depth = (nb_desc & (nb_desc - 1))
@@ -2231,7 +2237,13 @@ hinic3_dev_stop(struct rte_eth_dev *dev)
 	/* Free mempool. */
 	hinic3_copy_mempool_uninit(nic_dev);
 
+	for (uint16_t i = 0; i < dev->data->nb_rx_queues; i++)
+		dev->data->rx_queue_state[i] = RTE_ETH_QUEUE_STATE_STOPPED;
+	for (uint16_t i = 0; i < dev->data->nb_tx_queues; i++)
+		dev->data->tx_queue_state[i] = RTE_ETH_QUEUE_STATE_STOPPED;
+
 	nic_dev->rxq_depth = 0;
+	nic_dev->txq_depth = 0;
 	return 0;
 }
 
diff --git a/drivers/net/hinic3/hinic3_ethdev.h b/drivers/net/hinic3/hinic3_ethdev.h
index 92c7d44741..72337230c8 100644
--- a/drivers/net/hinic3/hinic3_ethdev.h
+++ b/drivers/net/hinic3/hinic3_ethdev.h
@@ -15,6 +15,9 @@
 
 #define HINIC3_PMD_DRV_VERSION "B106"
 
+#define HINIC3_MAX_QUEUE_DEPTH         16384
+#define HINIC3_MIN_QUEUE_DEPTH         128
+
 #define PCI_DEV_TO_INTR_HANDLE(pci_dev) ((pci_dev)->intr_handle)
 
 #define HINIC3_PKT_RX_L4_CKSUM_BAD	RTE_MBUF_F_RX_L4_CKSUM_BAD
@@ -149,6 +152,7 @@ struct hinic3_nic_dev {
 	uint16_t max_rqs;
 
 	uint16_t rxq_depth;
+	uint16_t txq_depth;
 	uint16_t rx_buff_len;
 	uint16_t mtu_size;
 
-- 
2.33.0

