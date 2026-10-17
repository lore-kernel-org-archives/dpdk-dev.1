Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1EB4CCF2C4
	for <dpdk-dev@archiver.kernel.org>; Sat, 17 Oct 2026 17:02:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A41FF40291;
	Sat, 17 Oct 2026 19:02:25 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 5A79B40276;
 Sat, 17 Oct 2026 19:02:24 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 319832080A;
 Sat, 17 Oct 2026 19:02:24 +0200 (CEST)
Received: from dkrd4.smartsharesys.local ([192.168.4.26]) by
 smartserver.smartsharesystems.com with Microsoft SMTPSVC(6.0.3790.4675); 
 Sat, 17 Oct 2026 19:02:22 +0200
From: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
To: dev@dpdk.org,
	Jiayu Hu <hujiayu.hu@foxmail.com>
Cc: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>,
 stable@dpdk.org
Subject: [PATCH] gro: fix packet type comparisons
Date: Sat, 17 Oct 2026 17:02:21 +0000
Message-ID: <20261017170221.3139971-1-mb@smartsharesystems.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 17 Oct 2026 17:02:22.0740 (UTC)
 FILETIME=[47020D40:01DD5E59]
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

Identifying packet types requires masking with the mask, not the value,
before comparing to the value.

Fixes: 0d2cbe59b719 ("lib/gro: support TCP/IPv4")
Fixes: 9e0b9d2ec0f4 ("gro: support VxLAN GRO")
Fixes: 1ca5e6740852 ("gro: support UDP/IPv4")
Fixes: e2d811063673 ("gro: support VXLAN UDP/IPv4")
Cc: stable@dpdk.org

Signed-off-by: Morten Brørup <mb@smartsharesystems.com>
---
 lib/gro/rte_gro.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/lib/gro/rte_gro.c b/lib/gro/rte_gro.c
index 578cc9b801..4f50b59322 100644
--- a/lib/gro/rte_gro.c
+++ b/lib/gro/rte_gro.c
@@ -35,26 +35,23 @@ static gro_tbl_pkt_count_fn tbl_pkt_count_fn[RTE_GRO_TYPE_MAX_NUM] = {
 			NULL};
 
 #define IS_IPV4_TCP_PKT(ptype) (RTE_ETH_IS_IPV4_HDR(ptype) && \
-		((ptype & RTE_PTYPE_L4_TCP) == RTE_PTYPE_L4_TCP) && \
-		((ptype & RTE_PTYPE_L4_FRAG) != RTE_PTYPE_L4_FRAG) && \
+		((ptype & RTE_PTYPE_L4_MASK) == RTE_PTYPE_L4_TCP) && \
 		(RTE_ETH_IS_TUNNEL_PKT(ptype) == 0))
 
 /* GRO with extension headers is not supported */
 #define IS_IPV6_TCP_PKT(ptype) (RTE_ETH_IS_IPV6_HDR(ptype) && \
-		((ptype & RTE_PTYPE_L4_TCP) == RTE_PTYPE_L4_TCP) && \
-		((ptype & RTE_PTYPE_L4_FRAG) != RTE_PTYPE_L4_FRAG) && \
+		((ptype & RTE_PTYPE_L4_MASK) == RTE_PTYPE_L4_TCP) && \
 		(RTE_ETH_IS_TUNNEL_PKT(ptype) == 0))
 
 #define IS_IPV4_UDP_PKT(ptype) (RTE_ETH_IS_IPV4_HDR(ptype) && \
-		((ptype & RTE_PTYPE_L4_UDP) == RTE_PTYPE_L4_UDP) && \
+		((ptype & RTE_PTYPE_L4_MASK) == RTE_PTYPE_L4_UDP) && \
 		(RTE_ETH_IS_TUNNEL_PKT(ptype) == 0))
 
 #define IS_IPV4_VXLAN_TCP4_PKT(ptype) (RTE_ETH_IS_IPV4_HDR(ptype) && \
-		((ptype & RTE_PTYPE_L4_UDP) == RTE_PTYPE_L4_UDP) && \
-		((ptype & RTE_PTYPE_L4_FRAG) != RTE_PTYPE_L4_FRAG) && \
-		((ptype & RTE_PTYPE_TUNNEL_VXLAN) == \
+		((ptype & RTE_PTYPE_L4_MASK) == RTE_PTYPE_L4_UDP) && \
+		((ptype & RTE_PTYPE_TUNNEL_MASK) == \
 		 RTE_PTYPE_TUNNEL_VXLAN) && \
-		((ptype & RTE_PTYPE_INNER_L4_TCP) == \
+		((ptype & RTE_PTYPE_INNER_L4_MASK) == \
 		 RTE_PTYPE_INNER_L4_TCP) && \
 		(((ptype & RTE_PTYPE_INNER_L3_MASK) == \
 		  RTE_PTYPE_INNER_L3_IPV4) || \
@@ -64,10 +61,10 @@ static gro_tbl_pkt_count_fn tbl_pkt_count_fn[RTE_GRO_TYPE_MAX_NUM] = {
 		  RTE_PTYPE_INNER_L3_IPV4_EXT_UNKNOWN)))
 
 #define IS_IPV4_VXLAN_UDP4_PKT(ptype) (RTE_ETH_IS_IPV4_HDR(ptype) && \
-		((ptype & RTE_PTYPE_L4_UDP) == RTE_PTYPE_L4_UDP) && \
-		((ptype & RTE_PTYPE_TUNNEL_VXLAN) == \
+		((ptype & RTE_PTYPE_L4_MASK) == RTE_PTYPE_L4_UDP) && \
+		((ptype & RTE_PTYPE_TUNNEL_MASK) == \
 		 RTE_PTYPE_TUNNEL_VXLAN) && \
-		((ptype & RTE_PTYPE_INNER_L4_UDP) == \
+		((ptype & RTE_PTYPE_INNER_L4_MASK) == \
 		 RTE_PTYPE_INNER_L4_UDP) && \
 		(((ptype & RTE_PTYPE_INNER_L3_MASK) == \
 		  RTE_PTYPE_INNER_L3_IPV4) || \
-- 
2.43.0

