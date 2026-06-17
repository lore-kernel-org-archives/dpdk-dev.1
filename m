Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90E3DCD98F0
	for <dpdk-dev@archiver.kernel.org>; Wed, 17 Jun 2026 11:33:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 420854064F;
	Wed, 17 Jun 2026 13:33:47 +0200 (CEST)
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
 by mails.dpdk.org (Postfix) with ESMTP id E71F14027A
 for <dev@dpdk.org>; Wed, 17 Jun 2026 13:33:44 +0200 (CEST)
X-QQ-mid: esmtpsz20t1781696020td32ce424
X-QQ-Originating-IP: xz+PlGyJJ1zW6g1zggJIW16MFMRB0kJrjsbWrtNPQcQ=
Received: from DSK-zaiyuwang.trustnetic.com ( [183.157.22.210])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 17 Jun 2026 19:33:39 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6409720032569125280
EX-QQ-RecipientCnt: 3
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v2 1/4] net/ngbe: add USO support
Date: Wed, 17 Jun 2026 19:33:31 +0800
Message-Id: <20260617113335.15648-2-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260617113335.15648-1-zaiyuwang@trustnetic.com>
References: <20260617105959.10764-1-zaiyuwang@trustnetic.com>
 <20260617113335.15648-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NBUSIVIw0bNzWx/NnTj1aqlrqWib8mEQ44OylEvBuNMalkWnPz1K63R3
 09ZdPoJ35AdTcX29vr9xPaPfq1PoAcN1fiOJZqo3vnjc46au/xhiBfsndOiQkDtD5eVfqn+
 6xgRyUpqG5QIG7lnwrBJceHCjOt7bDxjQHKSoSaLtXo9NPRduJN7nhnWP6B2CBzMMkuCm8+
 0n+rnDqWzJKKrwVmrawBTl72OVgFPQLN+gwsV9nYsoK3/5IEVC3eQw+WpYgbcaW8c1z9zYG
 fqUG0tNO3Qsjjd9JOh3BBxDNPbp3X2Y8XbwxObWZtcxRwhu7L6Pu88lW1DbJ7kMzbA7KL01
 QybzsQG4Yl+eNA/QnHjouBYpfCU0CpAHs/9XNZKkObVf/HvkTzKLTqgUPwyT6E92g7Wfg7t
 OF9Iar2BVQ9/8pctXhY7Kkit16PW0gVPIEraargcMpdJFFc3T/zFJ1sNqRjedbGY4Rx1+GA
 JZyDldgdtGj7jxXyTQ9DgfL/hJuMDa6ZhahPUE+h1ZzCqUlTF2Cgo+Pl/9z5b7jXqfVfPIE
 2VBLmE0zYoWuDIxwuHCbn6PmBrYY3qtSWWdZC6nsvK3vWnC4AqdCM9fkhaaoAoMFjXc3Zxk
 yOWWz40qQCIaykAyb5CEgDOen3TM3WxXWUSttcRol5lqjGAlEA3w8Uac98kyYOAk/8rltGB
 RSwQpv25x834NOzwzwPXCb9fCZ4mgCiOQrqT8Vn2zMnDaD3V2J6+joI2ibRjY5wT0LvK/c/
 rs54rRFccWX/xuOFOnAib0TDdb1Amx3iMzFwyJhZHkGopErxZJJBK2mZfts1Csp79feY28K
 kRn820TPdXxoOPMnh2WIRP3PMcnCLDj2Ejq4neMeudx3AKtjzObkwqqVGJlugovXbXVDFmD
 xP/0Uh8BCaY6rbBCnK/hWJtuOnXnbIKKTQBbPgZjMM/zyHpRqxRq5yuHFZ5w0x42LyrfDLt
 A/klUkwgzuY+vVPJbqTMBeCHOyllkKAru290R4JRoUMSznimsYxBIF/kCqEOyDcUg9xTQ6D
 LODSGtZm4vdV2jxOdGDGFWfFvR8uPTm+ABOfbvZICd4y+gV/fRZcSly/ifNrM5CzJkPgrIZ
 eDFSWtG/2E1sM3Fa4VF08BIwo3jESG7pAL6fFcQ2xQjByYWdQCaK8U=
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

Note:
USO segments UDP packets, requiring hardware to recalculate both IP
and UDP checksums due to length change. Thus, USO implicitly requires
IP and UDP checksum offloads, same as TSO.

Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
---
 drivers/net/ngbe/ngbe_rxtx.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

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

