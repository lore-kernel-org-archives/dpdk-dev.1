Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39A8EFF886D
	for <dpdk-dev@archiver.kernel.org>; Tue, 28 Apr 2026 17:04:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2ECD240684;
	Tue, 28 Apr 2026 19:03:43 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id DD18540674
 for <dev@dpdk.org>; Tue, 28 Apr 2026 19:03:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777395822; x=1808931822;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=59HwFGQ+Gw5ud79HqhdrRLZXEBgf4Z7mZYRmNU7wLEI=;
 b=fbfAcjfbgbDxn248qyP90O5ZSxY6eD92T16TfvJ9gXrOSfO2u0/rYKCe
 l+ACXxheIGqxYdMn1SS93sESItPs6P4IkXomjr+EfcMUHXktTkd/Zp55w
 UfTNFuqZmxzUD8M5oMciOY99G/tXjMGhqc2fCSw9tYrwL7AG3HvnXu+1U
 G282ay0OEW51ot7bke4geKAh11u+HCZLLGb/0WYVCR7kcpK+ReXCNvqsT
 oSyWi8hr/nXRRYLPwn7lqOCauUldnbydXPfsJcRKQlTSA5fC6ONzn3r2z
 QeCwsbpbvoQODFpQ8RdE12SGTm593sDD1oyYiem1UBOQwOp8SB6n/WMwl Q==;
X-CSE-ConnectionGUID: 27/CZaRLTcK0LB+4rXeQDA==
X-CSE-MsgGUID: 2VDSEHfaRh+AQoY6UD3ISw==
X-IronPort-AV: E=McAfee;i="6800,10657,11770"; a="82180208"
X-IronPort-AV: E=Sophos;i="6.23,204,1770624000"; d="scan'208";a="82180208"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Apr 2026 10:03:34 -0700
X-CSE-ConnectionGUID: BvuT/hAPR6eKIjb8Hy7Aag==
X-CSE-MsgGUID: 8byLsW1RSJ6rTtMQ5c3UBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,204,1770624000"; d="scan'208";a="233973104"
Received: from icx008.iind.intel.com ([10.190.212.196])
 by orviesa009.jf.intel.com with ESMTP; 28 Apr 2026 10:03:31 -0700
From: Rajesh Kumar <rajesh3.kumar@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, aman.deep.singh@intel.com,
 stephen@networkplumber.org, Rajesh Kumar <rajesh3.kumar@intel.com>
Subject: [RFC v2 5/6] app/test: add PTP library unit tests
Date: Wed, 29 Apr 2026 03:58:36 +0530
Message-ID: <3b557058e28c1952b920fcecfe62b8b033d1fe40.1777413123.git.rajesh3.kumar@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1777413123.git.rajesh3.kumar@intel.com>
References: <cover.1777413123.git.rajesh3.kumar@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Add autotest for the PTP library covering:
- Transport classification (L2, VLAN, QinQ, UDP/IPv4, UDP/IPv6)
- Message type parsing and string conversion
- Inline helpers (is_event, two_step, seq_id, version, domain)
- Correction field arithmetic (add, accumulate, negative values)
- Timestamp nanosecond conversion
- Flag field extraction (TWO_STEP, UNICAST, LI_61, LI_59)

Signed-off-by: Rajesh Kumar <rajesh3.kumar@intel.com>
---
 MAINTAINERS          |    1 +
 app/test/meson.build |    1 +
 app/test/test_ptp.c  | 1052 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 1054 insertions(+)
 create mode 100644 app/test/test_ptp.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 665e08dc90..8d509cbe8e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1668,6 +1668,7 @@ F: app/test-sad/
 PTP - EXPERIMENTAL
 M: Rajesh Kumar <rajesh3.kumar@intel.com>
 F: lib/ptp/
+F: app/test/test_ptp.c
 F: doc/guides/prog_guide/ptp_lib.rst
 F: examples/ptp_tap_relay_sw/
 F: doc/guides/sample_app_ug/ptp_tap_relay_sw.rst
