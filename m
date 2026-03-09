Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF4CAF417F3
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Mar 2026 16:13:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B4E0B40670;
	Mon,  9 Mar 2026 17:13:50 +0100 (CET)
Received: from 1.mo15.mail-out.ovh.net (1.mo15.mail-out.ovh.net [5.135.90.178])
 by mails.dpdk.org (Postfix) with ESMTP id 7F9514066D;
 Mon,  9 Mar 2026 17:13:48 +0100 (CET)
Received: from DAGFR7EX1.OVH.local (unknown [10.109.254.233])
 by mo15.mail-out.ovh.net (Postfix) with ESMTPS id 4fV2BN1hwLz3xXW;
 Mon,  9 Mar 2026 16:13:48 +0000 (UTC)
Received: from laptop1704918.desk.int.gns.ovh.net (109.190.254.56) by
 DAGFR7EX1.OVH.local (172.16.2.20) with Microsoft SMTP Server (version=TLS1_2, 
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 9 Mar
 2026 17:13:47 +0100
From: Xavier Guillaume <xavier.guillaume@ovhcloud.com>
To: <dev@dpdk.org>
CC: <stable@dpdk.org>, Xavier Guillaume <xavier.guillaume@ovhcloud.com>
Subject: [PATCH v2 2/3] net/af_packet: fix receive buffer overflow
Date: Mon, 9 Mar 2026 17:10:20 +0100
Message-ID: <20260309161021.2790684-3-xavier.guillaume@ovhcloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260309161021.2790684-1-xavier.guillaume@ovhcloud.com>
References: <20260306092013.2205076-1-xavier.guillaume@ovhcloud.com>
 <20260309161021.2790684-1-xavier.guillaume@ovhcloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [109.190.254.56]
X-ClientProxiedBy: CAS1.OVH.local (172.16.1.1) To DAGFR7EX1.OVH.local
 (172.16.2.20)
X-OVH-CORPLIMIT-SKIP: true
x-ovh-tracer-id: 17418797462051107185
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: dmFkZTFX7Ywr2E4ILOcrMbVpx+Fq3/ZT3Gft+2CPhKyCMWYh/WmCrXtyjnE7tlvBoLJ0XFsBYFoBQEc+Cn/txPxMferDgXHCPkWWOD+TdaVztpA78bFdevnWxz+TiMveZBaIAdbQ7KxKzBuTbfWh6uMLAT1hVqXSF6lfJ5GdT5lGi0bcbu22uJSKnRC6H8zjgQYKg1iWzWKtsuXWtX3Rc4EFr1HwjEKQS2CUG2bDaaFogySp4Q80bltdNfW15DUzH5VHzVR1Qi+iVlasVutaGg65JIKGlQyN7JmC2fvdvpa36Pr/F7jUmizfJvxKPy/OLvcgZyFR29jtYa/GYAcdVu/lI6PpHFUhBarq4tX+Wx9rLAraD/TeijfuvNyHmOlGmPbMpZ5xA+gmIeb/wJ8q3VjUn3qKD1YI5mckuHeKy4iFd8Z4jSq4r6usnrppyWnIZj+zuIfJDvmDvfu2RcXyJpa5qvRXKuxv4U+4699QvpjE2E7sMCrPPVvew1IX84YdRv7tEbzK9+Qmq5yCrXtJD65XAqo5axuu6ImUFuRnKYOBQdWQzXvqALEuOmkre+yfx7JU96caAw4eLLhbq6VABqhbcqgeXTO1iF+Vg83/IQgvZG94WgELRlLgxp9Vo7LgnwgcRTmzNjVumm7pSl6ByOiMPVlg9bniHbN8OHbN14SJDkcBrA
DKIM-Signature: a=rsa-sha256; bh=2tnBdlMxqou/hNvNp/XfwgaBom/s68HT3+XVR38F6Xc=; 
 c=relaxed/relaxed; d=ovhcloud.com; h=From; s=mailout;
 t=1773072828; v=1; 
 b=s/LaIMhBRADQMzpSHpAcaSd6XHdrsWZ9ApfejKNDSwLImkZNtERaZhBd3jKd1AEL0AJ7+Wts
 Ecycjps4vKTgTQu1LkDs/lX/AnsCfPg5syylcQmIxRPtb7ZK6EKsbFLJQESFWmK0Vf2OBkjWAPo
 x8FRk0q74kPew/L5RtZaXwOs=
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

Fixes: 364e08f2bbc0 ("af_packet: add PMD for AF_PACKET-based virtual devices")
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

