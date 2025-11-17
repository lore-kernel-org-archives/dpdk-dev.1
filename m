Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C85BCEACEF
	for <dpdk-dev@archiver.kernel.org>; Mon, 17 Nov 2025 07:50:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4EDEB42788;
	Mon, 17 Nov 2025 08:50:56 +0100 (CET)
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com
 [113.46.200.217])
 by mails.dpdk.org (Postfix) with ESMTP id 09C02402A1
 for <dev@dpdk.org>; Mon, 17 Nov 2025 08:50:53 +0100 (CET)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=ZlX18Xa11wtAZb6VL89Pse4INZfQF4V35Z2OzIoAmI0=;
 b=P8TE6v+UypY49ncd3EdL1EiJ619DlzQzRu8u5QCseQKGZH/jzvWLSyvL140UJCyyxTSFO7idt
 52FeIArM1R2V2/4927AXr5BDE3Bo+BvMBaATaFKdJbF6NISWJA7589X80rLHYajJDNe1HR3d6py
 4j7x6f4fKJjtGswozbV7Qc4=
Received: from mail.maildlp.com (unknown [172.19.88.194])
 by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4d90HT2rNPzcb3b;
 Mon, 17 Nov 2025 15:48:53 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id D6EB7140257;
 Mon, 17 Nov 2025 15:50:51 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 17 Nov 2025 15:50:51 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <thomas@monjalon.net>, <stephen@networkplumber.org>
CC: <dev@dpdk.org>, <mingjinx.ye@intel.com>, <aman.deep.singh@intel.com>,
 <liuyonglong@huawei.com>, <yangxingui@huawei.com>, <lihuisong@huawei.com>
Subject: [PATCH] app/testpmd: fix inner UDP checksum offload fail
Date: Mon, 17 Nov 2025 15:50:46 +0800
Message-ID: <20251117075046.11624-1-fengchengwen@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.50.163.32]
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemk500009.china.huawei.com (7.202.194.94)
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

If the packet is ether+ipv6+vxlan+ether+ipv4+udp, the parse_l4_proto()
function will treat the inner IPv4 header as an IPv6 header. As a
result, it cannot identify the inner L4 protocol type, leading to the
failure of the inner UDP checksum offload.

This commit changes the handling of the inner layer to match that of
the outer layer, allowing for the reuse of subsequent processes. It
also fixes the issue where the L4 could not be identified in the case
of an ether+ipv4+vxlan+ether+ipv6+udp encapsulation.

Bugzilla ID: 1813
Fixes: 496159613ffc ("app/testpmd: fix L4 protocol retrieval from L3 header")
Fixes: 76730c7b9b5a ("app/testpmd: use packet type parsing API")
Cc: stable@dpdk.org

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 app/test-pmd/csumonly.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/app/test-pmd/csumonly.c b/app/test-pmd/csumonly.c
index a6e872e5a4..c841651756 100644
--- a/app/test-pmd/csumonly.c
+++ b/app/test-pmd/csumonly.c
@@ -526,11 +526,26 @@ get_tunnel_ol_flags_by_ptype(uint32_t ptype)
 }
 
 static uint8_t
-parse_l4_proto(const struct rte_mbuf *m, uint32_t off, uint32_t ptype, bool parse_inner)
+parse_l4_proto(const struct rte_mbuf *m, uint32_t off, uint32_t ptype, bool in_tunnel)
 {
+	uint32_t align_ptype = ptype;
 	int frag = 0, ret;
 
-	if (RTE_ETH_IS_IPV4_HDR(ptype)) {
+	if (in_tunnel) {
+		uint32_t mask_ptype = ptype & RTE_PTYPE_INNER_L3_MASK;
+		if (mask_ptype == RTE_PTYPE_INNER_L3_IPV4)
+			align_ptype = RTE_PTYPE_L3_IPV4;
+		else if (mask_ptype == RTE_PTYPE_INNER_L3_IPV4_EXT)
+			align_ptype = RTE_PTYPE_L3_IPV4_EXT;
+		else if (mask_ptype == RTE_PTYPE_INNER_L3_IPV6)
+			align_ptype = RTE_PTYPE_L3_IPV6;
+		else if (mask_ptype == RTE_PTYPE_INNER_L3_IPV6_EXT)
+			align_ptype = RTE_PTYPE_L3_IPV6_EXT;
+		else
+			align_ptype = 0;
+	}
+
+	if (RTE_ETH_IS_IPV4_HDR(align_ptype)) {
 		const struct rte_ipv4_hdr *ip4h;
 		struct rte_ipv4_hdr ip4h_copy;
 		ip4h = rte_pktmbuf_read(m, off, sizeof(*ip4h), &ip4h_copy);
@@ -538,17 +553,14 @@ parse_l4_proto(const struct rte_mbuf *m, uint32_t off, uint32_t ptype, bool pars
 			return 0;
 
 		return ip4h->next_proto_id;
-	} else if (RTE_ETH_IS_IPV6_HDR(ptype)) {
+	} else if (RTE_ETH_IS_IPV6_HDR(align_ptype)) {
 		const struct rte_ipv6_hdr *ip6h;
 		struct rte_ipv6_hdr ip6h_copy;
 		ip6h = rte_pktmbuf_read(m, off, sizeof(*ip6h), &ip6h_copy);
 		if (unlikely(ip6h == NULL))
 			return 0;
 
-		if (!parse_inner && (ptype & RTE_PTYPE_L3_MASK) != RTE_PTYPE_L3_IPV6_EXT)
-			return ip6h->proto;
-
-		if (parse_inner && (ptype & RTE_PTYPE_INNER_L3_MASK) != RTE_PTYPE_INNER_L3_IPV6_EXT)
+		if ((align_ptype & RTE_PTYPE_L3_MASK) != RTE_PTYPE_L3_IPV6_EXT)
 			return ip6h->proto;
 
 		off += sizeof(struct rte_ipv6_hdr);
-- 
2.17.1

