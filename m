Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCFC3CA0FF9
	for <dpdk-dev@archiver.kernel.org>; Sat, 30 Aug 2025 01:29:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A93FC40280;
	Sat, 30 Aug 2025 03:29:19 +0200 (CEST)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
 by mails.dpdk.org (Postfix) with ESMTP id 41F354027D
 for <dev@dpdk.org>; Sat, 30 Aug 2025 03:29:17 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.19.163.17])
 by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4cDHVl4j8Hz2Cfx8;
 Sat, 30 Aug 2025 09:24:47 +0800 (CST)
Received: from kwepemo500011.china.huawei.com (unknown [7.202.195.194])
 by mail.maildlp.com (Postfix) with ESMTPS id B57351A0188;
 Sat, 30 Aug 2025 09:29:14 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 kwepemo500011.china.huawei.com (7.202.195.194) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 30 Aug 2025 09:29:14 +0800
From: Dengdui Huang <huangdengdui@huawei.com>
To: <dev@dpdk.org>
CC: <aman.deep.singh@intel.com>, <stephen@networkplumber.org>,
 <lihuisong@huawei.com>, <fengchengwen@huawei.com>, <liuyonglong@huawei.com>
Subject: [PATCH] app/testpmd: fix L4 protocol retrieval from L3 header
Date: Sat, 30 Aug 2025 09:29:13 +0800
Message-ID: <20250830012913.1117632-1-huangdengdui@huawei.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.50.165.33]
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemo500011.china.huawei.com (7.202.195.194)
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

Currently, when retrieving the L4 protocol from the L3 header,
the case of IPv6 with extension headers is not handled correctly.
This patch fixes it.

Fixes: 76730c7b9b5a ("app/testpmd: use packet type parsing API")
Cc: stable@dpdk.org

Signed-off-by: Dengdui Huang <huangdengdui@huawei.com>
---
 app/test-pmd/csumonly.c | 39 ++++++++++++++++-----------------------
 1 file changed, 16 insertions(+), 23 deletions(-)

diff --git a/app/test-pmd/csumonly.c b/app/test-pmd/csumonly.c
index d355dbd8c0..a6e872e5a4 100644
--- a/app/test-pmd/csumonly.c
+++ b/app/test-pmd/csumonly.c
@@ -525,20 +525,8 @@ get_tunnel_ol_flags_by_ptype(uint32_t ptype)
 	}
 }
 
-static void
-parse_inner_l4_proto(void *outer_l3_hdr,
-			struct testpmd_offload_info *info)
-{
-	struct rte_ipv4_hdr *ipv4_hdr = outer_l3_hdr;
-	struct rte_ipv6_hdr *ipv6_hdr = outer_l3_hdr;
-	if (info->ethertype == _htons(RTE_ETHER_TYPE_IPV4))
-		info->l4_proto = ipv4_hdr->next_proto_id;
-	else
-		info->l4_proto = ipv6_hdr->proto;
-}
-
 static uint8_t
-parse_l4_proto(const struct rte_mbuf *m, uint32_t off, uint32_t ptype)
+parse_l4_proto(const struct rte_mbuf *m, uint32_t off, uint32_t ptype, bool parse_inner)
 {
 	int frag = 0, ret;
 
@@ -557,16 +545,19 @@ parse_l4_proto(const struct rte_mbuf *m, uint32_t off, uint32_t ptype)
 		if (unlikely(ip6h == NULL))
 			return 0;
 
-		if ((ptype & RTE_PTYPE_INNER_L3_MASK) ==
-				RTE_PTYPE_INNER_L3_IPV6_EXT) {
-			ret = rte_net_skip_ip6_ext(ip6h->proto, m, &off, &frag);
-			if (ret < 0)
-				return 0;
-			return ret;
-		}
+		if (!parse_inner && (ptype & RTE_PTYPE_L3_MASK) != RTE_PTYPE_L3_IPV6_EXT)
+			return ip6h->proto;
+
+		if (parse_inner && (ptype & RTE_PTYPE_INNER_L3_MASK) != RTE_PTYPE_INNER_L3_IPV6_EXT)
+			return ip6h->proto;
 
-		return ip6h->proto;
+		off += sizeof(struct rte_ipv6_hdr);
+		ret = rte_net_skip_ip6_ext(ip6h->proto, m, &off, &frag);
+		if (ret < 0)
+			return 0;
+		return ret;
 	}
+
 	return 0;
 }
 
@@ -705,7 +696,7 @@ pkt_burst_checksum_forward(struct fwd_stream *fs)
 		info.l4_len = hdr_lens.l4_len;
 		info.ethertype = get_ethertype_by_ptype(eth_hdr,
 					ptype & RTE_PTYPE_L3_MASK);
-		info.l4_proto = parse_l4_proto(m, info.l2_len, ptype);
+		info.l4_proto = parse_l4_proto(m, info.l2_len, ptype, false);
 
 		l3_hdr = (char *)eth_hdr + info.l2_len;
 		/* check if it's a supported tunnel */
@@ -723,9 +714,11 @@ pkt_burst_checksum_forward(struct fwd_stream *fs)
 		}
 		/* update l3_hdr and outer_l3_hdr if a tunnel was parsed */
 		if (info.is_tunnel) {
+			uint16_t l3_off = info.outer_l2_len +  info.outer_l3_len + info.l2_len;
+
 			outer_l3_hdr = l3_hdr;
 			l3_hdr = (char *)l3_hdr + info.outer_l3_len + info.l2_len;
-			parse_inner_l4_proto(l3_hdr, &info);
+			info.l4_proto = parse_l4_proto(m, l3_off, ptype, true);
 		}
 		/* step 2: depending on user command line configuration,
 		 * recompute checksum either in software or flag the
-- 
2.33.0

