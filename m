Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C851CA9EBE
	for <dpdk-dev@archiver.kernel.org>; Sat, 10 Oct 2026 14:46:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8183740B8C;
	Sat, 10 Oct 2026 16:45:30 +0200 (CEST)
Received: from mail-m16.vip.163.com (mail-m16.vip.163.com [220.197.30.221])
 by mails.dpdk.org (Postfix) with ESMTP id 3FC5E4066C
 for <dev@dpdk.org>; Sat, 10 Oct 2026 16:45:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vip.163.com; s=s110527; h=From:To:Subject:Date:Message-ID:
 MIME-Version; bh=THG3rOdTGHcz+mlTk6Vv6ekN5D/TFHXjuYmCEuVL468=;
 b=gccvRyaJJxxnGK1ewC6X8e+jtMCQ9UPV0r9vrQdWj8e3uDUPU0au5XyMJCEBqy
 vA5aU2Gzh4VRFMeRlIOqWeE0d6Wsv2zajK//Du2cqlsHFnS+uJFdxTSLGu885g6X
 ZzIzrpuuSRQ2GypvBmiCySk9BeQ8dX2QohWEZbWUVdvIU=
From: Jiacheng Ye <yejiacheng4@h-partners.com>
To: dev@dpdk.org
Cc: Feifei Wang <wangfeifei40@huawei.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v1 15/17] net/hinic3: add pseudo-header checksum calculation
Date: Sat, 10 Oct 2026 22:45:06 +0800
Message-ID: <20261010144509.2731-16-yejiacheng4@h-partners.com>
X-Mailer: git-send-email 2.53.0.windows.2
In-Reply-To: <20261010144509.2731-1-yejiacheng4@h-partners.com>
References: <20261010144509.2731-1-yejiacheng4@h-partners.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-CM-TRANSID: As8vCgDX70B4T8pqMdk9Aw--.440S17
X-Coremail-Antispam: 1Uf129KBjvJXoW3uw13CF4kGryUWw4fGr45Wrg_yoWDKFW3pF
 W5GayxJF4DJrWUXrs5Wwn3u3s8J3s0gr92k3s5K3WY9Fy3Jr97Ja40gFW29r15tw47A3ZF
 vF98Za1vgF1UKFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UMGQgUUUUU=
Sender: wff_light@vip.163.com
X-CM-SenderInfo: pziiszhljk3qxylshiywtou0bp/1tbiNx9ASmrKT38xigAA3J
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

Hardware checksum offload needs the pseudo-header checksum precomputed by=0D
the driver. Compute the inner/outer pseudo-header checksums, including=0D
walking IPv6 extension headers, in the Tx prepare path.=0D
=0D
Signed-off-by: Jiacheng Ye <yejiacheng4@h-partners.com>=0D
---=0D
 drivers/net/hinic3/hinic3_ethdev.c |   1 +=0D
 drivers/net/hinic3/hinic3_ethdev.h |   1 +=0D
 drivers/net/hinic3/hinic3_tx.c     | 179 ++++++++++++++++++++++++++++-=0D
 drivers/net/hinic3/hinic3_tx.h     |  11 ++=0D
 4 files changed, 186 insertions(+), 6 deletions(-)=0D
=0D
diff --git a/drivers/net/hinic3/hinic3_ethdev.c b/drivers/net/hinic3/hinic3=
_ethdev.c=0D
index ffbd080ede..0f7a653594 100644=0D
--- a/drivers/net/hinic3/hinic3_ethdev.c=0D
+++ b/drivers/net/hinic3/hinic3_ethdev.c=0D
@@ -871,6 +871,7 @@ hinic3_dev_infos_get(struct rte_eth_dev *dev, struct rt=
e_eth_dev_info *info)=0D
 				RTE_ETH_TX_OFFLOAD_TCP_CKSUM |=0D
 				RTE_ETH_TX_OFFLOAD_SCTP_CKSUM |=0D
 				RTE_ETH_TX_OFFLOAD_OUTER_IPV4_CKSUM |=0D
+				RTE_ETH_TX_OFFLOAD_OUTER_UDP_CKSUM |=0D
 				RTE_ETH_TX_OFFLOAD_VXLAN_TNL_TSO |=0D
 				RTE_ETH_TX_OFFLOAD_TCP_TSO |=0D
 				RTE_ETH_TX_OFFLOAD_MULTI_SEGS |=0D
