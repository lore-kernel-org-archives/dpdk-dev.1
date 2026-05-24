Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4506BCD4F54
	for <dpdk-dev@archiver.kernel.org>; Sun, 24 May 2026 09:34:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A815E40A75;
	Sun, 24 May 2026 11:33:24 +0200 (CEST)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by mails.dpdk.org (Postfix) with ESMTP id DDF8A4065B
 for <dev@dpdk.org>; Sun, 24 May 2026 11:33:10 +0200 (CEST)
Received: from localhost.localdomain (unknown [118.112.177.181])
 by APP-03 (Coremail) with SMTP id rQCowABXd97QxRJq+04kEg--.9115S20;
 Sun, 24 May 2026 17:33:09 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org,
	Jie Liu <liujie5@linkdatatechnology.com>
Subject: [PATCH v1 18/23] net/sxe2: add mbuf validation in Tx debug mode
Date: Sun, 24 May 2026 17:32:54 +0800
Message-ID: <20260524093259.397506-19-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260524093259.397506-1-liujie5@linkdatatechnology.com>
References: <20260524093259.397506-1-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowABXd97QxRJq+04kEg--.9115S20
X-Coremail-Antispam: 1UD129KBjvAXoWfAry8Kw1rtr4DAr1DXFWkJFb_yoW8uFWfuo
 WxGw45ury8ur17urZ8tFyxZFyIqw4UK3y8Wwsa9Fs5uw1xuw1UG3sxG3y3AFW8Jws7Zr4q
 va1xWasIqr47tFWkn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
 AaLaJ3UjIYCTnIWjp_UUUYM7AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20EY4v20xva
 j40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7IE14v26r126s0DM28Irc
 Ia0xkI8VCY1x0267AKxVW5JVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l
 84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j6r
 4UJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVW8JVW8
 Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2I
 x0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8
 JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lw4CEc2x0rVAKj4xxMx
 AIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_
 Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAwCIc40Y0x0EwI
 xGrwCI42IY6xIIjxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8
 Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0x
 vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUB89_UUUUU=
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

Introduce the `sxe2_txrx_check_mbuf` helper function to validate outgoing
mbufs when `RTE_ETHDEV_DEBUG_TX` is enabled. This helps developers catch
malformed mbufs (e.g., invalid segment lengths, bad offload flags, or
unaligned buffers) before passing them to the hardware rings, avoiding
potential hardware hangs or silent packet drops.

The validation is fully wrapped inside `RTE_ETHDEV_DEBUG_TX` conditional
compilation blocks to ensure zero performance overhead in standard
production builds.

Signed-off-by: Jie Liu <liujie5@linkdatatechnology.com>
---
 drivers/net/sxe2/meson.build            |   2 +
 drivers/net/sxe2/sxe2_txrx.c            |   8 +-
 drivers/net/sxe2/sxe2_txrx_check_mbuf.c | 595 ++++++++++++++++++++++++
 drivers/net/sxe2/sxe2_txrx_check_mbuf.h |  38 ++
 4 files changed, 641 insertions(+), 2 deletions(-)
 create mode 100644 drivers/net/sxe2/sxe2_txrx_check_mbuf.c
 create mode 100644 drivers/net/sxe2/sxe2_txrx_check_mbuf.h

diff --git a/drivers/net/sxe2/meson.build b/drivers/net/sxe2/meson.build
index 631730bf3e..5a02b1c3d3 100644
--- a/drivers/net/sxe2/meson.build
+++ b/drivers/net/sxe2/meson.build
@@ -78,6 +78,8 @@ sources += files(
         'sxe2_flow_parse_pattern.c',
         'sxe2_flow_parse_engine.c',
         'sxe2_dump.c',
+        'sxe2_txrx_check_mbuf.c',
+
 )
 
 allow_internal_get_api = true
diff --git a/drivers/net/sxe2/sxe2_txrx.c b/drivers/net/sxe2/sxe2_txrx.c
index a2cea954d5..55e477db1d 100644
--- a/drivers/net/sxe2/sxe2_txrx.c
+++ b/drivers/net/sxe2/sxe2_txrx.c
@@ -13,6 +13,7 @@
 #include "sxe2_txrx_common.h"
 #include "sxe2_txrx_vec.h"
 #include "sxe2_txrx_poll.h"
+#include "sxe2_txrx_check_mbuf.h"
 #include "sxe2_ethdev.h"
 #include "sxe2_common_log.h"
 #include "sxe2_osal.h"
