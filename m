Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63820CD98E4
	for <dpdk-dev@archiver.kernel.org>; Wed, 17 Jun 2026 11:00:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5202540696;
	Wed, 17 Jun 2026 13:00:29 +0200 (CEST)
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
 by mails.dpdk.org (Postfix) with ESMTP id DC92C4064F
 for <dev@dpdk.org>; Wed, 17 Jun 2026 13:00:26 +0200 (CEST)
X-QQ-mid: esmtpsz21t1781694020t18cdda88
X-QQ-Originating-IP: CGl+MJC/wrCphnfuYjtGBPK7PQowgNbjagCetABZhBY=
Received: from DSK-zaiyuwang.trustnetic.com ( [183.157.22.210])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 17 Jun 2026 19:00:19 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 5319601359925638037
EX-QQ-RecipientCnt: 3
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH 2/4] net/txgbe: add USO support
Date: Wed, 17 Jun 2026 18:59:57 +0800
Message-Id: <20260617105959.10764-3-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260617105959.10764-1-zaiyuwang@trustnetic.com>
References: <20260617105959.10764-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MqN/FiDJuNHiFHJ24o/vSI2wTk2/O8EGRH1MoMIBgsbjQu0aAu9XDDD3
 nMvKy5ga9n/96eOiGyoo110TCRmNGNI/ovw8tjVU3mpheVBLLKBmYhL5VK5WfTrnkwpztoI
 yOr2LaHoM0bb8rnMwfw80ttTS3k4ahQW8Q2JXbqKT/iZHM0xQRCuKUEXNWC8PHM7BtSe8Pv
 nKJRORMkYCNwiYR5BIMqTjxw583C6nXsKUU4xfSIQO2lZQ9J7K4q9M0IcwmnjBDmgH8qD7+
 A3hi9LGLJY2B3Qk5dLpWrNp8JHLy+Y9FeIRHyrIolJJs59cQZL1rO80x79lbijeHaptQbNW
 InLjtkH4sRsuvZAk34Sep3Zb0XDXQgn+MjZU4ZVw10t+5L7Ves7nQeC3N79xpCkjnOMC4kO
 8jwGVjrRXEqKMrzTGYHa+SrnIexem/MjG0Q8Z2DdV05AI7fXu7D8cKlg5V9zzWTRtaEIHEI
 5gEftb4V8aRYUn3FBj5xJ6VcjRMn7hxmplhdkuiqCY6iOAF0G1RkBYcT/7Sa/qLIvJYSCuy
 4SXRF6bGfivOxDb394BoRm8pF50pQOyJJsev7VnEOJqkyrrpfEOlU9J0ZZR5WSMl99tXXQV
 P+Y0unUsNQc+KO2V3LgyKb94tVDRgpTyttiMxx4/yXcGUVacp0OnwzBD9gaHNiluH4/5eWL
 z++p7iptKg901WlgBZmJ4azdzxiFLL56uWRriKXx4wvalaq1uOxP/EbpWhsNhetKrP+JsCD
 T7kgf8kFgNKNBixpLj52PqcckJtRzP37jGu1ddWutVHAGqP9HmPUC7jXEN+QQivf8JBqb6N
 gj0scDlpUiERV7Bn4TNLmzrbmWad+3IvXQ3qn6V2uEA8jCBgiMhskfvmfKkwgBy0XA7W/Ws
 SKxi2mDGm68vqsanPrK1+x8ZTCy39k1x8wo9YqefRB+hEqMj0gdTTWEuKMp296dNTZXoru8
 /wMh3+ulvsP5/3YH+VC8otm9S26HACNrjfUF9GxzMSzeK76OImM8OV6WYS0Yz+IFg4MUaYx
 NCM6i+dbIusS2jRP2QhOoQLSXjig6kQMCmP1xV89VLExNM89QHglRVkN/yMye86XUyzVyXD
 gdPy9u1fKvM
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
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
index f51c6193a9..77ec9f1e39 100644
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
@@ -366,7 +367,7 @@ txgbe_set_xmit_ctx(struct txgbe_tx_queue *txq,
 	type_tucmd_mlhl |= TXGBE_TXD_PTID(tx_offload.ptid);
 
 	/* check if TCP segmentation required for this packet */
-	if (ol_flags & RTE_MBUF_F_TX_TCP_SEG) {
+	if (ol_flags & (RTE_MBUF_F_TX_TCP_SEG | RTE_MBUF_F_TX_UDP_SEG)) {
 		tx_offload_mask.l2_len |= ~0;
 		tx_offload_mask.l3_len |= ~0;
 		tx_offload_mask.l4_len |= ~0;
@@ -516,7 +517,7 @@ tx_desc_cksum_flags_to_olinfo(uint64_t ol_flags)
 		tmp |= TXGBE_TXD_CC;
 		tmp |= TXGBE_TXD_EIPCS;
 	}
-	if (ol_flags & RTE_MBUF_F_TX_TCP_SEG) {
+	if (ol_flags & (RTE_MBUF_F_TX_TCP_SEG | RTE_MBUF_F_TX_UDP_SEG)) {
 		tmp |= TXGBE_TXD_CC;
 		/* implies IPv4 cksum */
 		if (ol_flags & RTE_MBUF_F_TX_IPV4)
@@ -536,7 +537,7 @@ tx_desc_ol_flags_to_cmdtype(uint64_t ol_flags)
 
 	if (ol_flags & RTE_MBUF_F_TX_VLAN)
 		cmdtype |= TXGBE_TXD_VLE;
-	if (ol_flags & RTE_MBUF_F_TX_TCP_SEG)
+	if (ol_flags & (RTE_MBUF_F_TX_TCP_SEG | RTE_MBUF_F_TX_UDP_SEG))
 		cmdtype |= TXGBE_TXD_TSE;
 	if (ol_flags & RTE_MBUF_F_TX_MACSEC)
 		cmdtype |= TXGBE_TXD_LINKSEC;
@@ -586,6 +587,8 @@ tx_desc_ol_flags_to_ptype(uint64_t oflags)
 
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
@@ -2395,7 +2398,7 @@ txgbe_get_tx_port_offloads(struct rte_eth_dev *dev)
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

