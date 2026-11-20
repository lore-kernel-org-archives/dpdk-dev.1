Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD79606A32C
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Nov 2026 16:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=vip.163.com header.i=@vip.163.com header.a=rsa-sha256 header.s=s110527 header.b=UwssZYyW
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2A197406FF;
	Fri, 20 Nov 2026 17:35:26 +0100 (CET)
Received: from mail-m16.vip.163.com (mail-m16.vip.163.com [1.95.21.3])
 by mails.dpdk.org (Postfix) with ESMTPS id 6E3F040263;
 Fri, 20 Nov 2026 17:35:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vip.163.com; s=s110527; h=From:To:Subject:Date:Message-ID:
 MIME-Version; bh=h2P9dOV9LiHFg2XFBS2yntD9gf7vb+/qZb/O/UAXH2g=;
 b=UwssZYyWCVryF1XLLjEo7BOnkPfOIcfG/jq0hqIVm4xujWJHN2YtlfUVKWH/Gs
 uUlwZn6Bo18NA5Jci6248FsUevlepxZyMWx7S16tNKqSZTjmYZ/PEfMQok5yXHmY
 ZppdtrxsnZ++IRialKRCYSyZcWrvsotfZKOlnAXARXJBw=
From: Jiacheng Ye <yejiacheng4@h-partners.com>
To: dev@dpdk.org
Cc: Feifei Wang <wangfeifei40@huawei.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 Anatoly Burakov <anatoly.burakov@intel.com>, stable@dpdk.org
Subject: [PATCH v8 09/28] net/hinic3: fix pseudo-header checksum and identify
 NIC type
Date: Sat, 21 Nov 2026 00:34:34 +0800
Message-ID: <20261120163454.1159-10-yejiacheng4@h-partners.com>
X-Mailer: git-send-email 2.53.0.windows.2
In-Reply-To: <20261120163454.1159-1-yejiacheng4@h-partners.com>
References: <20261117155711.1048-1-yejiacheng4@h-partners.com>
 <20261120163454.1159-1-yejiacheng4@h-partners.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Ac8vCgCHL5q7dgBrCNqsBQ--.46998S11
X-Coremail-Antispam: 1Uf129KBjvAXoW3tw4rKw4xtw13CF47GFW3Jrb_yoW8GFW7Xo
 WSqr4Skr1ftr1rGry0grWqvF4qqr95trWYkws0gwsrtay3ur1UKwnxG34fAa48Xwn5AF13
 Aa42qFnakrW7Jw47n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
 AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU4WrWUUUUU
Sender: wff_light@vip.163.com
X-CM-SenderInfo: pziiszhljk3qxylshiywtou0bp/1tbiMwCosmsAdsALLQAA3S
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

SP620 expects the driver to precompute the L4 pseudo-header checksum for
TCP/UDP checksum and TSO offload; without it the hardware writes a wrong
checksum. Compute the inner and outer pseudo-header checksums in the Tx
prepare callback, with the L4 protocol derived from the offload flags.

The checksum is written back into the packet headers, so reject a shared
or indirect mbuf only when the offload modifies the packet: TCP/UDP
checksum, TSO and outer UDP checksum. The SCTP checksum is computed by
the hardware and writes nothing back. Reject a packet whose headers do
not fit in the first segment.

The SP230 derives the inner checksums and TSO headers in hardware and must
not have them written back, so the prepare step needs to know the NIC
model. Identify it from the PCI device ID at initialization and keep it in
the NIC private data, and run the software pseudo-header writes only for
the other models.

Fixes: 7608f0367d5a ("net/hinic3: add basic ethdev operations")
Cc: stable@dpdk.org

Signed-off-by: Jiacheng Ye <yejiacheng4@h-partners.com>
---
 drivers/net/hinic3/hinic3_ethdev.c |  18 +++
 drivers/net/hinic3/hinic3_ethdev.h |  11 ++
 drivers/net/hinic3/hinic3_tx.c     | 220 ++++++++++++++++++++++++++---
 drivers/net/hinic3/hinic3_tx.h     |   1 +
 4 files changed, 234 insertions(+), 16 deletions(-)

