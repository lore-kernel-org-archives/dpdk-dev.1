Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD77AEF36F8
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Mar 2026 07:47:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CF5F2402EF;
	Mon,  9 Mar 2026 08:47:46 +0100 (CET)
Received: from 2.mo15.mail-out.ovh.net (2.mo15.mail-out.ovh.net [5.135.90.179])
 by mails.dpdk.org (Postfix) with ESMTP id 50F3040278;
 Fri,  6 Mar 2026 10:20:38 +0100 (CET)
Received: from DAGFR7EX1.OVH.local (unknown [10.110.54.187])
 by mo15.mail-out.ovh.net (Postfix) with ESMTPS id 4fS1920lxZz3wvf;
 Fri,  6 Mar 2026 09:20:38 +0000 (UTC)
Received: from laptop1704918.desk.int.gns.ovh.net (109.190.254.56) by
 DAGFR7EX1.OVH.local (172.16.2.20) with Microsoft SMTP Server (version=TLS1_2, 
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 6 Mar
 2026 10:20:37 +0100
From: Xavier Guillaume <xavier.guillaume@ovhcloud.com>
To: <dev@dpdk.org>
CC: <linville@tuxdriver.com>, Xavier Guillaume
 <xavier.guillaume@ovhcloud.com>, <stable@dpdk.org>
Subject: [PATCH v1 2/3] net/af_packet: fix receive buffer overflow
Date: Fri, 6 Mar 2026 10:20:12 +0100
Message-ID: <20260306092013.2205076-3-xavier.guillaume@ovhcloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260306092013.2205076-1-xavier.guillaume@ovhcloud.com>
References: <20260306092013.2205076-1-xavier.guillaume@ovhcloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [109.190.254.56]
X-ClientProxiedBy: CAS1.OVH.local (172.16.1.1) To DAGFR7EX1.OVH.local
 (172.16.2.20)
X-OVH-CORPLIMIT-SKIP: true
x-ovh-tracer-id: 11269695121265865073
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: dmFkZTFh2na8x+FrMpf+EgdYNge5r9uU32ke3iCP3EMXSFIoZiTre7rOZ/BWKW9uA07tfM07psGiPYyolTGbuk4HuGhYH9Yv887NykBIT4jL52wsAZZvQ02AlBBroQRMjfgWQhIP/nqOusNmxHuYQBlcZQWzNCkECe0BGeltl1mawXW5DcfyquxN17rV4LCad1QYGlozPEdm4tHQ2fvwKCvNZMA6gWiiPJjL3dhy2M/DNpT0ELXD2CDEV0AZBRBBnjVegFp7omvHx+1G9OgU8LEwmnF1KpkSoDRUBhejmzqn/Q+df97ukiujgOuiKx2eKmZCaR2sQRKtyk0gzVjsWqZ8WVAtb9F6xN/S8DhlQRlkNW4oyLGK9Anp01dXJlxdpGEgSrrIAWcA3hn2LS3Q29U5VxINzJW5b0V/EIZE5ZZ3zwPL4KKDlwJJDVmEPf+KOQvr1uYzm3EH/FiAcq7INIlx7tDBW9wDSYBMVGfEfZif0k0u4Z+4B2hx+EWD66TZUZXagHwCLOkgBVBS22gY+oxajSW2Qz9P0aXZCbr0Vt/yOlYWzc7PmtZ220/LrLc025FdQILpp158FX4faDpi10prs9dqJdcxwYayqj64CUMu+wwTipzPb1RvxMTSK7mmBm+CNDpvbDpyKCkQ4XTBfF3+xz/rR2ofpDJ6e7nAktZh6udlHA
DKIM-Signature: a=rsa-sha256; bh=K0sC5E9RnsfwlnZyLBSN3aXrNmDHehec9d43f6iKQTg=; 
 c=relaxed/relaxed; d=ovhcloud.com; h=From; s=mailout;
 t=1772788838; v=1; 
 b=p3VwYkavX/PFfkZBF/fAXckGrBCWpObK1oXuFp+7Gf+ElOjYtWZNyiFL4dCdhU7E7P/pdXsQ
 Iq7JpUl/WxDynt/b69Amru2zzTPIHP6KYLCf97+mt3tWQG9aO940Lig2exXagyZLfsQIzO2UQ5s
 wqpH0r5pDxYlj7yfR5H8QiYM=
X-Mailman-Approved-At: Mon, 09 Mar 2026 08:47:43 +0100
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
Reply-To: xavier.guillaume@ovhcloud.com
Errors-To: dev-bounces@dpdk.org

The receive path copies the entire incoming packet into a single
mbuf without verifying the packet fits. If the kernel interface
MTU is raised externally beyond the mbuf data room size, the
memcpy overflows the mbuf buffer.

Add a bounds check against the mbuf tailroom before copying.
Oversized packets are dropped and accounted for in the
rx_dropped_pkts counter, consistent with how the TX path
already drops oversized packets.

Fixes: 364e08f2bb ("af_packet: add PMD for AF_PACKET-based virtual devices")
Cc: stable@dpdk.org

Signed-off-by: Xavier Guillaume <xavier.guillaume@ovhcloud.com>
---
 drivers/net/af_packet/rte_eth_af_packet.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/af_packet/rte_eth_af_packet.c b/drivers/net/af_packet/rte_eth_af_packet.c
index bfa68297a6..b04987aaf7 100644
--- a/drivers/net/af_packet/rte_eth_af_packet.c
+++ b/drivers/net/af_packet/rte_eth_af_packet.c
@@ -154,6 +154,16 @@ eth_af_packet_rx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 			break;
 		}
 
+		/* drop packets that won't fit in the mbuf */
+		if (ppd->tp_snaplen > rte_pktmbuf_tailroom(mbuf)) {
+			rte_pktmbuf_free(mbuf);
+			ppd->tp_status = TP_STATUS_KERNEL;
+			if (++framenum >= framecount)
+				framenum = 0;
+			pkt_q->rx_dropped_pkts++;
+			continue;
+		}
+
 		/* packet will fit in the mbuf, go ahead and receive it */
 		rte_pktmbuf_pkt_len(mbuf) = rte_pktmbuf_data_len(mbuf) = ppd->tp_snaplen;
 		pbuf = (uint8_t *) ppd + ppd->tp_mac;
-- 
2.34.1

