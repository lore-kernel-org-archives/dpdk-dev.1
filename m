Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC545C3600C
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Mar 2025 05:17:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 743E740B92;
	Fri, 28 Mar 2025 06:15:34 +0100 (CET)
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
 by mails.dpdk.org (Postfix) with ESMTP id 2653A40A7D
 for <dev@dpdk.org>; Fri, 28 Mar 2025 06:15:31 +0100 (CET)
X-QQ-mid: bizesmtpsz12t1743138924t8h69y
X-QQ-Originating-IP: ddq/F2Tz0EFflrnHMzVwibSxfpi/QPNlM+EpolL4ozA=
Received: from steven.localdomain ( [103.233.162.252])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Fri, 28 Mar 2025 13:15:22 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16740512309163321620
EX-QQ-RecipientCnt: 5
From: Wenbo Cao <caowenbo@mucse.com>
To: thomas@monjalon.net
Cc: stephen@networkplumber.org, dev@dpdk.org, yaojun@mucse.com,
 Wenbo Cao <caowenbo@mucse.com>
Subject: [PATCH v17 15/29] net/rnp: add Tx burst simple support
Date: Fri, 28 Mar 2025 05:14:30 +0000
Message-Id: <20250328051444.1019208-16-caowenbo@mucse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250328051444.1019208-1-caowenbo@mucse.com>
References: <20250328051444.1019208-1-caowenbo@mucse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:mucse.com:qybglogicsvrgz:qybglogicsvrgz5a-0
X-QQ-XMAILINFO: NXhskp4g2j/ObUFFpQjeDhMHilYQ/JRSY0qiDwkhb0j3PhNXfJQfpxrj
 lMyv/PSXxvwRjDMrWhJiznTMOeRhsWV0+XJnVjCx63Sin5upj1HP1GZItUBKK++HvLgKgyI
 pbxg+fBTSZkHHkOYSW/T3bjvEzDO2097YiC5qt+EmMpbnpDwmhedzsdxyjJ84p6TsYrLNrZ
 lo9QqLSQQH5BJNLYNFa2yJhmuVPB8JmRfdwYyLozk5uH+615Wm8TECQk9ID1z09Q70P5C3z
 u7aYtBLtpFsUfZRj2+uMgsrcE7KooJBn6jF0B8kOiij2Sl0mEFcoYNrOUGygKZtsIZ0pMwl
 4RfoobrlgyA8Ba5P/23iM4+dWuPskOmPQQ3FE3dOQpTxb5kdHrCuvt6malLOOQ5bCLkpSol
 TjEO31GhZAVgXmqTotm1JfmcT5sNG/j6ca383VWfTGIubrvHwCakTiNXC7yyP7VAJmuxHIf
 zhVaRgh3GBw7LBYbsWbN9cnp4GWtFrK9Le1DweHsogjZvAI44/8LDb2Fqc0In4xKd+VTrHF
 8ANs8TyyIwNRBIFKPs4x65lwFOb9e+mq0T+OZbLqCcHYisFdrt8Icl7EmjRNr2cn1htrYDY
 OUhnbUVTJnPKWTm4jBZHWWuXXFhZNIE9aCfE/zF2j9a4SCjfXnGHpU2Cl1QHzpKsJXe+UZ3
 QgroqaeVdb8XdlCDURPOb0ltD4eHl0hzQrOrfdcVN8MLerQe5wquG7WBXIftsp6RK1RgAFL
 MeVLa+yY9SOfUIF9NifK2vy/Yio6zjF8Cm6EbBUjoZl1xXwfI1gxZhXneqiCAHN9VNbFvqp
 87MkikaU+y/VMX3bo6r9u8jaY6wCDcHMvBe1grFv60wn+QSVan8VOMLsaf1bnfSGGVk//bb
 Lemlpspn6Z3JIcRoRJ6rMqhAR6RHli+HOwkVhEuG6ImzAnPjTv3FuJDUxB0cKZa2wRGJ2Ik
 ggR1085pt6rLvljky+y9jjbcTRYa7hB7hhPtJ2EuH4dzaqxuTGe16JCNN7Ht8wPMgAEi+VU
 cx5oSQDQ==
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
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

add only support simple send pkts.

Signed-off-by: Wenbo Cao <caowenbo@mucse.com>
---
 drivers/net/rnp/rnp_ethdev.c |  6 +++
 drivers/net/rnp/rnp_rxtx.c   | 85 +++++++++++++++++++++++++++++++++++-
 drivers/net/rnp/rnp_rxtx.h   |  1 +
 3 files changed, 91 insertions(+), 1 deletion(-)

diff --git a/drivers/net/rnp/rnp_ethdev.c b/drivers/net/rnp/rnp_ethdev.c
index 31f339c021..9a20df8990 100644
--- a/drivers/net/rnp/rnp_ethdev.c
+++ b/drivers/net/rnp/rnp_ethdev.c
@@ -606,6 +606,12 @@ static int rnp_dev_infos_get(struct rte_eth_dev *eth_dev,
 	};
 
 	dev_info->default_txconf = (struct rte_eth_txconf) {
+		.tx_thresh = {
+			.pthresh = RNP_TX_DESC_FETCH_TH,
+			.hthresh = RNP_TX_DESC_FETCH_BURST,
+		},
+		.tx_free_thresh = RNP_DEFAULT_TX_FREE_THRESH,
+		.tx_rs_thresh = RNP_DEFAULT_TX_RS_THRESH,
 		.offloads = 0,
 	};
 
