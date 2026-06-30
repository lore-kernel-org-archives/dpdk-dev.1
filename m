Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4239EC44500
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Jun 2026 11:16:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D5BCA4065C;
	Tue, 30 Jun 2026 13:16:44 +0200 (CEST)
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
 by mails.dpdk.org (Postfix) with ESMTP id ED214402BE;
 Tue, 30 Jun 2026 13:16:41 +0200 (CEST)
X-QQ-mid: zesmtpsz7t1782818193t56cf10a8
X-QQ-Originating-IP: 8OH2JF9P0UJrf7ZphCjZ/Yx5ZxC/iBNJovhQyxJtFF0=
Received: from DSK-zaiyuwang.trustnetic.com ( [36.24.190.76])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 30 Jun 2026 19:16:31 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 12297304018901104534
EX-QQ-RecipientCnt: 5
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>, Ferruh Yigit <ferruh.yigit@amd.com>
Subject: [PATCH v4 2/4] net/txgbe: implement USO support
Date: Tue, 30 Jun 2026 19:16:02 +0800
Message-Id: <20260630111608.22196-3-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260630111608.22196-1-zaiyuwang@trustnetic.com>
References: <20260617105959.10764-1-zaiyuwang@trustnetic.om>
 <20260630111608.22196-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: OBWTMGjbXnSF7C5sfao71rb1laC4nKlfXFyS4jHBYuiPEiZiRmMAA6sa
 /cHGkaTSZn1LJYcSnbaO0LBsLgk1grdcRll3ud6tD2bb+p2hC/3EmKqxL/GdifzrmgAgnBj
 KYYoLOZgrvBEhSFfse9q9MasETSgz3gUwR7rDusdScCVyfCkSwu2ReanTpu255zKjxlD+L7
 3jV5VeXQ43F4NtvoXhy/peh+ozfeMws398NNLwQeI3IVw8tVaUeOgyuH7/x+Y7QhUUlfDwv
 5KcdMDhhMUmZm/W4YaKFWTeuEcySw7Ge/mWycv9RTWm97U0sQRIr/fBTiVk7VQjdbQNujEI
 QJnNZdedDKZ4B3N6NEyt/3nkjzJgztn+u9ZKwabu2quGeAGoa2J17AossgjuXrmrzpOMaF1
 wQ3Qm2/1wT3ZiRHrxU5z2KP94m8Cr8wC/++wf5qGfFFZcgxNwlabDwgcjd2SO9mUXTcSQQ1
 Sw6nAqzmlZzZGl455hvTryB/hkpvN483JRuHg4Zda/K+v72zG3Qk5SXaWxhIJtaraSlNlwh
 rkiZLW27nItS/GVqUkjUTV1CmVfNZoC5opUVcWiUBSL3sb02f+BIZWnUZy2fOotBCfjLm0A
 j+ArSn2dNuRozupjxt5tUFU1msQxbK/XFq37TsGzUwWHXLfpvBd66XUUoJ7q24/MfpfBkjt
 9IGphxqrDB7c6hA0ozzotucHc04gkPp4K5ueVk4af8OdtLK+um+I4OroTZ2TVKJ4wKJzoQ0
 uFcE6g7PFaMHigL+G6vMRoe0ZX4Ff4wPOlc0PkitrMy4lDjJc4SWy+OtWuB82FMNIbg+s3X
 3nIzmgCzuRrnxOrnMD2+W5v5kA1EZWwmo/AVA7EvD5F+JpNDHLyD3oSAi3xVv2dQUGIb01G
 q5/83u/safgNnN9YbyV6qGJnFGhDBYKmeQqvhJHi3tFLs/8/SDfPdcGe/zoLSmmIlCnxdKx
 oM/3w8wLxRMl7bT0zLVFC0Z3Qb2ZiacEFyqBmLKfmALGgTjzAiYSKplJYlpp53jQ8gFSAyg
 Fh4vR69lsEa4/bGqSEdEPp7GW2DU3CE7rYbqLgztwaAerT1doELv5rKmWK+KxR8LfZZ/zli
 QGkgqjZXlVUh0FeDLK7Ba9Nn+KzwCReJko+VRMwTHI6
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
X-QQ-RECHKSPAM: 0
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

USO (UDP Segmentation Offload), also known as UFO (UDP Fragmentation
Offload), is a hardware offload rarely seen in DPDK. Its implementation
is similar to TSO (TCP Segmentation Offload), so the driver enables
USO based on existing TSO support.

The driver has advertised RTE_ETH_TX_OFFLOAD_UDP_TSO in tx_offload_capa
since its initial integration, but the data path never implemented the
actual segmentation support. This commit fills that gap by enabling USO
in the transmit path, making the advertised capability fully functional.

Note:
USO segments UDP packets, requiring hardware to recalculate both IP
and UDP checksums due to length change. Thus, USO implicitly requires
IP and UDP checksum offloads, same as TSO.

Fixes: 86d8adc7702c ("net/txgbe: support getting device info")
Cc: stable@dpdk.org

Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
---
 doc/guides/rel_notes/release_26_07.rst |  7 +++++++
 drivers/net/txgbe/txgbe_rxtx.c         | 13 ++++++++-----
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_07.rst b/doc/guides/rel_notes/release_26_07.rst
index c5a168fdc9..06cd52b777 100644
--- a/doc/guides/rel_notes/release_26_07.rst
+++ b/doc/guides/rel_notes/release_26_07.rst
@@ -184,6 +184,13 @@ New Features
     driver's initial integration but the data path was missing; it is now
     functional.
 
