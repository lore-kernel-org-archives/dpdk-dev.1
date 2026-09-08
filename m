Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A386C79F9E
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Sep 2026 12:42:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CC32E40E38;
	Tue,  8 Sep 2026 14:41:31 +0200 (CEST)
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
 by mails.dpdk.org (Postfix) with ESMTP id C2F5D40EE7;
 Tue,  8 Sep 2026 14:41:27 +0200 (CEST)
X-QQ-mid: esmtpgz10t1788871276t2c044a6d
X-QQ-Originating-IP: cecfrhdBPTgypd4YgpNNWyICMztq9CyMRZxAF25Edug=
Received: from DSK-zaiyuwang.trustnetic.com ( [36.24.66.61])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 08 Sep 2026 20:41:14 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 1319923394918874426
EX-QQ-RecipientCnt: 5
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>, Ferruh Yigit <ferruh.yigit@amd.com>
Subject: [PATCH v2 08/15] net/txgbe: add offload support for tunnel type UDP
Date: Tue,  8 Sep 2026 20:38:53 +0800
Message-ID: <523B66E1D2611B4E+20260908124047.2284-9-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.55.0.windows.2
In-Reply-To: <20260908124047.2284-1-zaiyuwang@trustnetic.com>
References: <20260827114309.10530-1-zaiyuwang@trustnetic.com>
 <20260908124047.2284-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NDKX6hzkjVZaI2KWgLnWnm5VpR/3YTf4AtIxiz4xeE2jOhvYfqbVHIek
 CbNfYo8dK/pw/JGZVtUcGD/zz4VvsaRH4PgScusqMwxIOX/5GuPqG9KbCJHSkbJx+0+pvZt
 Xn0+DaMESMxv4LPjlg3Sv6jjpuyV+Km3/5jYYawjwo3x52NgN5ewel1sUpzjnjwZ7VMZaDp
 tUzkF9xwFQQwfN7YfRfUIQob58/tS5Vs7BX60E8udVz7T7fiKHAUycbdsf7DDYACUHnkyii
 NDq+zYXtcuI/7pEW2zVvPjor+A9qzUxXVxvAXdd6XdaC0jTILWgaV4NmuHIjLGPZYRhmY96
 RA1khDvHRBzJpzyczQFxQlow8AGHvuPZ2wEw4STznKHC6SBdxhziacKUB4KjjQqB7WO+jnc
 wlj9cDuUhdZGQTzCmaP3oXMXmRAoFgXHQey3YQkY93CBGhwHiRsI8XkkZ0S+jiSZGPZwvAd
 z+HLVWEAWuPOX7e0DdUdawhv0J9fpLTur+hzrjM5xm8C51FOs5wm3gQ91Rb/59HpaaA23Mj
 mQxcG1Oz/9Cx/AofDESJS/tbVUHONIn0UJVbuK03QMSXzz7LJQLU/yH4A2FHyayNFUdrpZP
 B4P95B9/P0o15FJln1wzwImP4ni6GAD9p6p5cKmnqtO36rneLKo6uSRloNioz0iVcSOkbm2
 qYC/NRA5CfJX6x2e7lkc4HF6L/aexyftPRhdR77tb/x9m/Zc2KC6e7ACxOrGIf9KKIj0fMs
 waZLZichUJl2UJccrmMA19JLIdav60GVzBUdyFhIrWTiaqRH0AVC57qUhpKevsIdamVJ16Z
 kKq6ZWjKLyE3ZKUPyw0Es9FfbI5tJOd0825s/laRllRcnDLGH3HLSvJzd7qFMDoCOd0PgH7
 n37E18D3VPr+Zi/KonqPYFUUSAJ5zGVq9uDzRsrpfNW+HAs129CmCzx9c+sPKvjBbVD41JM
 6TyfiZqMgkeGwzACsOeD3NMFghTU6lewEYPbVJLRY+0fdprVXBRTL6TzPNcpOw902BSUOAQ
 1xl07YFIlxXjBlbxpYBDxSv13CwJ+c3POj933/Fj7b0xcl/BnjccJpBbu870OjrVxMDgWYI
 ffdj6Nyr3K3wPcvkztqJ9M=
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

The non-standard RTE_MBUF_F_TX_TUNNEL_UDP tunnel type (UDP
encapsulation carrying either VXLAN or GENEVE) is not handled:
txgbe_set_xmit_ctx() falls into the "unknown tunnel type" case and
txgbe_get_tun_len() cannot compute the tunnel length, so tunneled
packets are sent with a wrong descriptor or dropped.