diff --git a/drivers/net/hinic3/hinic3_ethdev.h b/drivers/net/hinic3/hinic3=
_ethdev.h=0D
index 399c9c9342..1afd7cd77a 100644=0D
--- a/drivers/net/hinic3/hinic3_ethdev.h=0D
+++ b/drivers/net/hinic3/hinic3_ethdev.h=0D
@@ -49,6 +49,7 @@=0D
 #define HINIC3_PKT_TX_OUTER_IP_CKSUM	RTE_MBUF_F_TX_OUTER_IP_CKSUM=0D
 #define HINIC3_PKT_TX_OUTER_UDP_CKSUM	RTE_MBUF_F_TX_OUTER_UDP_CKSUM=0D
 #define HINIC3_PKT_TX_OUTER_IPV6	RTE_MBUF_F_TX_OUTER_IPV6=0D
+#define HINIC3_PKT_TX_OUTER_IPV4	RTE_MBUF_F_TX_OUTER_IPV4=0D
 #define HINIC3_PKT_RX_LRO		RTE_MBUF_F_RX_LRO=0D
 #define HINIC3_PKT_TX_L4_NO_CKSUM	RTE_MBUF_F_TX_L4_NO_CKSUM=0D
 =0D
diff --git a/drivers/net/hinic3/hinic3_tx.c b/drivers/net/hinic3/hinic3_tx.=
c=0D
index c3f053f869..bf79b1bd28 100644=0D
--- a/drivers/net/hinic3/hinic3_tx.c=0D
+++ b/drivers/net/hinic3/hinic3_tx.c=0D
@@ -31,7 +31,7 @@=0D
 	(HINIC3_PKT_TX_IP_CKSUM | HINIC3_PKT_TX_TCP_CKSUM |   \=0D
 	 HINIC3_PKT_TX_UDP_CKSUM | HINIC3_PKT_TX_SCTP_CKSUM | \=0D
 	 HINIC3_PKT_TX_OUTER_IP_CKSUM | HINIC3_PKT_TX_OUTER_UDP_CKSUM | \=0D
-	 HINIC3_PKT_TX_TCP_SEG)=0D
+	 HINIC3_PKT_TX_TCP_SEG | HINIC3_PKT_TX_IPV6)=0D
 =0D
 static inline uint16_t=0D
 hinic3_get_sq_free_wqebbs(struct hinic3_txq *sq)=0D
@@ -366,6 +366,68 @@ hinic3_tx_done_cleanup(void *txq, uint32_t free_cnt)=0D
 	return hinic3_xmit_mbuf_cleanup(tx_queue, try_free_cnt);=0D
 }=0D
 =0D
