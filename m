Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BBC910BA45E
	for <dpdk-dev@archiver.kernel.org>; Sat, 28 Mar 2026 07:33:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 51B7A4021F;
	Sat, 28 Mar 2026 08:33:01 +0100 (CET)
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com
 [113.46.200.217])
 by mails.dpdk.org (Postfix) with ESMTP id 838FF400D6
 for <dev@dpdk.org>; Sat, 28 Mar 2026 08:32:59 +0100 (CET)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=Q17q778lWRrkzOgdyGxIfvJ3xRPAji5xvxJ5DFKD4l4=;
 b=JlJrjg/y9odXmdL2XyrnL/6EPB2d6lUuwigOKizRouq7pE5BAhKOmAfq4BZa7AaTre8/X4+Mg
 uttpLFVFYu4tLBX4kTnAfIh/3ox0F2yamdQgO3E063omwsldzDG3VyPgtSLxCC0dnnqs5M9qbtq
 gtPkTl6w/WQGU8yFkfzf6ek=
Received: from mail.maildlp.com (unknown [172.19.162.140])
 by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4fjTbj1MnBzcZxr;
 Sat, 28 Mar 2026 15:26:57 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
 by mail.maildlp.com (Postfix) with ESMTPS id 597AB2025F;
 Sat, 28 Mar 2026 15:32:54 +0800 (CST)
Received: from kwepemq100013.china.huawei.com (7.202.195.192) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 28 Mar 2026 15:32:54 +0800
Received: from localhost (10.174.243.191) by kwepemq100013.china.huawei.com
 (7.202.195.192) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 28 Mar
 2026 15:32:53 +0800
From: Yunjian Wang <wangyunjian@huawei.com>
To: <dev@dpdk.org>
CC: <chas3@att.com>, <humin29@huawei.com>, <jerry.lilijun@huawei.com>,
 "Yunjian Wang" <wangyunjian@huawei.com>
Subject: [PATCH 1/1] net/bonding: support UDPLITE protocol in l34 hashing
Date: Sat, 28 Mar 2026 15:32:22 +0800
Message-ID: <1774683142-27684-1-git-send-email-wangyunjian@huawei.com>
X-Mailer: git-send-email 1.9.5.msysgit.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.243.191]
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemq100013.china.huawei.com (7.202.195.192)
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

Add support for the UDPLITE protocol in l34 hashing.

Signed-off-by: Yunjian Wang <wangyunjian@huawei.com>
---
 drivers/net/bonding/rte_eth_bond_pmd.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/bonding/rte_eth_bond_pmd.c b/drivers/net/bonding/rte_eth_bond_pmd.c
index 96725071da..8c4cd039b2 100644
--- a/drivers/net/bonding/rte_eth_bond_pmd.c
+++ b/drivers/net/bonding/rte_eth_bond_pmd.c
@@ -798,7 +798,9 @@ burst_xmit_l34_hash(struct rte_mbuf **buf, uint16_t nb_pkts,
 							<= pkt_end)
 						l4hash = HASH_L4_PORTS(tcp_hdr);
 				} else if (ipv4_hdr->next_proto_id ==
-								IPPROTO_UDP) {
+						IPPROTO_UDP ||
+						ipv4_hdr->next_proto_id ==
+						IPPROTO_UDPLITE) {
 					udp_hdr = (struct rte_udp_hdr *)
 						((char *)ipv4_hdr +
 							ip_hdr_offset);
@@ -815,7 +817,8 @@ burst_xmit_l34_hash(struct rte_mbuf **buf, uint16_t nb_pkts,
 			if (ipv6_hdr->proto == IPPROTO_TCP) {
 				tcp_hdr = (struct rte_tcp_hdr *)(ipv6_hdr + 1);
 				l4hash = HASH_L4_PORTS(tcp_hdr);
-			} else if (ipv6_hdr->proto == IPPROTO_UDP) {
+			} else if (ipv6_hdr->proto == IPPROTO_UDP ||
+					ipv6_hdr->proto == IPPROTO_UDPLITE) {
 				udp_hdr = (struct rte_udp_hdr *)(ipv6_hdr + 1);
 				l4hash = HASH_L4_PORTS(udp_hdr);
 			}
-- 
2.33.0

