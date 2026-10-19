Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1786360AA0F5
	for <dpdk-dev@archiver.kernel.org>; Mon, 19 Oct 2026 15:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=vip.163.com header.i=@vip.163.com header.a=rsa-sha256 header.s=s110527 header.b=NXc/rep0
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E9DAC40E44;
	Mon, 19 Oct 2026 17:20:23 +0200 (CEST)
Received: from mail-m16.vip.163.com (mail-m16.vip.163.com [220.197.30.223])
 by mails.dpdk.org (Postfix) with ESMTP id B36114067A;
 Mon, 19 Oct 2026 17:20:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vip.163.com; s=s110527; h=From:To:Subject:Date:Message-ID:
 MIME-Version; bh=n3tyPu+kdoPD0HPxvNo6m3HHB1LhA7SEAxk7i6BJ+bE=;
 b=NXc/rep0qEMzqNmoBifHDtVWaM8/wXx3P3URQFhcMyGQlgHeEGD30rTKHvOmXB
 h4gynUftX1hIkMgJIj4pNuDin/ZqHs0hm5eAntlmsbMgUo+3gHqI/3V5UUb4fRPS
 JSj3ys6Y3+Z8SARhCnBp82sLYbMRMrWCdd/8BOtdEFDr0=
From: Jiacheng Ye <yejiacheng4@h-partners.com>
To: dev@dpdk.org
Cc: Feifei Wang <wangfeifei40@huawei.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 Anatoly Burakov <anatoly.burakov@intel.com>, stable@dpdk.org
Subject: [PATCH 27/27] net/hinic3: add pseudo-header checksum calculation
Date: Mon, 19 Oct 2026 23:19:29 +0800
Message-ID: <20261019151930.1572-28-yejiacheng4@h-partners.com>
X-Mailer: git-send-email 2.53.0.windows.2
In-Reply-To: <20261019151930.1572-1-yejiacheng4@h-partners.com>
References: <20261014150923.838-1-yejiacheng4@h-partners.com>
 <20261019151930.1572-1-yejiacheng4@h-partners.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Ac8vCgCXK5cUNdZqqgUkBA--.15723S29
X-Coremail-Antispam: 1Uf129KBjvAXoW3tw4rKF4rCrW8XF1ktF1DWrg_yoW8Jr4kuo
 WSqr4fZr1Iqr1rJry8KryqvFZ0qws8t3yYkws0gw17tayfZr1jkwnxG3yfAayUXw1DAFsF
 va4IqF9ayrW7Jwsrn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
 AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU2GNtUUUUU
Sender: wff_light@vip.163.com
X-CM-SenderInfo: pziiszhljk3qxylshiywtou0bp/1tbiMwOlr2rWNSPMmgAA3G
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_ZEN_BLOCKED_OPENDNS,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

SP620/SP560 hardware requires the driver to precompute the L4
pseudo-header checksum for TCP/UDP checksum and TSO offload; without it
the offloaded checksum is wrong. Compute the inner/outer pseudo-header
checksum in the Tx prepare path, deriving the L4 protocol from the
offload flags, and fail mbufs that are shared or indirect instead of
sending them with an incorrect checksum.

Fixes: 7608f0367d5a ("net/hinic3: add basic ethdev operations")
Cc: stable@dpdk.org

Signed-off-by: Jiacheng Ye <yejiacheng4@h-partners.com>
---
 drivers/net/hinic3/hinic3_ethdev.c |   1 +
 drivers/net/hinic3/hinic3_ethdev.h |   1 +
 drivers/net/hinic3/hinic3_tx.c     | 226 ++++++++++++++++++++++++++++-
 drivers/net/hinic3/hinic3_tx.h     |   1 +
 4 files changed, 221 insertions(+), 8 deletions(-)

diff --git a/drivers/net/hinic3/hinic3_ethdev.c b/drivers/net/hinic3/hinic3_ethdev.c
index 310eed6a0c..a10707fba9 100644
--- a/drivers/net/hinic3/hinic3_ethdev.c
+++ b/drivers/net/hinic3/hinic3_ethdev.c
@@ -817,6 +817,7 @@ hinic3_dev_infos_get(struct rte_eth_dev *dev, struct rte_eth_dev_info *info)
 		RTE_ETH_TX_OFFLOAD_UDP_CKSUM | RTE_ETH_TX_OFFLOAD_TCP_CKSUM |
 		RTE_ETH_TX_OFFLOAD_SCTP_CKSUM |
 		RTE_ETH_TX_OFFLOAD_OUTER_IPV4_CKSUM |