diff --git a/drivers/net/hinic3/hinic3_ethdev.c b/drivers/net/hinic3/hinic3_ethdev.c
index aaae6f4364..e74dfa22da 100644
--- a/drivers/net/hinic3/hinic3_ethdev.c
+++ b/drivers/net/hinic3/hinic3_ethdev.c
@@ -482,6 +482,22 @@ hinic3_init_default_cos(struct hinic3_nic_dev *nic_dev)
 	return 0;
 }
 
+static enum nic_type
+hinic3_get_nic_type(struct rte_pci_device *pci_dev)
+{
+	switch (pci_dev->id.device_id) {
+	case HINIC3_DEV_ID_SP620:
+	case HINIC3_DEV_ID_VF_SP620:
+	case HINIC3_DEV_ID_SP920: /* SP920 is the DPU card of SP620. */
+		return NIC_SP620;
+	case HINIC3_DEV_ID_SP230:
+	case HINIC3_DEV_ID_VF_SP230:
+		return NIC_SP230;
+	default:
+		return NIC_UNKNOWN;
+	}
+}
+
 /**
  * Initialize Class of Service (CoS). For PF devices, it also sync the link
  * status with the physical port.
@@ -3423,6 +3439,7 @@ hinic3_func_init(struct rte_eth_dev *eth_dev)
 
 	nic_dev = HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(eth_dev);
 	memset(nic_dev, 0, sizeof(*nic_dev));
+	nic_dev->nic_type = hinic3_get_nic_type(pci_dev);
 	snprintf(nic_dev->dev_name, sizeof(nic_dev->dev_name),
 		"dbdf-%.4x:%.2x:%.2x.%x", pci_dev->addr.domain,
 		pci_dev->addr.bus, pci_dev->addr.devid,
@@ -3646,6 +3663,7 @@ hinic3_dev_init(struct rte_eth_dev *eth_dev)
 
 	eth_dev->rx_pkt_burst = hinic3_recv_pkts;
 	eth_dev->tx_pkt_burst = hinic3_xmit_pkts;
+	eth_dev->tx_pkt_prepare = hinic3_prep_pkts;
 
 	return hinic3_func_init(eth_dev);
 }
diff --git a/drivers/net/hinic3/hinic3_ethdev.h b/drivers/net/hinic3/hinic3_ethdev.h
index 9061e2b217..8bbab2ad53 100644
--- a/drivers/net/hinic3/hinic3_ethdev.h
+++ b/drivers/net/hinic3/hinic3_ethdev.h
@@ -41,6 +41,7 @@
 #define HINIC3_PKT_TX_OUTER_IP_CKSUM	RTE_MBUF_F_TX_OUTER_IP_CKSUM
 #define HINIC3_PKT_TX_OUTER_UDP_CKSUM	RTE_MBUF_F_TX_OUTER_UDP_CKSUM
 #define HINIC3_PKT_TX_OUTER_IPV6	RTE_MBUF_F_TX_OUTER_IPV6
+#define HINIC3_PKT_TX_OUTER_IPV4	RTE_MBUF_F_TX_OUTER_IPV4
 #define HINIC3_PKT_RX_LRO		RTE_MBUF_F_RX_LRO
 #define HINIC3_PKT_TX_L4_NO_CKSUM	RTE_MBUF_F_TX_L4_NO_CKSUM
 
@@ -106,6 +107,12 @@ enum nic_feature_cap {
 TAILQ_HEAD(hinic3_ethertype_filter_list, rte_flow);
 TAILQ_HEAD(hinic3_fdir_rule_filter_list, rte_flow);
 
+enum nic_type {
+	NIC_SP620 = 0,
+	NIC_SP230 = 1,
+	NIC_UNKNOWN = 2,
+};
+
 struct hinic3_nic_dev {
 	struct hinic3_hwdev *hwdev; /**< Hardware device. */
 	struct hinic3_txq **txqs;
