Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3231C79F99
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Sep 2026 13:28:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2F284410D4;
	Tue,  8 Sep 2026 15:28:14 +0200 (CEST)
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
 by mails.dpdk.org (Postfix) with ESMTP id 07C59410D0;
 Tue,  8 Sep 2026 15:28:11 +0200 (CEST)
X-QQ-mid: zesmtpsz3t1788874085t890ee287
X-QQ-Originating-IP: JHWFn84tZ9Qw1erv8BTfkZUpXoFe/LRdxDH6Wt/ABFg=
Received: from DSK-zaiyuwang.trustnetic.com ( [36.24.66.61])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 08 Sep 2026 21:28:03 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 5240350349390422308
EX-QQ-RecipientCnt: 5
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>, Ferruh Yigit <ferruh.yigit@amd.com>
Subject: [PATCH v3 08/15] net/txgbe: add offload support for tunnel type UDP
Date: Tue,  8 Sep 2026 21:25:53 +0800
Message-ID: <C031DA3742ED3D93+20260908132742.2661-9-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.55.0.windows.2
In-Reply-To: <20260908132742.2661-1-zaiyuwang@trustnetic.com>
References: <20260827114309.10530-1-zaiyuwang@trustnetic.com>
 <20260908132742.2661-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NIY9SeApT9R1wdTOij18eq0lIZoocSRQZFF6oF5hkynm23W91X5zoFnK
 uIp1Vp7eQZGIr2l8d7S1Jj2tDVjoj34Yb75wuE5AuS3d26A/5dLFAimWL1eqeP0GrwkcOq8
 2K59fEG7DmT5VKCbITCpDzQVIjkDNvEQ0FYWYXlDuYy7a6oNuvmvXYi/GQ1+1SyFtaeOCiT
 eqK8MjY0B7WBfAvqXGVM1d1+Mwjd/+tPYul5lZaqZRqDRjpxUvTbhALnOPhZKOyvF9Lankw
 40fpXBd/kez/N3TJ+31OUsQOAO19VUQK7EFm/QDzh6JYPLdShbV/No/mXAnFteAn2oGGeRQ
 fZ6sGMPvKl/qVCc+/W7kyVkJv9Z9o8b/uYsH9ihSkKbRrz/58q3ZQ3nmo3+yY5n5f0X/Akn
 bWeHtBV8FHPkyB/fGY0LfYzXMkGdy4wsxEftFg/+umIKzY5spB2kvFBw15bIGtt9zKxhqCr
 8Xp6Dyycyki3jr/g+qZX4ccgxNRyvrir5xrqsdJHjeLILhqV4DHebjrh6fc3Xa/c7Fpzhuo
 V/Fa1QSF+ilpuQoLuz4NKmIAlCGf9iya2HDYqS2nMEbYGTP/X1PqMDky6mrZ0ozbH0+y8aB
 +h84f4JQgk8oevBat3qI61T2ek/UD0ntwNM+afkSnBM8BGUgXMVvjROZHOQ+Ca9/SuB+7Ry
 Li2YffvsK6wNJ3ANRIbiGkrsf/5i4YiN2megwDTVym+9/SxLGNR5EeECnV6674wgLDR7f42
 745BtVWdTlIi8CVera9M/N3EJsfwvdf4pT0fBtBAwb8llEckMNs/A2xWdFKrLOksIN+mD0g
 HgwbsYc08H9xp4J7BofSlwDeChbELAcEipQMFXhXgHC/2aH/57bqU4VppMttoGHxeYHMdOh
 WxfYxfWVLp4K6FJFP9Uauo3mUWvULvosokXNjEYFjtvJk99a4nzguklrM84WnqMmMQRLHux
 yY+VmU4bmHpSVyTter8KpFQSD10EDd9o688BaJSr04K4+rLH1V+zNVK1fB+CEirUhzGcUPJ
 AYF/rswCepPHNajfeWvv1vPJxT9MkXyxWiqzYimEhC8HPuIon3JrU0fKtECofly0Uc/9cu/
 uUg6/dYBheDjo24kfHkDBRFR8nEYcnbKxJOzuSyUVTXP/fRBge5TrprbR0JnCmpzw==
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

