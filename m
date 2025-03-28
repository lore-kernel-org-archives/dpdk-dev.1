Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13A02C3600C
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Mar 2025 05:18:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7640640E03;
	Fri, 28 Mar 2025 06:15:49 +0100 (CET)
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
 by mails.dpdk.org (Postfix) with ESMTP id 284C040E03
 for <dev@dpdk.org>; Fri, 28 Mar 2025 06:15:46 +0100 (CET)
X-QQ-mid: bizesmtpsz12t1743138941tjp4j1
X-QQ-Originating-IP: pJ9PmYP+GZ4PqXwGd6DtNCO+xhVB6VV3pjct/lKnfKY=
Received: from steven.localdomain ( [103.233.162.252])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Fri, 28 Mar 2025 13:15:40 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 7697864366925224596
EX-QQ-RecipientCnt: 5
From: Wenbo Cao <caowenbo@mucse.com>
To: thomas@monjalon.net
Cc: stephen@networkplumber.org, dev@dpdk.org, yaojun@mucse.com,
 Wenbo Cao <caowenbo@mucse.com>
Subject: [PATCH v17 23/29] net/rnp: add support Rx checksum offload
Date: Fri, 28 Mar 2025 05:14:38 +0000
Message-Id: <20250328051444.1019208-24-caowenbo@mucse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250328051444.1019208-1-caowenbo@mucse.com>
References: <20250328051444.1019208-1-caowenbo@mucse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:mucse.com:qybglogicsvrgz:qybglogicsvrgz5a-0
X-QQ-XMAILINFO: MGf0zeB6Hs/wPPm0xttEWhutWOyLW3Ns3y4UlnzcBAa1cPXSarbU6GWP
 qrsf3EEKfPHW7ErJf1m2GPAbX/aKmfyCvBMGwibfW67C+jRJPv4B2Vb0rj8ldOHgqrn2h39
 tpKVa1XZ4+FDGRuWWi1/xHaY7lhYyspHR0BKlYSXNuBrGKTAeJ4DNXvEEAsyA932tk3RYX5
 PUyRxfL4V3dz8xONCyiBZn0ihiyqaUG7k2RcKJJtKETNlFoWR8rm+fk+kkvOMSoFAcN6SE7
 LaMoegnaZ2AWOtuMRJivb1Xt4hhw+KvE7zNI8iSFhnDVJqr5Vr2/eEqhaMZ3pSs8dKs/Ux3
 Zgx9rWS0kUPIlFQUccTnm0kzEDIAOSi95FrJXYHqOU6CcHqc698u9ivJomjmGo+WR/qYamm
 HtG/gas7nGuVVAFaiH/wo6+IDTyrSuE4ENc04Fz9ORdmDHIZGgK3RhdLDycAjXgUWQH/sXu
 kuwApl9vRcFCG6vrHRSc8YOjsROwitDcovDfoKv2viGAB2Twk5wBLaXsaSuYHo9IN7+eqsn
 RrEDMOzqiUUyE52mJUbBnjbhr9lu/+XIQMf1gbgBXUe8ws846DNV4qfgu7jc59KkE4ypFaE
 Y9a80VJ9pVd2TZXG9I+CIrc9UWtXAywml6K8Ovl1tb4wmwihTVUWmNiXGmXUfaIWZN4qOHH
 +7V5c5UpmLoBy716YzeTrgy6eD7hc9BDMAqoXsD9ZdYSBCli+EDAO62GpHRxThbV1qO0mXP
 jgSIDIQ3P6noZWUBEl5EmfI9iTsjVDboFC1bNvnTcAAIISCp8phdvafhDYJUsiipDhCeVkg
 Bo0C3Xow/Y37DKnye6CCH1Pdo7b9r3/yx63Vp5JLiM3bm+XpQlnBIkHRNjCzi3COm2N+2yX
 +dIS8VYRO8RH1uVMGCdR3pbI0nClItEY6uajnaRVQuHTEb/aOxum4lj1aHvoZJzRXXYUDyY
 gNmOuz8OCOEldTean2I9S9fGxZX9GnFSjN1HAuMpvr6X0p3r12EoMxbowZCvgqz8dtAQmn6
 jAKd+DxSMH9lr5tB2crls93pwtyksu3iN3Bev4sA0/YhyLvDUgHa2tEHORwXo=
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
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

