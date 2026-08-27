Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AC8CC61DC2
	for <dpdk-dev@archiver.kernel.org>; Thu, 27 Aug 2026 11:44:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 45DE140655;
	Thu, 27 Aug 2026 13:44:03 +0200 (CEST)
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
 by mails.dpdk.org (Postfix) with ESMTP id B594F4067C;
 Thu, 27 Aug 2026 13:44:01 +0200 (CEST)
X-QQ-mid: esmtpgz13t1787831039tad0dc104
X-QQ-Originating-IP: qyJtu48yD53YegKv6LF25k9bCx5pRjmjZyTyV4Qq9zo=
Received: from DSK-zaiyuwang.trustnetic.com ( [122.233.170.62])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Thu, 27 Aug 2026 19:43:53 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11770604307375046632
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH 07/13] net/txgbe: add offload support for tunnel type UDP
Date: Thu, 27 Aug 2026 19:41:59 +0800
Message-ID: <134A19BB26769507+20260827114309.10530-8-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.55.0.windows.2
In-Reply-To: <20260827114309.10530-1-zaiyuwang@trustnetic.com>
References: <20260827114309.10530-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: M74hkAQalrlrUozEkchWvtesau2A6hmhLlyBpPuPCFPnyoliKjb8FCsh
 poRishNiZ/iGJ+uEM6vppWT2bRFA3smodH1xTXgeH7eNOo69Qlf7NiUuyrVH2k7ykcsvz1D
 GtIz41Z6Iy84eW6k++xaKiavyLDR36iFkwTMJ30Vzk2M3qibvgMmatfCCl/G6xDnr4XZGj9
 /Gwzk++zuNfrHh5KKTSsRDQ0CFqspCj3fasoGTmh6WYrkhk0laOC53dDLqrFHwrbjTT6J1p
 5/YrebNtsAc+7ofKAWu/iR5+yno7Hu+dFTnvUYV3TnGe9U5R+6Uy7FxwOvzvbIz3LFXmt9o
 OxvbdcS18LuUH2jxuEzFH9HbBmKP7/jR8f8tsTh+G4fZBfZqbI1HIkuJvNobGy+ExckGk1x
 79o4tqfDB2j5+MdRPjYLVwVOO8GzmQ6xhGsb8KgsBM8X2VEcYJamOFAXBFyh8fN5sRyNXww
 2y2+D5/rLPpVopSmc3MZW8gnj/ruvcd6BqJW4MyPLYKGFcxdmAJIuDFdovsc8K2tPVn9Z1x
 jM89eUMCSe6iQewZcfRr7zll367vWAf4WiQ4wXqeMcU1tyFMPq0OMa9L4Sc3MejS5Fov8h6
 3xrJyiheuThr4SW2ynsYySyCVZaVvbXeRcxQ89iKR/6Y4K0gpHwgXxB65XPtL9WwwzZdo6H
 JW2Cv/DuEOsKps+/I48SKv13QYb68efLARer2MU/mKCubHWcO45mKCX18xpJLvyyXB4UCDk
 7ytfPwGVmonNSEHDsz0Ei3+lbbfG4MboXCV2nqAPj8yeb4JZuVt8Xp8pxurZX6zDbky1LzW
 OLupBcB8nmJMZLoe6/j+vT7eolRxkatsrT3Gj3vt4Q2oex4qfjpx8Tk71KsfIAmqp/zNrkQ
 r8L8oqtRPlMAx5OAQ/ORfYdKJMoE0iOhXB9toeZdQ2CdmeL07lVxQoDFke5Os22gBrz4cnY
 13yAdfKrW5AiMLCrsH8d+uy5Gy4reI+aZ54V/yTqMTCxP62LeWtXGSZO8aU2Z0ck25szDXx
 DWB2H8Q7DjelFFRWMPWv/JB9Kaun8K5FmR34J36BEYhOSp3sOPCPnXsNaXqYj5FLD+rxd/t
 /ixAI+Kgt/lFCMdk2LwgMmne3TRF+Zkh4wyI9n2D/kfWtNA4Ff9ccgTmVqT1UDZIQ==
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

The non-standard RTE_MBUF_F_TX_TUNNEL_UDP tunnel type (UDP
encapsulation carrying either VXLAN or GENEVE) is not handled:
txgbe_set_xmit_ctx() falls into the "unknown tunnel type" case and
txgbe_get_tun_len() cannot compute the tunnel length, so tunneled
packets are sent with a wrong descriptor or dropped.

Handle RTE_MBUF_F_TX_TUNNEL_UDP by parsing the UDP destination port
(6081 -> GENEVE, otherwise VXLAN) to select the inner tunnel type, so
the correct tunnel length and packet type are reported.

Cc: stable@dpdk.org

Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
---
 drivers/net/txgbe/txgbe_rxtx.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/net/txgbe/txgbe_rxtx.c b/drivers/net/txgbe/txgbe_rxtx.c
index a295666f9d..cd958b4aab 100644
--- a/drivers/net/txgbe/txgbe_rxtx.c
+++ b/drivers/net/txgbe/txgbe_rxtx.c
@@ -419,6 +419,7 @@ txgbe_set_xmit_ctx(struct txgbe_tx_queue *txq,
 			break;
 		case RTE_MBUF_F_TX_TUNNEL_VXLAN:
 		case RTE_MBUF_F_TX_TUNNEL_VXLAN_GPE:
+		case RTE_MBUF_F_TX_TUNNEL_UDP:
 		case RTE_MBUF_F_TX_TUNNEL_GENEVE:
 			tunnel_seed |= TXGBE_TXD_ETYPE_UDP;
 			break;
@@ -593,6 +594,7 @@ tx_desc_ol_flags_to_ptype(uint64_t oflags)
 	switch (oflags & RTE_MBUF_F_TX_TUNNEL_MASK) {
 	case RTE_MBUF_F_TX_TUNNEL_VXLAN:
 	case RTE_MBUF_F_TX_TUNNEL_VXLAN_GPE:
+	case RTE_MBUF_F_TX_TUNNEL_UDP:
 		ptype |= RTE_PTYPE_TUNNEL_GRENAT;
 		break;
 	case RTE_MBUF_F_TX_TUNNEL_GRE:
@@ -713,8 +715,21 @@ txgbe_get_tun_len(struct rte_mbuf *mbuf)
 	const struct txgbe_genevehdr *gh;
 	const struct txgbe_grehdr *grh;
 	struct txgbe_grehdr grehdr;
+	struct txgbe_udphdr udphdr;
+	const struct txgbe_udphdr *uh;
 	uint8_t tun_len;
 
+	/* Check for UDP tunneling */
+	if ((mbuf->ol_flags & RTE_MBUF_F_TX_TUNNEL_MASK) == RTE_MBUF_F_TX_TUNNEL_UDP) {
+		mbuf->ol_flags &= ~RTE_MBUF_F_TX_TUNNEL_UDP;
+		uh = rte_pktmbuf_read(mbuf, mbuf->outer_l2_len + mbuf->outer_l3_len,
+				      sizeof(udphdr), &udphdr);
+		if (uh->dest == rte_cpu_to_be_16(6081))
+			mbuf->ol_flags |= RTE_MBUF_F_TX_TUNNEL_GENEVE;
+		else
+			mbuf->ol_flags |= RTE_MBUF_F_TX_TUNNEL_VXLAN;
+	}
+
 	switch (mbuf->ol_flags & RTE_MBUF_F_TX_TUNNEL_MASK) {
 	case RTE_MBUF_F_TX_TUNNEL_IPIP:
 		tun_len = 0;
-- 
2.55.0.windows.2

