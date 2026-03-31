Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D94041061B2B
	for <dpdk-dev@archiver.kernel.org>; Tue, 31 Mar 2026 03:11:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A0BE040691;
	Tue, 31 Mar 2026 05:11:46 +0200 (CEST)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by mails.dpdk.org (Postfix) with ESMTP id 649C44025E
 for <dev@dpdk.org>; Tue, 31 Mar 2026 05:11:43 +0200 (CEST)
Received: from ar (unknown [42.177.178.249])
 by APP-03 (Coremail) with SMTP id rQCowACHa+JtO8tpg6liDA--.41003S2;
 Tue, 31 Mar 2026 11:11:41 +0800 (CST)
From: Sun Yuechi <sunyuechi@iscas.ac.cn>
To: dev@dpdk.org
Cc: Sun Yuechi <sunyuechi@iscas.ac.cn>, Zijian <zijian.oerv@isrc.iscas.ac.cn>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Pavan Nikhilesh <pbhagavatula@marvell.com>,
 =?UTF-8?q?Stanis=C5=82aw=20Kardach?= <stanislaw.kardach@gmail.com>
Subject: [PATCH v4 2/2] node: lookup with RISC-V vector extension
Date: Tue, 31 Mar 2026 11:10:59 +0800
Message-ID: <20260331031059.2621971-3-sunyuechi@iscas.ac.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331031059.2621971-1-sunyuechi@iscas.ac.cn>
References: <20260206081635.1409106-1-sunyuechi@iscas.ac.cn>
 <20260331031059.2621971-1-sunyuechi@iscas.ac.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowACHa+JtO8tpg6liDA--.41003S2
X-Coremail-Antispam: 1UD129KBjvJXoW3WryktF1UWr1Uur4xKr1kGrg_yoW3Jw15p3
 45GrWFkr93JF13G3ySv3W8ZFyru3W8Kr47KryDWayfCF93Cr4xCr97try2ka9xXryku3sx
 Xa1UZ34UJr17G3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUkK14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
 6r4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr
 1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
 6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
 0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v2
 6r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrV
 AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCI
 c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267
 AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_
 Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbb_-P
 UUUUU==
X-Originating-IP: [42.177.178.249]
X-CM-SenderInfo: 5vxq53phfkxq5lvft2wodfhubq/1tbiDAUDAmnLGIuLBAAAs2
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

Implement ip4_lookup_node_process_vec function for RISC-V architecture
using RISC-V Vector Extension instruction set.

Signed-off-by: Sun Yuechi <sunyuechi@iscas.ac.cn>
Signed-off-by: Zijian <zijian.oerv@isrc.iscas.ac.cn>
---
 doc/guides/rel_notes/release_26_03.rst |   4 +
 lib/node/ip4_lookup.c                  |   5 +-
 lib/node/ip4_lookup_rvv.h              | 164 +++++++++++++++++++++++++
 3 files changed, 172 insertions(+), 1 deletion(-)
 create mode 100644 lib/node/ip4_lookup_rvv.h

diff --git a/doc/guides/rel_notes/release_26_03.rst b/doc/guides/rel_notes/release_26_03.rst
index 6bb18433f5..ea03c95477 100644
--- a/doc/guides/rel_notes/release_26_03.rst
+++ b/doc/guides/rel_notes/release_26_03.rst
@@ -153,6 +153,10 @@ New Features
   Added handling of the key combination Control+L
   to clear the screen before redisplaying the prompt.
 
+* **Added RISC-V vector extension support for node library.**
+
+  * Added vectorized IPv4 LPM lookup implementation for the node library
+    using RISC-V Vector Extension instruction set.
 
 Removed Items
 -------------
diff --git a/lib/node/ip4_lookup.c b/lib/node/ip4_lookup.c
index f6db3219f0..42db993142 100644
--- a/lib/node/ip4_lookup.c
+++ b/lib/node/ip4_lookup.c
@@ -44,6 +44,8 @@ static struct ip4_lookup_node_main ip4_lookup_nm;
 #include "ip4_lookup_neon.h"
 #elif defined(RTE_ARCH_X86)
 #include "ip4_lookup_sse.h"
+#elif defined(RTE_ARCH_RISCV) && defined(RTE_RISCV_FEATURE_V)
+#include "ip4_lookup_rvv.h"
 #endif
 
 static uint16_t
