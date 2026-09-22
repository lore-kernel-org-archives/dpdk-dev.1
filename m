Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ADB8C982FA
	for <dpdk-dev@archiver.kernel.org>; Tue, 22 Sep 2026 12:55:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5B98042EBC;
	Tue, 22 Sep 2026 14:54:57 +0200 (CEST)
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
 by mails.dpdk.org (Postfix) with ESMTP id 28AA542EB1;
 Tue, 22 Sep 2026 14:54:52 +0200 (CEST)
X-QQ-mid: esmtpsz17t1790081685t4040d081
X-QQ-Originating-IP: fDghcfuvQlai88tE6CmcLD8oYngEN23MF8hdxUaeeE4=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.205.193.132])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 22 Sep 2026 20:54:43 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14474844564764944958
EX-QQ-RecipientCnt: 5
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>, Ferruh Yigit <ferruh.yigit@amd.com>
Subject: [PATCH v4 09/16] net/txgbe: add offload support for tunnel type UDP
Date: Tue, 22 Sep 2026 20:37:42 +0800
Message-ID: <9E9C9CB291795F51+20260922125414.3638-10-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.55.0.windows.2
In-Reply-To: <20260922125414.3638-1-zaiyuwang@trustnetic.com>
References: <20260827114309.10530-1-zaiyuwang@trustnetic.com>
 <20260922125414.3638-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MUSna4nE7xDosEfC6OnPayAdMsOApYUM3CL8IJ+lG22c10Pey1qllZ4l
 o+HPwo7m9XIqhBPhGcKfkAhkbMP4M35O9/KdoUnzHaTlTo9RRNyyHBtyRvq/k7H8voCRvGY
 sPbux53ohB53kHKz/5qs652/IGvOqsOn6QQpBuUzH541iQIYn3l8yIK/578Fq5whaItoIqI
 YW2nsGXnjzF+IMCXG6Ct0U3J5yEdsRfsGcfQ6x8/+RRnjrReYVHAYQou1eLYdxIxzbJjhtP
 b3ttUeDMW5Wyp7AhggjgIWR58TtK+jkpr6HJ8moOSmNHvJlvmT+615BChXxyfgvwm4wnfOX
 6yxEQA6s6jVF1ovDiYnzlS1vapr9ZDo6kD4O7KucRanzhkHGy5aLx7W+IiwDC7Nges/TnCn
 ERK2nxR9imk0PjH9w1OOrnWHA7Zamp2FPYelcE0hU+y80qo7GkO6uVl1AE2VYqVyyrbaugT
 bHgK2ikxNlhRqh/tw7mtGZZxYEZEZYKZod7FSbfU6x4tnhajQxu0jpslRDNiz5XEWNc1MMk
 PQbbAFjT6gJxa3jqd7HzTbVVYnNkjRD2Rc92V+scIE77KiFaqKbBSuZ/QItTMY9USAm3Dup
 kFWNJRTFrKH+2I+tpAjqYZ2NDkS6DQt2OTEa1wKusyFEqIMUA4n1XstwDl2mJ3+n7Oikk0P
 XzPczKQB+QpYUeAaYIxgk2R8rHV6WUMWiLhL2lj9rdiQBWn8YIxgF4OUPb+wx5X0fr7FiFf
 fkUPkJRnGbxOmnXAiMCrnmS77zDkjHd0SWZopK8M0wlkyIHZ+c80Ak/e49hlOlQxClaNzi7
 fiN3xOnLGw680zn/Q17rCV8LYpqclu76anao0xISOtDLZyPsKNliFBxtpbINA8sOFapzHnW
 ue1Kvlyl7wp+usHAZUVdv2EJnbIJOY/o6J/7lHHoxSGG5Ya+5FLCP3KqHkUch3Hv6zEGr42
 UDrgbShAWTv+y9PLxUQLdPPR8L9E7KtzhzRkJWPIY5iYSI8MHZV4IDV0GBSGHXOhxgzM9yh
 6IfZ4tmT9KkLUqe/wcOZbHY1bU4MtLIEHB4hN/4pmwS5GWzcLMBxD+kEgLq5g62/bGAhBV+
 0JG4QWKD08TyqQkXcaqNa0=
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