@@ -152,9 +159,13 @@ struct hinic3_nic_dev {
 	struct hinic3_nic_cmdq_ops *cmdq_ops;
 	struct hinic3_nic_rx_ops *rx_ops;
 	struct hinic3_nic_tx_ops *tx_ops;
+	enum nic_type nic_type; /**< NIC type. */
 
 };
 
+#define HINIC3_IS_SP620_NIC(nic_dev) ((nic_dev)->nic_type == NIC_SP620)
+#define HINIC3_IS_SP230_NIC(nic_dev) ((nic_dev)->nic_type == NIC_SP230)
+
 extern const struct rte_flow_ops hinic3_flow_ops;
 
 /**
diff --git a/drivers/net/hinic3/hinic3_tx.c b/drivers/net/hinic3/hinic3_tx.c
index 6b2bffb14e..0555fd3393 100644
--- a/drivers/net/hinic3/hinic3_tx.c
+++ b/drivers/net/hinic3/hinic3_tx.c
@@ -285,6 +285,28 @@ hinic3_tx_done_cleanup(void *txq, uint32_t free_cnt)
 	return hinic3_xmit_mbuf_cleanup(tx_queue, try_free_cnt);
 }
 
+static uint16_t
+hinic3_ipv6_phdr_cksum(const struct rte_ipv6_hdr *ipv6_hdr, uint16_t l3_len,
+		       uint8_t proto, uint64_t ol_flags)
+{
+	uint32_t sum;
+	rte_be32_t l4_len;
+	rte_be32_t l4_proto;
+
+	l4_proto = rte_cpu_to_be_32(proto);
+	if (ol_flags & HINIC3_PKT_TX_TCP_SEG)
+		l4_len = 0;
+	else
+		l4_len = rte_cpu_to_be_16(rte_be_to_cpu_16(ipv6_hdr->payload_len) -
+					  l3_len + sizeof(*ipv6_hdr));
+
+	sum = __rte_raw_cksum(ipv6_hdr->src_addr.a,
+			      sizeof(ipv6_hdr->src_addr.a) + sizeof(ipv6_hdr->dst_addr.a), 0);
+	sum = __rte_raw_cksum(&l4_len, sizeof(l4_len), sum);
+	sum = __rte_raw_cksum(&l4_proto, sizeof(l4_proto), sum);
+
+	return __rte_raw_cksum_reduce(sum);
+}
 /**
  * Prepare the data packet to be sent and calculate the internal L3 offset.
  *
@@ -297,19 +319,111 @@ hinic3_tx_done_cleanup(void *txq, uint32_t free_cnt)
  * @return
  * 0 as success, -EINVAL as failure.
  */
