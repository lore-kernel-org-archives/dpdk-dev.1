Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7F9ECC6B1A
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Oct 2026 15:12:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E26CE40E44;
	Wed, 14 Oct 2026 17:10:11 +0200 (CEST)
Received: from mail-m16.vip.163.com (mail-m16.vip.163.com [1.95.21.5])
 by mails.dpdk.org (Postfix) with ESMTP id C8F0840664
 for <dev@dpdk.org>; Wed, 14 Oct 2026 17:09:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vip.163.com; s=s110527; h=From:To:Subject:Date:Message-ID:
 MIME-Version; bh=F0eRyqcyj3s1IhgWAYichTOY3r6dOTS8ng+/RTm0zk8=;
 b=Oy6WviD5AOPe4Xx1Ot8dyzGWodAcTZ4xFqLrSH7d48OLRXNYQUCua8Tkha67pn
 V3fon0LFMGXE3Oy1WQPHb6NYZhK58bg1dqTnpgrfHr6QgzM1LS56czHQlL36ljOX
 mPXLrwIoXL+poTs5sh3cp0KCoLDaPC76MTIdKes7boNxk=
From: Jiacheng Ye <yejiacheng4@h-partners.com>
To: dev@dpdk.org
Cc: Feifei Wang <wangfeifei40@huawei.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v2 25/26] net/hinic3: add pseudo-header checksum calculation
Date: Wed, 14 Oct 2026 23:09:21 +0800
Message-ID: <20261014150923.838-26-yejiacheng4@h-partners.com>
X-Mailer: git-send-email 2.53.0.windows.2
In-Reply-To: <20261014150923.838-1-yejiacheng4@h-partners.com>
References: <20261010144509.2731-1-yejiacheng4@h-partners.com>
 <20261014150923.838-1-yejiacheng4@h-partners.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: As8vCgAXMEEym89qB_SFAw--.62919S27
X-Coremail-Antispam: 1Uf129KBjvAXoW3tr4xZw4UKF1kArykJF1xuFg_yoW8JFW8Ao
 WfXr4Skr1Sqr1rJryjgrWv9FWqqwn0q3y5Cws0gwsFqay3Zr1Yk3sxG3yfAayUXwn5AFnF
 ya4aqFnak3y7Jwsrn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
 AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUwb10UUUUU
Sender: wff_light@vip.163.com
X-CM-SenderInfo: pziiszhljk3qxylshiywtou0bp/1tbiMh6EjmrPmz4aDgAA3y
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

Hardware checksum offload needs the pseudo-header checksum precomputed by
the driver. Compute the inner/outer pseudo-header checksums, including
walking IPv6 extension headers, in the Tx prepare path.

Signed-off-by: Jiacheng Ye <yejiacheng4@h-partners.com>
---
 drivers/net/hinic3/hinic3_ethdev.c |   3 +
 drivers/net/hinic3/hinic3_ethdev.h |   1 +
 drivers/net/hinic3/hinic3_tx.c     | 219 +++++++++++++++++++++++++++--
 drivers/net/hinic3/hinic3_tx.h     |  10 ++
 4 files changed, 224 insertions(+), 9 deletions(-)

diff --git a/drivers/net/hinic3/hinic3_ethdev.c b/drivers/net/hinic3/hinic3_ethdev.c
index 03d1dffb11..5ecedab55d 100644
--- a/drivers/net/hinic3/hinic3_ethdev.c
+++ b/drivers/net/hinic3/hinic3_ethdev.c
@@ -804,6 +804,7 @@ hinic3_dev_infos_get(struct rte_eth_dev *dev, struct rte_eth_dev_info *info)
 				RTE_ETH_TX_OFFLOAD_TCP_CKSUM |
 				RTE_ETH_TX_OFFLOAD_SCTP_CKSUM |
 				RTE_ETH_TX_OFFLOAD_OUTER_IPV4_CKSUM |
+				RTE_ETH_TX_OFFLOAD_OUTER_UDP_CKSUM |
 				RTE_ETH_TX_OFFLOAD_TCP_TSO |
 				RTE_ETH_TX_OFFLOAD_MULTI_SEGS;
 
@@ -4103,6 +4104,8 @@ hinic3_dev_init(struct rte_eth_dev *eth_dev)
 			return err;
 		}
 