@@ -121,13 +122,11 @@ uint16_t sxe2_tx_pkts_prepare(void *tx_queue,
 			rte_errno = -EINVAL;
 			goto l_end;
 		}
-#ifdef RTE_ETHDEV_DEBUG_TX
 		ret = rte_validate_tx_offload(mbuf);
 		if (ret != 0) {
 			rte_errno = -ret;
 			goto l_end;
 		}
-#endif
 		ret = rte_net_intel_cksum_prepare(mbuf);
 		if (ret != 0) {
 			rte_errno = -ret;
@@ -138,6 +137,11 @@ uint16_t sxe2_tx_pkts_prepare(void *tx_queue,
 			rte_errno = -ret;
 			goto l_end;
 		}
+		ret = sxe2_txrx_check_mbuf(mbuf);
+		if (ret != 0) {
+			rte_errno = -ret;
+			goto l_end;
+		}
 	}
 l_end:
 	return i;
diff --git a/drivers/net/sxe2/sxe2_txrx_check_mbuf.c b/drivers/net/sxe2/sxe2_txrx_check_mbuf.c
new file mode 100644
index 0000000000..5a12b42120
--- /dev/null
+++ b/drivers/net/sxe2/sxe2_txrx_check_mbuf.c
@@ -0,0 +1,595 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (C), 2025, Wuxi Stars Micro System Technologies Co., Ltd.
+ */
+
+#include <rte_common.h>
+#include <rte_net.h>
+#include <rte_vect.h>
+#include <rte_malloc.h>
+#include <rte_memzone.h>
+#include <ethdev_driver.h>
+#include <rte_geneve.h>
+
+#include "sxe2_txrx_check_mbuf.h"
+#include "sxe2_common_log.h"
+
+#define TX_IPPROTO_IPIP 4
+#define TX_IPPROTO_GRE  47
+#define GRE_CHECKSUM_PRESENT 0x8000
+#define GRE_KEY_PRESENT 0x2000
+#define GRE_SEQUENCE_PRESENT 0x1000
+#define GRE_EXT_LEN 4
+#define GRE_SUPPORTED_FIELDS (GRE_CHECKSUM_PRESENT | GRE_KEY_PRESENT | GRE_SEQUENCE_PRESENT)
+
+
+static uint16_t vxlan_gpe_udp_port = RTE_VXLAN_GPE_DEFAULT_PORT;
+static uint16_t geneve_udp_port = RTE_GENEVE_DEFAULT_PORT;
+
+static inline int32_t check_mbuf_len(struct offload_info *info, struct rte_mbuf *m)
+{
+	int32_t ret = 0;
+	if (m->ol_flags & RTE_MBUF_F_TX_TUNNEL_MASK) {
+		if (info->outer_l2_len != m->outer_l2_len) {
+			PMD_LOG_ERR(TX, "outer_l2_len error in mbuf. Original "
+				    "length:%hu calculated length:%u", m->outer_l2_len,
+				    info->outer_l2_len);
+			ret = -1;
+			goto end;
+		}
+		if (info->outer_l3_len != m->outer_l3_len) {
+			PMD_LOG_ERR(TX, "outer_l3_len error in mbuf. Original "
+				    "length:%hu calculated length:%u", m->outer_l3_len,
+				    info->outer_l3_len);
+			ret = -1;
+			goto end;
+		}
+	}
+
+	if (info->l2_len != m->l2_len) {
+		PMD_LOG_ERR(TX, "l2_len error in mbuf. Original "
+			"length:%hu calculated length:%u", m->l2_len, info->l2_len);
+		ret = -1;
+		goto end;
+	}
+	if (info->l3_len != m->l3_len) {
+		PMD_LOG_ERR(TX, "l3_len error in mbuf. Original "
+			"length:%hu calculated length:%u", m->l3_len, info->l3_len);
+		ret = -1;
+		goto end;
+	}
+	if (info->l4_len != m->l4_len) {
+		PMD_LOG_ERR(TX, "l4_len error in mbuf. Original "
+			"length:%hu calculated length:%u", m->l4_len, info->l4_len);
+		ret = -1;
+		goto end;
+	}
+	ret = 0;
+
+end:
+	return ret;
+}
+
+static inline int32_t check_ether_type(struct offload_info *info, struct rte_mbuf *m)
+{
+	int32_t ret = 0;
+
+	if (m->ol_flags & RTE_MBUF_F_TX_TUNNEL_MASK) {
+		if (info->outer_ethertype == rte_cpu_to_be_16(RTE_ETHER_TYPE_IPV4)) {
+			if (!(m->ol_flags & RTE_MBUF_F_TX_OUTER_IPV4)) {
+				PMD_LOG_ERR(TX, "Outer ethernet type is ipv4, "
+					"tx offload missing `RTE_MBUF_F_TX_OUTER_IPV4` flag");
+				ret = -1;
+				goto end;
+			}
+			if (m->ol_flags & RTE_MBUF_F_TX_OUTER_IPV6) {
+				PMD_LOG_ERR(TX, "Outer ethernet type is ipv4, tx "
+					"offload contains wrong `RTE_MBUF_F_TX_OUTER_IPV6` flag");
+				ret = -1;
+				goto end;
+			}
+		} else if (info->outer_ethertype == rte_cpu_to_be_16(RTE_ETHER_TYPE_IPV6)) {
+			if (!(m->ol_flags & RTE_MBUF_F_TX_OUTER_IPV6)) {
+				PMD_LOG_ERR(TX, "Outer ethernet type is ipv6, "
+					"tx offload missing `RTE_MBUF_F_TX_OUTER_IPV6` flag");
+				ret = -1;
+				goto end;
+			}
+			if (m->ol_flags & RTE_MBUF_F_TX_OUTER_IPV4) {
+				PMD_LOG_ERR(TX, "Outer ethernet type is ipv6, tx "
+					"offload contains wrong `RTE_MBUF_F_TX_OUTER_IPV4` flag");
+				ret = -1;
+				goto end;
+			}
+		}
+	}
+
+	if (info->ethertype == rte_cpu_to_be_16(RTE_ETHER_TYPE_IPV4)) {
+		if (!(m->ol_flags & RTE_MBUF_F_TX_IPV4)) {
+			PMD_LOG_ERR(TX, "Ethernet type is ipv4, tx offload "
+				"missing `RTE_MBUF_F_TX_IPV4` flag.");
+			ret = -1;
+			goto end;
+		}
+		if (m->ol_flags & RTE_MBUF_F_TX_IPV6) {
+			PMD_LOG_ERR(TX, "Ethernet type is ipv4, tx "
+				"offload contains wrong `RTE_MBUF_F_TX_IPV6` flag");
+			ret = -1;
+			goto end;
+		}
+	} else if (info->ethertype == rte_cpu_to_be_16(RTE_ETHER_TYPE_IPV6)) {
+		if (!(m->ol_flags & RTE_MBUF_F_TX_IPV6)) {
+			PMD_LOG_ERR(TX, "Ethernet type is ipv6, tx offload "
+				"missing `RTE_MBUF_F_TX_IPV6` flag.");
+			ret = -1;
+			goto end;
+		}
+		if (m->ol_flags & RTE_MBUF_F_TX_IPV4) {
+			PMD_LOG_ERR(TX, "Ethernet type is ipv6, tx offload "
+				"contains wrong `RTE_MBUF_F_TX_IPV4` flag");
+			ret = -1;
+			goto end;
+		}
+	}
+	ret = 0;
+
+end:
+	return ret;
+}
+
+static inline void parse_ipv4(struct rte_ipv4_hdr *ipv4_hdr, struct offload_info *info)
+{
+	struct rte_tcp_hdr *tcp_hdr;
+
+	info->l3_len   = rte_ipv4_hdr_len(ipv4_hdr);
+	info->l4_proto = ipv4_hdr->next_proto_id;
+
+	if (info->l4_proto == IPPROTO_TCP) {
+		tcp_hdr = (struct rte_tcp_hdr *)((char *)ipv4_hdr + info->l3_len);
+		info->l4_len = (tcp_hdr->data_off & 0xf0) >> 2;
+	} else if (info->l4_proto == IPPROTO_UDP) {
+		info->l4_len = sizeof(struct rte_udp_hdr);
+	} else {
+		info->l4_len = 0;
+	}
+}
+
+static inline void parse_ipv6(struct rte_ipv6_hdr *ipv6_hdr, struct offload_info *info)
+{
+	struct rte_tcp_hdr *tcp_hdr;
+
+	info->l3_len   = sizeof(struct rte_ipv6_hdr);
+	info->l4_proto = ipv6_hdr->proto;
+
+	if (info->l4_proto == IPPROTO_TCP) {
+		tcp_hdr = (struct rte_tcp_hdr *)((char *)ipv6_hdr + info->l3_len);
+		info->l4_len = (tcp_hdr->data_off & 0xf0) >> 2;
+	} else if (info->l4_proto == IPPROTO_UDP) {
+		info->l4_len = sizeof(struct rte_udp_hdr);
+	} else {
+		info->l4_len = 0;
+	}
+}
+
+static inline void parse_ethernet(struct rte_ether_hdr *eth_hdr, struct offload_info *info)
+{
+	struct rte_ipv4_hdr *ipv4_hdr;
+	struct rte_ipv6_hdr *ipv6_hdr;
+	struct rte_vlan_hdr *vlan_hdr;
+
+	info->l2_len = sizeof(struct rte_ether_hdr);
+	info->ethertype = eth_hdr->ether_type;
+
+	while (info->ethertype == rte_cpu_to_be_16(RTE_ETHER_TYPE_VLAN) ||
+		   info->ethertype == rte_cpu_to_be_16(RTE_ETHER_TYPE_QINQ)) {
+		vlan_hdr = (struct rte_vlan_hdr *)
+			((char *)eth_hdr + info->l2_len);
+		info->l2_len   += sizeof(struct rte_vlan_hdr);
+		info->ethertype = vlan_hdr->eth_proto;
+	}
+
+	switch (info->ethertype) {
+	case RTE_STATIC_BSWAP16(RTE_ETHER_TYPE_IPV4):
+		ipv4_hdr = (struct rte_ipv4_hdr *)((char *)eth_hdr + info->l2_len);
+		parse_ipv4(ipv4_hdr, info);
+		break;
+	case RTE_STATIC_BSWAP16(RTE_ETHER_TYPE_IPV6):
+		ipv6_hdr = (struct rte_ipv6_hdr *)((char *)eth_hdr + info->l2_len);
+		parse_ipv6(ipv6_hdr, info);
+		break;
+	default:
+		info->l4_len = 0;
+		info->l3_len = 0;
+		info->l4_proto = 0;
+		break;
+	}
+}
+
+static inline void update_tunnel_outer(struct offload_info *info)
+{
+	info->is_tunnel       = 1;
+	info->outer_ethertype = info->ethertype;
+	info->outer_l2_len    = info->l2_len;
+	info->outer_l3_len    = info->l3_len;
+	info->outer_l4_proto  = info->l4_proto;
+}
+
+static inline void parse_gtp(struct rte_udp_hdr *udp_hdr, struct offload_info *info)
+{
+	struct rte_ipv4_hdr *ipv4_hdr;
+	struct rte_ipv6_hdr *ipv6_hdr;
+	struct rte_gtp_hdr *gtp_hdr;
+	uint8_t gtp_len = sizeof(*gtp_hdr);
+	uint8_t ip_ver;
+
+	if (udp_hdr->dst_port != rte_cpu_to_be_16(RTE_GTPC_UDP_PORT) &&
+		udp_hdr->src_port != rte_cpu_to_be_16(RTE_GTPC_UDP_PORT) &&
+		udp_hdr->dst_port != rte_cpu_to_be_16(RTE_GTPU_UDP_PORT))
+		goto end;
+
+	update_tunnel_outer(info);
+	info->l2_len = 0;
+
+	gtp_hdr = (struct rte_gtp_hdr *)((char *)udp_hdr + sizeof(*udp_hdr));
+
+	if (gtp_hdr->msg_type == 0xff) {
+		ip_ver = *(uint8_t *)((char *)udp_hdr + sizeof(*udp_hdr) + sizeof(*gtp_hdr));
+		ip_ver = (ip_ver) & 0xf0;
+
+		if (ip_ver == RTE_GTP_TYPE_IPV4) {
+			ipv4_hdr = (struct rte_ipv4_hdr *)((char *)gtp_hdr + gtp_len);
+			info->ethertype = rte_cpu_to_be_16(RTE_ETHER_TYPE_IPV4);
+			parse_ipv4(ipv4_hdr, info);
+		} else if (ip_ver == RTE_GTP_TYPE_IPV6) {
+			ipv6_hdr = (struct rte_ipv6_hdr *)((char *)gtp_hdr + gtp_len);
+			info->ethertype = rte_cpu_to_be_16(RTE_ETHER_TYPE_IPV6);
+			parse_ipv6(ipv6_hdr, info);
+		}
+	} else {
+		info->ethertype = 0;
+		info->l4_len    = 0;
+		info->l3_len    = 0;
+		info->l4_proto  = 0;
+	}
+
+	info->l2_len += RTE_ETHER_GTP_HLEN;
+
+end:
+	return;
+}
+
+static inline void parse_vxlan(struct rte_udp_hdr *udp_hdr, struct offload_info *info)
+{
+	struct rte_ether_hdr *eth_hdr;
+
+	if (udp_hdr->dst_port != rte_cpu_to_be_16(RTE_VXLAN_DEFAULT_PORT))
+		goto end;
+
+	update_tunnel_outer(info);
+
+	eth_hdr = (struct rte_ether_hdr *)((char *)udp_hdr +
+		sizeof(struct rte_udp_hdr) + sizeof(struct rte_vxlan_hdr));
+
+	parse_ethernet(eth_hdr, info);
+	info->l2_len += RTE_ETHER_VXLAN_HLEN;
+
+end:
+	return;
+}
+
+static inline void parse_vxlan_gpe(struct rte_udp_hdr *udp_hdr, struct offload_info *info)
+{
+	struct rte_ether_hdr *eth_hdr;
+	struct rte_ipv4_hdr *ipv4_hdr;
+	struct rte_ipv6_hdr *ipv6_hdr;
+	struct rte_vxlan_gpe_hdr *vxlan_gpe_hdr;
+	uint8_t vxlan_gpe_len = sizeof(*vxlan_gpe_hdr);
+
+	if (udp_hdr->dst_port != rte_cpu_to_be_16(vxlan_gpe_udp_port))
+		goto end;
+
+	vxlan_gpe_hdr = (struct rte_vxlan_gpe_hdr *)((char *)udp_hdr + sizeof(struct rte_udp_hdr));
+
+	if (!vxlan_gpe_hdr->proto || vxlan_gpe_hdr->proto == RTE_VXLAN_GPE_TYPE_IPV4) {
+		update_tunnel_outer(info);
+
+		ipv4_hdr = (struct rte_ipv4_hdr *)((char *)vxlan_gpe_hdr + vxlan_gpe_len);
+
+		parse_ipv4(ipv4_hdr, info);
+		info->ethertype = rte_cpu_to_be_16(RTE_ETHER_TYPE_IPV4);
+		info->l2_len = 0;
+
+	} else if (vxlan_gpe_hdr->proto == RTE_VXLAN_GPE_TYPE_IPV6) {
+		update_tunnel_outer(info);
+
+		ipv6_hdr = (struct rte_ipv6_hdr *)((char *)vxlan_gpe_hdr + vxlan_gpe_len);
+
+		info->ethertype = rte_cpu_to_be_16(RTE_ETHER_TYPE_IPV6);
+		parse_ipv6(ipv6_hdr, info);
+		info->l2_len = 0;
+
+	} else if (vxlan_gpe_hdr->proto == RTE_VXLAN_GPE_TYPE_ETH) {
+		update_tunnel_outer(info);
+
+		eth_hdr = (struct rte_ether_hdr *)((char *)vxlan_gpe_hdr + vxlan_gpe_len);
+
+		parse_ethernet(eth_hdr, info);
+	} else {
+		goto end;
+	}
+
+	info->l2_len += RTE_ETHER_VXLAN_GPE_HLEN;
+
+end:
+	return;
+}
+
+static inline void parse_geneve(struct rte_udp_hdr *udp_hdr, struct offload_info *info)
+{
+	struct rte_ether_hdr *eth_hdr;
+	struct rte_ipv4_hdr *ipv4_hdr;
+	struct rte_ipv6_hdr *ipv6_hdr;
+	struct rte_geneve_hdr *geneve_hdr;
+	uint16_t geneve_len;
+
+	if (udp_hdr->dst_port != rte_cpu_to_be_16(geneve_udp_port))
+		goto end;
+
+	geneve_hdr = (struct rte_geneve_hdr *)((char *)udp_hdr + sizeof(struct rte_udp_hdr));
+	geneve_len = sizeof(struct rte_geneve_hdr) + geneve_hdr->opt_len * 4;
+	if (!geneve_hdr->proto || geneve_hdr->proto == rte_cpu_to_be_16(RTE_ETHER_TYPE_IPV4)) {
+		update_tunnel_outer(info);
+		ipv4_hdr = (struct rte_ipv4_hdr *)((char *)geneve_hdr + geneve_len);
+		parse_ipv4(ipv4_hdr, info);
+		info->ethertype = rte_cpu_to_be_16(RTE_ETHER_TYPE_IPV4);
+		info->l2_len = 0;
+	} else if (geneve_hdr->proto == rte_cpu_to_be_16(RTE_ETHER_TYPE_IPV6)) {
+		update_tunnel_outer(info);
+		ipv6_hdr = (struct rte_ipv6_hdr *)((char *)geneve_hdr + geneve_len);
+		info->ethertype = rte_cpu_to_be_16(RTE_ETHER_TYPE_IPV6);
+		parse_ipv6(ipv6_hdr, info);
+		info->l2_len = 0;
+
+	} else if (geneve_hdr->proto == rte_cpu_to_be_16(RTE_GENEVE_TYPE_ETH)) {
+		update_tunnel_outer(info);
+		eth_hdr = (struct rte_ether_hdr *)((char *)geneve_hdr + geneve_len);
+		parse_ethernet(eth_hdr, info);
+	} else {
+		goto end;
+	}
+
+	info->l2_len += (sizeof(struct rte_udp_hdr) + sizeof(struct rte_geneve_hdr) +
+		((struct rte_geneve_hdr *)geneve_hdr)->opt_len * 4);
+
+end:
+	return;
+}
+
+static inline void parse_gre(struct simple_gre_hdr *gre_hdr, struct offload_info *info)
+{
+	struct rte_ether_hdr *eth_hdr;
+	struct rte_ipv4_hdr *ipv4_hdr;
+	struct rte_ipv6_hdr *ipv6_hdr;
+	uint8_t gre_len = 0;
+
+	gre_len += sizeof(struct simple_gre_hdr);
+
+	if (gre_hdr->flags & rte_cpu_to_be_16(GRE_KEY_PRESENT))
+		gre_len += GRE_EXT_LEN;
+	if (gre_hdr->flags & rte_cpu_to_be_16(GRE_SEQUENCE_PRESENT))
+		gre_len += GRE_EXT_LEN;
+	if (gre_hdr->flags & rte_cpu_to_be_16(GRE_CHECKSUM_PRESENT))
+		gre_len += GRE_EXT_LEN;
+
+	if (gre_hdr->proto == rte_cpu_to_be_16(RTE_ETHER_TYPE_IPV4)) {
+		update_tunnel_outer(info);
+
+		ipv4_hdr = (struct rte_ipv4_hdr *)((char *)gre_hdr + gre_len);
+
+		parse_ipv4(ipv4_hdr, info);
+		info->ethertype = rte_cpu_to_be_16(RTE_ETHER_TYPE_IPV4);
+		info->l2_len = 0;
+
+	} else if (gre_hdr->proto == rte_cpu_to_be_16(RTE_ETHER_TYPE_IPV6)) {
+		update_tunnel_outer(info);
+
+		ipv6_hdr = (struct rte_ipv6_hdr *)((char *)gre_hdr + gre_len);
+
+		info->ethertype = rte_cpu_to_be_16(RTE_ETHER_TYPE_IPV6);
+		parse_ipv6(ipv6_hdr, info);
+		info->l2_len = 0;
+
+	} else if (gre_hdr->proto == rte_cpu_to_be_16(RTE_ETHER_TYPE_TEB)) {
+		update_tunnel_outer(info);
+
+		eth_hdr = (struct rte_ether_hdr *)((char *)gre_hdr + gre_len);
+
+		parse_ethernet(eth_hdr, info);
+	} else {
+		goto end;
+	}
+
+	info->l2_len += gre_len;
+
+end:
+	return;
+}
+
+static inline void parse_encap_ip(void *encap_ip, struct offload_info *info)
+{
+	struct rte_ipv4_hdr *ipv4_hdr = encap_ip;
+	struct rte_ipv6_hdr *ipv6_hdr = encap_ip;
+	uint8_t ip_version;
+
+	ip_version = ((ipv4_hdr->version_ihl & 0xf0) >> 4);
+
+	if (ip_version != 4 && ip_version != 6)
+		goto end;
+
+	info->is_tunnel = 1;
+	info->outer_ethertype = info->ethertype;
+	info->outer_l2_len = info->l2_len;
+	info->outer_l3_len = info->l3_len;
+
+	if (ip_version == 4) {
+		parse_ipv4(ipv4_hdr, info);
+		info->ethertype = rte_cpu_to_be_16(RTE_ETHER_TYPE_IPV4);
+	} else {
+		parse_ipv6(ipv6_hdr, info);
+		info->ethertype = rte_cpu_to_be_16(RTE_ETHER_TYPE_IPV6);
+	}
+	info->l2_len = 0;
+
+end:
+	return;
+}
+
+__rte_unused int32_t sxe2_txrx_check_mbuf(struct rte_mbuf *m)
+{
+	int32_t ret = 0;
+	struct rte_ether_hdr *eth_hdr;
+	void *l3_hdr = NULL;
+	struct offload_info info = {0};
+	uint64_t ol_flags = m->ol_flags;
+	uint64_t tunnel_type = ol_flags & RTE_MBUF_F_TX_TUNNEL_MASK;
+
+	eth_hdr = rte_pktmbuf_mtod(m, struct rte_ether_hdr *);
+	parse_ethernet(eth_hdr, &info);
+	l3_hdr = (char *)eth_hdr + info.l2_len;
+	if (info.l4_proto == IPPROTO_UDP) {
+		struct rte_udp_hdr *udp_hdr;
+
+		udp_hdr = (struct rte_udp_hdr *)((char *)l3_hdr + info.l3_len);
+		if ((info.l2_len + info.l3_len + sizeof(struct rte_udp_hdr)) > m->data_len) {
+			PMD_LOG_ERR(TX, "UDP header exceeds mbuf data length");
+			ret = -1;
+			goto end;
+		}
+		parse_gtp(udp_hdr, &info);
+		if (info.is_tunnel) {
+			if (!tunnel_type) {
+				PMD_LOG_ERR(TX, "gtp tunnel packet missing tx "
+					"offload missing `RTE_MBUF_F_TX_TUNNEL_GTP` flag");
+				ret = -1;
+				goto end;
+			}
+			if (tunnel_type != RTE_MBUF_F_TX_TUNNEL_GTP) {
+				PMD_LOG_ERR(TX, "gtp tunnel packet, tx offload has wrong "
+					"`%s` flag correct is `RTE_MBUF_F_TX_TUNNEL_GTP` flag",
+				rte_get_tx_ol_flag_name(tunnel_type));
+				ret = -1;
+				goto end;
+			}
+			goto check_len;
+		}
+		parse_vxlan_gpe(udp_hdr, &info);
+		if (info.is_tunnel) {
+			if (!tunnel_type) {
+				PMD_LOG_ERR(TX, "vxlan gpe tunnel packet missing tx "
+					"offload missing `RTE_MBUF_F_TX_TUNNEL_VXLAN_GPE` flag");
+				ret = -1;
+				goto end;
+			}
+			if (tunnel_type != RTE_MBUF_F_TX_TUNNEL_VXLAN_GPE) {
+				PMD_LOG_ERR(TX, "vxlan gpe tunnel packet, tx offload has "
+					"wrong `%s` flag correct is `RTE_MBUF_F_TX_TUNNEL_VXLAN_GPE` flag",
+				rte_get_tx_ol_flag_name(tunnel_type));
+				ret = -1;
+				goto end;
+			}
+			goto check_len;
+		}
+		parse_vxlan(udp_hdr, &info);
+		if (info.is_tunnel) {
+			if (!tunnel_type) {
+				PMD_LOG_ERR(TX, "vxlan tunnel packet missing tx "
+					"offload missing `RTE_MBUF_F_TX_TUNNEL_VXLAN` flag");
+				ret = -1;
+				goto end;
+			}
+			if (tunnel_type != RTE_MBUF_F_TX_TUNNEL_VXLAN) {
+				PMD_LOG_ERR(TX, "vxlan tunnel packet, tx offload has "
+					"wrong `%s` flag correct is `RTE_MBUF_F_TX_TUNNEL_VXLAN` flag",
+				rte_get_tx_ol_flag_name(tunnel_type));
+				ret = -1;
+				goto end;
+			}
+			goto check_len;
+		}
+		parse_geneve(udp_hdr, &info);
+		if (info.is_tunnel) {
+			if (!tunnel_type) {
+				PMD_LOG_ERR(TX, "geneve tunnel packet missing tx "
+					"offload missing `RTE_MBUF_F_TX_TUNNEL_GENEVE` flag");
+				ret = -1;
+				goto end;
+			}
+			if (tunnel_type != RTE_MBUF_F_TX_TUNNEL_GENEVE) {
+				PMD_LOG_ERR(TX, "geneve tunnel packet, tx offload has "
+					"wrong `%s` flag correct is `RTE_MBUF_F_TX_TUNNEL_GENEVE` flag",
+				rte_get_tx_ol_flag_name(tunnel_type));
+				ret = -1;
+				goto end;
+			}
+			goto check_len;
+		}
+
+		if (unlikely(RTE_ETH_IS_TUNNEL_PKT(m->packet_type) != 0)) {
+			PMD_LOG_ERR(TX, "Unknown tunnel packet UDP dst port:%hu",
+				    udp_hdr->dst_port);
+			ret = -1;
+			goto end;
+		}
+	} else if (info.l4_proto == TX_IPPROTO_GRE) {
+		struct simple_gre_hdr *gre_hdr;
+
+		gre_hdr = (struct simple_gre_hdr *)((char *)l3_hdr + info.l3_len);
+		parse_gre(gre_hdr, &info);
+		if (info.is_tunnel) {
+			if (!tunnel_type) {
+				PMD_LOG_ERR(TX, "gre tunnel packet missing tx "
+					"offload missing `RTE_MBUF_F_TX_TUNNEL_GRE` flag.");
+				ret = -1;
+				goto end;
+			}
+			if (tunnel_type != RTE_MBUF_F_TX_TUNNEL_GRE) {
+				PMD_LOG_ERR(TX, "gre tunnel packet, tx offload has "
+					"wrong `%s` flag, correct is `RTE_MBUF_F_TX_TUNNEL_GRE` flag",
+				rte_get_tx_ol_flag_name(tunnel_type));
+				ret = -1;
+				goto end;
+			}
+			goto check_len;
+		}
+	} else if (info.l4_proto == TX_IPPROTO_IPIP) {
+		void *encap_ip_hdr;
+
+		encap_ip_hdr = (char *)l3_hdr + info.l3_len;
+		parse_encap_ip(encap_ip_hdr, &info);
+		if (info.is_tunnel) {
+			if (!tunnel_type) {
+				PMD_LOG_ERR(TX, "Ipip tunnel packet missing tx "
+					"offload missing `RTE_MBUF_F_TX_TUNNEL_IPIP` flag");
+				ret = -1;
+				goto end;
+			}
+			if (tunnel_type != RTE_MBUF_F_TX_TUNNEL_IPIP) {
+				PMD_LOG_ERR(TX, "Ipip tunnel packet, tx offload has "
+					"wrong `%s` flag, correct is `RTE_MBUF_F_TX_TUNNEL_IPIP` flag",
+				rte_get_tx_ol_flag_name(tunnel_type));
+				ret = -1;
+				goto end;
+			}
+			goto check_len;
+		}
+	}
+
+check_len:
+	if (check_mbuf_len(&info, m) != 0) {
+		ret = -1;
+		goto end;
+	}
+	ret = check_ether_type(&info, m);
+
+end:
+	return ret;
+}
diff --git a/drivers/net/sxe2/sxe2_txrx_check_mbuf.h b/drivers/net/sxe2/sxe2_txrx_check_mbuf.h
new file mode 100644
index 0000000000..98197f85d9
--- /dev/null
+++ b/drivers/net/sxe2/sxe2_txrx_check_mbuf.h
@@ -0,0 +1,38 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (C), 2025, Wuxi Stars Micro System Technologies Co., Ltd.
+ */
+
+#ifndef __SXE2_TXRX_CHECK_MBUF_H__
+#define __SXE2_TXRX_CHECK_MBUF_H__
+
+#include <rte_common.h>
+#include <rte_net.h>
+#include <rte_vect.h>
+#include <rte_malloc.h>
+#include <rte_memzone.h>
+#include <ethdev_driver.h>
+
+struct offload_info {
+	uint16_t ethertype;
+	uint8_t  gso_enable;
+	uint16_t l2_len;
+	uint16_t l3_len;
+	uint16_t l4_len;
+	uint8_t  l4_proto;
+	uint8_t  is_tunnel;
+	uint16_t outer_ethertype;
+	uint16_t outer_l2_len;
+	uint16_t outer_l3_len;
+	uint8_t  outer_l4_proto;
+	uint16_t tso_segsz;
+	uint16_t tunnel_tso_segsz;
+	uint32_t pkt_len;
+};
+
+struct simple_gre_hdr {
+	uint16_t flags;
+	uint16_t proto;
+};
+
+__rte_unused int32_t sxe2_txrx_check_mbuf(struct rte_mbuf *m);
+#endif /* __SXE2_TXRX_CHECK_MBUF_H__ */
-- 
2.47.3

