Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55C0CCD98E2
	for <dpdk-dev@archiver.kernel.org>; Wed, 17 Jun 2026 11:00:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 72D8840674;
	Wed, 17 Jun 2026 13:00:24 +0200 (CEST)
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
 by mails.dpdk.org (Postfix) with ESMTP id 159FA4064F
 for <dev@dpdk.org>; Wed, 17 Jun 2026 13:00:21 +0200 (CEST)
X-QQ-mid: esmtpsz21t1781694018t55b704c4
X-QQ-Originating-IP: NVKdJvm/EDv+OmbnyZawkHr9RQJqQVe4oA3POZt6zSE=
Received: from DSK-zaiyuwang.trustnetic.com ( [183.157.22.210])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 17 Jun 2026 19:00:13 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 1171172343799257195
EX-QQ-RecipientCnt: 3
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH 1/4] net/ngbe: add USO support
Date: Wed, 17 Jun 2026 18:59:56 +0800
Message-Id: <20260617105959.10764-2-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260617105959.10764-1-zaiyuwang@trustnetic.com>
References: <20260617105959.10764-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: M0wYV6TTeeWi6FQCtY/MVDuhKIaBR+bP8RZXTbgq0TnKx/pJRkDGQeMF
 Oc0IfhP7b3SgVE92tkTfekV+yvvcyBYEk3MMdK1QkCdACeA0BwOWcIfYDrIY5YTZqY7s7pY
 6GeJimYeRUaSCQJFprSMKyaT33xA4eU3fOeE2pJGs5F5QBcpp1l7A6o/aiQiQpelNzmgnpC
 bFBknW3YMp8JOb4d5xCr/8T4DDgxxhWGTnVdhLbg3pd5D2Jk5+AzBxBG9BNtrcUQMTVfnVP
 cMZ14/YXmoIwdCMcKuFVs+PhYCYU71e6M1lsyVR2EtwmEAKIIF4HvAZEZPYE+1W8D4RTXW8
 716QF0zBZ6ExkMTXCk7eMqjhjiGyCrJYN4eI1F7gNVC3XmmOXOnVj5Dr+oleEy+sbgkFJ7X
 +kTKDNcCyzNGn7+csa0VlNST0jQLyQhY69ZdGvwwylvVTugYPZJK0Bl3GzAHJ9qEVuavVrv
 FpRfnXWCN1KnnabL88bC2/QQa2nowYbh+NsKDsG3ej0caraNKddQa7f1URnXiCb5I+JM4Rn
 rIFpXZSs6JgBEde1UjiA7tBDZ6y5LyJXTGS1S0TEUdXrtWDBrQvWTdDrYdqEIFRyy45BgZd
 IKrRHITKjkloj68YvbcIOrZH3oX4dTtNj3jx0ZIT068rvqhKbNBIgEnAtSuZQtk3IqYxKRp
 Gl/8AWjNR8Rntub+BgsKEsxAzEEjCXQS6V7Ay2fQOVqw15+rmgZbT4tSng2mr921tzYzWS/
 3yTPQRDM+cyvNfgOdz1vYsJnyvGsFc+Ouq1O6uUId6yzNynoB7heoCR3hLLfKNbSXJrKk2K
 zjW9lSN9cq3flv3LDZpikZAzZFR3cMu3daCExzm2bxW116+ThuDPtXqxupIfbi8bUmboQK/
 TB3T+aQYql2tJ0t4NKUc1iG/7dLVXYaonQ7pQWxiVqkCT08tRCyiDhO50L4IJRP1xRKpw0U
 i2jjH59xbnuVA9w0vVG2gb3S61IaQ+RyI48CYgjoEJRBEWUqeOeeZOdIa7KeAqQy2ENVyqu
 fYGuajX3ZXrzoU8frMAMFY2WFJkC6JsMudo93T7CvmCFo+MgdI
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

