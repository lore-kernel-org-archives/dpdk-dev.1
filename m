Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D45E4CD98E4
	for <dpdk-dev@archiver.kernel.org>; Wed, 17 Jun 2026 11:33:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3EE2840670;
	Wed, 17 Jun 2026 13:33:49 +0200 (CEST)
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
 by mails.dpdk.org (Postfix) with ESMTP id 6FD4440670
 for <dev@dpdk.org>; Wed, 17 Jun 2026 13:33:47 +0200 (CEST)
X-QQ-mid: esmtpsz20t1781696023ta8e4e261
X-QQ-Originating-IP: WOGbAy4mxFUAaVT3K4FiLTyxoktDcgQrVE1F5SxbNIA=
Received: from DSK-zaiyuwang.trustnetic.com ( [183.157.22.210])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 17 Jun 2026 19:33:42 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2280013514267277963
EX-QQ-RecipientCnt: 3
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v2 2/4] net/txgbe: add USO support
Date: Wed, 17 Jun 2026 19:33:32 +0800
Message-Id: <20260617113335.15648-3-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260617113335.15648-1-zaiyuwang@trustnetic.com>
References: <20260617105959.10764-1-zaiyuwang@trustnetic.com>
 <20260617113335.15648-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: OZrJc9xBLFL5rjP+2AHZIOP5dXpn+kLrWa/AoR8wwZ1Zwa+okrrS0bNT
 FN0in8YiNlwlLmfvmqvF1BfJ0nCvFpD01FOXLOC6MXaV4xCRHiDf/h/c9t4hy0soHoM5L8y
 RKE1Q7qv06ir7egljDReke/HT5NbI+vL2qMaHzsHY856UNn+1ng7pwK2LBpwyqnYLLM2dl5
 lPdjLJ+OSoXCC0ktvtw78uN7BbS2NNaibl9pdhnVZEiUumOrygwOQ8MgeoNkC8sVyKDLYE6
 dUT/cl6siA87E5+ad8DmKxtBqmvEp1cGGL9zJa7EfUNLdupariVoOLor3K+vP0cfhvLxoWJ
 hlgVih3Od5XMPCOjav9CblXW04rgn/yDf8ziT71IpU7eRS9hrproUXGc+Ss3Rh42pNn93n7
 npzFmZ8xd/Vxn+27CtFlbvuM/RYihpdzHCp4qEsHUHwejQK7Z94Uc/T83dPSOE1e04HefcV
 RKH4BXH0tr04DfRm0rmTV5rM7gkXQ5HaXCcqLDkVoG1XkJAowDMwHeOnoN5v/NSvxYj+bRv
 WdBMl6BxSvYwPaZAZbYf8dc1H6m5QsTRwH0k+ZIBOY5vZjgUOWpGp8S79CBaCH5L9AzrG05
 suby77QMYv7tYEONPYyM79C9JicSr+ZPi8BG+UPFjkLOCjzG+Jz1rvX4cusudppL/mgrFIe
 GNOkFXGA8STUDL+9Th1qKMP4X8JhGeFXi8TjdFLTVJDwdJjbpAW0sj8BezBpDlco6SyyJVG
 KRtahcF183Otzp4Hrei0x70kxdu7TxyvZPYX1pbOjvXqzbN370KviraVne9gAhdisFJFhIH
 4EqH2lLdWh42DPcNqyGdXNLUzOrEV8V8nn8HVemax7t49nxPuhZm93+oOsQvPbvTybCZ42Z
 mZ6NUC8WpTFgWHp4EwI1EEwfwHecugAXEwLkcO5R3YDJ3vOopmsJ+RM6tzFpxIsNEwkZiDM
 GN54r4otWPzLpQ9N8JAVm6m7bAAgthLayHWLG970qkuIsHYAdAeG7ek1Xz1EdEBM4CdpwVF
 d46dBiaEUrILiegSChF9Ms2DdReuOx9v49bQbl4TDOrit84wv5RPwf7/2owMRwziuf3WMkL
 ek8TtDu51DlZUCCkH73rogQdqitJPy7kYux+9jziBAvmk/EoIe7O3JPUMffR8SrmYQZlCO8
 uBIS
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
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

Note:
USO segments UDP packets, requiring hardware to recalculate both IP
and UDP checksums due to length change. Thus, USO implicitly requires
IP and UDP checksum offloads, same as TSO.

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