Add support Rx l3/l4 checum and tunnel
inner l3/l4, out l3 chksum.

Signed-off-by: Wenbo Cao <caowenbo@mucse.com>
---
 doc/guides/nics/features/rnp.ini    |  4 ++
 doc/guides/nics/rnp.rst             |  1 +
 drivers/net/rnp/base/rnp_eth_regs.h | 13 ++++
 drivers/net/rnp/rnp.h               |  7 +++
 drivers/net/rnp/rnp_ethdev.c        | 65 ++++++++++++++++++-
 drivers/net/rnp/rnp_rxtx.c          | 97 ++++++++++++++++++++++++++++-
 6 files changed, 185 insertions(+), 2 deletions(-)

diff --git a/doc/guides/nics/features/rnp.ini b/doc/guides/nics/features/rnp.ini
index eb1c27a3d3..ceac0beff8 100644
--- a/doc/guides/nics/features/rnp.ini
+++ b/doc/guides/nics/features/rnp.ini
@@ -8,6 +8,10 @@ Speed capabilities   = Y
 Link status          = Y
 Link status event    = Y
 Packet type parsing  = Y
+L3 checksum offload  = P
+L4 checksum offload  = P
+Inner L3 checksum    = P
+Inner L4 checksum    = P
 Basic stats          = Y
 Stats per queue      = Y
 Extended stats       = Y
diff --git a/doc/guides/nics/rnp.rst b/doc/guides/nics/rnp.rst
index fefe243656..f59c6ecb48 100644
--- a/doc/guides/nics/rnp.rst
+++ b/doc/guides/nics/rnp.rst
@@ -49,6 +49,7 @@ Features
 - Scatter-Gather IO support
 - Port hardware statistic
 - Packet type parsing
+- Checksum offload
 
 Prerequisites and Pre-conditions
 --------------------------------
diff --git a/drivers/net/rnp/base/rnp_eth_regs.h b/drivers/net/rnp/base/rnp_eth_regs.h
index 49860135bd..e096ec90e6 100644
--- a/drivers/net/rnp/base/rnp_eth_regs.h
+++ b/drivers/net/rnp/base/rnp_eth_regs.h
@@ -16,6 +16,19 @@
 #define RNP_RX_ETH_F_CTRL(n)	_ETH_(0x8070 + ((n) * 0x8))
 #define RNP_RX_ETH_F_OFF	(0x7ff)
 #define RNP_RX_ETH_F_ON		(0x270)
+/* rx checksum ctrl */
+#define RNP_HW_SCTP_CKSUM_CTRL		_ETH_(0x8038)
+#define RNP_HW_CHECK_ERR_CTRL		_ETH_(0x8060)
+#define RNP_HW_ERR_HDR_LEN		RTE_BIT32(0)
+#define RNP_HW_ERR_PKTLEN		RTE_BIT32(1)
+#define RNP_HW_L3_CKSUM_ERR		RTE_BIT32(2)
+#define RNP_HW_L4_CKSUM_ERR		RTE_BIT32(3)
+#define RNP_HW_SCTP_CKSUM_ERR		RTE_BIT32(4)
+#define RNP_HW_INNER_L3_CKSUM_ERR	RTE_BIT32(5)
+#define RNP_HW_INNER_L4_CKSUM_ERR	RTE_BIT32(6)
+#define RNP_HW_CKSUM_ERR_MASK		RTE_GENMASK32(6, 2)
+#define RNP_HW_CHECK_ERR_MASK		RTE_GENMASK32(6, 0)
+#define RNP_HW_ERR_RX_ALL_MASK		RTE_GENMASK32(1, 0)
 /* max/min pkts length receive limit ctrl */
 #define RNP_MIN_FRAME_CTRL	_ETH_(0x80f0)
 #define RNP_MAX_FRAME_CTRL	_ETH_(0x80f4)
diff --git a/drivers/net/rnp/rnp.h b/drivers/net/rnp/rnp.h
index e4c677a179..694ce1409a 100644
--- a/drivers/net/rnp/rnp.h
+++ b/drivers/net/rnp/rnp.h
@@ -45,6 +45,13 @@
 		RTE_ETH_RSS_NONFRAG_IPV6_UDP | \
 		RTE_ETH_RSS_IPV6_UDP_EX | \
 		RTE_ETH_RSS_NONFRAG_IPV6_SCTP)
