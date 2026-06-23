Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D086CDB46F
	for <dpdk-dev@archiver.kernel.org>; Tue, 23 Jun 2026 11:38:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A120D40657;
	Tue, 23 Jun 2026 13:38:21 +0200 (CEST)
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
 by mails.dpdk.org (Postfix) with ESMTP id EAF8540650;
 Tue, 23 Jun 2026 13:38:17 +0200 (CEST)
X-QQ-mid: zesmtpsz6t1782214694t5cd08118
X-QQ-Originating-IP: gDzvkOMZyBk5RmwpeUJ3L1wOEI5XHzuaBb2sVSAAJJU=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.204.248.247])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 23 Jun 2026 19:38:10 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 7252453615884425832
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v3 1/4] net/ngbe: implement USO support
Date: Tue, 23 Jun 2026 19:38:01 +0800
Message-Id: <20260623113805.16464-2-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260623113805.16464-1-zaiyuwang@trustnetic.com>
References: <20260617105959.10764-1-zaiyuwang@trustnetic.com>
 <20260623113805.16464-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: OBLY2KvBtCtvJ/t2EghP9TtAJG4LVY25rqC/xVbdCa0aVgR2Gpwyk3Jt
 JRYHWdfkhCOyM8Y/pflg/VOfGRjcwixiaNXjerJTbiVMZlUwF/7tC9QQlhp2J+0bO2w7WYX
 s5ahesaLpvN4BviIdDFTW6g0VsmJ990Zj46prt5XojkT3ZRCXngB6uj9JpfXUi2yHET8bzW
 wWxMfA3oHqbnUfEiv2z1k49e28rDroPxVmUyedpZhZjNkO+TIP+d493jeKEaqS2mRkzkNLV
 HZXFu1/APxzIpxfYwXca0oLY8GqOJ4TqMqw3Rsbn1JWvqG96uTVsz9Tv5lRq3UfcNNYRhh5
 7vQCRZqcqzxZP6ai35RtjrzZjPj01oxWH4yaTwiPYpAOlNtJD7Ra8+8PBxGt+9k62Gkipoe
 EHiI1iOWzIVokNHw1De0J3nQk75dPXT2CmmP78o28IEfGawt1hq79CShNfy+SIrzd0bN8/t
 /w632v5Bu/eN4AAS0Gw1Q/x1kISe5lsUkc/aGMYHSMUgYLYQOHJ35GgXpJdBKL3On/mFoB8
 bQLEDz7TkxDpTFiPeuCN5REXnrDFcpjL3wEdjc+j2dhWn5qnLdKOnhfS+gEadvjlEnDrapJ
 7QDS7C05cimNbHtfCVKzp4sbg5yx/E1U0900D5gBnnWYJnhH7OWED/gXcRlSXE4Oauawm7e
 4eeT+JMfGMVK5VvKHnZ9YoidWTbO9aNmEP8+uXnqD4e9RQOQFZSYcMTzIoOvzSEJd0OnTAE
 QAcbcfibuDEL6UFbCw8goIOSwmxZXkbAwOZJdWXQkm3wKJu34ri+RFZ1CmurN4LJWB9YCRR
 LoFyPTvhs3L5nmjoySLeQqVzmgIRxoG3GK4Q+izvX2D0cn5yO3QDD8NvySaqCM8ZQ9LPyVu
 DdCduFdbAykkoufdldb19f+Kr0wOmmIWw+M9mBkO93aRsWn5UNAnBJ5RmLI8JcWODwXdnBu
 /Izy4uhlwYfbm6JHnxb5ZocZywbHFOWksmJLDukqEENWgbCMZP6jtyjq9vWJo2jN8NhtJEH
 OOzEtH11rfT4TBE/9ChAc8peoI5i+ko8wwNgD1GuEp9ciW3tHzLBtDQuCruWtQbv6MAIKqj
 GkwIU6pyZDTYDFKgcpT/Jw9aAzyhUY19Wx6TFnaDt3uE/HqkILqZwQ=
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
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