+* **Updated Wangxun txgbe driver.**
+
+  * Implemented UDP Segmentation Offload (USO) in the transmit path.
+    The ``RTE_ETH_TX_OFFLOAD_UDP_TSO`` capability was advertised since the
+    driver's initial integration but the data path was missing; it is now
+    functional.
+
 
 Removed Items
 -------------
diff --git a/drivers/net/txgbe/txgbe_rxtx.c b/drivers/net/txgbe/txgbe_rxtx.c
index e2cd9b8841..c4cbdbc2b4 100644
--- a/drivers/net/txgbe/txgbe_rxtx.c
+++ b/drivers/net/txgbe/txgbe_rxtx.c
@@ -58,6 +58,7 @@ static const u64 TXGBE_TX_OFFLOAD_MASK = (RTE_MBUF_F_TX_IP_CKSUM |
 		RTE_MBUF_F_TX_VLAN |
 		RTE_MBUF_F_TX_L4_MASK |
 		RTE_MBUF_F_TX_TCP_SEG |
+		RTE_MBUF_F_TX_UDP_SEG |
 		RTE_MBUF_F_TX_TUNNEL_MASK |
 		RTE_MBUF_F_TX_OUTER_IP_CKSUM |
 		RTE_MBUF_F_TX_OUTER_UDP_CKSUM |
@@ -367,7 +368,7 @@ txgbe_set_xmit_ctx(struct txgbe_tx_queue *txq,
 	type_tucmd_mlhl |= TXGBE_TXD_PTID(tx_offload.ptid);
 
 	/* check if TCP segmentation required for this packet */
-	if (ol_flags & RTE_MBUF_F_TX_TCP_SEG) {
+	if (ol_flags & (RTE_MBUF_F_TX_TCP_SEG | RTE_MBUF_F_TX_UDP_SEG)) {
 		tx_offload_mask.l2_len |= ~0;
 		tx_offload_mask.l3_len |= ~0;
 		tx_offload_mask.l4_len |= ~0;
@@ -517,7 +518,7 @@ tx_desc_cksum_flags_to_olinfo(uint64_t ol_flags)
 		tmp |= TXGBE_TXD_CC;
 		tmp |= TXGBE_TXD_EIPCS;
 	}
-	if (ol_flags & RTE_MBUF_F_TX_TCP_SEG) {
+	if (ol_flags & (RTE_MBUF_F_TX_TCP_SEG | RTE_MBUF_F_TX_UDP_SEG)) {
 		tmp |= TXGBE_TXD_CC;
 		/* implies IPv4 cksum */
 		if (ol_flags & RTE_MBUF_F_TX_IPV4)
@@ -537,7 +538,7 @@ tx_desc_ol_flags_to_cmdtype(uint64_t ol_flags)
 
 	if (ol_flags & RTE_MBUF_F_TX_VLAN)
 		cmdtype |= TXGBE_TXD_VLE;
-	if (ol_flags & RTE_MBUF_F_TX_TCP_SEG)
+	if (ol_flags & (RTE_MBUF_F_TX_TCP_SEG | RTE_MBUF_F_TX_UDP_SEG))
 		cmdtype |= TXGBE_TXD_TSE;
 	if (ol_flags & RTE_MBUF_F_TX_MACSEC)
 		cmdtype |= TXGBE_TXD_LINKSEC;
@@ -587,6 +588,8 @@ tx_desc_ol_flags_to_ptype(uint64_t oflags)
 
 	if (oflags & RTE_MBUF_F_TX_TCP_SEG)
 		ptype |= (tun ? RTE_PTYPE_INNER_L4_TCP : RTE_PTYPE_L4_TCP);
+	else if (oflags & RTE_MBUF_F_TX_UDP_SEG)
+		ptype |= (tun ? RTE_PTYPE_INNER_L4_UDP : RTE_PTYPE_L4_UDP);
 
 	/* Tunnel */
 	switch (oflags & RTE_MBUF_F_TX_TUNNEL_MASK) {
@@ -1071,7 +1074,7 @@ txgbe_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts,
 
 		olinfo_status = 0;
 		if (tx_ol_req) {
-			if (ol_flags & RTE_MBUF_F_TX_TCP_SEG) {
+			if (ol_flags & (RTE_MBUF_F_TX_TCP_SEG | RTE_MBUF_F_TX_UDP_SEG)) {
 				/* when TSO is on, paylen in descriptor is the
 				 * not the packet len but the tcp payload len
 				 */
@@ -2389,7 +2392,7 @@ txgbe_get_tx_port_offloads(struct rte_eth_dev *dev)
 		RTE_ETH_TX_OFFLOAD_TCP_CKSUM   |
 		RTE_ETH_TX_OFFLOAD_SCTP_CKSUM  |
 		RTE_ETH_TX_OFFLOAD_TCP_TSO     |
-		RTE_ETH_TX_OFFLOAD_UDP_TSO	   |
+		RTE_ETH_TX_OFFLOAD_UDP_TSO     |
 		RTE_ETH_TX_OFFLOAD_UDP_TNL_TSO	|
 		RTE_ETH_TX_OFFLOAD_IP_TNL_TSO	|
 		RTE_ETH_TX_OFFLOAD_VXLAN_TNL_TSO	|
-- 
2.21.0.windows.1