+static void hinic3_get_ipv6_len_proto(const void *hdr, uint16_t *hdr_len, =
uint8_t *proto)=0D
+{=0D
+	const struct hinic3_ipv6_ext_hdr *xh =3D NULL;=0D
+	uint8_t i;=0D
+=0D
+	*proto =3D ((const struct rte_ipv6_hdr *)hdr)->proto;=0D
+	*hdr_len =3D sizeof(struct rte_ipv6_hdr);=0D
+=0D
+	/*=0D
+	 * Consistent with ucode's IPV6_MAX_EXT_HDRS,=0D
+	 * maximum parsing up to IPV6_MAX_EXT_HDRS layer.=0D
+	 */=0D
+	for (i =3D 0; i < IPV6_MAX_EXT_HDRS; i++) {=0D
+		xh =3D (const struct hinic3_ipv6_ext_hdr *)((const uint8_t *)hdr + *hdr_=
len);=0D
+		switch (*proto) {=0D
+		case IPPROTO_HOPOPTS:=0D
+		case IPPROTO_ROUTING:=0D
+		case IPPROTO_DSTOPTS:=0D
+			/* hdr len is a multiple of 8, excluding the first 8 bytes */=0D
+			*hdr_len +=3D FIXED_EXT_HDR_LEN + xh->len * UNIT_BYTES_U;=0D
+			*proto =3D xh->next_hdr;=0D
+			break;=0D
+		case IPPROTO_AH:=0D
+			/* hdr len is a multiple of 4, excluding the first 8 bytes */=0D
+			*hdr_len +=3D FIXED_EXT_HDR_LEN + xh->len * UNIT_BYTES_AH;=0D
+			*proto =3D xh->next_hdr;=0D
+			break;=0D
+		case IPPROTO_FRAGMENT:=0D
+			/* hdr len is fixed 8 bytes */=0D
+			*hdr_len +=3D FIXED_EXT_HDR_LEN;=0D
+			*proto =3D xh->next_hdr;=0D
+			break;=0D
+		default:=0D
+			break;=0D
+		}=0D
+	}=0D
+}=0D
+=0D
+static uint16_t=0D
+hinic3_ipv6_phdr_cksum(const struct rte_ipv6_hdr *ipv6_hdr, uint64_t ol_fl=
ags)=0D
+{=0D
+	uint32_t   sum;=0D
+	uint8_t	   proto;=0D
+	uint16_t   l3_len;=0D
+	rte_be32_t l4_len;=0D
+	rte_be32_t l4_proto;=0D
+=0D
+	hinic3_get_ipv6_len_proto((const void *)ipv6_hdr, &l3_len, &proto);=0D
+	l4_proto =3D rte_cpu_to_be_16(proto);=0D
+	if (ol_flags & HINIC3_PKT_TX_TCP_SEG)=0D
+		l4_len =3D 0;=0D
+	else=0D
+		l4_len =3D rte_cpu_to_be_16(rte_be_to_cpu_16(ipv6_hdr->payload_len) -=0D
+							   l3_len + sizeof(*ipv6_hdr));=0D
+=0D
+	sum =3D __rte_raw_cksum(ipv6_hdr->src_addr.a,=0D
+			      sizeof(ipv6_hdr->src_addr.a) + sizeof(ipv6_hdr->dst_addr.a), 0);=
=0D
+	sum =3D __rte_raw_cksum(&l4_len, sizeof(l4_len), sum);=0D
+	sum =3D __rte_raw_cksum(&l4_proto, sizeof(l4_proto), sum);=0D
+=0D
+	return __rte_raw_cksum_reduce(sum);=0D
+}=0D
 /**=0D
  * Prepare the data packet to be sent and calculate the internal L3 offset=
.=0D
  *=0D
@@ -378,6 +440,90 @@ hinic3_tx_done_cleanup(void *txq, uint32_t free_cnt)=0D
  * @return=0D
  * 0 as success, -EINVAL as failure.=0D
  */=0D