diff --git a/drivers/net/rnp/rnp_rxtx.c b/drivers/net/rnp/rnp_rxtx.c
index a742646c7e..260c34113a 100644
--- a/drivers/net/rnp/rnp_rxtx.c
+++ b/drivers/net/rnp/rnp_rxtx.c
@@ -752,6 +752,89 @@ rnp_recv_pkts(void *_rxq, struct rte_mbuf **rx_pkts, uint16_t nb_pkts)
 	return nb_rx;
 }
 
+static  __rte_always_inline int
+rnp_clean_tx_ring(struct rnp_tx_queue *txq)
+{
+	volatile struct rnp_tx_desc *txbd;
+	struct rnp_txsw_entry *tx_swbd;
+	struct rte_mbuf *m;
+	uint16_t next_dd;
+	uint16_t i;
+
+	txbd = &txq->tx_bdr[txq->tx_next_dd];
+	if (!(txbd->d.cmd & RNP_CMD_DD))
+		return 0;
+	*txbd = txq->zero_desc;
+	next_dd = txq->tx_next_dd - (txq->tx_free_thresh - 1);
+	tx_swbd = &txq->sw_ring[next_dd];
+
+	for (i = 0; i < txq->tx_rs_thresh; ++i, ++tx_swbd) {
+		if (tx_swbd->mbuf) {
+			m = tx_swbd->mbuf;
+			rte_pktmbuf_free_seg(m);
+			tx_swbd->mbuf = NULL;
+		}
+	}
+	txq->nb_tx_free = (txq->nb_tx_free + txq->tx_rs_thresh);
+	txq->tx_next_dd = (txq->tx_next_dd + txq->tx_rs_thresh) &
+		txq->attr.nb_desc_mask;
+
+	return 0;
+}
+
+static __rte_always_inline uint16_t
+rnp_xmit_simple(void *_txq, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
+{
+	struct rnp_tx_queue *txq = (struct rnp_tx_queue *)_txq;
+	volatile struct rnp_tx_desc *txbd;
+	struct rnp_txsw_entry *tx_swbd;
+	uint64_t phy;
+	uint16_t start;
+	uint16_t i;
+
+	if (unlikely(!txq->txq_started || !txq->tx_link))
+		return 0;
+
+	if (txq->nb_tx_free < txq->tx_free_thresh)
+		rnp_clean_tx_ring(txq);
+
+	nb_pkts = RTE_MIN(txq->nb_tx_free, nb_pkts);
+	if (!nb_pkts)
+		return 0;
+	start = nb_pkts;
+	i = txq->tx_tail;
+
+	while (nb_pkts--) {
+		txbd = &txq->tx_bdr[i];
+		tx_swbd = &txq->sw_ring[i];
+		tx_swbd->mbuf = *tx_pkts++;
+		phy = rnp_get_dma_addr(&txq->attr, tx_swbd->mbuf);
+		txbd->d.addr = phy;
+		if (unlikely(tx_swbd->mbuf->data_len > RNP_MAC_MAXFRM_SIZE))
+			tx_swbd->mbuf->data_len = 0;
+		txbd->d.blen = tx_swbd->mbuf->data_len;
+		txbd->d.cmd = RNP_CMD_EOP;
+
+		i = (i + 1) & txq->attr.nb_desc_mask;
+	}
+	txq->nb_tx_free -= start;
+	if (txq->tx_tail + start > txq->tx_next_rs) {
+		txbd = &txq->tx_bdr[txq->tx_next_rs];
+		txbd->d.cmd |= RNP_CMD_RS;
+		txq->tx_next_rs = (txq->tx_next_rs + txq->tx_rs_thresh);
+
+		if (txq->tx_next_rs > txq->attr.nb_desc)
+			txq->tx_next_rs = txq->tx_rs_thresh - 1;
+	}
+
+	txq->tx_tail = i;
+
+	rte_wmb();
+	RNP_REG_WR(txq->tx_tailreg, 0, i);
+
+	return start;
+}
+
 int rnp_rx_func_select(struct rte_eth_dev *dev)
 {
 	dev->rx_pkt_burst = rnp_recv_pkts;
@@ -761,7 +844,7 @@ int rnp_rx_func_select(struct rte_eth_dev *dev)
 
 int rnp_tx_func_select(struct rte_eth_dev *dev)
 {
-	dev->tx_pkt_burst = rte_eth_pkt_burst_dummy;
+	dev->tx_pkt_burst = rnp_xmit_simple;
 	dev->tx_pkt_prepare = rte_eth_pkt_burst_dummy;
 
 	return 0;
diff --git a/drivers/net/rnp/rnp_rxtx.h b/drivers/net/rnp/rnp_rxtx.h
index 39e5184502..a8fd8d052f 100644
--- a/drivers/net/rnp/rnp_rxtx.h
+++ b/drivers/net/rnp/rnp_rxtx.h
@@ -89,6 +89,7 @@ struct rnp_tx_queue {
 	const struct rte_memzone *rz;
 	uint64_t ring_phys_addr; /* tx dma ring physical addr */
 	volatile struct rnp_tx_desc *tx_bdr; /* tx dma ring virtual addr */
+	volatile struct rnp_tx_desc zero_desc;
 	struct rnp_txsw_entry *sw_ring; /* tx software ring addr */
 	volatile void *tx_tailreg; /* hw desc tail register */
 	volatile void *tx_headreg; /* hw desc head register*/
-- 
2.25.1