+		eth_dev->tx_pkt_prepare = hinic3_prep_pkts;
+
 		if (nic_dev->config.rx_cqe_compact_en != HINIC3_RX_CQE_COMPACT_EN) {
 			eth_dev->rx_pkt_burst = hinic3_recv_pkts;
 			eth_dev->tx_pkt_burst = hinic3_xmit_pkts;
diff --git a/drivers/net/hinic3/hinic3_ethdev.h b/drivers/net/hinic3/hinic3_ethdev.h
index 72337230c8..125a508467 100644
--- a/drivers/net/hinic3/hinic3_ethdev.h
+++ b/drivers/net/hinic3/hinic3_ethdev.h
@@ -47,6 +47,7 @@
 #define HINIC3_PKT_TX_OUTER_IP_CKSUM	RTE_MBUF_F_TX_OUTER_IP_CKSUM
 #define HINIC3_PKT_TX_OUTER_UDP_CKSUM	RTE_MBUF_F_TX_OUTER_UDP_CKSUM
 #define HINIC3_PKT_TX_OUTER_IPV6	RTE_MBUF_F_TX_OUTER_IPV6
+#define HINIC3_PKT_TX_OUTER_IPV4	RTE_MBUF_F_TX_OUTER_IPV4
 #define HINIC3_PKT_RX_LRO		RTE_MBUF_F_RX_LRO
 #define HINIC3_PKT_TX_L4_NO_CKSUM	RTE_MBUF_F_TX_L4_NO_CKSUM
 
diff --git a/drivers/net/hinic3/hinic3_tx.c b/drivers/net/hinic3/hinic3_tx.c
index 7ffa680123..8122334309 100644
--- a/drivers/net/hinic3/hinic3_tx.c
+++ b/drivers/net/hinic3/hinic3_tx.c
@@ -30,7 +30,7 @@
 	(HINIC3_PKT_TX_IP_CKSUM | HINIC3_PKT_TX_TCP_CKSUM |   \
 	 HINIC3_PKT_TX_UDP_CKSUM | HINIC3_PKT_TX_SCTP_CKSUM | \
 	 HINIC3_PKT_TX_OUTER_IP_CKSUM | HINIC3_PKT_TX_OUTER_UDP_CKSUM | \
-	 HINIC3_PKT_TX_TCP_SEG)
+	 HINIC3_PKT_TX_TCP_SEG | HINIC3_PKT_TX_IPV6)
 
 static inline uint16_t
 hinic3_get_sq_free_wqebbs(struct hinic3_txq *sq)
@@ -365,6 +365,68 @@ hinic3_tx_done_cleanup(void *txq, uint32_t free_cnt)
 	return hinic3_xmit_mbuf_cleanup(tx_queue, try_free_cnt);
 }
 