-static int
-hinic3_tx_offload_pkt_prepare(struct hinic3_nic_dev *nic_dev, struct rte_mbuf *mbuf,
-			      uint16_t *inner_l3_offset)
+static inline uint16_t
+hinic3_calculate_l4_cksum(struct rte_mbuf *mbuf, uint16_t inner_l3_offset,
+			  uint16_t l3_len, uint8_t l4_proto)
+{
+	struct rte_ipv4_hdr *ipv4_hdr;
+	struct rte_ipv6_hdr *ipv6_hdr;
+	uint64_t ol_flags = mbuf->ol_flags;
+
+	if (ol_flags & HINIC3_PKT_TX_IPV4) {
+		ipv4_hdr = rte_pktmbuf_mtod_offset(mbuf, struct rte_ipv4_hdr *,
+						   inner_l3_offset);
+
+		if (ol_flags & HINIC3_PKT_TX_IP_CKSUM)
+			ipv4_hdr->hdr_checksum = 0;
+
+		return rte_ipv4_phdr_cksum(ipv4_hdr, ol_flags);
+	}
+
+	ipv6_hdr = rte_pktmbuf_mtod_offset(mbuf, struct rte_ipv6_hdr *,
+					   inner_l3_offset);
+
+	return hinic3_ipv6_phdr_cksum(ipv6_hdr, l3_len, l4_proto, ol_flags);
+}
+
+static inline void hinic3_calculate_outer_udp_checksum(struct rte_mbuf *mbuf,
+						       uint16_t outer_l3_offset)
+{
+	struct rte_ipv4_hdr *ipv4_hdr;
+	struct rte_ipv6_hdr *ipv6_hdr;
+	struct rte_udp_hdr *udp_hdr;
+	uint64_t ol_flags = mbuf->ol_flags;
+
+	if (ol_flags & HINIC3_PKT_TX_OUTER_IPV4) {
+		ipv4_hdr = rte_pktmbuf_mtod_offset(mbuf, struct rte_ipv4_hdr *, outer_l3_offset);
+		if (ol_flags & HINIC3_PKT_TX_OUTER_IP_CKSUM)
+			ipv4_hdr->hdr_checksum = 0;
+		udp_hdr = (struct rte_udp_hdr *)((char *)ipv4_hdr + mbuf->outer_l3_len);
+		udp_hdr->dgram_cksum = rte_ipv4_phdr_cksum(ipv4_hdr, ol_flags);
+	} else if (ol_flags & HINIC3_PKT_TX_OUTER_IPV6) {
+		ipv6_hdr = rte_pktmbuf_mtod_offset(mbuf, struct rte_ipv6_hdr *, outer_l3_offset);
+		udp_hdr = rte_pktmbuf_mtod_offset(mbuf, struct rte_udp_hdr *,
+						  (outer_l3_offset + mbuf->outer_l3_len));
+		udp_hdr->dgram_cksum = hinic3_ipv6_phdr_cksum(ipv6_hdr, mbuf->outer_l3_len,
+							      IPPROTO_UDP, ol_flags);
+	}
+}
+
+static inline void hinic3_calculate_outer_phdr_checksum(struct rte_mbuf *mbuf,
+							uint16_t outer_l3_offset)
+{
+	uint64_t ol_flags = mbuf->ol_flags;
+
+	if (ol_flags & HINIC3_PKT_TX_OUTER_UDP_CKSUM)
+		hinic3_calculate_outer_udp_checksum(mbuf, outer_l3_offset);
+}
+
+static inline void hinic3_calculate_phdr_checksum(struct rte_mbuf *mbuf,
+						  uint16_t inner_l3_offset)
 {
 	uint64_t ol_flags = mbuf->ol_flags;
+	struct rte_tcp_hdr *tcp_hdr;
+	struct rte_udp_hdr *udp_hdr;
+	uint16_t l3_len = mbuf->l3_len;
+	uint16_t l4_offset;
+
+	l4_offset = inner_l3_offset + l3_len;
+
+	switch (ol_flags & HINIC3_PKT_TX_L4_MASK) {
+	case HINIC3_PKT_TX_UDP_CKSUM:
+		udp_hdr = rte_pktmbuf_mtod_offset(mbuf, struct rte_udp_hdr *, l4_offset);
+		udp_hdr->dgram_cksum = hinic3_calculate_l4_cksum(mbuf, inner_l3_offset,
+								 l3_len, IPPROTO_UDP);
+		break;
+	case HINIC3_PKT_TX_TCP_CKSUM:
+		tcp_hdr = rte_pktmbuf_mtod_offset(mbuf, struct rte_tcp_hdr *, l4_offset);
+		tcp_hdr->cksum = hinic3_calculate_l4_cksum(mbuf, inner_l3_offset,
+							   l3_len, IPPROTO_TCP);
+		break;
+	case HINIC3_PKT_TX_SCTP_CKSUM:
+		/* Sctp csum no need to calculate pseudo-header */
+		break;
+	default:
+		if (ol_flags & HINIC3_PKT_TX_TCP_SEG) {
+			tcp_hdr = rte_pktmbuf_mtod_offset(mbuf, struct rte_tcp_hdr *, l4_offset);
+			tcp_hdr->cksum = hinic3_calculate_l4_cksum(mbuf, inner_l3_offset,
+								   l3_len, IPPROTO_TCP);
+		}
+		break;
+	}
+}
 