+static inline uint16_t=0D
+hinic3_calculate_l4_cksum(struct rte_mbuf *mbuf, uint16_t inner_l3_offset)=
=0D
+{=0D
+	struct rte_ipv4_hdr *ipv4_hdr;=0D
+	struct rte_ipv6_hdr *ipv6_hdr;=0D
+	uint64_t ol_flags =3D mbuf->ol_flags;=0D
+=0D
+	if (ol_flags & HINIC3_PKT_TX_IPV4) {=0D
+		ipv4_hdr =3D rte_pktmbuf_mtod_offset(mbuf, struct rte_ipv4_hdr *,=0D
+						   inner_l3_offset);=0D
+=0D
+		if (ol_flags & HINIC3_PKT_TX_IP_CKSUM)=0D
+			ipv4_hdr->hdr_checksum =3D 0;=0D
+=0D
+		return rte_ipv4_phdr_cksum(ipv4_hdr, ol_flags);=0D
+	}=0D
+=0D
+	ipv6_hdr =3D rte_pktmbuf_mtod_offset(mbuf, struct rte_ipv6_hdr *,=0D
+					   inner_l3_offset);=0D
+=0D
+	return hinic3_ipv6_phdr_cksum(ipv6_hdr, ol_flags);=0D
+}=0D
+=0D
+static inline void hinic3_calculate_outer_udp_checksum(struct rte_mbuf *mb=
uf,=0D
+						       uint16_t outer_l3_offset)=0D
+{=0D
+	struct rte_ipv4_hdr *ipv4_hdr;=0D
+	struct rte_ipv6_hdr *ipv6_hdr;=0D
+	struct rte_udp_hdr *udp_hdr;=0D
+	uint64_t ol_flags =3D mbuf->ol_flags;=0D
+=0D
+	if (ol_flags & HINIC3_PKT_TX_OUTER_IPV4) {=0D
+		ipv4_hdr =3D rte_pktmbuf_mtod_offset(mbuf, struct rte_ipv4_hdr *, outer_=
l3_offset);=0D
+		if (ol_flags & HINIC3_PKT_TX_OUTER_IP_CKSUM)=0D
+			ipv4_hdr->hdr_checksum =3D 0;=0D
+		udp_hdr =3D (struct rte_udp_hdr *)((char *)ipv4_hdr + mbuf->outer_l3_len=
);=0D
+		if (udp_hdr->dgram_cksum !=3D 0x0)=0D
+			udp_hdr->dgram_cksum =3D rte_ipv4_phdr_cksum(ipv4_hdr, ol_flags);=0D
+	} else if (ol_flags & HINIC3_PKT_TX_OUTER_IPV6) {=0D
+		ipv6_hdr =3D rte_pktmbuf_mtod_offset(mbuf, struct rte_ipv6_hdr *, outer_=
l3_offset);=0D
+		udp_hdr =3D rte_pktmbuf_mtod_offset(mbuf, struct rte_udp_hdr *,=0D
+						  (outer_l3_offset + mbuf->outer_l3_len));=0D
+		udp_hdr->dgram_cksum =3D hinic3_ipv6_phdr_cksum(ipv6_hdr, ol_flags);=0D
+	}=0D
+}=0D
+=0D
+static inline void hinic3_calculate_outer_phdr_checksum(struct rte_mbuf *m=
buf,=0D
+							uint16_t outer_l3_offset)=0D
+{=0D
+	uint64_t ol_flags =3D mbuf->ol_flags;=0D
+=0D
+	if (ol_flags & HINIC3_PKT_TX_OUTER_UDP_CKSUM)=0D
+		hinic3_calculate_outer_udp_checksum(mbuf, outer_l3_offset);=0D
+}=0D
+=0D
+static inline void hinic3_calculate_phdr_checksum(struct rte_mbuf *mbuf,=0D
+						  uint16_t inner_l3_offset)=0D
+{=0D
+	uint64_t ol_flags =3D mbuf->ol_flags;=0D
+	struct rte_tcp_hdr *tcp_hdr;=0D
+	struct rte_udp_hdr *udp_hdr;=0D
+	uint16_t l4_offset =3D inner_l3_offset + mbuf->l3_len;=0D
+=0D
+	switch (ol_flags & HINIC3_PKT_TX_L4_MASK) {=0D
+	case HINIC3_PKT_TX_UDP_CKSUM:=0D
+		udp_hdr =3D rte_pktmbuf_mtod_offset(mbuf, struct rte_udp_hdr *, l4_offse=
t);=0D
+		udp_hdr->dgram_cksum =3D hinic3_calculate_l4_cksum(mbuf, inner_l3_offset=
);=0D
+		break;=0D
+	case HINIC3_PKT_TX_TCP_CKSUM:=0D
+		tcp_hdr =3D rte_pktmbuf_mtod_offset(mbuf, struct rte_tcp_hdr *, l4_offse=
t);=0D
+		tcp_hdr->cksum =3D hinic3_calculate_l4_cksum(mbuf, inner_l3_offset);=0D
+		break;=0D
+	case HINIC3_PKT_TX_SCTP_CKSUM:=0D
+		/* Sctp csum no need to calculate pseudo-header */=0D
+		break;=0D
+	default:=0D
+		if (ol_flags & HINIC3_PKT_TX_TCP_SEG) {=0D
+			tcp_hdr =3D rte_pktmbuf_mtod_offset(mbuf, struct rte_tcp_hdr *, l4_offs=
et);=0D
+			tcp_hdr->cksum =3D hinic3_calculate_l4_cksum(mbuf, inner_l3_offset);=0D
+		}=0D
+		break;=0D
+	}=0D
+}=0D
+=0D
 static int=0D
 hinic3_tx_offload_pkt_prepare(struct hinic3_nic_dev *nic_dev, struct rte_m=
buf *mbuf,=0D
 			      uint16_t *inner_l3_offset)=0D
@@ -389,7 +535,7 @@ hinic3_tx_offload_pkt_prepare(struct hinic3_nic_dev *ni=
c_dev, struct rte_mbuf *m=0D
 				HINIC3_SUPPORT_VXLAN_OFFLOAD(nic_dev)) ||=0D
 		      ((ol_flags & HINIC3_PKT_TX_TUNNEL_GENEVE) &&=0D
 				HINIC3_SUPPORT_GENEVE_OFFLOAD(nic_dev)) ||=0D
-		      ((ol_flags & HINIC3_PKT_TX_TUNNEL_IPIP) &&=0D
+		      (((ol_flags & HINIC3_PKT_TX_TUNNEL_IPIP) =3D=3D HINIC3_PKT_TX_TUNN=
EL_IPIP) &&=0D
 				HINIC3_SUPPORT_IPXIP_OFFLOAD(nic_dev))))=0D
 			return -EINVAL;=0D
 	}=0D
