Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47B6AC3ABD8
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 May 2025 09:29:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D49BA4042F;
	Fri, 16 May 2025 11:28:48 +0200 (CEST)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
 by mails.dpdk.org (Postfix) with ESMTP id 8EDD5402CD
 for <dev@dpdk.org>; Fri, 16 May 2025 11:28:44 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.19.163.174])
 by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4ZzMDK4l4Gz1d1Bt;
 Fri, 16 May 2025 17:27:13 +0800 (CST)
Received: from kwepemo500011.china.huawei.com (unknown [7.202.195.194])
 by mail.maildlp.com (Postfix) with ESMTPS id 4DB88140202;
 Fri, 16 May 2025 17:28:42 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 kwepemo500011.china.huawei.com (7.202.195.194) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 16 May 2025 17:28:41 +0800
From: Dengdui Huang <huangdengdui@huawei.com>
To: <dev@dpdk.org>
CC: <stephen@networkplumber.org>, <jasvinder.singh@intel.com>,
 <thomas@monjalon.net>, <aman.deep.singh@intel.com>, <lihuisong@huawei.com>,
 <fengchengwen@huawei.com>
Subject: [PATCH v3 2/4] net: fix parse the tunnel length of tunnel packet with
 UDP
Date: Fri, 16 May 2025 17:28:38 +0800
Message-ID: <20250516092840.2061252-3-huangdengdui@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250516092840.2061252-1-huangdengdui@huawei.com>
References: <20250417123739.2291519-1-huangdengdui@huawei.com>
 <20250516092840.2061252-1-huangdengdui@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.50.165.33]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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

Currently, the tunnel length info is not available when
get the tunnel packet type with UDP port. This patch
adds the parsing of the tunnel length info.

Fixes: 64ed7f854cf4 ("net: add tunnel packet type parsing")
Cc: stable@dpdk.org

Signed-off-by: Dengdui Huang <huangdengdui@huawei.com>
---
 lib/net/rte_net.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/net/rte_net.c b/lib/net/rte_net.c
index 1771588a09..67d57d5f04 100644
--- a/lib/net/rte_net.c
+++ b/lib/net/rte_net.c
@@ -197,6 +197,7 @@ ptype_tunnel_with_udp(uint16_t *proto, const struct rte_mbuf *m,
 	switch (port_no) {
 	case RTE_VXLAN_DEFAULT_PORT: {
 		*off += sizeof(struct rte_vxlan_hdr);
+		hdr_lens->tunnel_len = sizeof(struct rte_vxlan_hdr);
 		hdr_lens->inner_l2_len = RTE_ETHER_VXLAN_HLEN;
 		*proto = RTE_VXLAN_GPE_TYPE_ETH; /* just for eth header parse. */
 		return RTE_PTYPE_TUNNEL_VXLAN;
@@ -208,6 +209,7 @@ ptype_tunnel_with_udp(uint16_t *proto, const struct rte_mbuf *m,
 		if (unlikely(vgh == NULL))
 			return 0;
 		*off += sizeof(struct rte_vxlan_gpe_hdr);
+		hdr_lens->tunnel_len = sizeof(struct rte_vxlan_gpe_hdr);
 		hdr_lens->inner_l2_len = RTE_ETHER_VXLAN_GPE_HLEN;
 		*proto = vgh->proto;
 
@@ -243,6 +245,7 @@ ptype_tunnel_with_udp(uint16_t *proto, const struct rte_mbuf *m,
 		}
 		*off += gtp_len;
 		hdr_lens->inner_l2_len = gtp_len + sizeof(struct rte_udp_hdr);
+		hdr_lens->tunnel_len = gtp_len;
 		if (port_no == RTE_GTPC_UDP_PORT)
 			return RTE_PTYPE_TUNNEL_GTPC;
 		else if (port_no == RTE_GTPU_UDP_PORT)
@@ -258,6 +261,7 @@ ptype_tunnel_with_udp(uint16_t *proto, const struct rte_mbuf *m,
 			return 0;
 		geneve_len = sizeof(*gnh) + gnh->opt_len * 4;
 		*off = geneve_len;
+		hdr_lens->tunnel_len = geneve_len;
 		*proto = gnh->proto;
 		if (gnh->proto == 0)
 			*proto = rte_cpu_to_be_16(RTE_ETHER_TYPE_IPV4);
-- 
2.33.0