+static void hinic3_get_ipv6_len_proto(const void *hdr, uint16_t *hdr_len, uint8_t *proto)
+{
+	const struct hinic3_ipv6_ext_hdr *xh = NULL;
+	uint8_t i;
+
+	*proto = ((const struct rte_ipv6_hdr *)hdr)->proto;
+	*hdr_len = sizeof(struct rte_ipv6_hdr);
+
+	/*
+	 * Consistent with ucode's IPv6 max extension header count,
+	 * maximum parsing up to HINIC3_IPV6_MAX_EXT_HDRS layer.
+	 */
+	for (i = 0; i < HINIC3_IPV6_MAX_EXT_HDRS; i++) {
+		xh = (const struct hinic3_ipv6_ext_hdr *)((const uint8_t *)hdr + *hdr_len);
+		switch (*proto) {
+		case IPPROTO_HOPOPTS:
+		case IPPROTO_ROUTING:
+		case IPPROTO_DSTOPTS:
+			/* hdr len is a multiple of 8, excluding the first 8 bytes */
+			*hdr_len += HINIC3_FIXED_EXT_HDR_LEN + xh->len * HINIC3_UNIT_BYTES_U;
+			*proto = xh->next_hdr;
+			break;
+		case IPPROTO_AH:
+			/* hdr len is a multiple of 4, excluding the first 8 bytes */
+			*hdr_len += HINIC3_FIXED_EXT_HDR_LEN + xh->len * HINIC3_UNIT_BYTES_AH;
+			*proto = xh->next_hdr;
+			break;
+		case IPPROTO_FRAGMENT:
+			/* hdr len is fixed 8 bytes */
+			*hdr_len += HINIC3_FIXED_EXT_HDR_LEN;
+			*proto = xh->next_hdr;
+			break;
+		default:
+			break;
+		}
+	}
+}
+
+static uint16_t
+hinic3_ipv6_phdr_cksum(const struct rte_ipv6_hdr *ipv6_hdr, uint64_t ol_flags)
+{
+	uint32_t   sum;
+	uint8_t	   proto;
+	uint16_t   l3_len;
+	rte_be32_t l4_len;
+	rte_be32_t l4_proto;
+
+	hinic3_get_ipv6_len_proto((const void *)ipv6_hdr, &l3_len, &proto);
+	l4_proto = rte_cpu_to_be_16(proto);
+	if (ol_flags & HINIC3_PKT_TX_TCP_SEG)
+		l4_len = 0;
+	else
+		l4_len = rte_cpu_to_be_16(rte_be_to_cpu_16(ipv6_hdr->payload_len) -
+							   l3_len + sizeof(*ipv6_hdr));
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
@@ -377,9 +439,92 @@ hinic3_tx_done_cleanup(void *txq, uint32_t free_cnt)
  * @return
  * 0 as success, -EINVAL as failure.
  */
+static inline uint16_t
+hinic3_calculate_l4_cksum(struct rte_mbuf *mbuf, uint16_t inner_l3_offset)
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
+	return hinic3_ipv6_phdr_cksum(ipv6_hdr, ol_flags);
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
+		udp_hdr->dgram_cksum = hinic3_ipv6_phdr_cksum(ipv6_hdr, ol_flags);
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
+{
+	uint64_t ol_flags = mbuf->ol_flags;
+	struct rte_tcp_hdr *tcp_hdr;
+	struct rte_udp_hdr *udp_hdr;
+	uint16_t l4_offset = inner_l3_offset + mbuf->l3_len;
+
+	switch (ol_flags & HINIC3_PKT_TX_L4_MASK) {
+	case HINIC3_PKT_TX_UDP_CKSUM:
+		udp_hdr = rte_pktmbuf_mtod_offset(mbuf, struct rte_udp_hdr *, l4_offset);
+		udp_hdr->dgram_cksum = hinic3_calculate_l4_cksum(mbuf, inner_l3_offset);
+		break;
+	case HINIC3_PKT_TX_TCP_CKSUM:
+		tcp_hdr = rte_pktmbuf_mtod_offset(mbuf, struct rte_tcp_hdr *, l4_offset);
+		tcp_hdr->cksum = hinic3_calculate_l4_cksum(mbuf, inner_l3_offset);
+		break;
+	case HINIC3_PKT_TX_SCTP_CKSUM:
+		/* Sctp csum no need to calculate pseudo-header */
+		break;
+	default:
+		if (ol_flags & HINIC3_PKT_TX_TCP_SEG) {
+			tcp_hdr = rte_pktmbuf_mtod_offset(mbuf, struct rte_tcp_hdr *, l4_offset);
+			tcp_hdr->cksum = hinic3_calculate_l4_cksum(mbuf, inner_l3_offset);
+		}
+		break;
+	}
+}
+
 static int
-hinic3_tx_offload_pkt_prepare(struct hinic3_nic_dev *nic_dev, struct rte_mbuf *mbuf,
-			      uint16_t *inner_l3_offset)
+hinic3_get_inner_l3_offset(struct hinic3_nic_dev *nic_dev, struct rte_mbuf *mbuf,
+			   uint16_t *inner_l3_offset)
 {
 	uint64_t ol_flags = mbuf->ol_flags;
 
@@ -388,7 +533,7 @@ hinic3_tx_offload_pkt_prepare(struct hinic3_nic_dev *nic_dev, struct rte_mbuf *m
 				HINIC3_SUPPORT_VXLAN_OFFLOAD(nic_dev)) ||
 		      ((ol_flags & HINIC3_PKT_TX_TUNNEL_GENEVE) &&
 				HINIC3_SUPPORT_GENEVE_OFFLOAD(nic_dev)) ||
-		      ((ol_flags & HINIC3_PKT_TX_TUNNEL_IPIP) &&
+		      (((ol_flags & HINIC3_PKT_TX_TUNNEL_IPIP) == HINIC3_PKT_TX_TUNNEL_IPIP) &&
 				HINIC3_SUPPORT_IPXIP_OFFLOAD(nic_dev))))
 			return -EINVAL;
 	}
