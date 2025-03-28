Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1358CC3600C
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Mar 2025 05:18:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C941040E24;
	Fri, 28 Mar 2025 06:15:59 +0100 (CET)
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
 by mails.dpdk.org (Postfix) with ESMTP id 589D8402A7
 for <dev@dpdk.org>; Fri, 28 Mar 2025 06:15:56 +0100 (CET)
X-QQ-mid: bizesmtpsz12t1743138950t7c07q
X-QQ-Originating-IP: yeR/moiymBDM+2BF2kdDn6rbnRCXHXFscdrh+UbOahM=
Received: from steven.localdomain ( [103.233.162.252])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Fri, 28 Mar 2025 13:15:48 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 17762436488043338033
EX-QQ-RecipientCnt: 5
From: Wenbo Cao <caowenbo@mucse.com>
To: thomas@monjalon.net
Cc: stephen@networkplumber.org, dev@dpdk.org, yaojun@mucse.com,
 Wenbo Cao <caowenbo@mucse.com>
Subject: [PATCH v17 27/29] net/rnp: add queue info operation
Date: Fri, 28 Mar 2025 05:14:42 +0000
Message-Id: <20250328051444.1019208-28-caowenbo@mucse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250328051444.1019208-1-caowenbo@mucse.com>
References: <20250328051444.1019208-1-caowenbo@mucse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:mucse.com:qybglogicsvrgz:qybglogicsvrgz5a-0
X-QQ-XMAILINFO: McBWBoQOJCkjZCMCeLhLrnqeQdYCrphVblyZtwIQyY7+lyV4xwGQc21d
 eUedYyXgdT6FfjoesbphhuAFkAZFxc/vxmqbh4Ya2p+1cBAw0+XPtb/BhWy0G9v1P7o968k
 7zUiUlqBqE8Mn2tt20ljtC2EgDinz6c9nFXZjutb/VY8IR2x22FedfyUHusYet397TQE4bs
 V2f2tGk/U3tCFZGpk52vQF7M6KQ57ILPvy/CEJ9FOT+357EenvlxHfgz/kBbaIHdBa1Bj9j
 3JMnXjYEf9WZBsukrEA1QLRctvCs7s2IuHNaPHrjJgsg5Yvp1R/x5md0Dex3/mmX37kuyj3
 hVCczQAXq6SgKefXtRd1fDxKykb94B3ipdRWQRFY6J0FtRunJBxAESUrZ4R28CaGIOwZhZd
 Bjm2wk+z8T+k5U8U8Ogvc2QQk/j/NQwK7cxb3AJnjAQUhF0+EGk/Vn+eEg4NiN02I4MW/lU
 baQCVvKUsddqJV/xEmFXrLfEYs6rSahW93U4n/7J4tH+8ZcUzNPiXLx+1JK4bc+NikGHujv
 +VMyHRqqVDqxjcwvPDo7/GF1l0o08gQUPbRPmmZK3b/mv2+HpNanQ2YbnqDkZfdG/GRy2Am
 KrzWNRWGLk5kMSnwHZrCPpXSt8WreivpnR8PqfSrEHn3nbXyU9iWJs9gK7AP13ne1m/Ie1x
 zZqURM+LfaR85NZDyhWmcuHWf8zeBFyyxn9oFUO9PaDdfXH4JRcBn0QWgCc3fnC7hzcJeAL
 xKbyjvTiYegn8KvFqDhLyZSemmSi3EwbaYj0kF/zLPp/FHdswehWh6wWuHw8Z7eevr+qkGr
 YNR7UVJYhAZo+PPboz/p8/cUjsmlePOt0n6iaP5Ak5hG21zQOGeMTC4Bv/iJTAcu5oTOJSC
 VMrzppn1aY/9jU/V/Y8RNsNrPhv5E7uNZmuibOjcyATyOR2L5CqV/Ooh9+TrSAiayHZ3O8n
 +7G2eMGz6fwkSW1rUSemYH5FbC98TGR7eLNx3reeIZ6bH+MGwMyT48UhjurO8A9bq4Cf/LE
 kHNatye8pGdG81WhdYeiuRcMHVemNNuSfAaprZnXCcTTZFBBfW+s01hKEuhIUr5gCpOjZge
 T8HSFagYJfCoYQ4xw29+aY=
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
X-QQ-RECHKSPAM: 0
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

add support get queue configure info for user debug

Signed-off-by: Wenbo Cao <caowenbo@mucse.com>
---
 doc/guides/nics/rnp.rst      |  2 ++
 drivers/net/rnp/rnp_ethdev.c |  2 ++
 drivers/net/rnp/rnp_rxtx.c   | 42 ++++++++++++++++++++++++++++++++++++
 drivers/net/rnp/rnp_rxtx.h   |  4 ++++
 4 files changed, 50 insertions(+)

diff --git a/doc/guides/nics/rnp.rst b/doc/guides/nics/rnp.rst
index 2713d03765..671bb28112 100644
--- a/doc/guides/nics/rnp.rst
+++ b/doc/guides/nics/rnp.rst
@@ -106,7 +106,9 @@ Listed below are the rte_eth functions supported:
 * ``rte_eth_promiscuous_get``
 * ``rte_eth_allmulticast_get``
 * ``rte_eth_rx_queue_setup``