@@ -208,7 +210,8 @@ ip4_lookup_node_init(const struct rte_graph *graph, struct rte_node *node)
 	IP4_LOOKUP_NODE_LPM(node->ctx) = ip4_lookup_nm.lpm_tbl[graph->socket];
 	IP4_LOOKUP_NODE_PRIV1_OFF(node->ctx) = dyn;
 
-#if defined(__ARM_NEON) || defined(RTE_ARCH_X86)
+#if defined(__ARM_NEON) || defined(RTE_ARCH_X86) || \
+	(defined(RTE_ARCH_RISCV) && defined(RTE_RISCV_FEATURE_V))
 	if (rte_vect_get_max_simd_bitwidth() >= RTE_VECT_SIMD_128)
 		node->process = ip4_lookup_node_process_vec;
 #endif
diff --git a/lib/node/ip4_lookup_rvv.h b/lib/node/ip4_lookup_rvv.h
new file mode 100644
index 0000000000..0d9db2e19b
--- /dev/null
+++ b/lib/node/ip4_lookup_rvv.h
@@ -0,0 +1,164 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (c) 2025 Institute of Software Chinese Academy of Sciences (ISCAS).
+ */
+
+#ifndef __INCLUDE_IP4_LOOKUP_RVV_H__
+#define __INCLUDE_IP4_LOOKUP_RVV_H__
+
+static __rte_always_inline vuint32m8_t
+bswap32_vec(vuint32m8_t v, size_t vl)
+{
+	vuint32m8_t low16 = __riscv_vor_vv_u32m8(
+		__riscv_vsll_vx_u32m8(__riscv_vand_vx_u32m8(v, 0xFF, vl), 24, vl),
+		__riscv_vsll_vx_u32m8(__riscv_vand_vx_u32m8(v, 0xFF00, vl), 8, vl),
+		vl);
+
+	vuint32m8_t high16 = __riscv_vor_vv_u32m8(
+		__riscv_vsrl_vx_u32m8(__riscv_vand_vx_u32m8(v, 0xFF0000, vl), 8, vl),
+		__riscv_vsrl_vx_u32m8(v, 24, vl),
+		vl);
+
+	return __riscv_vor_vv_u32m8(low16, high16, vl);
+}
+
+static __rte_always_inline void
+rte_lpm_lookup_vec(const struct rte_lpm *lpm, const uint32_t *ips,
+			uint32_t *hop, size_t vl, uint32_t defv)
+{
+	/* Load IP addresses (network byte order) */
+	vuint32m8_t v_ip = bswap32_vec(__riscv_vle32_v_u32m8(ips, vl), vl);
+
+	vuint32m8_t v_tbl24_byte_offset = __riscv_vsll_vx_u32m8(
+			__riscv_vsrl_vx_u32m8(v_ip, 8, vl), 2, vl);
+
+	vuint32m8_t vtbl_entry = __riscv_vluxei32_v_u32m8(
+		(const uint32_t *)lpm->tbl24, v_tbl24_byte_offset, vl);
+
+	vbool4_t mask = __riscv_vmseq_vx_u32m8_b4(
+		__riscv_vand_vx_u32m8(vtbl_entry, RTE_LPM_VALID_EXT_ENTRY_BITMASK, vl),
+		RTE_LPM_VALID_EXT_ENTRY_BITMASK, vl);
+
+	vuint32m8_t vtbl8_index = __riscv_vsll_vx_u32m8(
+		__riscv_vadd_vv_u32m8(
+			__riscv_vsll_vx_u32m8(
+				__riscv_vand_vx_u32m8(vtbl_entry, 0x00FFFFFF, vl), 8, vl),
+			__riscv_vand_vx_u32m8(v_ip, 0x000000FF, vl), vl),
+		2, vl);
+
+	vtbl_entry = __riscv_vluxei32_v_u32m8_mu(
+		mask, vtbl_entry, (const uint32_t *)(lpm->tbl8), vtbl8_index, vl);
+
+	vuint32m8_t vnext_hop = __riscv_vand_vx_u32m8(vtbl_entry, 0x00FFFFFF, vl);
+	mask = __riscv_vmseq_vx_u32m8_b4(
+		__riscv_vand_vx_u32m8(vtbl_entry, RTE_LPM_LOOKUP_SUCCESS, vl), 0, vl);
+
+	vnext_hop = __riscv_vmerge_vxm_u32m8(vnext_hop, defv, mask, vl);
+
+	__riscv_vse32_v_u32m8(hop, vnext_hop, vl);
+}
+
+/* Can be increased further for VLEN > 256 */
+#define RVV_MAX_BURST 64U
+
+static uint16_t
+ip4_lookup_node_process_vec(struct rte_graph *graph, struct rte_node *node,
+			void **objs, uint16_t nb_objs)
+{
+	struct rte_mbuf **pkts;
+	struct rte_lpm *lpm = IP4_LOOKUP_NODE_LPM(node->ctx);
+	const int dyn = IP4_LOOKUP_NODE_PRIV1_OFF(node->ctx);
+	rte_edge_t next_index;
+	void **to_next, **from;
+	uint16_t last_spec = 0;
+	uint16_t n_left_from;
+	uint16_t held = 0;
+	uint32_t drop_nh;
+
+	/* Temporary arrays for batch processing */
+	uint32_t ips[RVV_MAX_BURST];
+	uint32_t res[RVV_MAX_BURST];
+	rte_edge_t next_hops[RVV_MAX_BURST];
+
+	/* Speculative next */
+	next_index = RTE_NODE_IP4_LOOKUP_NEXT_REWRITE;
+	/* Drop node */
+	drop_nh = ((uint32_t)RTE_NODE_IP4_LOOKUP_NEXT_PKT_DROP) << 16;
+
+	pkts = (struct rte_mbuf **)objs;
+	from = objs;
+	n_left_from = nb_objs;
+
+	/* Get stream for the speculated next node */
+	to_next = rte_node_next_stream_get(graph, node, next_index, nb_objs);
+
+	while (n_left_from > 0) {
+		rte_edge_t fix_spec = 0;
+
+		size_t vl = __riscv_vsetvl_e32m8(RTE_MIN(n_left_from, RVV_MAX_BURST));
+
+		/* Extract IP addresses and metadata from current batch */
+		for (size_t i = 0; i < vl; i++) {
+			struct rte_ipv4_hdr *ipv4_hdr =
+				rte_pktmbuf_mtod_offset(pkts[i], struct rte_ipv4_hdr *,
+						sizeof(struct rte_ether_hdr));
+			ips[i] = ipv4_hdr->dst_addr;
+			node_mbuf_priv1(pkts[i], dyn)->cksum = ipv4_hdr->hdr_checksum;
+			node_mbuf_priv1(pkts[i], dyn)->ttl = ipv4_hdr->time_to_live;
+		}
+
+		/* Perform LPM lookup */
+		rte_lpm_lookup_vec(lpm, ips, res, vl, drop_nh);
+
+		for (size_t i = 0; i < vl; i++) {
+			/* Update statistics */
+			if ((res[i] >> 16) == (drop_nh >> 16))
+				NODE_INCREMENT_XSTAT_ID(node, 0, 1, 1);
+
+			/* Extract next hop and next node */
+			node_mbuf_priv1(pkts[i], dyn)->nh = res[i] & 0xFFFF;
+			next_hops[i] = res[i] >> 16;
+
+			/* Check speculation */
+			fix_spec |= (next_index ^ next_hops[i]);
+		}
+
+		if (unlikely(fix_spec)) {
+			/* Copy successfully speculated packets before this batch */
+			memcpy(to_next, from, last_spec * sizeof(from[0]));
+			from += last_spec;
+			to_next += last_spec;
+			held += last_spec;
+			last_spec = 0;
+
+			/* Process each packet in current batch individually */
+			for (size_t i = 0; i < vl; i++) {
+				if (next_index == next_hops[i]) {
+					*to_next++ = from[i];
+					held++;
+				} else {
+					rte_node_enqueue_x1(graph, node, next_hops[i], from[i]);
+				}
+			}
+
+			from += vl;
+		} else {
+			last_spec += vl;
+		}
+
+		pkts += vl;
+		n_left_from -= vl;
+	}
+
+	/* Handle successfully speculated packets */
+	if (likely(last_spec == nb_objs)) {
+		rte_node_next_stream_move(graph, node, next_index);
+		return nb_objs;
+	}
+
+	held += last_spec;
+	memcpy(to_next, from, last_spec * sizeof(from[0]));
+	rte_node_next_stream_put(graph, node, next_index, held);
+
+	return nb_objs;
+}
+#endif
-- 
2.53.0