@@ -399,12 +544,27 @@ hinic3_tx_offload_pkt_prepare(struct hinic3_nic_dev *nic_dev, struct rte_mbuf *m
 #endif
 	/* Support tunnel. */
 	if ((ol_flags & HINIC3_PKT_TX_TUNNEL_MASK)) {
-		if ((ol_flags & HINIC3_PKT_TX_OUTER_IP_CKSUM) ||
-		    (ol_flags & HINIC3_PKT_TX_OUTER_IPV6) ||
-		    (ol_flags & HINIC3_PKT_TX_TCP_SEG)) {
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
+		if ((ol_flags & HINIC3_PKT_TX_TUNNEL_IPIP) == HINIC3_PKT_TX_TUNNEL_IPIP) {
+			if (mbuf->l2_len == 0)
+				*inner_l3_offset = mbuf->outer_l2_len + mbuf->outer_l3_len;
+			else
+				*inner_l3_offset = mbuf->l2_len;
+		} else if ((ol_flags & HINIC3_PKT_TX_OUTER_IP_CKSUM) ||
+			  (ol_flags & HINIC3_PKT_TX_OUTER_UDP_CKSUM) ||
+			  (ol_flags & HINIC3_PKT_TX_TCP_SEG)) {
 			/*
 			 * For this senmatic, l2_len of mbuf means
-			 * len(out_udp + vxlan + in_eth).
+			 * len(out_udp + vxlan/geneve + in_eth).
 			 */
 			*inner_l3_offset = mbuf->l2_len + mbuf->outer_l2_len +
 					   mbuf->outer_l3_len;
@@ -423,6 +583,47 @@ hinic3_tx_offload_pkt_prepare(struct hinic3_nic_dev *nic_dev, struct rte_mbuf *m
 	return 0;
 }
 
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
+			 * packet's L3/L4 header; for a shared or indirect mbuf
+			 * that would corrupt data still referenced by another
+			 * consumer, so skip the pseudo-header checksum.
+			 */
+			if (unlikely(rte_mbuf_refcnt_read(mbuf) > 1 || RTE_MBUF_CLONED(mbuf)))
+				continue;
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
 static inline void hinic3_set_vlan_tx_offload(struct hinic3_sq_task *task,
 					      uint16_t vlan_tag, uint8_t vlan_type)
 {
@@ -786,7 +987,7 @@ hinic3_get_tx_offload(struct hinic3_nic_dev *nic_dev, struct rte_mbuf *mbuf,
 	}
 
 	wqe_info->offload = 1;
-	err = hinic3_tx_offload_pkt_prepare(nic_dev, mbuf, &inner_l3_offset);
+	err = hinic3_get_inner_l3_offset(nic_dev, mbuf, &inner_l3_offset);
 	if (err)
 		return err;
 
diff --git a/drivers/net/hinic3/hinic3_tx.h b/drivers/net/hinic3/hinic3_tx.h
index af702b7ec5..8576ad0e3d 100644
--- a/drivers/net/hinic3/hinic3_tx.h
+++ b/drivers/net/hinic3/hinic3_tx.h
@@ -387,12 +387,22 @@ struct __rte_cache_aligned hinic3_txq {
 	uint64_t prof_tx_end_tsc;
 #endif
 };
+#define HINIC3_FIXED_EXT_HDR_LEN  8
+#define HINIC3_UNIT_BYTES_U  8
+#define HINIC3_UNIT_BYTES_AH  4
+#define HINIC3_IPV6_MAX_EXT_HDRS 9
+
+struct hinic3_ipv6_ext_hdr {
+	uint8_t next_hdr;
+	uint8_t len;
+};
 
 void hinic3_flush_txqs(struct hinic3_nic_dev *nic_dev);
 void hinic3_free_txq_mbufs(struct hinic3_txq *txq);
 void hinic3_free_all_txq_mbufs(struct hinic3_nic_dev *nic_dev);
 uint16_t hinic3_xmit_pkts_compact_cqe(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts);
 uint16_t hinic3_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts);
+uint16_t hinic3_prep_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts);
 int hinic3_stop_sq(struct hinic3_txq *txq);
 int hinic3_start_all_sqs(struct rte_eth_dev *eth_dev);
 int hinic3_tx_done_cleanup(void *txq, uint32_t free_cnt);
-- 
2.33.0