+		RTE_ETH_TX_OFFLOAD_OUTER_UDP_CKSUM |
 		RTE_ETH_TX_OFFLOAD_TCP_TSO | RTE_ETH_TX_OFFLOAD_MULTI_SEGS;
 
 	hinic3_dev_tnl_tso_support(info, nic_dev);
diff --git a/drivers/net/hinic3/hinic3_ethdev.h b/drivers/net/hinic3/hinic3_ethdev.h
index 21abea0668..f4533ae417 100644
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
index 02d8802c0b..694d9487c6 100644
--- a/drivers/net/hinic3/hinic3_tx.c
+++ b/drivers/net/hinic3/hinic3_tx.c
@@ -365,6 +365,59 @@ hinic3_tx_done_cleanup(void *txq, uint32_t free_cnt)
 	return hinic3_xmit_mbuf_cleanup(tx_queue, try_free_cnt);
 }
 
+static uint8_t
+hinic3_tx_l4_proto(uint64_t ol_flags)
+{
+	if (ol_flags & (HINIC3_PKT_TX_TCP_CKSUM | HINIC3_PKT_TX_TCP_SEG))
+		return IPPROTO_TCP;
+
+	return IPPROTO_UDP;
+}
+
+/*
+ * Walk the IPv6 extension headers to obtain the real L3 length (including
+ * extension headers) and the final upper-layer protocol number.
+ */
+static uint16_t
+hinic3_get_ipv6_len_proto(const struct rte_ipv6_hdr *ipv6_hdr, uint8_t *proto)
+{
+	const uint8_t *p = (const uint8_t *)(ipv6_hdr + 1);
+	uint16_t l3_len = sizeof(*ipv6_hdr);
+	int next_proto;
+	size_t ext_len;
+
+	*proto = ipv6_hdr->proto;
+	while ((next_proto = rte_ipv6_get_next_ext(p, *proto, &ext_len)) >= 0) {
+		*proto = (uint8_t)next_proto;
+		p += ext_len;
+		l3_len += ext_len;
+	}
+
+	return l3_len;
+}
+
+static uint16_t
+hinic3_ipv6_phdr_cksum(const struct rte_ipv6_hdr *ipv6_hdr, uint16_t l3_len,
+		       uint8_t proto, uint64_t ol_flags)
+{
+	uint32_t sum;
+	rte_be32_t l4_len;
+	rte_be32_t l4_proto;
+
+	l4_proto = (uint32_t)proto << 24;
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
@@ -377,9 +430,108 @@ hinic3_tx_done_cleanup(void *txq, uint32_t free_cnt)
  * @return
  * 0 as success, -EINVAL as failure.
  */
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
+{
+	uint64_t ol_flags = mbuf->ol_flags;
+	struct rte_tcp_hdr *tcp_hdr;
+	struct rte_udp_hdr *udp_hdr;
+	struct rte_ipv6_hdr *ipv6_hdr;
+	uint16_t l3_len = mbuf->l3_len;
+	uint8_t l4_proto = hinic3_tx_l4_proto(ol_flags);
+	uint16_t l4_offset;
+
+	if (ol_flags & HINIC3_PKT_TX_IPV6) {
+		ipv6_hdr = rte_pktmbuf_mtod_offset(mbuf, struct rte_ipv6_hdr *,
+						   inner_l3_offset);
+		l3_len = hinic3_get_ipv6_len_proto(ipv6_hdr, &l4_proto);
+	}
+
+	l4_offset = inner_l3_offset + l3_len;
+
+	switch (ol_flags & HINIC3_PKT_TX_L4_MASK) {
+	case HINIC3_PKT_TX_UDP_CKSUM:
+		udp_hdr = rte_pktmbuf_mtod_offset(mbuf, struct rte_udp_hdr *, l4_offset);
+		udp_hdr->dgram_cksum = hinic3_calculate_l4_cksum(mbuf, inner_l3_offset,
+							l3_len, l4_proto);
+		break;
+	case HINIC3_PKT_TX_TCP_CKSUM:
+		tcp_hdr = rte_pktmbuf_mtod_offset(mbuf, struct rte_tcp_hdr *, l4_offset);
+		tcp_hdr->cksum = hinic3_calculate_l4_cksum(mbuf, inner_l3_offset,
+							 l3_len, l4_proto);
+		break;
+	case HINIC3_PKT_TX_SCTP_CKSUM:
+		/* Sctp csum no need to calculate pseudo-header */
+		break;
+	default:
+		if (ol_flags & HINIC3_PKT_TX_TCP_SEG) {
+			tcp_hdr = rte_pktmbuf_mtod_offset(mbuf, struct rte_tcp_hdr *, l4_offset);
+			tcp_hdr->cksum = hinic3_calculate_l4_cksum(mbuf, inner_l3_offset,
+								 l3_len, l4_proto);
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
 
@@ -388,7 +540,7 @@ hinic3_tx_offload_pkt_prepare(struct hinic3_nic_dev *nic_dev, struct rte_mbuf *m
 				HINIC3_SUPPORT_VXLAN_OFFLOAD(nic_dev)) ||
 		      ((ol_flags & HINIC3_PKT_TX_TUNNEL_GENEVE) &&
 				HINIC3_SUPPORT_GENEVE_OFFLOAD(nic_dev)) ||
-		      ((ol_flags & HINIC3_PKT_TX_TUNNEL_IPIP) &&
+		      (((ol_flags & HINIC3_PKT_TX_TUNNEL_IPIP) == HINIC3_PKT_TX_TUNNEL_IPIP) &&
 				HINIC3_SUPPORT_IPXIP_OFFLOAD(nic_dev))))
 			return -EINVAL;
 	}
@@ -399,12 +551,27 @@ hinic3_tx_offload_pkt_prepare(struct hinic3_nic_dev *nic_dev, struct rte_mbuf *m
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
@@ -423,6 +590,49 @@ hinic3_tx_offload_pkt_prepare(struct hinic3_nic_dev *nic_dev, struct rte_mbuf *m
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
+			 * packet's L3/L4 header, which would corrupt data still
+			 * referenced by another consumer for a shared or indirect
+			 * mbuf, so fail those packets instead.
+			 */
+			if (unlikely(rte_mbuf_refcnt_read(mbuf) > 1 || RTE_MBUF_CLONED(mbuf))) {
+				rte_errno = EINVAL;
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
 static inline void hinic3_set_vlan_tx_offload(struct hinic3_sq_task *task,
 					      uint16_t vlan_tag, uint8_t vlan_type)
 {
@@ -785,7 +995,7 @@ hinic3_get_tx_offload(struct hinic3_nic_dev *nic_dev, struct rte_mbuf *mbuf,
 	}
 
 	wqe_info->offload = 1;
-	err = hinic3_tx_offload_pkt_prepare(nic_dev, mbuf, &inner_l3_offset);
+	err = hinic3_get_inner_l3_offset(nic_dev, mbuf, &inner_l3_offset);
 	if (err)
 		return err;
 
diff --git a/drivers/net/hinic3/hinic3_tx.h b/drivers/net/hinic3/hinic3_tx.h
index d66b6031c7..da89ab7983 100644
--- a/drivers/net/hinic3/hinic3_tx.h
+++ b/drivers/net/hinic3/hinic3_tx.h
@@ -392,6 +392,7 @@ void hinic3_free_txq_mbufs(struct hinic3_txq *txq);
 void hinic3_free_all_txq_mbufs(struct hinic3_nic_dev *nic_dev);
 uint16_t hinic3_xmit_pkts_compact_cqe(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts);
 uint16_t hinic3_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts);
+uint16_t hinic3_prep_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts);
 int hinic3_stop_sq(struct hinic3_txq *txq);
 int hinic3_start_all_sqs(struct rte_eth_dev *eth_dev);
 int hinic3_tx_done_cleanup(void *txq, uint32_t free_cnt);
-- 
2.33.0

