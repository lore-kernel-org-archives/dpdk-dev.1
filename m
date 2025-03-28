Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0616CC3600C
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Mar 2025 05:18:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 608AB402E3;
	Fri, 28 Mar 2025 06:16:01 +0100 (CET)
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
 by mails.dpdk.org (Postfix) with ESMTP id 9B15C40E20
 for <dev@dpdk.org>; Fri, 28 Mar 2025 06:15:57 +0100 (CET)
X-QQ-mid: bizesmtpsz12t1743138952tv979a
X-QQ-Originating-IP: G2vG9BetA2nUlOZDt/fjwzc6ltwzt8ixoKKHb1tsWW8=
Received: from steven.localdomain ( [103.233.162.252])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Fri, 28 Mar 2025 13:15:50 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13301628341681190967
EX-QQ-RecipientCnt: 5
From: Wenbo Cao <caowenbo@mucse.com>
To: thomas@monjalon.net
Cc: stephen@networkplumber.org, dev@dpdk.org, yaojun@mucse.com,
 Wenbo Cao <caowenbo@mucse.com>
Subject: [PATCH v17 28/29] net/rnp: support Rx/Tx burst mode info
Date: Fri, 28 Mar 2025 05:14:43 +0000
Message-Id: <20250328051444.1019208-29-caowenbo@mucse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250328051444.1019208-1-caowenbo@mucse.com>
References: <20250328051444.1019208-1-caowenbo@mucse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:mucse.com:qybglogicsvrgz:qybglogicsvrgz5a-0
X-QQ-XMAILINFO: N/DcPz7jUYXlnrXT+IvLT0I6tQOrFXr/67lh030I6Jh5h8LU+K/V01bU
 lcDWIM5CPDeo7+HqVXsizKAKrHUnamNrCrK++iwCAPveT3yNMA2exojN2qtgVC7NGEsM3rm
 zN7q9N5gGYAagg/Xiy0j9ayAixn50c7gqv0CBintIvpSMoT2q45WDMd/wslCvdlGmdCwJIX
 rl2X0gr653E7uJGH+6pKUZmR4AHxN6Z8H1mZ/QvyJbCNBSHHRjDTbbuZIqZ2jM/btTG56r9
 heRDsTpf/D4VdTbFasR7yTg3rA5w9LtZKbAAQMuiJ+0/lv2OQ6+LoBau5qMX9M7ZIl1TalF
 Etsp6lJr63msR8cN7ZDc1pMz/Lel+2Do6J5PX+YI7J84GW53A2ven4SzEXsHP1CppLi3Dxe
 y86Eokj7BMJdL7srdsFAkViVF9IQ+yZv/2p7jh2ZdY/qHbIvpn6BCOZHSoJRWfZtKEDmTMP
 ljg0onTTFSWmWWdhUu5v24tMFxnwO+UAVnt2CCicMePR+/wRUUFGH47BIaQ8wCih/QAo9rZ
 cbntTnCqMnisMwomLlWyVYWiPCCFLRZMIJTbSMl60LHdyl3erdbd61AVbjJmumQpncUVL75
 H2hgKAPO1j6bWfSVHObMMQbyhzNDcXFtiOo39Cclol2GvZ7h0vfX7sb9uhlX+VncGEe6NxB
 Mk3LuInJoHAFtNOF4mW/0/2fSEjLzur5S/Z09eTx2/dzC02rh4n9+u+buctyJFD36yqaErh
 xokwxEnhScHxbNbZMESvB5djfsSrSBkg2Qzwu+jinel1Lmsk6/1AWy905oe9auuap+bB1Vf
 HX4qcFfecdhF4vIqNQ2okV86viHaVLn5RMNG6RGQRMPVzFzR00relmBx/yqwmb1Ij0um9ep
 nFfAzOgp1YqN9pMGfIhIHadWk773ZanOzx2PM/g56kbbHPDyJuFtxI1XTlAbJiLlO5cO7YE
 kcNUImwcWniz1CSltMGuNsDEhdmVhaXlZdbzDVl2V05ZOquta6U8uyM3+9OiqNysVAsKHfy
 oOba2jz9ONwFmss5YV
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

add platform method for get rx/tx burst function select
by upload func name.

Signed-off-by: Wenbo Cao <caowenbo@mucse.com>
---
 doc/guides/nics/rnp.rst      |  2 ++
 drivers/net/rnp/rnp_ethdev.c |  2 ++
 drivers/net/rnp/rnp_rxtx.c   | 58 ++++++++++++++++++++++++++++++++++++
 drivers/net/rnp/rnp_rxtx.h   |  6 ++++
 4 files changed, 68 insertions(+)

diff --git a/doc/guides/nics/rnp.rst b/doc/guides/nics/rnp.rst
index 671bb28112..f0afea9cd4 100644
--- a/doc/guides/nics/rnp.rst
+++ b/doc/guides/nics/rnp.rst
@@ -107,8 +107,10 @@ Listed below are the rte_eth functions supported:
 * ``rte_eth_allmulticast_get``
 * ``rte_eth_rx_queue_setup``
 * ``rte_eth_rx_queue_info_get``
+* ``rte_eth_rx_burst_mode_get``
 * ``rte_eth_tx_queue_setup``
 * ``rte_eth_tx_queue_info_get``
