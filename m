Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A830DC43458
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Jun 2026 11:16:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BE61E40652;
	Tue, 30 Jun 2026 13:16:38 +0200 (CEST)
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
 by mails.dpdk.org (Postfix) with ESMTP id 1B97E40278;
 Tue, 30 Jun 2026 13:16:34 +0200 (CEST)
X-QQ-mid: zesmtpsz7t1782818190tef95ee94
X-QQ-Originating-IP: pfYr+tPrRMgr/Xhgdg4fH0gcFoDWxmKDjaMA0H4i38c=
Received: from DSK-zaiyuwang.trustnetic.com ( [36.24.190.76])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 30 Jun 2026 19:16:17 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6055009643262683373
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v4 1/4] net/ngbe: implement USO support
Date: Tue, 30 Jun 2026 19:16:01 +0800
Message-Id: <20260630111608.22196-2-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260630111608.22196-1-zaiyuwang@trustnetic.com>
References: <20260617105959.10764-1-zaiyuwang@trustnetic.om>
 <20260630111608.22196-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MJGq/3UMnf82ylulzY60Enx8UpRoJWkifAfCeN93/UxGCIlBIZLEWSIo
 OB0zmNvvdo8ZrknKA8JS0n/GpKVsoNbLm/J9mFepWkmULF2buQ4BSDkXf2UU3IhAb59YRlE
 Wt8WfImgWradXrvjprVvE1AvZBMdGBBawAYWpAlzKmR7pwlvYbo8qoGpVGDJNdpO3oVtRUR
 FuoN2aX4/ch6op9deDtozH1ULxyq+V42A7nj3GGbzqN7SgN399J2/1CRjN2fOORq84nHJal
 mFFSXLRSgFpiocWR4N/7cl/uwYpJR0/V7UO1qsUQDTR86SZIH7WJbrUyo5VbPsd4yBtXANa
 qtTUTjvm134md9DVGfnWTcNSHdAAyktFHkOl4xZ3GKfCPwD9ljqr5k/OF+IP5IeXqhmvpga
 xbr1pQxqUV3tAbB4rfWWhjolk2ku3O+ehF3k1MqgjJ3rtl1gQceEq7NXlzRxU37ev9Rpkhg
 f8lNWo84HIF1LbMYjnPd3To9H7UEYtVU0Ex/DfIsf57iESmbw4IG7yClXJbL+apBh7fJpB1
 A8oAsKbhYxK0rRnMFlHF7dhLzhiJSPPkO1qZvtJEFk9YQY8kJIHfjsIxUkyElXtpbeak+A5
 8McFaO9cDlt6kt+CE92vcBfJWJ0fyjDfeCEBKzMXZpN/CjzpBQ8JUEC/Xhg1wBtpG1Vfbp7
 BZp8M/F3d+9tvKwysegTe+VBnaCBSsNdwr/BrtwnH2LsHHYdDR11V0aVf5ID5tal0QeTWsD
 K3poBe30TYEmkozv8ljqDY0XBWCGIr2i7GxB/DTWqjhuC0j6HiQA5c9QhhAfUNJwq/95cEM
 MvEFhYLZ+01Idn6yX5+ul/+s1GQhwWRqKN6DnFsI1YZW7GsYFcZUmbO7TYb3RDu65GvEEjC
 JgcnSI3k6EEoN410b8YB6BreTLm6DRkgNRe5Ja+xuzB/DhqlIrEzMlTjFrfqTmaIxKmDuMu
 SRMoO5Je/oDbIbzjS63n+m6y75iUJOgkaglyGALMEgv/fbak7NdYJbtb0bvOIbQSdcQTsmd
 ARGVTp4vtSUrlCYK51lDrGfLT+1LmeNmoIsPlTc+me7hijFKR7C+qjHpoo/FB1J1OPsKttX
 eNuAvxa49pInb3tUCB5sAAx1CAAeNkNZKewgLZzqWNC
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
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

Fixes: 9f3206140274 ("net/ngbe: support TSO")
Cc: stable@dpdk.org

Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
---
 doc/guides/rel_notes/release_26_07.rst |  7 +++++++
 drivers/net/ngbe/ngbe_rxtx.c           | 13 ++++++++-----
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_07.rst b/doc/guides/rel_notes/release_26_07.rst
index 4ca0a9ac77..c5a168fdc9 100644
--- a/doc/guides/rel_notes/release_26_07.rst
+++ b/doc/guides/rel_notes/release_26_07.rst
@@ -177,6 +177,13 @@ New Features
   Added AGENTS.md file for AI review
   and supporting scripts to review patches and documentation.
 
