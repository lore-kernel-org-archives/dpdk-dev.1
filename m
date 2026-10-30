Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D24B606A31C
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 Oct 2026 14:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=vip.163.com header.i=@vip.163.com header.a=rsa-sha256 header.s=s110527 header.b=gvfonZJS
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A135C40DF5;
	Fri, 30 Oct 2026 15:48:04 +0100 (CET)
Received: from mail-m16.vip.163.com (mail-m16.vip.163.com [220.197.30.223])
 by mails.dpdk.org (Postfix) with ESMTPS id D0F3D40285;
 Fri, 30 Oct 2026 15:47:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vip.163.com; s=s110527; h=From:To:Subject:Date:Message-ID:
 MIME-Version; bh=V8OkIW4qbhmeQAWz07wdLZw5xeo7aCQpzHPBXLl2xUw=;
 b=gvfonZJSygeLw12c7ESuXo+zTYrFwKPXNVKbbX3chC5oiv8T5PKjVJw7KHYnxy
 U00GzmummOv9cxo0DqAJ9MxSdxxKS51pW6gsZDcKdWFZorYsJrvKDhmzySgxmoDL
 fvUjdo/LiWNamKxG+5N3pOEUtMXAeMOpzFBL3Lz78zp3c=
From: Jiacheng Ye <yejiacheng4@h-partners.com>
To: dev@dpdk.org
Cc: Feifei Wang <wangfeifei40@huawei.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 Anatoly Burakov <anatoly.burakov@intel.com>, stable@dpdk.org
Subject: [PATCH v5 09/28] net/hinic3: fix pseudo-header checksum calculation
Date: Fri, 30 Oct 2026 22:47:13 +0800
Message-ID: <20261030144733.2120-10-yejiacheng4@h-partners.com>
X-Mailer: git-send-email 2.53.0.windows.2
In-Reply-To: <20261030144733.2120-1-yejiacheng4@h-partners.com>
References: <20261023155809.855-1-yejiacheng4@h-partners.com>
 <20261030144733.2120-1-yejiacheng4@h-partners.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: As8vCgDHb_EUruRqpJ41BA--.59781S11
X-Coremail-Antispam: 1Uf129KBjvJXoW3tw4rKF4rKF17WF4kuw15Arb_yoWkCrWUpF
 Z8GFWfJFs8JrW8Xrs5Wwsxu3s0q34DWr97K3s5K3Z09Fy3Jrn7ta40qFW29r15tw47AFnF
 vFn8Aa9rWF1UKFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jewZcUUUUU=
Sender: wff_light@vip.163.com
X-CM-SenderInfo: pziiszhljk3qxylshiywtou0bp/1tbiNRmFj2rkrhlghgAA35
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

SP620 hardware requires the driver to precompute the L4
pseudo-header checksum for TCP/UDP checksum and TSO offload; without it
the offloaded checksum is wrong. Compute the inner/outer pseudo-header
checksum in the Tx prepare path, deriving the L4 protocol from the
offload flags, and fail mbufs that are shared or indirect instead of
sending them with an incorrect checksum.

Fixes: 7608f0367d5a ("net/hinic3: add basic ethdev operations")
Cc: stable@dpdk.org

Signed-off-by: Jiacheng Ye <yejiacheng4@h-partners.com>
---
 drivers/net/hinic3/hinic3_ethdev.c |   2 +
 drivers/net/hinic3/hinic3_ethdev.h |   1 +
 drivers/net/hinic3/hinic3_tx.c     | 188 +++++++++++++++++++++++++++--
 drivers/net/hinic3/hinic3_tx.h     |   1 +
 4 files changed, 184 insertions(+), 8 deletions(-)

diff --git a/drivers/net/hinic3/hinic3_ethdev.c b/drivers/net/hinic3/hinic3_ethdev.c
index 69b7a23d6a..2400adfb81 100644
--- a/drivers/net/hinic3/hinic3_ethdev.c
+++ b/drivers/net/hinic3/hinic3_ethdev.c
@@ -713,6 +713,7 @@ hinic3_dev_infos_get(struct rte_eth_dev *dev, struct rte_eth_dev_info *info)
 		RTE_ETH_TX_OFFLOAD_UDP_CKSUM | RTE_ETH_TX_OFFLOAD_TCP_CKSUM |
 		RTE_ETH_TX_OFFLOAD_SCTP_CKSUM |
 		RTE_ETH_TX_OFFLOAD_OUTER_IPV4_CKSUM |