+* ``rte_eth_tx_burst_mode_get``
 * ``rte_eth_link_get``
 * ``rte_eth_link_get_nowait``
 * ``rte_eth_stats_get``
diff --git a/drivers/net/rnp/rnp_ethdev.c b/drivers/net/rnp/rnp_ethdev.c
index 84352509a1..484e40f3be 100644
--- a/drivers/net/rnp/rnp_ethdev.c
+++ b/drivers/net/rnp/rnp_ethdev.c
@@ -1481,11 +1481,13 @@ static const struct eth_dev_ops rnp_eth_dev_ops = {
 	.rx_queue_stop                = rnp_rx_queue_stop,
 	.rx_queue_start               = rnp_rx_queue_start,
 	.rxq_info_get                 = rnp_rx_queue_info_get,
+	.rx_burst_mode_get            = rnp_rx_burst_mode_get,
 	.tx_queue_setup               = rnp_tx_queue_setup,
 	.tx_queue_release             = rnp_dev_tx_queue_release,
 	.tx_queue_stop                = rnp_tx_queue_stop,
 	.tx_queue_start               = rnp_tx_queue_start,
 	.txq_info_get                 = rnp_tx_queue_info_get,
+	.tx_burst_mode_get            = rnp_tx_burst_mode_get,
 	/* rss impl */
 	.reta_update                  = rnp_dev_rss_reta_update,
 	.reta_query                   = rnp_dev_rss_reta_query,
diff --git a/drivers/net/rnp/rnp_rxtx.c b/drivers/net/rnp/rnp_rxtx.c
index d58b0412ce..da08728198 100644
--- a/drivers/net/rnp/rnp_rxtx.c
+++ b/drivers/net/rnp/rnp_rxtx.c
@@ -1762,3 +1762,61 @@ rnp_tx_queue_info_get(struct rte_eth_dev *dev, uint16_t queue_id,
 	qinfo->conf.tx_thresh.hthresh = txq->pburst;
 	qinfo->conf.offloads = txq->tx_offloads;
 }
+
+static const struct {
+	eth_rx_burst_t pkt_burst;
+	const char *info;
+} rnp_rx_burst_infos[] = {
+	{ rnp_scattered_rx,		"Scalar Scattered" },
+	{ rnp_recv_pkts,		"Scalar" },
+};
+
+static const struct {
+	eth_tx_burst_t pkt_burst;
+	const char *info;
+} rnp_tx_burst_infos[] = {
+	{ rnp_xmit_simple,		"Scalar Simple" },
+	{ rnp_multiseg_xmit_pkts,	"Scalar" },
+};
+
+int
+rnp_rx_burst_mode_get(struct rte_eth_dev *dev,
+		      __rte_unused uint16_t queue_id,
+		      struct rte_eth_burst_mode *mode)
+{
+	eth_rx_burst_t pkt_burst = dev->rx_pkt_burst;
+	int ret = -EINVAL;
+	unsigned int i;
+
+	for (i = 0; i < RTE_DIM(rnp_rx_burst_infos); ++i) {
+		if (pkt_burst == rnp_rx_burst_infos[i].pkt_burst) {
+			snprintf(mode->info, sizeof(mode->info), "%s",
+					rnp_rx_burst_infos[i].info);
+			ret = 0;
+			break;
+		}
+	}
+
+	return ret;
+}
+
+int
+rnp_tx_burst_mode_get(struct rte_eth_dev *dev,
+		      __rte_unused uint16_t queue_id,
+		      struct rte_eth_burst_mode *mode)
+{
+	eth_tx_burst_t pkt_burst = dev->tx_pkt_burst;
+	int ret = -EINVAL;
+	unsigned int i;
+
+	for (i = 0; i < RTE_DIM(rnp_tx_burst_infos); ++i) {
+		if (pkt_burst == rnp_tx_burst_infos[i].pkt_burst) {
+			snprintf(mode->info, sizeof(mode->info), "%s",
+					rnp_tx_burst_infos[i].info);
+			ret = 0;
+			break;
+		}
+	}
+
+	return ret;
+}
diff --git a/drivers/net/rnp/rnp_rxtx.h b/drivers/net/rnp/rnp_rxtx.h
index dc4a8ea9dd..8639f0892d 100644
--- a/drivers/net/rnp/rnp_rxtx.h
+++ b/drivers/net/rnp/rnp_rxtx.h
@@ -152,5 +152,11 @@ void rnp_rx_queue_info_get(struct rte_eth_dev *dev, uint16_t queue_id,
 			   struct rte_eth_rxq_info *qinfo);
 void rnp_tx_queue_info_get(struct rte_eth_dev *dev, uint16_t queue_id,
 			   struct rte_eth_txq_info *qinfo);
+int rnp_rx_burst_mode_get(struct rte_eth_dev *dev,
+			  __rte_unused uint16_t queue_id,
+			  struct rte_eth_burst_mode *mode);
+int rnp_tx_burst_mode_get(struct rte_eth_dev *dev,
+			  __rte_unused uint16_t queue_id,
+			  struct rte_eth_burst_mode *mode);
 
 #endif /* _RNP_RXTX_H_ */
-- 
2.25.1

