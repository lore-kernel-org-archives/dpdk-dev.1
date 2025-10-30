Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FADACCF9EB
	for <dpdk-dev@archiver.kernel.org>; Thu, 30 Oct 2025 03:36:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 914A140297;
	Thu, 30 Oct 2025 04:36:30 +0100 (CET)
Received: from out28-193.mail.aliyun.com (out28-193.mail.aliyun.com
 [115.124.28.193])
 by mails.dpdk.org (Postfix) with ESMTP id 8CF904027A
 for <dev@dpdk.org>; Thu, 30 Oct 2025 04:36:28 +0100 (CET)
Received: from ubuntu.localdomain(mailfrom:dimon.zhao@nebula-matrix.com
 fp:SMTPD_---.fAfczpa_1761795386 cluster:ay29) by smtp.aliyun-inc.com;
 Thu, 30 Oct 2025 11:36:26 +0800
From: Dimon Zhao <dimon.zhao@nebula-matrix.com>
To: dimon.zhao@nebula-matrix.com,
	dev@dpdk.org
Cc: Kyo Liu <kyo.liu@nebula-matrix.com>, Leon Yu <leon.yu@nebula-matrix.com>,
 Sam Chen <sam.chen@nebula-matrix.com>
Subject: [PATCH v1 1/1] net/nbl: fix issues reported by Coverity
Date: Wed, 29 Oct 2025 20:36:19 -0700
Message-Id: <20251030033619.3386064-2-dimon.zhao@nebula-matrix.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251030033619.3386064-1-dimon.zhao@nebula-matrix.com>
References: <20250627014022.4019625-1-dimon.zhao@nebula-matrix.com>
 <20251030033619.3386064-1-dimon.zhao@nebula-matrix.com>
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

Coverity issue: 490942
Coverity issue: 490943
Coverity issue: 490946
Coverity issue: 490947
Coverity issue: 490949
Coverity issue: 490950
Coverity issue: 490951
Coverity issue: 490952
Coverity issue: 490953
Coverity issue: 490954
Coverity issue: 490955
Coverity issue: 490957
Coverity issue: 490958
Coverity issue: 490959
Fixes: a1c5ffa13b2c ("net/nbl: add channel layer")
Fixes: dc955cd24c8f ("net/nbl: add coexistence mode")
Fixes: 93b38df5a2ec ("net/nbl: support basic configuration")

Signed-off-by: Dimon Zhao <dimon.zhao@nebula-matrix.com>
---
 drivers/net/nbl/nbl_common/nbl_userdev.c | 11 +++++++++--
 drivers/net/nbl/nbl_dev/nbl_dev.c        |  4 ++--
 drivers/net/nbl/nbl_hw/nbl_channel.c     | 13 +++++++------
 3 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/drivers/net/nbl/nbl_common/nbl_userdev.c b/drivers/net/nbl/nbl_common/nbl_userdev.c
index 75e0e2884b..c0bc995b64 100644
--- a/drivers/net/nbl/nbl_common/nbl_userdev.c
+++ b/drivers/net/nbl/nbl_common/nbl_userdev.c
@@ -715,7 +715,11 @@ int nbl_pci_map_device(struct nbl_adapter *adapter)
 	}
 
 	common->eventfd = fd;
-	ioctl(common->devfd, NBL_DEV_USER_GET_BAR_SIZE, &bar_size);
+	ret = ioctl(common->devfd, NBL_DEV_USER_GET_BAR_SIZE, &bar_size);
+	if (ret) {
+		NBL_LOG(ERR, "nbl userdev get bar size failed");
+		goto close_eventfd;
+	}
 
 	if (!ret) {
 		pci_dev->mem_resource[0].addr = nbl_userdev_mmap(common->devfd, 0, bar_size);
@@ -744,12 +748,15 @@ void nbl_pci_unmap_device(struct nbl_adapter *adapter)
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
 
diff --git a/drivers/net/nbl/nbl_dev/nbl_dev.c b/drivers/net/nbl/nbl_dev/nbl_dev.c
index 8a4a776b22..b4cc241def 100644
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
diff --git a/drivers/net/nbl/nbl_hw/nbl_channel.c b/drivers/net/nbl/nbl_hw/nbl_channel.c
index 7cc214df01..654e56f200 100644
--- a/drivers/net/nbl/nbl_hw/nbl_channel.c
+++ b/drivers/net/nbl/nbl_hw/nbl_channel.c
@@ -36,7 +36,7 @@ static int nbl_chan_init_tx_queue(union nbl_chan_info *chan_info)
 		goto req_wait_queue_failed;
 	}
 