Resolve RTE_MBUF_F_TX_TUNNEL_UDP by parsing the UDP destination
port in a local variable instead of rewriting the mbuf: the
application still owns the mbuf and may re-transmit it (cloned or
multicast paths), so a second pass would otherwise see the resolved
VXLAN/GENEVE type instead of UDP. The outer_l2_len/outer_l3_len
used for the offset are application supplied and not validated by
the driver, so check the rte_pktmbuf_read() result and fall back to
a zero tunnel length on a short or mis-annotated packet. Use
RTE_GENEVE_DEFAULT_PORT for the GENEVE destination port.

Fixes: ca46fcd753b1 ("net/txgbe: support Tx with hardware offload")
Cc: stable@dpdk.org

Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
---
 drivers/net/txgbe/txgbe_rxtx.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/net/txgbe/txgbe_rxtx.c b/drivers/net/txgbe/txgbe_rxtx.c
index a295666f9d..ad90df5f69 100644
--- a/drivers/net/txgbe/txgbe_rxtx.c
+++ b/drivers/net/txgbe/txgbe_rxtx.c
@@ -21,6 +21,7 @@
 #include <rte_debug.h>
 #include <rte_ethdev.h>
 #include <ethdev_driver.h>
+#include <rte_geneve.h>
 #include <rte_security_driver.h>
 #include <rte_memzone.h>
 #include <rte_atomic.h>
@@ -419,6 +420,7 @@ txgbe_set_xmit_ctx(struct txgbe_tx_queue *txq,
 			break;
 		case RTE_MBUF_F_TX_TUNNEL_VXLAN:
 		case RTE_MBUF_F_TX_TUNNEL_VXLAN_GPE:
+		case RTE_MBUF_F_TX_TUNNEL_UDP:
 		case RTE_MBUF_F_TX_TUNNEL_GENEVE:
 			tunnel_seed |= TXGBE_TXD_ETYPE_UDP;
 			break;
@@ -593,6 +595,7 @@ tx_desc_ol_flags_to_ptype(uint64_t oflags)
 	switch (oflags & RTE_MBUF_F_TX_TUNNEL_MASK) {
 	case RTE_MBUF_F_TX_TUNNEL_VXLAN:
 	case RTE_MBUF_F_TX_TUNNEL_VXLAN_GPE:
+	case RTE_MBUF_F_TX_TUNNEL_UDP:
 		ptype |= RTE_PTYPE_TUNNEL_GRENAT;
 		break;
 	case RTE_MBUF_F_TX_TUNNEL_GRE:
@@ -713,9 +716,32 @@ txgbe_get_tun_len(struct rte_mbuf *mbuf)
 	const struct txgbe_genevehdr *gh;
 	const struct txgbe_grehdr *grh;
 	struct txgbe_grehdr grehdr;
+	struct txgbe_udphdr udphdr;
+	const struct txgbe_udphdr *uh;
+	uint64_t tun_type;
 	uint8_t tun_len;
 
-	switch (mbuf->ol_flags & RTE_MBUF_F_TX_TUNNEL_MASK) {
+	/* Resolve the UDP tunnel to its inner type without rewriting the
+	 * mbuf: the application still owns it and may re-transmit it.
+	 */
+	tun_type = mbuf->ol_flags & RTE_MBUF_F_TX_TUNNEL_MASK;
+	if (tun_type == RTE_MBUF_F_TX_TUNNEL_UDP) {
+		uh = rte_pktmbuf_read(mbuf,
+				      mbuf->outer_l2_len + mbuf->outer_l3_len,
+				      sizeof(udphdr), &udphdr);
+		if (uh == NULL) {
+			/* The outer offsets are application supplied and may
+			 * point past the end of the packet.
+			 */
+			return 0;
+		}
+		tun_type = (uh->dest ==
+			    rte_cpu_to_be_16(RTE_GENEVE_DEFAULT_PORT)) ?
+			   RTE_MBUF_F_TX_TUNNEL_GENEVE :
+			   RTE_MBUF_F_TX_TUNNEL_VXLAN;
+	}
+
+	switch (tun_type) {
 	case RTE_MBUF_F_TX_TUNNEL_IPIP:
 		tun_len = 0;
 		break;
-- 
2.55.0.windows.2