+		RTE_ETH_TX_OFFLOAD_OUTER_UDP_CKSUM |
 		RTE_ETH_TX_OFFLOAD_TCP_TSO | RTE_ETH_TX_OFFLOAD_MULTI_SEGS;
 	if (nic_dev->feature_cap & NIC_F_HTN_CMDQ)
 		hinic3_dev_tnl_tso_support(info, nic_dev);
@@ -3670,6 +3671,7 @@ hinic3_dev_init(struct rte_eth_dev *eth_dev)
 
 	eth_dev->rx_pkt_burst = hinic3_recv_pkts;
 	eth_dev->tx_pkt_burst = hinic3_xmit_pkts;
+	eth_dev->tx_pkt_prepare = hinic3_prep_pkts;
 
 	return hinic3_func_init(eth_dev);
 }
diff --git a/drivers/net/hinic3/hinic3_ethdev.h b/drivers/net/hinic3/hinic3_ethdev.h
index c46fcfcbec..8bbab2ad53 100644
--- a/drivers/net/hinic3/hinic3_ethdev.h
+++ b/drivers/net/hinic3/hinic3_ethdev.h
@@ -41,6 +41,7 @@
 #define HINIC3_PKT_TX_OUTER_IP_CKSUM	RTE_MBUF_F_TX_OUTER_IP_CKSUM
 #define HINIC3_PKT_TX_OUTER_UDP_CKSUM	RTE_MBUF_F_TX_OUTER_UDP_CKSUM
 #define HINIC3_PKT_TX_OUTER_IPV6	RTE_MBUF_F_TX_OUTER_IPV6
+#define HINIC3_PKT_TX_OUTER_IPV4	RTE_MBUF_F_TX_OUTER_IPV4
 #define HINIC3_PKT_RX_LRO		RTE_MBUF_F_RX_LRO
 #define HINIC3_PKT_TX_L4_NO_CKSUM	RTE_MBUF_F_TX_L4_NO_CKSUM
 
diff --git a/drivers/net/hinic3/hinic3_tx.c b/drivers/net/hinic3/hinic3_tx.c
index 6b2bffb14e..a10789e0f5 100644
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
@@ -297,9 +319,100 @@ hinic3_tx_done_cleanup(void *txq, uint32_t free_cnt)
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
+
 static int
-hinic3_tx_offload_pkt_prepare(struct hinic3_nic_dev *nic_dev, struct rte_mbuf *mbuf,
-			      uint16_t *inner_l3_offset)
+hinic3_get_inner_l3_offset(struct hinic3_nic_dev *nic_dev, struct rte_mbuf *mbuf,
+			   uint16_t *inner_l3_offset)
 {
 	uint64_t ol_flags = mbuf->ol_flags;
 
@@ -308,7 +421,7 @@ hinic3_tx_offload_pkt_prepare(struct hinic3_nic_dev *nic_dev, struct rte_mbuf *m
 				HINIC3_SUPPORT_VXLAN_OFFLOAD(nic_dev)) ||
 		      ((ol_flags & HINIC3_PKT_TX_TUNNEL_GENEVE) &&
 				HINIC3_SUPPORT_GENEVE_OFFLOAD(nic_dev)) ||
-		      ((ol_flags & HINIC3_PKT_TX_TUNNEL_IPIP) &&
+		      (((ol_flags & HINIC3_PKT_TX_TUNNEL_IPIP) == HINIC3_PKT_TX_TUNNEL_IPIP) &&
 				HINIC3_SUPPORT_IPXIP_OFFLOAD(nic_dev))))
 			return -EINVAL;
 	}
@@ -319,12 +432,27 @@ hinic3_tx_offload_pkt_prepare(struct hinic3_nic_dev *nic_dev, struct rte_mbuf *m
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
+			   (ol_flags & HINIC3_PKT_TX_OUTER_UDP_CKSUM) ||
+			   (ol_flags & HINIC3_PKT_TX_TCP_SEG)) {
 			/*
 			 * For this senmatic, l2_len of mbuf means
-			 * len(out_udp + vxlan + in_eth).
+			 * len(out_udp + vxlan/geneve + in_eth).
 			 */
 			*inner_l3_offset = mbuf->l2_len + mbuf->outer_l2_len +
 					   mbuf->outer_l3_len;
@@ -343,6 +471,50 @@ hinic3_tx_offload_pkt_prepare(struct hinic3_nic_dev *nic_dev, struct rte_mbuf *m
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
 void
 hinic3_tx_set_normal_task_offload(struct hinic3_wqe_info *wqe_info,
 				  struct hinic3_sq_wqe_combo *wqe_combo)
@@ -622,7 +794,7 @@ hinic3_get_tx_offload(struct hinic3_nic_dev *nic_dev, struct rte_mbuf *mbuf,
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

