Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 602AFC02192
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Feb 2025 01:34:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D55F640A7D;
	Thu,  6 Feb 2025 02:33:49 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 3652540608
 for <dev@dpdk.org>; Thu,  6 Feb 2025 02:33:38 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id D957E203F5AA; Wed,  5 Feb 2025 17:33:36 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D957E203F5AA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1738805616;
 bh=R1q3dWwl0t6YhWGgHYDG3ZXRsMth7Rdr4mn/KHJaCzs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=cKY7bfuCjRGdMtRSKNqd9cEumYDjkHaOvR87b8yoBElZtUuzGuvapzwLMR692igyL
 c/b3yHmYmwHit1RHygql6o3+4eXAYqG7yRJQBVBhG6JTu2mHi6Re9nVL1H8VmoXnN1
 gnkyhrzsfeQg2RuKpCX/PSbdtzo9jkB4IQC6LeBo=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: dev@dpdk.org
Cc: konstantin.ananyev@huawei.com, thomas@monjalon.net,
 david.marchand@redhat.com
Subject: [PATCH v22 09/27] gro: remove use of VLAs
Date: Wed,  5 Feb 2025 17:33:12 -0800
Message-Id: <1738805610-17507-10-git-send-email-andremue@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1738805610-17507-1-git-send-email-andremue@linux.microsoft.com>
References: <1713397319-26135-1-git-send-email-roretzla@linux.microsoft.com>
 <1738805610-17507-1-git-send-email-andremue@linux.microsoft.com>
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

From: Konstantin Ananyev <konstantin.ananyev@huawei.com>

../lib/gro/rte_gro.c:182:34: warning:
    variable length array used [-Wvla]
../lib/gro/rte_gro.c:363:34: warning:
    variable length array used [-Wvla]

In both cases the pattern is the same: we use unprocess_pkts[nb_pkts] to
collect un-used by GRO packets, and then copy them to the start of
input/output pkts[] array.
In both cases, we can safely copy pkts[i] into already
processed entry at the same array, i.e. into pkts[unprocess_num].
Such change eliminates need of temporary VLA: unprocess_pkts[nb_pkts].

Signed-off-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>
Acked-by: Ferruh Yigit <ferruh.yigit@amd.com>
---
 lib/gro/rte_gro.c | 40 ++++++++++++++--------------------------
 1 file changed, 14 insertions(+), 26 deletions(-)