@@ -400,15 +546,33 @@ hinic3_tx_offload_pkt_prepare(struct hinic3_nic_dev *=
nic_dev, struct rte_mbuf *m=0D
 #endif=0D
 	/* Support tunnel. */=0D
 	if ((ol_flags & HINIC3_PKT_TX_TUNNEL_MASK)) {=0D
-		if ((ol_flags & HINIC3_PKT_TX_OUTER_IP_CKSUM) ||=0D
-		    (ol_flags & HINIC3_PKT_TX_OUTER_IPV6) ||=0D
-		    (ol_flags & HINIC3_PKT_TX_TCP_SEG)) {=0D
+		/*=0D
+		 * For IPv6-in-IPv6 packets, ol_flags cannot be used to determine=0D
+		 * whether the delivered port offload value contains UDP and IP=0D
+		 * hardware offload flags, so it is impossible to determine how=0D
+		 * l2_len is populated. Here, the property that l2_len is 0 for=0D
+		 * IP-in-IP is used to distinguish population modes. If=0D
+		 * mbuf->l2_len =3D=3D 0, the upper layer has enabled UDP and IP=0D
+		 * hardware offload flags; the inner L3 offset is then=0D
+		 * outer_l2_len + outer_l3_len.=0D
+		 */=0D
+		if ((ol_flags & HINIC3_PKT_TX_TUNNEL_IPIP) =3D=3D HINIC3_PKT_TX_TUNNEL_I=
PIP) {=0D
+			if (mbuf->l2_len =3D=3D 0)=0D
+				*inner_l3_offset =3D mbuf->outer_l2_len + mbuf->outer_l3_len;=0D
+			else=0D
+				*inner_l3_offset =3D mbuf->l2_len;=0D
+		} else if ((ol_flags & HINIC3_PKT_TX_OUTER_IP_CKSUM) ||=0D
+			  (ol_flags & HINIC3_PKT_TX_OUTER_UDP_CKSUM) ||=0D
+			  (ol_flags & HINIC3_PKT_TX_TCP_SEG)) {=0D
 			/*=0D
 			 * For this senmatic, l2_len of mbuf means=0D
-			 * len(out_udp + vxlan + in_eth).=0D
+			 * len(out_udp + vxlan/geneve + in_eth).=0D
 			 */=0D
 			*inner_l3_offset =3D mbuf->l2_len + mbuf->outer_l2_len +=0D
 					   mbuf->outer_l3_len;=0D
+			if (!HINIC3_IS_SP230_NIC(nic_dev))=0D
+				/* Process the outer UDP pseudo-header checksum */=0D
+				hinic3_calculate_outer_phdr_checksum(mbuf, mbuf->outer_l2_len);=0D
 		} else {=0D
 			/*=0D
 			 * For this senmatic, l2_len of mbuf means=0D
@@ -420,6 +584,9 @@ hinic3_tx_offload_pkt_prepare(struct hinic3_nic_dev *ni=
c_dev, struct rte_mbuf *m=0D
 		/* For non-tunnel type pkts. */=0D
 		*inner_l3_offset =3D mbuf->l2_len;=0D
 	}=0D
+	if (!HINIC3_IS_SP230_NIC(nic_dev))=0D
+		/* Process the pseudo-header checksum */=0D
+		hinic3_calculate_phdr_checksum(mbuf, *inner_l3_offset);=0D
 =0D
 	return 0;=0D
 }=0D
diff --git a/drivers/net/hinic3/hinic3_tx.h b/drivers/net/hinic3/hinic3_tx.=
h=0D
index 10ea174ea2..2fafb400b5 100644=0D
--- a/drivers/net/hinic3/hinic3_tx.h=0D
+++ b/drivers/net/hinic3/hinic3_tx.h=0D
@@ -408,6 +408,17 @@ struct __rte_cache_aligned hinic3_txq {=0D
 	uint64_t prof_tx_end_tsc;=0D
 #endif=0D
 };=0D
+#define IPV4_VERSION 4=0D
+#define IPV6_VERSION 6=0D
+#define FIXED_EXT_HDR_LEN  8=0D
+#define UNIT_BYTES_U  8=0D
+#define UNIT_BYTES_AH  4=0D
+#define IPV6_MAX_EXT_HDRS 9=0D
+=0D
+struct hinic3_ipv6_ext_hdr {=0D
+	uint8_t next_hdr;=0D
+	uint8_t len;=0D
+};=0D
 =0D
 void hinic3_flush_txqs(struct hinic3_nic_dev *nic_dev);=0D
 void hinic3_free_txq_mbufs(struct hinic3_txq *txq);=0D
-- =0D
2.33.0=0D
=0D

