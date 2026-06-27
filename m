Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3860C43458
	for <dpdk-dev@archiver.kernel.org>; Sat, 27 Jun 2026 04:14:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4864D4066A;
	Sat, 27 Jun 2026 06:14:52 +0200 (CEST)
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
 by mails.dpdk.org (Postfix) with ESMTP id 44E8D40272
 for <dev@dpdk.org>; Sat, 27 Jun 2026 06:14:51 +0200 (CEST)
Received: from localhost.localdomain (unknown [118.112.177.181])
 by APP-05 (Coremail) with SMTP id zQCowADXI8c5Tj9qnWuGFQ--.29831S2;
 Sat, 27 Jun 2026 12:14:49 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org,
	Jie Liu <liujie5@linkdatatechnology.com>
Subject: [PATCH v10 19/23] net/sxe2: add mbuf validation in Tx debug mode
Date: Sat, 27 Jun 2026 12:14:49 +0800
Message-ID: <20260627041449.846832-1-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260626064954.361771-1-liujie5@linkdatatechnology.com>
References: <20260626064954.361771-1-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zQCowADXI8c5Tj9qnWuGFQ--.29831S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Aw18tw45WFWftry5KryfWFg_yoWxJFyxpF
 4kCrWfJr45Jr17Gwnaq3W3ZFn0g340qrW2k3s3G3yftF1xX3Wxta1xKry8Wry5Ga13Wa9a
 yrW5ZFsxG3WUZ3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUkv14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
 6r4UJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVW8JV
 W8Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
 2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJV
 W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lw4CEc2x0rVAKj4xx
 MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr
 0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAwCIc40Y0x0E
 wIxGrwCI42IY6xIIjxv20xvE14v26ryj6F1UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJV
 W8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF
 0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JU4v38UUUUU=
X-Originating-IP: [118.112.177.181]
X-CM-SenderInfo: xolxyxrhv6zxpqngt3pdwhux5qro0w31of0z/
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

From: Jie Liu <liujie5@linkdatatechnology.com>

Introduce the 'sxe2_txrx_check_mbuf' helper function to validate
outgoing mbuf tunnel type flags when RTE_ETHDEV_DEBUG_TX is enabled.
The function checks that the RTE_MBUF_F_TX_TUNNEL_x flag in mbuf
ol_flags matches the actual tunnel protocol detected in the packet
(GTP, VXLAN, VXLAN-GPE, Geneve, GRE, or IPIP).

The validation uses only UDP port matching and L4 protocol detection;
it does NOT re-derive header lengths or checksum fields already
verified by rte_validate_tx_offload() and rte_net_intel_cksum_prepare().

All code is wrapped inside RTE_ETHDEV_DEBUG_TX conditional compilation
to ensure zero overhead in production builds.

Signed-off-by: Jie Liu <liujie5@linkdatatechnology.com>
---
 drivers/net/sxe2/sxe2_txrx.c | 156 +++++++++++++++++++++++++++++++++++
 1 file changed, 156 insertions(+)

diff --git a/drivers/net/sxe2/sxe2_txrx.c b/drivers/net/sxe2/sxe2_txrx.c
index 82b2e4fb7c..79870866d1 100644
--- a/drivers/net/sxe2/sxe2_txrx.c
+++ b/drivers/net/sxe2/sxe2_txrx.c
@@ -8,6 +8,9 @@
 #include <rte_malloc.h>
 #include <rte_memzone.h>
 #include <ethdev_driver.h>
+#include <rte_geneve.h>
+#include <rte_gtp.h>
+#include <rte_vxlan.h>
 #include <unistd.h>
 #include "sxe2_txrx.h"
 #include "sxe2_txrx_common.h"
@@ -89,6 +92,152 @@ static inline int32_t sxe2_tx_mbuf_empty_check(struct rte_mbuf *mbuf)
 	return 0;
 }
 