diff --git a/lib/gro/rte_gro.c b/lib/gro/rte_gro.c
index db86117609..6d5aadf32a 100644
--- a/lib/gro/rte_gro.c
+++ b/lib/gro/rte_gro.c
@@ -179,7 +179,6 @@ rte_gro_reassemble_burst(struct rte_mbuf **pkts,
 	struct gro_vxlan_udp4_item vxlan_udp_items[RTE_GRO_MAX_BURST_ITEM_NUM]
 			= {{{0}} };
 
-	struct rte_mbuf *unprocess_pkts[nb_pkts];
 	uint32_t item_num;
 	int32_t ret;
 	uint16_t i, unprocess_num = 0, nb_after_gro = nb_pkts;
@@ -275,7 +274,7 @@ rte_gro_reassemble_burst(struct rte_mbuf **pkts,
 				/* Merge successfully */
 				nb_after_gro--;
 			else if (ret < 0)
-				unprocess_pkts[unprocess_num++] = pkts[i];
+				pkts[unprocess_num++] = pkts[i];
 		} else if (IS_IPV4_VXLAN_UDP4_PKT(pkts[i]->packet_type) &&
 				do_vxlan_udp_gro) {
 			ret = gro_vxlan_udp4_reassemble(pkts[i],
@@ -284,7 +283,7 @@ rte_gro_reassemble_burst(struct rte_mbuf **pkts,
 				/* Merge successfully */
 				nb_after_gro--;
 			else if (ret < 0)
-				unprocess_pkts[unprocess_num++] = pkts[i];
+				pkts[unprocess_num++] = pkts[i];
 		} else if (IS_IPV4_TCP_PKT(pkts[i]->packet_type) &&
 				do_tcp4_gro) {
 			ret = gro_tcp4_reassemble(pkts[i], &tcp_tbl, 0);
@@ -292,7 +291,7 @@ rte_gro_reassemble_burst(struct rte_mbuf **pkts,
 				/* merge successfully */
 				nb_after_gro--;
 			else if (ret < 0)
-				unprocess_pkts[unprocess_num++] = pkts[i];
+				pkts[unprocess_num++] = pkts[i];
 		} else if (IS_IPV4_UDP_PKT(pkts[i]->packet_type) &&
 				do_udp4_gro) {
 			ret = gro_udp4_reassemble(pkts[i], &udp_tbl, 0);
@@ -300,7 +299,7 @@ rte_gro_reassemble_burst(struct rte_mbuf **pkts,
 				/* merge successfully */
 				nb_after_gro--;
 			else if (ret < 0)
-				unprocess_pkts[unprocess_num++] = pkts[i];
+				pkts[unprocess_num++] = pkts[i];
 		} else if (IS_IPV6_TCP_PKT(pkts[i]->packet_type) &&
 				do_tcp6_gro) {
 			ret = gro_tcp6_reassemble(pkts[i], &tcp6_tbl, 0);
@@ -308,21 +307,15 @@ rte_gro_reassemble_burst(struct rte_mbuf **pkts,
 				/* merge successfully */
 				nb_after_gro--;
 			else if (ret < 0)
-				unprocess_pkts[unprocess_num++] = pkts[i];
+				pkts[unprocess_num++] = pkts[i];
 		} else
-			unprocess_pkts[unprocess_num++] = pkts[i];
+			pkts[unprocess_num++] = pkts[i];
 	}
 
 	if ((nb_after_gro < nb_pkts)
 		 || (unprocess_num < nb_pkts)) {
-		i = 0;
-		/* Copy unprocessed packets */
-		if (unprocess_num > 0) {
-			memcpy(&pkts[i], unprocess_pkts,
-					sizeof(struct rte_mbuf *) *
-					unprocess_num);
-			i = unprocess_num;
-		}
+
+		i = unprocess_num;
 
 		/* Flush all packets from the tables */
 		if (do_vxlan_tcp_gro) {
@@ -360,7 +353,6 @@ rte_gro_reassemble(struct rte_mbuf **pkts,
 		uint16_t nb_pkts,
 		void *ctx)
 {
-	struct rte_mbuf *unprocess_pkts[nb_pkts];
 	struct gro_ctx *gro_ctx = ctx;
 	void *tcp_tbl, *udp_tbl, *vxlan_tcp_tbl, *vxlan_udp_tbl, *tcp6_tbl;
 	uint64_t current_time;
@@ -396,33 +388,29 @@ rte_gro_reassemble(struct rte_mbuf **pkts,
 				do_vxlan_tcp_gro) {
 			if (gro_vxlan_tcp4_reassemble(pkts[i], vxlan_tcp_tbl,
 						current_time) < 0)
-				unprocess_pkts[unprocess_num++] = pkts[i];
+				pkts[unprocess_num++] = pkts[i];
 		} else if (IS_IPV4_VXLAN_UDP4_PKT(pkts[i]->packet_type) &&
 				do_vxlan_udp_gro) {
 			if (gro_vxlan_udp4_reassemble(pkts[i], vxlan_udp_tbl,
 						current_time) < 0)
-				unprocess_pkts[unprocess_num++] = pkts[i];
+				pkts[unprocess_num++] = pkts[i];
 		} else if (IS_IPV4_TCP_PKT(pkts[i]->packet_type) &&
 				do_tcp4_gro) {
 			if (gro_tcp4_reassemble(pkts[i], tcp_tbl,
 						current_time) < 0)
-				unprocess_pkts[unprocess_num++] = pkts[i];
+				pkts[unprocess_num++] = pkts[i];
 		} else if (IS_IPV4_UDP_PKT(pkts[i]->packet_type) &&
 				do_udp4_gro) {
 			if (gro_udp4_reassemble(pkts[i], udp_tbl,
 						current_time) < 0)
-				unprocess_pkts[unprocess_num++] = pkts[i];
+				pkts[unprocess_num++] = pkts[i];
 		} else if (IS_IPV6_TCP_PKT(pkts[i]->packet_type) &&
 				do_tcp6_gro) {
 			if (gro_tcp6_reassemble(pkts[i], tcp6_tbl,
 						current_time) < 0)
-				unprocess_pkts[unprocess_num++] = pkts[i];
+				pkts[unprocess_num++] = pkts[i];
 		} else
-			unprocess_pkts[unprocess_num++] = pkts[i];
-	}
-	if (unprocess_num > 0) {
-		memcpy(pkts, unprocess_pkts, sizeof(struct rte_mbuf *) *
-				unprocess_num);
+			pkts[unprocess_num++] = pkts[i];
 	}
 
 	return unprocess_num;
-- 
2.47.2.vfs.0.1