+/* rx checksum offload */
+#define RNP_RX_CHECKSUM_SUPPORT ( \
+		RTE_ETH_RX_OFFLOAD_IPV4_CKSUM | \
+		RTE_ETH_RX_OFFLOAD_UDP_CKSUM | \
+		RTE_ETH_RX_OFFLOAD_TCP_CKSUM | \
+		RTE_ETH_RX_OFFLOAD_SCTP_CKSUM | \
+		RTE_ETH_RX_OFFLOAD_OUTER_IPV4_CKSUM)
 /* Ring info special */
 #define RNP_MAX_BD_COUNT	(4096)
 #define RNP_MIN_BD_COUNT	(128)
diff --git a/drivers/net/rnp/rnp_ethdev.c b/drivers/net/rnp/rnp_ethdev.c
index fe0dd7bede..646a723efe 100644
--- a/drivers/net/rnp/rnp_ethdev.c
+++ b/drivers/net/rnp/rnp_ethdev.c
@@ -411,6 +411,67 @@ static int rnp_disable_all_tx_queue(struct rte_eth_dev *dev)
 	return ret;
 }
 
+static void rnp_set_rx_cksum_offload(struct rte_eth_dev *dev)
+{
+	struct rnp_eth_port *port = RNP_DEV_TO_PORT(dev);
+	struct rnp_hw *hw = port->hw;
+	uint32_t cksum_ctrl;
+	uint64_t offloads;
+
+	offloads = dev->data->dev_conf.rxmode.offloads;
+	cksum_ctrl = RNP_HW_CHECK_ERR_MASK;
+	/* enable rx checksum feature */
+	if (!rnp_pf_is_multiple_ports(hw->device_id)) {
+		if (offloads & RTE_ETH_RX_OFFLOAD_OUTER_IPV4_CKSUM) {
+			/* Tunnel Option Cksum L4_Option */
+			cksum_ctrl &= ~RNP_HW_L4_CKSUM_ERR;
+			if (offloads & (RTE_ETH_RX_OFFLOAD_UDP_CKSUM |
+						RTE_ETH_RX_OFFLOAD_TCP_CKSUM))
+				cksum_ctrl &= ~RNP_HW_INNER_L4_CKSUM_ERR;
+			else
+				cksum_ctrl |= RNP_HW_INNER_L4_CKSUM_ERR;
+		} else {
+			/* no tunnel option cksum l4_option */
+			cksum_ctrl |= RNP_HW_INNER_L4_CKSUM_ERR;
+			if (offloads & (RTE_ETH_RX_OFFLOAD_UDP_CKSUM |
+						RTE_ETH_RX_OFFLOAD_TCP_CKSUM))
+				cksum_ctrl &= ~RNP_HW_L4_CKSUM_ERR;
+			else
+				cksum_ctrl |= RNP_HW_L4_CKSUM_ERR;
+		}
+		if (offloads & RTE_ETH_RX_OFFLOAD_OUTER_IPV4_CKSUM) {
+			/* tunnel option cksum l3_option */
+			cksum_ctrl &= ~RNP_HW_L3_CKSUM_ERR;
+			if (offloads & RTE_ETH_RX_OFFLOAD_IPV4_CKSUM)
+				cksum_ctrl &= ~RNP_HW_INNER_L3_CKSUM_ERR;
+			else
+				cksum_ctrl |= RNP_HW_INNER_L3_CKSUM_ERR;
+		} else {
+			/* no tunnel option cksum l3_option */
+			cksum_ctrl |= RNP_HW_INNER_L3_CKSUM_ERR;
+			if (offloads & RTE_ETH_RX_OFFLOAD_IPV4_CKSUM)
+				cksum_ctrl &= ~RNP_HW_L3_CKSUM_ERR;
+			else
+				cksum_ctrl |= RNP_HW_L3_CKSUM_ERR;
+		}
+		/* sctp option */
+		if (offloads & RTE_ETH_RX_OFFLOAD_SCTP_CKSUM) {
+			cksum_ctrl &= ~RNP_HW_SCTP_CKSUM_ERR;
+			RNP_E_REG_WR(hw, RNP_HW_SCTP_CKSUM_CTRL, true);
+		} else {
+			RNP_E_REG_WR(hw, RNP_HW_SCTP_CKSUM_CTRL, false);
+		}
+		RNP_E_REG_WR(hw, RNP_HW_CHECK_ERR_CTRL, cksum_ctrl);
+	} else {
+		/* Enabled all support checksum features
+		 * use software mode support per port rx checksum
+		 * feature enabled/disabled for multiple port mode
+		 */
+		RNP_E_REG_WR(hw, RNP_HW_CHECK_ERR_CTRL, RNP_HW_ERR_RX_ALL_MASK);
+		RNP_E_REG_WR(hw, RNP_HW_SCTP_CKSUM_CTRL, true);
+	}
+}
+
 static int rnp_dev_configure(struct rte_eth_dev *eth_dev)
 {
 	struct rnp_eth_port *port = RNP_DEV_TO_PORT(eth_dev);
@@ -420,6 +481,7 @@ static int rnp_dev_configure(struct rte_eth_dev *eth_dev)
 	else
 		port->rxq_num_changed = false;
 	port->last_rx_num = eth_dev->data->nb_rx_queues;
+	rnp_set_rx_cksum_offload(eth_dev);
 
 	return 0;
 }