+#ifdef RTE_ETHDEV_DEBUG_TX
+static int32_t
+sxe2_txrx_check_mbuf(struct rte_mbuf *m)
+{
+	struct rte_ether_hdr *eth_hdr;
+	struct rte_ipv4_hdr *ipv4_hdr;
+	struct rte_ipv6_hdr *ipv6_hdr;
+	struct rte_vlan_hdr *vlan_hdr;
+	void *l3_hdr;
+	uint64_t ol_flags = m->ol_flags;
+	uint64_t tunnel_type = ol_flags & RTE_MBUF_F_TX_TUNNEL_MASK;
+	uint16_t l2_len;
+	uint16_t l3_len;
+	uint8_t l4_proto;
+	uint16_t ethertype;
+
+	eth_hdr = rte_pktmbuf_mtod(m, struct rte_ether_hdr *);
+
+	/* Parse Ethernet + VLAN headers */
+	l2_len = sizeof(struct rte_ether_hdr);
+	ethertype = eth_hdr->ether_type;
+	while (ethertype == rte_cpu_to_be_16(RTE_ETHER_TYPE_VLAN) ||
+	       ethertype == rte_cpu_to_be_16(RTE_ETHER_TYPE_QINQ)) {
+		vlan_hdr = (struct rte_vlan_hdr *)((char *)eth_hdr + l2_len);
+		l2_len += sizeof(struct rte_vlan_hdr);
+		ethertype = vlan_hdr->eth_proto;
+	}
+
+	/* Parse L3 to get L3 length and L4 protocol */
+	if (ethertype == rte_cpu_to_be_16(RTE_ETHER_TYPE_IPV4)) {
+		ipv4_hdr = (struct rte_ipv4_hdr *)((char *)eth_hdr + l2_len);
+		l3_len = rte_ipv4_hdr_len(ipv4_hdr);
+		l4_proto = ipv4_hdr->next_proto_id;
+	} else if (ethertype == rte_cpu_to_be_16(RTE_ETHER_TYPE_IPV6)) {
+		ipv6_hdr = (struct rte_ipv6_hdr *)((char *)eth_hdr + l2_len);
+		l3_len = sizeof(struct rte_ipv6_hdr);
+		l4_proto = ipv6_hdr->proto;
+	} else {
+		return 0;
+	}
+
+	l3_hdr = (char *)eth_hdr + l2_len;
+
+	/* Detect tunnel type and validate flag consistency */
+	if (l4_proto == IPPROTO_UDP) {
+		struct rte_udp_hdr *udp_hdr;
+		uint16_t dst_port;
+
+		udp_hdr = (struct rte_udp_hdr *)((char *)l3_hdr + l3_len);
+		dst_port = udp_hdr->dst_port;
+
+		/* GTP */
+		if (dst_port == rte_cpu_to_be_16(RTE_GTPC_UDP_PORT) ||
+		    dst_port == rte_cpu_to_be_16(RTE_GTPU_UDP_PORT)) {
+			if (!tunnel_type) {
+				PMD_LOG_ERR(TX, "GTP tunnel packet missing "
+					"RTE_MBUF_F_TX_TUNNEL_GTP flag");
+				return -1;
+			}
+			if (tunnel_type != RTE_MBUF_F_TX_TUNNEL_GTP) {
+				PMD_LOG_ERR(TX, "GTP tunnel packet has wrong "
+					"tx offload flag %s, expected GTP",
+					rte_get_tx_ol_flag_name(tunnel_type));
+				return -1;
+			}
+			return 0;
+		}
+		/* VXLAN-GPE */
+		if (dst_port == rte_cpu_to_be_16(RTE_VXLAN_GPE_DEFAULT_PORT)) {
+			if (!tunnel_type) {
+				PMD_LOG_ERR(TX, "VXLAN-GPE tunnel packet missing "
+					"RTE_MBUF_F_TX_TUNNEL_VXLAN_GPE flag");
+				return -1;
+			}
+			if (tunnel_type != RTE_MBUF_F_TX_TUNNEL_VXLAN_GPE) {
+				PMD_LOG_ERR(TX, "VXLAN-GPE tunnel packet has wrong "
+					"tx offload flag %s, expected VXLAN-GPE",
+					rte_get_tx_ol_flag_name(tunnel_type));
+				return -1;
+			}
+			return 0;
+		}
+		/* VXLAN */
+		if (dst_port == rte_cpu_to_be_16(RTE_VXLAN_DEFAULT_PORT)) {
+			if (!tunnel_type) {
+				PMD_LOG_ERR(TX, "VXLAN tunnel packet missing "
+					"RTE_MBUF_F_TX_TUNNEL_VXLAN flag");
+				return -1;
+			}
+			if (tunnel_type != RTE_MBUF_F_TX_TUNNEL_VXLAN) {
+				PMD_LOG_ERR(TX, "VXLAN tunnel packet has wrong "
+					"tx offload flag %s, expected VXLAN",
+					rte_get_tx_ol_flag_name(tunnel_type));
+				return -1;
+			}
+			return 0;
+		}
+		/* Geneve */
+		if (dst_port == rte_cpu_to_be_16(RTE_GENEVE_DEFAULT_PORT)) {
+			if (!tunnel_type) {
+				PMD_LOG_ERR(TX, "Geneve tunnel packet missing "
+					"RTE_MBUF_F_TX_TUNNEL_GENEVE flag");
+				return -1;
+			}
+			if (tunnel_type != RTE_MBUF_F_TX_TUNNEL_GENEVE) {
+				PMD_LOG_ERR(TX, "Geneve tunnel packet has wrong "
+					"tx offload flag %s, expected Geneve",
+					rte_get_tx_ol_flag_name(tunnel_type));
+				return -1;
+			}
+			return 0;
+		}
+	} else if (l4_proto == IPPROTO_GRE) {
+		/* GRE */
+		if (!tunnel_type) {
+			PMD_LOG_ERR(TX, "GRE tunnel packet missing "
+				"RTE_MBUF_F_TX_TUNNEL_GRE flag");
+			return -1;
+		}
+		if (tunnel_type != RTE_MBUF_F_TX_TUNNEL_GRE) {
+			PMD_LOG_ERR(TX, "GRE tunnel packet has wrong "
+				"tx offload flag %s, expected GRE",
+				rte_get_tx_ol_flag_name(tunnel_type));
+			return -1;
+		}
+		return 0;
+	} else if (l4_proto == IPPROTO_IPIP) {
+		/* IP-in-IP */
+		if (!tunnel_type) {
+			PMD_LOG_ERR(TX, "IPIP tunnel packet missing "
+				"RTE_MBUF_F_TX_TUNNEL_IPIP flag");
+			return -1;
+		}
+		if (tunnel_type != RTE_MBUF_F_TX_TUNNEL_IPIP) {
+			PMD_LOG_ERR(TX, "IPIP tunnel packet has wrong "
+				"tx offload flag %s, expected IPIP",
+				rte_get_tx_ol_flag_name(tunnel_type));
+			return -1;
+		}
+		return 0;
+	}
+
+	return 0;
+}
+#endif
+
 uint16_t sxe2_tx_pkts_prepare(void *tx_queue,
 		struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 {
@@ -137,6 +286,13 @@ uint16_t sxe2_tx_pkts_prepare(void *tx_queue,
 			rte_errno = -ret;
 			goto l_end;
 		}
+#ifdef RTE_ETHDEV_DEBUG_TX
+		ret = sxe2_txrx_check_mbuf(mbuf);
+		if (ret != 0) {
+			rte_errno = -ret;
+			goto l_end;
+		}
+#endif
 	}
 l_end:
 	return i;
-- 
2.52.0