diff --git a/app/test/meson.build b/app/test/meson.build
index 7d458f9c07..ecaa8d0839 100644
--- a/app/test/meson.build
+++ b/app/test/meson.build
@@ -154,6 +154,7 @@ source_file_deps = {
     'test_power_kvm_vm.c': ['power', 'power_kvm_vm'],
     'test_prefetch.c': [],
     'test_ptr_compress.c': ['ptr_compress'],
+    'test_ptp.c': ['ptp'],
     'test_rand_perf.c': [],
     'test_rawdev.c': ['rawdev', 'bus_vdev', 'raw_skeleton'],
     'test_rcu_qsbr.c': ['rcu', 'hash'],
diff --git a/app/test/test_ptp.c b/app/test/test_ptp.c
new file mode 100644
index 0000000000..5c24804975
--- /dev/null
+++ b/app/test/test_ptp.c
@@ -0,0 +1,1052 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2026 Intel Corporation
+ */
+
+#include "test.h"
+
+#include <string.h>
+#include <stdio.h>
+#include <stdint.h>
+#include <inttypes.h>
+
+#include <rte_mbuf.h>
+#include <rte_mempool.h>
+#include <rte_memory.h>
+#include <rte_ether.h>
+#include <rte_ip.h>
+#include <rte_udp.h>
+#include <rte_byteorder.h>
+#include <rte_ptp.h>
+
+#define PTP_TEST_MP_NAME   "test_ptp_pool"
+#define PTP_TEST_MP_SIZE   63
+#define PTP_TEST_BUF_SIZE  RTE_MBUF_DEFAULT_BUF_SIZE
+
+static struct rte_mempool *ptp_mp;
+
+/* Helper: fill a minimal PTP header */
+static void
+fill_ptp_hdr(struct rte_ptp_hdr *ptp, uint8_t msg_type, uint16_t flags_host,
+	     int64_t correction_scaled_ns, uint16_t seq_id)
+{
+	memset(ptp, 0, sizeof(*ptp));
+	ptp->msg_type = msg_type;
+	ptp->version = 0x02;
+	ptp->msg_length = rte_cpu_to_be_16(34);
+	ptp->flags = rte_cpu_to_be_16(flags_host);
+	ptp->correction = rte_cpu_to_be_64(correction_scaled_ns);
+	ptp->sequence_id = rte_cpu_to_be_16(seq_id);
+}
+
+/* ================================================================
+ *  Packet builders
+ * ================================================================
+ */
+
+static struct rte_mbuf *
+build_l2_ptp(uint8_t msg_type)
+{
+	struct rte_mbuf *m = rte_pktmbuf_alloc(ptp_mp);
+	if (!m)
+		return NULL;
+
+	struct rte_ether_hdr *eth = (struct rte_ether_hdr *)
+		rte_pktmbuf_append(m, sizeof(*eth) + sizeof(struct rte_ptp_hdr));
+	memset(eth, 0, sizeof(*eth));
+	eth->ether_type = rte_cpu_to_be_16(0x88F7);
+
+	struct rte_ptp_hdr *ptp = (struct rte_ptp_hdr *)((uint8_t *)eth + sizeof(*eth));
+	fill_ptp_hdr(ptp, msg_type, RTE_PTP_FLAG_TWO_STEP, 0, 100);
+	return m;
+}
+
+/* Build L2 PTP with no TWO_STEP flag */
+static struct rte_mbuf *
+build_l2_ptp_noflags(uint8_t msg_type)
+{
+	struct rte_mbuf *m = rte_pktmbuf_alloc(ptp_mp);
+	if (!m)
+		return NULL;
+
+	struct rte_ether_hdr *eth = (struct rte_ether_hdr *)
+		rte_pktmbuf_append(m, sizeof(*eth) + sizeof(struct rte_ptp_hdr));
+	memset(eth, 0, sizeof(*eth));
+	eth->ether_type = rte_cpu_to_be_16(0x88F7);
+
+	struct rte_ptp_hdr *ptp = (struct rte_ptp_hdr *)((uint8_t *)eth + sizeof(*eth));
+	fill_ptp_hdr(ptp, msg_type, 0, 0, 200);
+	return m;
+}
+
+static struct rte_mbuf *
+build_vlan_l2_ptp(uint8_t msg_type, uint16_t tpid)
+{
+	struct rte_mbuf *m = rte_pktmbuf_alloc(ptp_mp);
+	if (!m)
+		return NULL;
+
+	uint32_t pkt_len = sizeof(struct rte_ether_hdr) +
+			   sizeof(struct rte_vlan_hdr) +
+			   sizeof(struct rte_ptp_hdr);
+	uint8_t *data = (uint8_t *)rte_pktmbuf_append(m, pkt_len);
+
+	struct rte_ether_hdr *eth = (struct rte_ether_hdr *)data;
+	memset(eth, 0, sizeof(*eth));
+	eth->ether_type = rte_cpu_to_be_16(tpid);
+
+	struct rte_vlan_hdr *vlan = (struct rte_vlan_hdr *)(data + sizeof(*eth));
+	vlan->vlan_tci = rte_cpu_to_be_16(100);
+	vlan->eth_proto = rte_cpu_to_be_16(0x88F7);
+
+	struct rte_ptp_hdr *ptp = (struct rte_ptp_hdr *)
+		(data + sizeof(*eth) + sizeof(*vlan));
+	fill_ptp_hdr(ptp, msg_type, 0, 0, 200);
+	return m;
+}
+
+static struct rte_mbuf *
+build_qinq_l2_ptp(uint8_t msg_type, uint16_t outer_tpid, uint16_t inner_tpid)
+{
+	struct rte_mbuf *m = rte_pktmbuf_alloc(ptp_mp);
+	if (!m)
+		return NULL;
+
+	uint32_t pkt_len = sizeof(struct rte_ether_hdr) +
+			   2 * sizeof(struct rte_vlan_hdr) +
+			   sizeof(struct rte_ptp_hdr);
+	uint8_t *data = (uint8_t *)rte_pktmbuf_append(m, pkt_len);
+
+	struct rte_ether_hdr *eth = (struct rte_ether_hdr *)data;
+	memset(eth, 0, sizeof(*eth));
+	eth->ether_type = rte_cpu_to_be_16(outer_tpid);
+
+	uint32_t off = sizeof(*eth);
+	struct rte_vlan_hdr *vo = (struct rte_vlan_hdr *)(data + off);
+	vo->vlan_tci = rte_cpu_to_be_16(200);
+	vo->eth_proto = rte_cpu_to_be_16(inner_tpid);
+	off += sizeof(*vo);
+
+	struct rte_vlan_hdr *vi = (struct rte_vlan_hdr *)(data + off);
+	vi->vlan_tci = rte_cpu_to_be_16(300);
+	vi->eth_proto = rte_cpu_to_be_16(0x88F7);
+	off += sizeof(*vi);
+
+	struct rte_ptp_hdr *ptp = (struct rte_ptp_hdr *)(data + off);
+	fill_ptp_hdr(ptp, msg_type, 0, 0, 300);
+	return m;
+}
+
+/* Helper: append IPv4 + UDP + PTP after offset */
+static void
+fill_ipv4_udp_ptp(uint8_t *data, uint32_t off, uint8_t msg_type,
+		  uint16_t dst_port, uint16_t seq_id)
+{
+	struct rte_ipv4_hdr *iph = (struct rte_ipv4_hdr *)(data + off);
+	memset(iph, 0, sizeof(*iph));
+	iph->version_ihl = 0x45;
+	iph->next_proto_id = IPPROTO_UDP;
+	iph->total_length = rte_cpu_to_be_16(
+		sizeof(struct rte_ipv4_hdr) + sizeof(struct rte_udp_hdr) +
+		sizeof(struct rte_ptp_hdr));
+	iph->src_addr = rte_cpu_to_be_32(0x0A000001);
+	iph->dst_addr = rte_cpu_to_be_32(0xE0000181);
+	off += sizeof(*iph);
+
+	struct rte_udp_hdr *udp = (struct rte_udp_hdr *)(data + off);
+	memset(udp, 0, sizeof(*udp));
+	udp->src_port = rte_cpu_to_be_16(12345);
+	udp->dst_port = rte_cpu_to_be_16(dst_port);
+	udp->dgram_len = rte_cpu_to_be_16(sizeof(*udp) +
+		sizeof(struct rte_ptp_hdr));
+	off += sizeof(*udp);
+
+	struct rte_ptp_hdr *ptp = (struct rte_ptp_hdr *)(data + off);
+	fill_ptp_hdr(ptp, msg_type, 0, 0, seq_id);
+}
+
+static struct rte_mbuf *
+build_ipv4_udp_ptp(uint8_t msg_type, uint16_t dst_port)
+{
+	struct rte_mbuf *m = rte_pktmbuf_alloc(ptp_mp);
+	if (!m)
+		return NULL;
+
+	uint32_t pkt_len = sizeof(struct rte_ether_hdr) +
+			   sizeof(struct rte_ipv4_hdr) +
+			   sizeof(struct rte_udp_hdr) +
+			   sizeof(struct rte_ptp_hdr);
+	uint8_t *data = (uint8_t *)rte_pktmbuf_append(m, pkt_len);
+
+	struct rte_ether_hdr *eth = (struct rte_ether_hdr *)data;
+	memset(eth, 0, sizeof(*eth));
+	eth->ether_type = rte_cpu_to_be_16(RTE_ETHER_TYPE_IPV4);
+
+	fill_ipv4_udp_ptp(data, sizeof(*eth), msg_type, dst_port, 400);
+	return m;
+}
+
+static struct rte_mbuf *
+build_vlan_ipv4_udp_ptp(uint8_t msg_type, uint16_t dst_port)
+{
+	struct rte_mbuf *m = rte_pktmbuf_alloc(ptp_mp);
+	if (!m)
+		return NULL;
+
+	uint32_t pkt_len = sizeof(struct rte_ether_hdr) +
+			   sizeof(struct rte_vlan_hdr) +
+			   sizeof(struct rte_ipv4_hdr) +
+			   sizeof(struct rte_udp_hdr) +
+			   sizeof(struct rte_ptp_hdr);
+	uint8_t *data = (uint8_t *)rte_pktmbuf_append(m, pkt_len);
+
+	struct rte_ether_hdr *eth = (struct rte_ether_hdr *)data;
+	memset(eth, 0, sizeof(*eth));
+	eth->ether_type = rte_cpu_to_be_16(RTE_ETHER_TYPE_VLAN);
+
+	uint32_t off = sizeof(*eth);
+	struct rte_vlan_hdr *vlan = (struct rte_vlan_hdr *)(data + off);
+	vlan->vlan_tci = rte_cpu_to_be_16(100);
+	vlan->eth_proto = rte_cpu_to_be_16(RTE_ETHER_TYPE_IPV4);
+	off += sizeof(*vlan);
+
+	fill_ipv4_udp_ptp(data, off, msg_type, dst_port, 500);
+	return m;
+}
+
+static struct rte_mbuf *
+build_qinq_ipv4_udp_ptp(uint8_t msg_type, uint16_t dst_port)
+{
+	struct rte_mbuf *m = rte_pktmbuf_alloc(ptp_mp);
+	if (!m)
+		return NULL;
+
+	uint32_t pkt_len = sizeof(struct rte_ether_hdr) +
+			   2 * sizeof(struct rte_vlan_hdr) +
+			   sizeof(struct rte_ipv4_hdr) +
+			   sizeof(struct rte_udp_hdr) +
+			   sizeof(struct rte_ptp_hdr);
+	uint8_t *data = (uint8_t *)rte_pktmbuf_append(m, pkt_len);
+
+	struct rte_ether_hdr *eth = (struct rte_ether_hdr *)data;
+	memset(eth, 0, sizeof(*eth));
+	eth->ether_type = rte_cpu_to_be_16(RTE_ETHER_TYPE_QINQ);
+
+	uint32_t off = sizeof(*eth);
+	struct rte_vlan_hdr *vo = (struct rte_vlan_hdr *)(data + off);
+	vo->vlan_tci = rte_cpu_to_be_16(200);
+	vo->eth_proto = rte_cpu_to_be_16(RTE_ETHER_TYPE_VLAN);
+	off += sizeof(*vo);
+
+	struct rte_vlan_hdr *vi = (struct rte_vlan_hdr *)(data + off);
+	vi->vlan_tci = rte_cpu_to_be_16(300);
+	vi->eth_proto = rte_cpu_to_be_16(RTE_ETHER_TYPE_IPV4);
+	off += sizeof(*vi);
+
+	fill_ipv4_udp_ptp(data, off, msg_type, dst_port, 600);
+	return m;
+}
+
+/* Helper: append IPv6 + UDP + PTP */
+static void
+fill_ipv6_udp_ptp(uint8_t *data, uint32_t off, uint8_t msg_type,
+		  uint16_t dst_port, uint16_t seq_id)
+{
+	struct rte_ipv6_hdr *ip6 = (struct rte_ipv6_hdr *)(data + off);
+	memset(ip6, 0, sizeof(*ip6));
+	ip6->vtc_flow = rte_cpu_to_be_32(0x60000000);
+	ip6->payload_len = rte_cpu_to_be_16(
+		sizeof(struct rte_udp_hdr) + sizeof(struct rte_ptp_hdr));
+	ip6->proto = IPPROTO_UDP;
+	ip6->hop_limits = 64;
+	off += sizeof(*ip6);
+
+	struct rte_udp_hdr *udp = (struct rte_udp_hdr *)(data + off);
+	memset(udp, 0, sizeof(*udp));
+	udp->src_port = rte_cpu_to_be_16(12345);
+	udp->dst_port = rte_cpu_to_be_16(dst_port);
+	udp->dgram_len = rte_cpu_to_be_16(sizeof(*udp) +
+		sizeof(struct rte_ptp_hdr));
+	off += sizeof(*udp);
+
+	struct rte_ptp_hdr *ptp = (struct rte_ptp_hdr *)(data + off);
+	fill_ptp_hdr(ptp, msg_type, 0, 0, seq_id);
+}
+
+static struct rte_mbuf *
+build_ipv6_udp_ptp(uint8_t msg_type, uint16_t dst_port)
+{
+	struct rte_mbuf *m = rte_pktmbuf_alloc(ptp_mp);
+	if (!m)
+		return NULL;
+
+	uint32_t pkt_len = sizeof(struct rte_ether_hdr) +
+			   sizeof(struct rte_ipv6_hdr) +
+			   sizeof(struct rte_udp_hdr) +
+			   sizeof(struct rte_ptp_hdr);
+	uint8_t *data = (uint8_t *)rte_pktmbuf_append(m, pkt_len);
+
+	struct rte_ether_hdr *eth = (struct rte_ether_hdr *)data;
+	memset(eth, 0, sizeof(*eth));
+	eth->ether_type = rte_cpu_to_be_16(RTE_ETHER_TYPE_IPV6);
+
+	fill_ipv6_udp_ptp(data, sizeof(*eth), msg_type, dst_port, 700);
+	return m;
+}
+
+static struct rte_mbuf *
+build_vlan_ipv6_udp_ptp(uint8_t msg_type, uint16_t dst_port)
+{
+	struct rte_mbuf *m = rte_pktmbuf_alloc(ptp_mp);
+	if (!m)
+		return NULL;
+
+	uint32_t pkt_len = sizeof(struct rte_ether_hdr) +
+			   sizeof(struct rte_vlan_hdr) +
+			   sizeof(struct rte_ipv6_hdr) +
+			   sizeof(struct rte_udp_hdr) +
+			   sizeof(struct rte_ptp_hdr);
+	uint8_t *data = (uint8_t *)rte_pktmbuf_append(m, pkt_len);
+
+	struct rte_ether_hdr *eth = (struct rte_ether_hdr *)data;
+	memset(eth, 0, sizeof(*eth));
+	eth->ether_type = rte_cpu_to_be_16(RTE_ETHER_TYPE_VLAN);
+
+	uint32_t off = sizeof(*eth);
+	struct rte_vlan_hdr *vlan = (struct rte_vlan_hdr *)(data + off);
+	vlan->vlan_tci = rte_cpu_to_be_16(100);
+	vlan->eth_proto = rte_cpu_to_be_16(RTE_ETHER_TYPE_IPV6);
+	off += sizeof(*vlan);
+
+	fill_ipv6_udp_ptp(data, off, msg_type, dst_port, 800);
+	return m;
+}
+
+static struct rte_mbuf *
+build_qinq_ipv6_udp_ptp(uint8_t msg_type, uint16_t dst_port)
+{
+	struct rte_mbuf *m = rte_pktmbuf_alloc(ptp_mp);
+	if (!m)
+		return NULL;
+
+	uint32_t pkt_len = sizeof(struct rte_ether_hdr) +
+			   2 * sizeof(struct rte_vlan_hdr) +
+			   sizeof(struct rte_ipv6_hdr) +
+			   sizeof(struct rte_udp_hdr) +
+			   sizeof(struct rte_ptp_hdr);
+	uint8_t *data = (uint8_t *)rte_pktmbuf_append(m, pkt_len);
+
+	struct rte_ether_hdr *eth = (struct rte_ether_hdr *)data;
+	memset(eth, 0, sizeof(*eth));
+	eth->ether_type = rte_cpu_to_be_16(RTE_ETHER_TYPE_QINQ);
+
+	uint32_t off = sizeof(*eth);
+	struct rte_vlan_hdr *vo = (struct rte_vlan_hdr *)(data + off);
+	vo->vlan_tci = rte_cpu_to_be_16(200);
+	vo->eth_proto = rte_cpu_to_be_16(RTE_ETHER_TYPE_VLAN);
+	off += sizeof(*vo);
+
+	struct rte_vlan_hdr *vi = (struct rte_vlan_hdr *)(data + off);
+	vi->vlan_tci = rte_cpu_to_be_16(300);
+	vi->eth_proto = rte_cpu_to_be_16(RTE_ETHER_TYPE_IPV6);
+	off += sizeof(*vi);
+
+	fill_ipv6_udp_ptp(data, off, msg_type, dst_port, 900);
+	return m;
+}
+
+static struct rte_mbuf *
+build_non_ptp(void)
+{
+	struct rte_mbuf *m = rte_pktmbuf_alloc(ptp_mp);
+	if (!m)
+		return NULL;
+
+	uint32_t pkt_len = sizeof(struct rte_ether_hdr) + 28;
+	uint8_t *data = (uint8_t *)rte_pktmbuf_append(m, pkt_len);
+
+	struct rte_ether_hdr *eth = (struct rte_ether_hdr *)data;
+	memset(data, 0, pkt_len);
+	eth->ether_type = rte_cpu_to_be_16(0x0806);
+	return m;
+}
+
+static struct rte_mbuf *
+build_ipv4_udp_non_ptp(void)
+{
+	struct rte_mbuf *m = rte_pktmbuf_alloc(ptp_mp);
+	if (!m)
+		return NULL;
+
+	uint32_t pkt_len = sizeof(struct rte_ether_hdr) +
+			   sizeof(struct rte_ipv4_hdr) +
+			   sizeof(struct rte_udp_hdr) + 20;
+	uint8_t *data = (uint8_t *)rte_pktmbuf_append(m, pkt_len);
+
+	struct rte_ether_hdr *eth = (struct rte_ether_hdr *)data;
+	memset(data, 0, pkt_len);
+	eth->ether_type = rte_cpu_to_be_16(RTE_ETHER_TYPE_IPV4);
+
+	struct rte_ipv4_hdr *iph = (struct rte_ipv4_hdr *)(data + sizeof(*eth));
+	iph->version_ihl = 0x45;
+	iph->next_proto_id = IPPROTO_UDP;
+	iph->total_length = rte_cpu_to_be_16(
+		sizeof(*iph) + sizeof(struct rte_udp_hdr) + 20);
+
+	struct rte_udp_hdr *udp = (struct rte_udp_hdr *)
+		(data + sizeof(*eth) + sizeof(*iph));
+	udp->dst_port = rte_cpu_to_be_16(53);
+	return m;
+}
+
+/* ================================================================
+ *  Individual test cases
+ * ================================================================
+ */
+
+/* Helper: classify + hdr_get for a given mbuf */
+static int
+check_classify_and_hdr_get(struct rte_mbuf *m, int expected_type)
+{
+	int ret;
+
+	TEST_ASSERT_NOT_NULL(m, "mbuf allocation failed");
+
+	ret = rte_ptp_classify(m);
+	TEST_ASSERT_EQUAL(ret, expected_type,
+		"classify: expected %d, got %d", expected_type, ret);
+
+	struct rte_ptp_hdr *hdr = rte_ptp_hdr_get(m);
+	if (expected_type == RTE_PTP_MSGTYPE_INVALID) {
+		TEST_ASSERT_NULL(hdr,
+			"hdr_get: expected NULL for non-PTP packet");
+	} else {
+		TEST_ASSERT_NOT_NULL(hdr,
+			"hdr_get: expected non-NULL for PTP packet");
+		TEST_ASSERT_EQUAL(rte_ptp_msg_type(hdr),
+			(uint8_t)expected_type,
+			"hdr_get: msg_type mismatch: expected %d, got %d",
+			expected_type, rte_ptp_msg_type(hdr));
+	}
+
+	rte_pktmbuf_free(m);
+	return TEST_SUCCESS;
+}
+
+/* Section 1: Transport classification */
+static int
+test_ptp_classify_l2(void)
+{
+	return check_classify_and_hdr_get(
+		build_l2_ptp(RTE_PTP_MSGTYPE_SYNC), RTE_PTP_MSGTYPE_SYNC);
+}
+
+static int
+test_ptp_classify_l2_delay_req(void)
+{
+	return check_classify_and_hdr_get(
+		build_l2_ptp(RTE_PTP_MSGTYPE_DELAY_REQ),
+		RTE_PTP_MSGTYPE_DELAY_REQ);
+}
+
+static int
+test_ptp_classify_vlan_8100(void)
+{
+	return check_classify_and_hdr_get(
+		build_vlan_l2_ptp(RTE_PTP_MSGTYPE_SYNC, RTE_ETHER_TYPE_VLAN),
+		RTE_PTP_MSGTYPE_SYNC);
+}
+
+static int
+test_ptp_classify_vlan_88a8(void)
+{
+	return check_classify_and_hdr_get(
+		build_vlan_l2_ptp(RTE_PTP_MSGTYPE_SYNC, RTE_ETHER_TYPE_QINQ),
+		RTE_PTP_MSGTYPE_SYNC);
+}
+
+static int
+test_ptp_classify_qinq(void)
+{
+	return check_classify_and_hdr_get(
+		build_qinq_l2_ptp(RTE_PTP_MSGTYPE_SYNC,
+			RTE_ETHER_TYPE_QINQ, RTE_ETHER_TYPE_VLAN),
+		RTE_PTP_MSGTYPE_SYNC);
+}
+
+static int
+test_ptp_classify_double_8100(void)
+{
+	return check_classify_and_hdr_get(
+		build_qinq_l2_ptp(RTE_PTP_MSGTYPE_SYNC,
+			RTE_ETHER_TYPE_VLAN, RTE_ETHER_TYPE_VLAN),
+		RTE_PTP_MSGTYPE_SYNC);
+}
+
+static int
+test_ptp_classify_ipv4_udp_319(void)
+{
+	return check_classify_and_hdr_get(
+		build_ipv4_udp_ptp(RTE_PTP_MSGTYPE_SYNC, 319),
+		RTE_PTP_MSGTYPE_SYNC);
+}
+
+static int
+test_ptp_classify_ipv4_udp_320(void)
+{
+	return check_classify_and_hdr_get(
+		build_ipv4_udp_ptp(RTE_PTP_MSGTYPE_FOLLOW_UP, 320),
+		RTE_PTP_MSGTYPE_FOLLOW_UP);
+}
+
+static int
+test_ptp_classify_vlan_ipv4_udp(void)
+{
+	return check_classify_and_hdr_get(
+		build_vlan_ipv4_udp_ptp(RTE_PTP_MSGTYPE_SYNC, 319),
+		RTE_PTP_MSGTYPE_SYNC);
+}
+
+static int
+test_ptp_classify_qinq_ipv4_udp(void)
+{
+	return check_classify_and_hdr_get(
+		build_qinq_ipv4_udp_ptp(RTE_PTP_MSGTYPE_SYNC, 319),
+		RTE_PTP_MSGTYPE_SYNC);
+}
+
+static int
+test_ptp_classify_ipv6_udp_319(void)
+{
+	return check_classify_and_hdr_get(
+		build_ipv6_udp_ptp(RTE_PTP_MSGTYPE_SYNC, 319),
+		RTE_PTP_MSGTYPE_SYNC);
+}
+
+static int
+test_ptp_classify_ipv6_udp_320(void)
+{
+	return check_classify_and_hdr_get(
+		build_ipv6_udp_ptp(RTE_PTP_MSGTYPE_FOLLOW_UP, 320),
+		RTE_PTP_MSGTYPE_FOLLOW_UP);
+}
+
+static int
+test_ptp_classify_vlan_ipv6_udp(void)
+{
+	return check_classify_and_hdr_get(
+		build_vlan_ipv6_udp_ptp(RTE_PTP_MSGTYPE_SYNC, 319),
+		RTE_PTP_MSGTYPE_SYNC);
+}
+
+static int
+test_ptp_classify_qinq_ipv6_udp(void)
+{
+	return check_classify_and_hdr_get(
+		build_qinq_ipv6_udp_ptp(RTE_PTP_MSGTYPE_SYNC, 319),
+		RTE_PTP_MSGTYPE_SYNC);
+}
+
+static int
+test_ptp_classify_non_ptp_arp(void)
+{
+	return check_classify_and_hdr_get(
+		build_non_ptp(), RTE_PTP_MSGTYPE_INVALID);
+}
+
+static int
+test_ptp_classify_non_ptp_udp(void)
+{
+	return check_classify_and_hdr_get(
+		build_ipv4_udp_non_ptp(), RTE_PTP_MSGTYPE_INVALID);
+}
+
+/* IPv4 with invalid IHL (< 5) should be rejected */
+static int
+test_ptp_classify_ipv4_bad_ihl(void)
+{
+	struct rte_mbuf *m = rte_pktmbuf_alloc(ptp_mp);
+
+	TEST_ASSERT_NOT_NULL(m, "alloc failed");
+
+	uint32_t pkt_len = sizeof(struct rte_ether_hdr) +
+			   sizeof(struct rte_ipv4_hdr) +
+			   sizeof(struct rte_udp_hdr) +
+			   sizeof(struct rte_ptp_hdr);
+	uint8_t *data = (uint8_t *)rte_pktmbuf_append(m, pkt_len);
+
+	struct rte_ether_hdr *eth = (struct rte_ether_hdr *)data;
+	memset(eth, 0, sizeof(*eth));
+	eth->ether_type = rte_cpu_to_be_16(RTE_ETHER_TYPE_IPV4);
+
+	fill_ipv4_udp_ptp(data, sizeof(*eth), RTE_PTP_MSGTYPE_SYNC, 319, 999);
+
+	/* Corrupt the IHL to 3 (< minimum 5) */
+	struct rte_ipv4_hdr *iph = (struct rte_ipv4_hdr *)
+		(data + sizeof(*eth));
+	iph->version_ihl = 0x43;
+
+	return check_classify_and_hdr_get(m, RTE_PTP_MSGTYPE_INVALID);
+}
+
+/* Truncated packet: Ethernet header only, no payload */
+static int
+test_ptp_classify_truncated(void)
+{
+	struct rte_mbuf *m = rte_pktmbuf_alloc(ptp_mp);
+
+	TEST_ASSERT_NOT_NULL(m, "alloc failed");
+
+	uint8_t *data = (uint8_t *)rte_pktmbuf_append(m,
+		sizeof(struct rte_ether_hdr));
+	struct rte_ether_hdr *eth = (struct rte_ether_hdr *)data;
+	memset(eth, 0, sizeof(*eth));
+	eth->ether_type = rte_cpu_to_be_16(0x88F7);
+
+	return check_classify_and_hdr_get(m, RTE_PTP_MSGTYPE_INVALID);
+}
+
+/* Section 2: All 10 message types via L2 */
+static int
+test_ptp_all_msg_types(void)
+{
+	static const uint8_t types[] = {
+		RTE_PTP_MSGTYPE_SYNC,
+		RTE_PTP_MSGTYPE_DELAY_REQ,
+		RTE_PTP_MSGTYPE_PDELAY_REQ,
+		RTE_PTP_MSGTYPE_PDELAY_RESP,
+		RTE_PTP_MSGTYPE_FOLLOW_UP,
+		RTE_PTP_MSGTYPE_DELAY_RESP,
+		RTE_PTP_MSGTYPE_PDELAY_RESP_FU,
+		RTE_PTP_MSGTYPE_ANNOUNCE,
+		RTE_PTP_MSGTYPE_SIGNALING,
+		RTE_PTP_MSGTYPE_MANAGEMENT,
+	};
+	unsigned int i;
+
+	for (i = 0; i < RTE_DIM(types); i++) {
+		int ret = check_classify_and_hdr_get(
+			build_l2_ptp(types[i]), types[i]);
+		if (ret != TEST_SUCCESS)
+			return ret;
+	}
+
+	return TEST_SUCCESS;
+}
+
+/* Section 3: Inline helpers */
+static int
+test_ptp_is_event(void)
+{
+	TEST_ASSERT(rte_ptp_is_event(RTE_PTP_MSGTYPE_SYNC),
+		"Sync should be event");
+	TEST_ASSERT(rte_ptp_is_event(RTE_PTP_MSGTYPE_DELAY_REQ),
+		"Delay_Req should be event");
+	TEST_ASSERT(rte_ptp_is_event(RTE_PTP_MSGTYPE_PDELAY_REQ),
+		"Pdelay_Req should be event");
+	TEST_ASSERT(rte_ptp_is_event(RTE_PTP_MSGTYPE_PDELAY_RESP),
+		"Pdelay_Resp should be event");
+	TEST_ASSERT(!rte_ptp_is_event(RTE_PTP_MSGTYPE_FOLLOW_UP),
+		"Follow_Up should not be event");
+	TEST_ASSERT(!rte_ptp_is_event(RTE_PTP_MSGTYPE_ANNOUNCE),
+		"Announce should not be event");
+	TEST_ASSERT(!rte_ptp_is_event(RTE_PTP_MSGTYPE_INVALID),
+		"INVALID (-1) should not be event");
+
+	return TEST_SUCCESS;
+}
+
+static int
+test_ptp_two_step(void)
+{
+	struct rte_mbuf *m;
+	struct rte_ptp_hdr *hdr;
+
+	m = build_l2_ptp(RTE_PTP_MSGTYPE_SYNC);
+	TEST_ASSERT_NOT_NULL(m, "alloc failed");
+	hdr = rte_ptp_hdr_get(m);
+	TEST_ASSERT_NOT_NULL(hdr, "hdr_get failed");
+	TEST_ASSERT(rte_ptp_is_two_step(hdr),
+		"TWO_STEP flag should be set");
+	rte_pktmbuf_free(m);
+
+	m = build_l2_ptp_noflags(RTE_PTP_MSGTYPE_SYNC);
+	TEST_ASSERT_NOT_NULL(m, "alloc failed");
+	hdr = rte_ptp_hdr_get(m);
+	TEST_ASSERT_NOT_NULL(hdr, "hdr_get failed");
+	TEST_ASSERT(!rte_ptp_is_two_step(hdr),
+		"TWO_STEP flag should not be set");
+	rte_pktmbuf_free(m);
+
+	return TEST_SUCCESS;
+}
+
+static int
+test_ptp_seq_id(void)
+{
+	struct rte_mbuf *m = build_l2_ptp(RTE_PTP_MSGTYPE_SYNC);
+
+	TEST_ASSERT_NOT_NULL(m, "alloc failed");
+	struct rte_ptp_hdr *hdr = rte_ptp_hdr_get(m);
+	TEST_ASSERT_NOT_NULL(hdr, "hdr_get failed");
+	TEST_ASSERT_EQUAL(rte_ptp_seq_id(hdr), 100,
+		"seq_id: expected 100, got %u", rte_ptp_seq_id(hdr));
+	rte_pktmbuf_free(m);
+
+	return TEST_SUCCESS;
+}
+
+static int
+test_ptp_version(void)
+{
+	struct rte_mbuf *m = build_l2_ptp(RTE_PTP_MSGTYPE_SYNC);
+
+	TEST_ASSERT_NOT_NULL(m, "alloc failed");
+	struct rte_ptp_hdr *hdr = rte_ptp_hdr_get(m);
+	TEST_ASSERT_NOT_NULL(hdr, "hdr_get failed");
+	TEST_ASSERT_EQUAL(rte_ptp_version(hdr), 2,
+		"version: expected 2, got %u", rte_ptp_version(hdr));
+	rte_pktmbuf_free(m);
+
+	return TEST_SUCCESS;
+}
+
+static int
+test_ptp_domain(void)
+{
+	struct rte_mbuf *m = build_l2_ptp(RTE_PTP_MSGTYPE_SYNC);
+
+	TEST_ASSERT_NOT_NULL(m, "alloc failed");
+	struct rte_ptp_hdr *hdr = rte_ptp_hdr_get(m);
+	TEST_ASSERT_NOT_NULL(hdr, "hdr_get failed");
+	TEST_ASSERT_EQUAL(rte_ptp_domain(hdr), 0,
+		"domain: expected 0, got %u", rte_ptp_domain(hdr));
+	rte_pktmbuf_free(m);
+
+	return TEST_SUCCESS;
+}
+
+/* Section 4: correctionField */
+static int
+test_ptp_correction_zero(void)
+{
+	struct rte_mbuf *m = build_l2_ptp(RTE_PTP_MSGTYPE_SYNC);
+
+	TEST_ASSERT_NOT_NULL(m, "alloc failed");
+	struct rte_ptp_hdr *hdr = rte_ptp_hdr_get(m);
+	int64_t ns = rte_ptp_correction_ns(hdr);
+	TEST_ASSERT_EQUAL(ns, 0,
+		"correction_ns: expected 0, got %" PRId64, ns);
+	rte_pktmbuf_free(m);
+
+	return TEST_SUCCESS;
+}
+
+static int
+test_ptp_correction_known(void)
+{
+	struct rte_mbuf *m = rte_pktmbuf_alloc(ptp_mp);
+
+	TEST_ASSERT_NOT_NULL(m, "alloc failed");
+	uint8_t *data = (uint8_t *)rte_pktmbuf_append(m,
+		sizeof(struct rte_ether_hdr) + sizeof(struct rte_ptp_hdr));
+	struct rte_ether_hdr *eth = (struct rte_ether_hdr *)data;
+	memset(eth, 0, sizeof(*eth));
+	eth->ether_type = rte_cpu_to_be_16(0x88F7);
+
+	struct rte_ptp_hdr *ptp = (struct rte_ptp_hdr *)(data + sizeof(*eth));
+	int64_t scaled_1000 = (int64_t)1000 << 16;
+	fill_ptp_hdr(ptp, RTE_PTP_MSGTYPE_SYNC, 0, scaled_1000, 0);
+
+	int64_t ns = rte_ptp_correction_ns(ptp);
+	TEST_ASSERT_EQUAL(ns, 1000,
+		"correction_ns: expected 1000, got %" PRId64, ns);
+	rte_pktmbuf_free(m);
+
+	return TEST_SUCCESS;
+}
+
+static int
+test_ptp_add_correction(void)
+{
+	struct rte_mbuf *m = build_l2_ptp(RTE_PTP_MSGTYPE_SYNC);
+
+	TEST_ASSERT_NOT_NULL(m, "alloc failed");
+	struct rte_ptp_hdr *hdr = rte_ptp_hdr_get(m);
+
+	rte_ptp_add_correction(hdr, 500);
+	int64_t ns = rte_ptp_correction_ns(hdr);
+	TEST_ASSERT_EQUAL(ns, 500,
+		"add 500: expected 500, got %" PRId64, ns);
+	rte_pktmbuf_free(m);
+
+	return TEST_SUCCESS;
+}
+
+static int
+test_ptp_add_correction_accumulate(void)
+{
+	struct rte_mbuf *m = build_l2_ptp(RTE_PTP_MSGTYPE_SYNC);
+
+	TEST_ASSERT_NOT_NULL(m, "alloc failed");
+	struct rte_ptp_hdr *hdr = rte_ptp_hdr_get(m);
+
+	rte_ptp_add_correction(hdr, 300);
+	rte_ptp_add_correction(hdr, 700);
+	int64_t ns = rte_ptp_correction_ns(hdr);
+	TEST_ASSERT_EQUAL(ns, 1000,
+		"accumulate: expected 1000, got %" PRId64, ns);
+	rte_pktmbuf_free(m);
+
+	return TEST_SUCCESS;
+}
+
+static int
+test_ptp_add_correction_large(void)
+{
+	struct rte_mbuf *m = build_l2_ptp(RTE_PTP_MSGTYPE_SYNC);
+
+	TEST_ASSERT_NOT_NULL(m, "alloc failed");
+	struct rte_ptp_hdr *hdr = rte_ptp_hdr_get(m);
+
+	rte_ptp_add_correction(hdr, 1000000000LL);
+	int64_t ns = rte_ptp_correction_ns(hdr);
+	TEST_ASSERT_EQUAL(ns, 1000000000LL,
+		"1s: expected 1000000000, got %" PRId64, ns);
+	rte_pktmbuf_free(m);
+
+	return TEST_SUCCESS;
+}
+
+static int
+test_ptp_add_correction_negative(void)
+{
+	struct rte_mbuf *m = build_l2_ptp(RTE_PTP_MSGTYPE_SYNC);
+
+	TEST_ASSERT_NOT_NULL(m, "alloc failed");
+	struct rte_ptp_hdr *hdr = rte_ptp_hdr_get(m);
+
+	rte_ptp_add_correction(hdr, -100LL);
+	int64_t ns = rte_ptp_correction_ns(hdr);
+	TEST_ASSERT_EQUAL(ns, -100LL,
+		"negative: expected -100, got %" PRId64, ns);
+	rte_pktmbuf_free(m);
+
+	return TEST_SUCCESS;
+}
+
+/* Section 5: Timestamp conversion */
+static int
+test_ptp_timestamp_to_ns(void)
+{
+	struct rte_ptp_timestamp ts;
+	uint64_t ns;
+
+	/* Zero */
+	memset(&ts, 0, sizeof(ts));
+	ns = rte_ptp_timestamp_to_ns(&ts);
+	TEST_ASSERT_EQUAL(ns, 0ULL,
+		"zero: expected 0, got %" PRIu64, ns);
+
+	/* 1 second */
+	ts.seconds_hi = 0;
+	ts.seconds_lo = rte_cpu_to_be_32(1);
+	ts.nanoseconds = 0;
+	ns = rte_ptp_timestamp_to_ns(&ts);
+	TEST_ASSERT_EQUAL(ns, 1000000000ULL,
+		"1s: expected 1000000000, got %" PRIu64, ns);
+
+	/* 1.5 seconds */
+	ts.seconds_lo = rte_cpu_to_be_32(1);
+	ts.nanoseconds = rte_cpu_to_be_32(500000000);
+	ns = rte_ptp_timestamp_to_ns(&ts);
+	TEST_ASSERT_EQUAL(ns, 1500000000ULL,
+		"1.5s: expected 1500000000, got %" PRIu64, ns);
+
+	/* Large value with seconds_hi */
+	ts.seconds_hi = rte_cpu_to_be_16(1);
+	ts.seconds_lo = 0;
+	ts.nanoseconds = 0;
+	ns = rte_ptp_timestamp_to_ns(&ts);
+	uint64_t expected = ((uint64_t)1 << 32) * 1000000000ULL;
+	TEST_ASSERT_EQUAL(ns, expected,
+		"2^32s: expected %" PRIu64 ", got %" PRIu64, expected, ns);
+
+	return TEST_SUCCESS;
+}
+
+/* Section 6: msg_type_str */
+static int
+test_ptp_msg_type_str(void)
+{
+	static const struct {
+		int type;
+		const char *expected;
+	} cases[] = {
+		{ RTE_PTP_MSGTYPE_SYNC,           "Sync" },
+		{ RTE_PTP_MSGTYPE_DELAY_REQ,      "Delay_Req" },
+		{ RTE_PTP_MSGTYPE_PDELAY_REQ,     "PDelay_Req" },
+		{ RTE_PTP_MSGTYPE_PDELAY_RESP,    "PDelay_Resp" },
+		{ RTE_PTP_MSGTYPE_FOLLOW_UP,      "Follow_Up" },
+		{ RTE_PTP_MSGTYPE_DELAY_RESP,     "Delay_Resp" },
+		{ RTE_PTP_MSGTYPE_PDELAY_RESP_FU, "PDelay_Resp_Follow_Up" },
+		{ RTE_PTP_MSGTYPE_ANNOUNCE,       "Announce" },
+		{ RTE_PTP_MSGTYPE_SIGNALING,      "Signaling" },
+		{ RTE_PTP_MSGTYPE_MANAGEMENT,     "Management" },
+	};
+	unsigned int i;
+
+	for (i = 0; i < RTE_DIM(cases); i++) {
+		const char *str = rte_ptp_msg_type_str(cases[i].type);
+		TEST_ASSERT_NOT_NULL(str,
+			"msg_type_str(%d) returned NULL", cases[i].type);
+		TEST_ASSERT(strcmp(str, cases[i].expected) == 0,
+			"msg_type_str(%d): expected \"%s\", got \"%s\"",
+			cases[i].type, cases[i].expected, str);
+	}
+
+	/* Invalid type should still return non-NULL */
+	const char *inv = rte_ptp_msg_type_str(RTE_PTP_MSGTYPE_INVALID);
+	TEST_ASSERT_NOT_NULL(inv,
+		"msg_type_str(INVALID) returned NULL");
+
+	return TEST_SUCCESS;
+}
+
+/* Section 7: Flag bit positions */
+static int
+test_ptp_flags(void)
+{
+	struct rte_ptp_hdr hdr;
+	uint16_t f;
+
+	/* TWO_STEP */
+	memset(&hdr, 0, sizeof(hdr));
+	hdr.flags = rte_cpu_to_be_16(RTE_PTP_FLAG_TWO_STEP);
+	f = rte_be_to_cpu_16(hdr.flags);
+	TEST_ASSERT(f & RTE_PTP_FLAG_TWO_STEP,
+		"TWO_STEP bit not set: 0x%04x", f);
+	TEST_ASSERT(rte_ptp_is_two_step(&hdr),
+		"is_two_step() should return true");
+
+	/* UNICAST */
+	memset(&hdr, 0, sizeof(hdr));
+	hdr.flags = rte_cpu_to_be_16(RTE_PTP_FLAG_UNICAST);
+	f = rte_be_to_cpu_16(hdr.flags);
+	TEST_ASSERT(f & RTE_PTP_FLAG_UNICAST,
+		"UNICAST bit not set: 0x%04x", f);
+
+	/* LI_61 */
+	memset(&hdr, 0, sizeof(hdr));
+	hdr.flags = rte_cpu_to_be_16(RTE_PTP_FLAG_LI_61);
+	f = rte_be_to_cpu_16(hdr.flags);
+	TEST_ASSERT(f & RTE_PTP_FLAG_LI_61,
+		"LI_61 bit not set: 0x%04x", f);
+
+	/* LI_59 */
+	memset(&hdr, 0, sizeof(hdr));
+	hdr.flags = rte_cpu_to_be_16(RTE_PTP_FLAG_LI_59);
+	f = rte_be_to_cpu_16(hdr.flags);
+	TEST_ASSERT(f & RTE_PTP_FLAG_LI_59,
+		"LI_59 bit not set: 0x%04x", f);
+
+	/* Combined TWO_STEP + UNICAST */
+	memset(&hdr, 0, sizeof(hdr));
+	hdr.flags = rte_cpu_to_be_16(
+		RTE_PTP_FLAG_TWO_STEP | RTE_PTP_FLAG_UNICAST);
+	f = rte_be_to_cpu_16(hdr.flags);
+	TEST_ASSERT((f & RTE_PTP_FLAG_TWO_STEP) &&
+		    (f & RTE_PTP_FLAG_UNICAST) &&
+		    !(f & RTE_PTP_FLAG_LI_61) &&
+		    !(f & RTE_PTP_FLAG_LI_59),
+		"combined flags incorrect: 0x%04x", f);
+
+	return TEST_SUCCESS;
+}
+
+/* ================================================================
+ *  Suite setup / teardown
+ * ================================================================
+ */
+
+static int
+test_ptp_setup(void)
+{
+	ptp_mp = rte_pktmbuf_pool_create(PTP_TEST_MP_NAME, PTP_TEST_MP_SIZE,
+		0, 0, PTP_TEST_BUF_SIZE, SOCKET_ID_ANY);
+	if (ptp_mp == NULL) {
+		printf("Cannot create ptp test mempool\n");
+		return TEST_FAILED;
+	}
+	return TEST_SUCCESS;
+}
+
+static void
+test_ptp_teardown(void)
+{
+	rte_mempool_free(ptp_mp);
+	ptp_mp = NULL;
+}
+
+static struct unit_test_suite ptp_test_suite = {
+	.suite_name = "PTP Library Unit Tests",
+	.setup = test_ptp_setup,
+	.teardown = test_ptp_teardown,
+	.unit_test_cases = {
+		/* Transport classification */
+		TEST_CASE(test_ptp_classify_l2),
+		TEST_CASE(test_ptp_classify_l2_delay_req),
+		TEST_CASE(test_ptp_classify_vlan_8100),
+		TEST_CASE(test_ptp_classify_vlan_88a8),
+		TEST_CASE(test_ptp_classify_qinq),
+		TEST_CASE(test_ptp_classify_double_8100),
+		TEST_CASE(test_ptp_classify_ipv4_udp_319),
+		TEST_CASE(test_ptp_classify_ipv4_udp_320),
+		TEST_CASE(test_ptp_classify_vlan_ipv4_udp),
+		TEST_CASE(test_ptp_classify_qinq_ipv4_udp),
+		TEST_CASE(test_ptp_classify_ipv6_udp_319),
+		TEST_CASE(test_ptp_classify_ipv6_udp_320),
+		TEST_CASE(test_ptp_classify_vlan_ipv6_udp),
+		TEST_CASE(test_ptp_classify_qinq_ipv6_udp),
+		TEST_CASE(test_ptp_classify_non_ptp_arp),
+		TEST_CASE(test_ptp_classify_non_ptp_udp),
+		TEST_CASE(test_ptp_classify_ipv4_bad_ihl),
+		TEST_CASE(test_ptp_classify_truncated),
+
+		/* All message types */
+		TEST_CASE(test_ptp_all_msg_types),
+
+		/* Inline helpers */
+		TEST_CASE(test_ptp_is_event),
+		TEST_CASE(test_ptp_two_step),
+		TEST_CASE(test_ptp_seq_id),
+		TEST_CASE(test_ptp_version),
+		TEST_CASE(test_ptp_domain),
+
+		/* correctionField */
+		TEST_CASE(test_ptp_correction_zero),
+		TEST_CASE(test_ptp_correction_known),
+		TEST_CASE(test_ptp_add_correction),
+		TEST_CASE(test_ptp_add_correction_accumulate),
+		TEST_CASE(test_ptp_add_correction_large),
+		TEST_CASE(test_ptp_add_correction_negative),
+
+		/* Timestamp conversion */
+		TEST_CASE(test_ptp_timestamp_to_ns),
+
+		/* msg_type_str */
+		TEST_CASE(test_ptp_msg_type_str),
+
+		/* Flag field bit positions */
+		TEST_CASE(test_ptp_flags),
+
+		TEST_CASES_END()
+	},
+};
+
+static int
+test_ptp(void)
+{
+	return unit_test_suite_runner(&ptp_test_suite);
+}
+
+REGISTER_FAST_TEST(ptp_autotest, NOHUGE_SKIP, ASAN_OK, test_ptp);
-- 
2.53.0