-	if ((ol_flags & HINIC3_PKT_TX_TUNNEL_MASK)) {
-		if (!(((ol_flags & HINIC3_PKT_TX_TUNNEL_VXLAN) &&
-				HINIC3_SUPPORT_VXLAN_OFFLOAD(nic_dev)) ||
-		      ((ol_flags & HINIC3_PKT_TX_TUNNEL_GENEVE) &&
-				HINIC3_SUPPORT_GENEVE_OFFLOAD(nic_dev)) ||
-		      ((ol_flags & HINIC3_PKT_TX_TUNNEL_IPIP) &&
-				HINIC3_SUPPORT_IPXIP_OFFLOAD(nic_dev))))
+static int
+hinic3_get_inner_l3_offset(struct hinic3_nic_dev *nic_dev, struct rte_mbuf *mbuf,
+			   uint16_t *inner_l3_offset)
+{
+	uint64_t ol_flags = mbuf->ol_flags;
+	uint64_t tunnel_type = ol_flags & HINIC3_PKT_TX_TUNNEL_MASK;
+
+	if (tunnel_type) {
+		if (!((tunnel_type == HINIC3_PKT_TX_TUNNEL_VXLAN &&
+		       HINIC3_SUPPORT_VXLAN_OFFLOAD(nic_dev)) ||
+		      (tunnel_type == HINIC3_PKT_TX_TUNNEL_GENEVE &&
+		       HINIC3_SUPPORT_GENEVE_OFFLOAD(nic_dev)) ||
+		      (tunnel_type == HINIC3_PKT_TX_TUNNEL_IPIP &&
+		       HINIC3_SUPPORT_IPXIP_OFFLOAD(nic_dev))))
 			return -EINVAL;
 	}
 
@@ -318,13 +432,28 @@ hinic3_tx_offload_pkt_prepare(struct hinic3_nic_dev *nic_dev, struct rte_mbuf *m
 		return -EINVAL;
 #endif
 	/* Support tunnel. */
-	if ((ol_flags & HINIC3_PKT_TX_TUNNEL_MASK)) {
-		if ((ol_flags & HINIC3_PKT_TX_OUTER_IP_CKSUM) ||
-		    (ol_flags & HINIC3_PKT_TX_OUTER_IPV6) ||
-		    (ol_flags & HINIC3_PKT_TX_TCP_SEG)) {
+	if (tunnel_type) {
+		/*
+		 * For IPv6-in-IPv6 packets, ol_flags cannot be used to determine
+		 * whether the delivered port offload value contains UDP and IP
+		 * hardware offload flags, so it is impossible to determine how
+		 * l2_len is populated. Here, the property that l2_len is 0 for
+		 * IP-in-IP is used to distinguish population modes. If
+		 * mbuf->l2_len == 0, the upper layer has enabled UDP and IP
+		 * hardware offload flags; the inner L3 offset is then
+		 * outer_l2_len + outer_l3_len.
+		 */
+		if (tunnel_type == HINIC3_PKT_TX_TUNNEL_IPIP) {
+			if (mbuf->l2_len == 0)
+				*inner_l3_offset = mbuf->outer_l2_len + mbuf->outer_l3_len;
+			else
+				*inner_l3_offset = mbuf->l2_len;
+		} else if ((ol_flags & HINIC3_PKT_TX_OUTER_IP_CKSUM) ||
+			   (ol_flags & HINIC3_PKT_TX_OUTER_UDP_CKSUM) ||
+			   (ol_flags & HINIC3_PKT_TX_TCP_SEG)) {
 			/*
 			 * For this senmatic, l2_len of mbuf means
-			 * len(out_udp + vxlan + in_eth).
+			 * len(out_udp + vxlan/geneve + in_eth).
 			 */
 			*inner_l3_offset = mbuf->l2_len + mbuf->outer_l2_len +
 					   mbuf->outer_l3_len;
@@ -343,6 +472,65 @@ hinic3_tx_offload_pkt_prepare(struct hinic3_nic_dev *nic_dev, struct rte_mbuf *m
 	return 0;
 }
 
+
+uint16_t
+hinic3_prep_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
+{
+	struct hinic3_txq *txq = tx_queue;
+	struct hinic3_nic_dev *nic_dev = txq->nic_dev;
+	struct rte_mbuf *mbuf;
+	uint16_t inner_l3_offset;
+	int ret;
+	int i;
+
+	for (i = 0; i != nb_pkts; i++) {
+		mbuf = tx_pkts[i];
+
+		if (!(mbuf->ol_flags & HINIC3_TX_OFFLOAD_MASK))
+			continue;
+
+		ret = hinic3_get_inner_l3_offset(nic_dev, mbuf, &inner_l3_offset);
+		if (unlikely(ret)) {
+			rte_errno = -ret;
+			return i;
+		}
+
+		if (!HINIC3_IS_SP230_NIC(nic_dev)) {
+			/*
+			 * The pseudo-header checksum is written back into the
+			 * packet's L3/L4 header, which would corrupt data still
+			 * referenced by another consumer for a shared or indirect
+			 * mbuf, so fail those packets instead. Only TCP/UDP
+			 * checksum, TSO and outer UDP checksum write into the
+			 * packet; the SCTP checksum is left to the hardware.
+			 */
+			if (unlikely((mbuf->ol_flags &
+				      (HINIC3_PKT_TX_TCP_CKSUM |
+				       HINIC3_PKT_TX_UDP_CKSUM |
+				       HINIC3_PKT_TX_TCP_SEG |
+				       HINIC3_PKT_TX_OUTER_UDP_CKSUM)) &&
+				     (rte_mbuf_refcnt_read(mbuf) > 1 ||
+				      RTE_MBUF_CLONED(mbuf)))) {
+				rte_errno = EINVAL;
+				return i;
+			}
+
+			/* The headers must be contiguous in the first segment. */
+			if (unlikely(rte_pktmbuf_data_len(mbuf) <
+				     inner_l3_offset + mbuf->l3_len + mbuf->l4_len)) {
+				rte_errno = ENOTSUP;
+				return i;
+			}
+
+			/* Process the outer and inner pseudo-header checksums. */
+			hinic3_calculate_outer_phdr_checksum(mbuf, mbuf->outer_l2_len);
+			hinic3_calculate_phdr_checksum(mbuf, inner_l3_offset);
+		}
+	}
+
+	return i;
+}
+
 void
 hinic3_tx_set_normal_task_offload(struct hinic3_wqe_info *wqe_info,
 				  struct hinic3_sq_wqe_combo *wqe_combo)
@@ -622,7 +810,7 @@ hinic3_get_tx_offload(struct hinic3_nic_dev *nic_dev, struct rte_mbuf *mbuf,
 	}
 
 	wqe_info->offload = 1;
-	err = hinic3_tx_offload_pkt_prepare(nic_dev, mbuf, &inner_l3_offset);
+	err = hinic3_get_inner_l3_offset(nic_dev, mbuf, &inner_l3_offset);
 	if (err)
 		return err;
 
diff --git a/drivers/net/hinic3/hinic3_tx.h b/drivers/net/hinic3/hinic3_tx.h
index e0ed9908ad..3b1580dd3a 100644
--- a/drivers/net/hinic3/hinic3_tx.h
+++ b/drivers/net/hinic3/hinic3_tx.h
@@ -394,6 +394,7 @@ void hinic3_flush_txqs(struct hinic3_nic_dev *nic_dev);
 void hinic3_free_txq_mbufs(struct hinic3_txq *txq);
 void hinic3_free_all_txq_mbufs(struct hinic3_nic_dev *nic_dev);
 uint16_t hinic3_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts);
+uint16_t hinic3_prep_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts);
 int hinic3_stop_sq(struct hinic3_txq *txq);
 int hinic3_start_all_sqs(struct rte_eth_dev *eth_dev);
 int hinic3_tx_done_cleanup(void *txq, uint32_t free_cnt);
-- 
2.33.0

