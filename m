Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC854CDB46F
	for <dpdk-dev@archiver.kernel.org>; Tue, 23 Jun 2026 11:38:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5A77D40663;
	Tue, 23 Jun 2026 13:38:29 +0200 (CEST)
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
 by mails.dpdk.org (Postfix) with ESMTP id 3511240662;
 Tue, 23 Jun 2026 13:38:27 +0200 (CEST)
X-QQ-mid: zesmtpsz6t1782214699tfc3dc697
X-QQ-Originating-IP: qODp5WoDUu3dGXZveMJDX6IR8FZazH1jYejBdWFVeWY=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.204.248.247])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 23 Jun 2026 19:38:16 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9443632802983263063
EX-QQ-RecipientCnt: 5
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>, Ferruh Yigit <ferruh.yigit@amd.com>
Subject: [PATCH v3 2/4] net/txgbe: implement USO support
Date: Tue, 23 Jun 2026 19:38:02 +0800
Message-Id: <20260623113805.16464-3-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260623113805.16464-1-zaiyuwang@trustnetic.com>
References: <20260617105959.10764-1-zaiyuwang@trustnetic.com>
 <20260623113805.16464-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NWhzXR87t/Dlm4dsaC6B5ZY4UJ8UHIFZUCNaC/l1+loPkfQd9RrBWvHM
 YZo2GOO2Bicpr3vvr3bYaSfKgx7F50TtIlqYw8mJX0Gc9/yIBc8WLaoU7rXk1IWOGNKq61x
 JBCn0bN40HUoeBeMA5f8cewuqHzegy27MG9JvmoBO6FfeD+JnLzG97XkfLJr4ThhkNUnYOU
 bbOUbJbltfj+FSNYLPp0zXfjpnTXIhtAcCe5+SGLOCymRuW3VNa61CyYBRN9HTIslNtFSm4
 bTJzJCaR9BULiH5sOO8RpNARkm7WuzayQkOldvwdSAxtTrFf3o+J1D6iS7kIlfcjJtSiS+j
 LosfQNuBNikqmZFNmFtr+teXROBV8kx9sQ/JoaW9CnZUwDE32u5WONG01IBmj8lX1MFlSSn
 GHa5Sm944P0rP5z8EvyddT/Aogax/AR1cbR68MHIgGJ7Yc3WU3OAlzsGvFUxWTN28HXBU3X
 BW4HGYZR09QtekukFLrV+BaU1wb0qNRusdT9/NNt/OT8Z/bSJJB1cy584fa0oiX49xiicQO
 oKSibTTcvFtT7uIqOYtqmZa0+VYAKGm8nDcgaE3xkDAG7hHSmPyK8DoaJ/U0r3fnA+ZEQBr
 0vKnmKDOA9HQMo4FAnPBM3Ia+PM/3SCJ64eZnuN70Ej7pSypofcV6nMFQ/+yGoilhcyLhgO
 U0pYTpijArebdMvoRrG985EMNCXcjJadGnsZsP2K4rOHy7F2+umCfgQQ0XHU8HOaml7sthy
 pys0RpJ0Yv6eRHK6XAAgjM/jvC3hxIiE+n1jaoBiwCPk5DeIQvugVmr6OaJgm5lWqfiDh0M
 GDhnS7ayv2NHw+Z/TAgvB5kUeNMAzHFZpoqBBX/GnH3P8ua+c1rJAczOrjq9oSugYoBraRg
 2qrZDTlbf8AL1d1wMIG1PSg6eriwc1O35Gfv+GysYNTePvr0E5cFsO6swQUalEygMBNPbLC
 ReKEb+Ta4tO8q3aYD9ozNCsb9RVrNJmllSPUynidlI9BA50gLVBvPbdFzXt8fLrcK+fJdGt
 gOiRJhBONkGVYhKndVHKUk4eI8Ll+1HukJ/viSUNhN76bOCYd0D0II7/0gTADLLy4aUMtHe
 0Xukuj/CtWE7DNJzwbGL3yl/CLIZNyGWL0Q0K70chYX
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
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
 drivers/net/txgbe/txgbe_rxtx.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

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