+* **Updated Wangxun ngbe driver.**
+
+  * Implemented UDP Segmentation Offload (USO) in the transmit path.
+    The ``RTE_ETH_TX_OFFLOAD_UDP_TSO`` capability was advertised since the
+    driver's initial integration but the data path was missing; it is now
+    functional.
+
 
 Removed Items
 -------------
diff --git a/drivers/net/ngbe/ngbe_rxtx.c b/drivers/net/ngbe/ngbe_rxtx.c
index 91e215694c..a1389de9c0 100644
--- a/drivers/net/ngbe/ngbe_rxtx.c
+++ b/drivers/net/ngbe/ngbe_rxtx.c
@@ -30,6 +30,7 @@ static const u64 NGBE_TX_OFFLOAD_MASK = (RTE_MBUF_F_TX_IP_CKSUM |
 		RTE_MBUF_F_TX_VLAN |
 		RTE_MBUF_F_TX_L4_MASK |
 		RTE_MBUF_F_TX_TCP_SEG |
+		RTE_MBUF_F_TX_UDP_SEG |
 		NGBE_TX_IEEE1588_TMST);
 
 #define NGBE_TX_OFFLOAD_NOTSUP_MASK \
@@ -317,7 +318,7 @@ ngbe_set_xmit_ctx(struct ngbe_tx_queue *txq,
 	type_tucmd_mlhl |= NGBE_TXD_PTID(tx_offload.ptid);
 
 	/* check if TCP segmentation required for this packet */
-	if (ol_flags & RTE_MBUF_F_TX_TCP_SEG) {
+	if (ol_flags & (RTE_MBUF_F_TX_TCP_SEG | RTE_MBUF_F_TX_UDP_SEG)) {
 		tx_offload_mask.l2_len |= ~0;
 		tx_offload_mask.l3_len |= ~0;
 		tx_offload_mask.l4_len |= ~0;
@@ -427,7 +428,7 @@ tx_desc_cksum_flags_to_olinfo(uint64_t ol_flags)
 		tmp |= NGBE_TXD_CC;
 		tmp |= NGBE_TXD_EIPCS;
 	}
-	if (ol_flags & RTE_MBUF_F_TX_TCP_SEG) {
+	if (ol_flags & (RTE_MBUF_F_TX_TCP_SEG | RTE_MBUF_F_TX_UDP_SEG)) {
 		tmp |= NGBE_TXD_CC;
 		/* implies IPv4 cksum */
 		if (ol_flags & RTE_MBUF_F_TX_IPV4)
@@ -447,7 +448,7 @@ tx_desc_ol_flags_to_cmdtype(uint64_t ol_flags)
 
 	if (ol_flags & RTE_MBUF_F_TX_VLAN)
 		cmdtype |= NGBE_TXD_VLE;
-	if (ol_flags & RTE_MBUF_F_TX_TCP_SEG)
+	if (ol_flags & (RTE_MBUF_F_TX_TCP_SEG | RTE_MBUF_F_TX_UDP_SEG))
 		cmdtype |= NGBE_TXD_TSE;
 	return cmdtype;
 }
@@ -483,6 +484,8 @@ tx_desc_ol_flags_to_ptype(uint64_t oflags)
 
 	if (oflags & RTE_MBUF_F_TX_TCP_SEG)
 		ptype |= RTE_PTYPE_L4_TCP;
+	else if (oflags & RTE_MBUF_F_TX_UDP_SEG)
+		ptype |= RTE_PTYPE_L4_UDP;
 
 	return ptype;
 }
@@ -764,7 +767,7 @@ ngbe_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts,
 
 		olinfo_status = 0;
 		if (tx_ol_req) {
-			if (ol_flags & RTE_MBUF_F_TX_TCP_SEG) {
+			if (ol_flags & (RTE_MBUF_F_TX_TCP_SEG | RTE_MBUF_F_TX_UDP_SEG)) {
 				/* when TSO is on, paylen in descriptor is the
 				 * not the packet len but the tcp payload len
 				 */
@@ -1991,7 +1994,7 @@ ngbe_get_tx_port_offloads(struct rte_eth_dev *dev)
 		RTE_ETH_TX_OFFLOAD_TCP_CKSUM   |
 		RTE_ETH_TX_OFFLOAD_SCTP_CKSUM  |
 		RTE_ETH_TX_OFFLOAD_TCP_TSO     |
-		RTE_ETH_TX_OFFLOAD_UDP_TSO	   |
+		RTE_ETH_TX_OFFLOAD_UDP_TSO     |
 		RTE_ETH_TX_OFFLOAD_MULTI_SEGS;
 
 	if (hw->is_pf)
-- 
2.21.0.windows.1