+* ``rte_eth_rx_queue_info_get``
 * ``rte_eth_tx_queue_setup``
+* ``rte_eth_tx_queue_info_get``
 * ``rte_eth_link_get``
 * ``rte_eth_link_get_nowait``
 * ``rte_eth_stats_get``
diff --git a/drivers/net/rnp/rnp_ethdev.c b/drivers/net/rnp/rnp_ethdev.c
index 9ce0779592..84352509a1 100644
--- a/drivers/net/rnp/rnp_ethdev.c
+++ b/drivers/net/rnp/rnp_ethdev.c
@@ -1480,10 +1480,12 @@ static const struct eth_dev_ops rnp_eth_dev_ops = {
 	.rx_queue_release             = rnp_dev_rx_queue_release,
 	.rx_queue_stop                = rnp_rx_queue_stop,
 	.rx_queue_start               = rnp_rx_queue_start,
+	.rxq_info_get                 = rnp_rx_queue_info_get,
 	.tx_queue_setup               = rnp_tx_queue_setup,
 	.tx_queue_release             = rnp_dev_tx_queue_release,
 	.tx_queue_stop                = rnp_tx_queue_stop,
 	.tx_queue_start               = rnp_tx_queue_start,
+	.txq_info_get                 = rnp_tx_queue_info_get,
 	/* rss impl */
 	.reta_update                  = rnp_dev_rss_reta_update,
 	.reta_query                   = rnp_dev_rss_reta_query,
diff --git a/drivers/net/rnp/rnp_rxtx.c b/drivers/net/rnp/rnp_rxtx.c
index 6504d62f62..d58b0412ce 100644
--- a/drivers/net/rnp/rnp_rxtx.c
+++ b/drivers/net/rnp/rnp_rxtx.c
@@ -1720,3 +1720,45 @@ int rnp_tx_func_select(struct rte_eth_dev *dev)
 
 	return 0;
 }
+
+void
+rnp_rx_queue_info_get(struct rte_eth_dev *dev, uint16_t queue_id,
+		      struct rte_eth_rxq_info *qinfo)
+{
+	struct rnp_rx_queue *rxq;
+
+	rxq = dev->data->rx_queues[queue_id];
+	if (!rxq)
+		return;
+	qinfo->mp = rxq->mb_pool;
+	qinfo->scattered_rx = dev->data->scattered_rx;
+	qinfo->queue_state = rxq->rxq_started;
+	qinfo->nb_desc = rxq->attr.nb_desc;
+	qinfo->rx_buf_size = rxq->rx_buf_len;
+
+	qinfo->conf.rx_deferred_start = rxq->rx_deferred_start;
+	qinfo->conf.rx_free_thresh = rxq->rx_free_thresh;
+	qinfo->conf.rx_thresh.pthresh = rxq->pthresh;
+	qinfo->conf.rx_thresh.hthresh = rxq->pburst;
+	qinfo->conf.offloads = rxq->rx_offloads;
+}
+
+void
+rnp_tx_queue_info_get(struct rte_eth_dev *dev, uint16_t queue_id,
+		      struct rte_eth_txq_info *qinfo)
+{
+	struct rnp_tx_queue *txq;
+
+	txq = dev->data->tx_queues[queue_id];
+	if (!txq)
+		return;
+	qinfo->queue_state = txq->txq_started;
+	qinfo->nb_desc = txq->attr.nb_desc;
+
+	qinfo->conf.tx_deferred_start = txq->tx_deferred_start;
+	qinfo->conf.tx_free_thresh = txq->tx_free_thresh;
+	qinfo->conf.tx_rs_thresh = txq->tx_rs_thresh;
+	qinfo->conf.tx_thresh.pthresh = txq->pthresh;
+	qinfo->conf.tx_thresh.hthresh = txq->pburst;
+	qinfo->conf.offloads = txq->tx_offloads;
+}
diff --git a/drivers/net/rnp/rnp_rxtx.h b/drivers/net/rnp/rnp_rxtx.h
index 51e5d4b600..dc4a8ea9dd 100644
--- a/drivers/net/rnp/rnp_rxtx.h
+++ b/drivers/net/rnp/rnp_rxtx.h
@@ -148,5 +148,9 @@ int rnp_rx_queue_stop(struct rte_eth_dev *eth_dev, uint16_t qidx);
 int rnp_rx_queue_start(struct rte_eth_dev *eth_dev, uint16_t qidx);
 int rnp_rx_func_select(struct rte_eth_dev *dev);
 int rnp_tx_func_select(struct rte_eth_dev *dev);
+void rnp_rx_queue_info_get(struct rte_eth_dev *dev, uint16_t queue_id,
+			   struct rte_eth_rxq_info *qinfo);
+void rnp_tx_queue_info_get(struct rte_eth_dev *dev, uint16_t queue_id,
+			   struct rte_eth_txq_info *qinfo);
 
 #endif /* _RNP_RXTX_H_ */
-- 
2.25.1