@@ -606,7 +668,8 @@ static int rnp_dev_infos_get(struct rte_eth_dev *eth_dev,
 	/* speed cap info */
 	dev_info->speed_capa = rnp_get_speed_caps(eth_dev);
 	/* rx support offload cap */
-	dev_info->rx_offload_capa = RTE_ETH_RX_OFFLOAD_SCATTER;
+	dev_info->rx_offload_capa = RNP_RX_CHECKSUM_SUPPORT |
+				    RTE_ETH_RX_OFFLOAD_SCATTER;
 	/* tx support offload cap */
 	dev_info->tx_offload_capa = RTE_ETH_TX_OFFLOAD_MULTI_SEGS;
 	/* default ring configure */
diff --git a/drivers/net/rnp/rnp_rxtx.c b/drivers/net/rnp/rnp_rxtx.c
index dd8cde8aff..c6c80f3a76 100644
--- a/drivers/net/rnp/rnp_rxtx.c
+++ b/drivers/net/rnp/rnp_rxtx.c
@@ -639,8 +639,102 @@ int rnp_rx_queue_start(struct rte_eth_dev *eth_dev, uint16_t qidx)
 	return 0;
 }
 
+struct rnp_rx_cksum_parse {
+	uint64_t offloads;
+	uint64_t packet_type;
+	uint16_t hw_offload;
+	uint64_t good;
+	uint64_t bad;
+};
+
+#define RNP_RX_OFFLOAD_L4_CKSUM (RTE_ETH_RX_OFFLOAD_TCP_CKSUM | \
+				 RTE_ETH_RX_OFFLOAD_UDP_CKSUM | \
+				 RTE_ETH_RX_OFFLOAD_SCTP_CKSUM)
+static const struct rnp_rx_cksum_parse rnp_rx_cksum_tunnel[] = {
+	{ RTE_ETH_RX_OFFLOAD_IPV4_CKSUM | RTE_ETH_RX_OFFLOAD_OUTER_IPV4_CKSUM,
+	  RTE_PTYPE_L3_IPV4 | RTE_PTYPE_TUNNEL_MASK, RNP_RX_L3_ERR,
+	  RTE_MBUF_F_RX_IP_CKSUM_GOOD, RTE_MBUF_F_RX_OUTER_IP_CKSUM_BAD
+	},
+	{ RTE_ETH_RX_OFFLOAD_IPV4_CKSUM,
+	  RTE_PTYPE_L3_IPV4, RNP_RX_IN_L3_ERR,
+	  RTE_MBUF_F_RX_IP_CKSUM_GOOD, RTE_MBUF_F_RX_IP_CKSUM_BAD
+	},
+	{ RNP_RX_OFFLOAD_L4_CKSUM, RTE_PTYPE_L4_MASK,
+	  RNP_RX_IN_L4_ERR | RNP_RX_SCTP_ERR,
+	  RTE_MBUF_F_RX_L4_CKSUM_GOOD, RTE_MBUF_F_RX_L4_CKSUM_BAD
+	}
+};
+
+static const struct rnp_rx_cksum_parse rnp_rx_cksum[] = {
+	{ RTE_ETH_RX_OFFLOAD_IPV4_CKSUM,
+	  RTE_PTYPE_L3_IPV4, RNP_RX_L3_ERR,
+	  RTE_MBUF_F_RX_IP_CKSUM_GOOD, RTE_MBUF_F_RX_IP_CKSUM_BAD
+	},
+	{ RNP_RX_OFFLOAD_L4_CKSUM,
+	  RTE_PTYPE_L4_MASK, RNP_RX_L4_ERR | RNP_RX_SCTP_ERR,
+	  RTE_MBUF_F_RX_L4_CKSUM_GOOD, RTE_MBUF_F_RX_L4_CKSUM_BAD
+	}
+};
+
+static void
+rnp_rx_parse_tunnel_cksum(struct rnp_rx_queue *rxq,
+			  struct rte_mbuf *m, uint16_t cksum_cmd)
+{
+	uint16_t idx = 0;
+
+	for (idx = 0; idx < RTE_DIM(rnp_rx_cksum_tunnel); idx++) {
+		if (rxq->rx_offloads & rnp_rx_cksum_tunnel[idx].offloads &&
+		    m->packet_type & rnp_rx_cksum_tunnel[idx].packet_type) {
+			if (cksum_cmd & rnp_rx_cksum_tunnel[idx].hw_offload)
+				m->ol_flags |= rnp_rx_cksum_tunnel[idx].bad;
+			else
+				m->ol_flags |= rnp_rx_cksum_tunnel[idx].good;
+		}
+	}
+}
+
+static void
+rnp_rx_parse_cksum(struct rnp_rx_queue *rxq,
+		   struct rte_mbuf *m, uint16_t cksum_cmd)
+{
+	uint16_t idx = 0;
+
+	for (idx = 0; idx < RTE_DIM(rnp_rx_cksum); idx++) {
+		if (rxq->rx_offloads & rnp_rx_cksum[idx].offloads &&
+		    m->packet_type & rnp_rx_cksum[idx].packet_type) {
+			if (cksum_cmd & rnp_rx_cksum[idx].hw_offload)
+				m->ol_flags |= rnp_rx_cksum[idx].bad;
+			else
+				m->ol_flags |= rnp_rx_cksum[idx].good;
+		}
+	}
+}
+
+static __rte_always_inline void
+rnp_dev_rx_offload(struct rnp_rx_queue *rxq,
+		   struct rte_mbuf *m,
+		   volatile struct rnp_rx_desc rxbd)
+{
+	uint32_t rss = rte_le_to_cpu_32(rxbd.wb.qword0.rss_hash);
+	uint16_t cmd = rxbd.wb.qword1.cmd;
+
+	if (rxq->rx_offloads & RNP_RX_CHECKSUM_SUPPORT) {
+		if (m->packet_type & RTE_PTYPE_TUNNEL_MASK) {
+			rnp_rx_parse_tunnel_cksum(rxq, m, cmd);
+		} else {
+			if (m->packet_type & RTE_PTYPE_L3_MASK ||
+			    m->packet_type & RTE_PTYPE_L4_MASK)
+				rnp_rx_parse_cksum(rxq, m, cmd);
+		}
+	}
+	if (rxq->rx_offloads & RTE_ETH_RX_OFFLOAD_RSS_HASH && rss) {
+		m->hash.rss = rss;
+		m->ol_flags |= RTE_MBUF_F_RX_RSS_HASH;
+	}
+}
+
 static __rte_always_inline void
-rnp_dev_rx_parse(struct rnp_rx_queue *rxq __rte_unused,
+rnp_dev_rx_parse(struct rnp_rx_queue *rxq,
 		 struct rte_mbuf *m,
 		 volatile struct rnp_rx_desc rxbd)
 {
@@ -680,6 +774,7 @@ rnp_dev_rx_parse(struct rnp_rx_queue *rxq __rte_unused,
 	}
 	if (!(m->packet_type & RTE_PTYPE_L2_MASK))
 		m->packet_type |= RTE_PTYPE_L2_ETHER;
+	rnp_dev_rx_offload(rxq, m, rxbd);
 }
 
 #define RNP_CACHE_FETCH_RX (4)
-- 
2.25.1