-	size = chan_info->mailbox.num_txq_entries * chan_info->mailbox.txq_buf_size;
+	size = (u64)chan_info->mailbox.num_txq_entries * (u64)chan_info->mailbox.txq_buf_size;
 	txq->buf = nbl_alloc_dma_mem(&txq->buf_mem, size);
 	if (!txq->buf) {
 		NBL_LOG(ERR, "Allocate memory for chan tx buffer arrays failed");
@@ -66,7 +66,7 @@ static int nbl_chan_init_rx_queue(union nbl_chan_info *chan_info)
 		return -ENOMEM;
 	}
 
-	size = chan_info->mailbox.num_rxq_entries * chan_info->mailbox.rxq_buf_size;
+	size = (u64)chan_info->mailbox.num_rxq_entries * (u64)chan_info->mailbox.rxq_buf_size;
 	rxq->buf = nbl_alloc_dma_mem(&rxq->buf_mem, size);
 	if (!rxq->buf) {
 		NBL_LOG(ERR, "Allocate memory for chan rx buffer arrays failed");
@@ -163,7 +163,7 @@ static int nbl_chan_prepare_rx_bufs(struct nbl_channel_mgt *chan_mgt,
 	desc = rxq->desc;
 	for (i = 0; i < chan_info->mailbox.num_rxq_entries - 1; i++) {
 		desc[i].flags = NBL_CHAN_RX_DESC_AVAIL;
-		desc[i].buf_addr = rxq->buf_mem.pa + i * chan_info->mailbox.rxq_buf_size;
+		desc[i].buf_addr = rxq->buf_mem.pa + (u64)i * (u64)chan_info->mailbox.rxq_buf_size;
 		desc[i].buf_len = chan_info->mailbox.rxq_buf_size;
 	}
 
@@ -324,7 +324,8 @@ static void nbl_chan_advance_rx_ring(struct nbl_channel_mgt *chan_mgt,
 	rx_desc = NBL_CHAN_RX_DESC(rxq, next_to_use);
 
 	rx_desc->flags = NBL_CHAN_RX_DESC_AVAIL;
-	rx_desc->buf_addr = rxq->buf_mem.pa + chan_info->mailbox.rxq_buf_size * next_to_use;
+	rx_desc->buf_addr = rxq->buf_mem.pa +
+				(u64)chan_info->mailbox.rxq_buf_size * (u64)next_to_use;
 	rx_desc->buf_len = chan_info->mailbox.rxq_buf_size;
 
 	rte_wmb();
@@ -376,8 +377,8 @@ static uint16_t nbl_chan_update_txqueue(union nbl_chan_info *chan_info,
 
 	txq = &chan_info->mailbox.txq;
 	next_to_use = txq->next_to_use;
-	va = (u8 *)txq->buf + next_to_use * chan_info->mailbox.txq_buf_size;
-	pa = txq->buf_mem.pa + next_to_use * chan_info->mailbox.txq_buf_size;
+	va = (u8 *)txq->buf + (u64)next_to_use * (u64)chan_info->mailbox.txq_buf_size;
+	pa = txq->buf_mem.pa + (u64)next_to_use * (u64)chan_info->mailbox.txq_buf_size;
 	tx_desc = NBL_CHAN_TX_DESC(txq, next_to_use);
 
 	tx_desc->dstid = dstid;
-- 
2.34.1

