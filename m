Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1006CEB104B
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Mar 2026 11:21:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A2C6040DD6;
	Tue, 10 Mar 2026 12:21:45 +0100 (CET)
Received: from 2.mo15.mail-out.ovh.net (2.mo15.mail-out.ovh.net [5.135.90.179])
 by mails.dpdk.org (Postfix) with ESMTP id 5979A402DC
 for <dev@dpdk.org>; Tue, 10 Mar 2026 12:21:43 +0100 (CET)
Received: from DAGFR7EX1.OVH.local (unknown [10.110.0.234])
 by mo15.mail-out.ovh.net (Postfix) with ESMTPS id 4fVWfv1N2Yz3wqK;
 Tue, 10 Mar 2026 11:21:43 +0000 (UTC)
Received: from laptop1704918.desk.int.gns.ovh.net (109.190.254.56) by
 DAGFR7EX1.OVH.local (172.16.2.20) with Microsoft SMTP Server (version=TLS1_2, 
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 10 Mar
 2026 12:21:42 +0100
From: Xavier Guillaume <xavier.guillaume@ovhcloud.com>
To: <dev@dpdk.org>
CC: Xavier Guillaume <xavier.guillaume@ovhcloud.com>, <stable@dpdk.org>
Subject: [PATCH v3 2/3] net/af_packet: fix receive buffer overflow
Date: Tue, 10 Mar 2026 12:21:21 +0100
Message-ID: <20260310112122.2930093-3-xavier.guillaume@ovhcloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260310112122.2930093-1-xavier.guillaume@ovhcloud.com>
References: <20260309161021.2790684-1-xavier.guillaume@ovhcloud.com>
 <20260310112122.2930093-1-xavier.guillaume@ovhcloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [109.190.254.56]
X-ClientProxiedBy: CAS1.OVH.local (172.16.1.1) To DAGFR7EX1.OVH.local
 (172.16.2.20)
X-OVH-CORPLIMIT-SKIP: true
x-ovh-tracer-id: 18358642406792245617
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: dmFkZTGUMtlrB8NvDWyrIFgd9vPeh5wE/1Aq8XERSU6szKcyggOJOK+CKqoxMRqHt3FDT8sgDJ4nC8uCCj6gi8Ml3gtQFLe3+Z7Vem0JQ8RLloqFz4MuC8q3/pXsEcad2VpLAndiGH3Bjd7E9jeCSDe0qUqmxad+Ae6weDCbq8o3eJRh/gVxRBVBwNJN6tSEo0R2d88jUzizjrIY8/4dbjcRn3nw+9NYzkibyVRCqHFxkoVNAGzlh1Uu3HPH1jfrT1Jh1mYPEgi1gLSQb+WtTwc417pNmESPXNqGAQq6801IeXvqHYBSt/YND61juaJhPVFAM5Unmtcx2AUdyI06tJV33DIFoq/1mCU/c3IpL+KPj1/qCPj/RV5xaz2oe3p/t3hSw69B4wuMYjDgJaPU+C7aKD6cI5JDXGsicGcP1doh1n2DPthN1I8VakdL7wmzsmrxqG3qdAGX9OUI1w/dB4P4f3Q9TdXEJpkX3vJY/E65/GCO322JYsZY5SqD+315c+ivk9SlX3niQd1EvN67lUYk8GtM20uIF4+iVFbMX37sJaOI6Dc5klbACT1jybPLo9KyafOoh0XuLss23x71bMbMhWtQFgMElOynL8EUCDtc3UaLeTZ2E1i2TztO34bcr8CT/zS5le2wU/o8Yp1hmc+gN4Xr9Vpk7VlmHlAra0TWKmt1Kg
DKIM-Signature: a=rsa-sha256; bh=2tnBdlMxqou/hNvNp/XfwgaBom/s68HT3+XVR38F6Xc=; 
 c=relaxed/relaxed; d=ovhcloud.com; h=From; s=mailout;
 t=1773141703; v=1; 
 b=bBwEbuQ5Aoq4AXLxJLSdz1988H46pOd/YAQhpRNzUXTtz79cYXFQJOQckgLIn8jAhU0WiN7V
 boyEiSE7who637L3yGZRc5ketIe9Q32U6xqbliFQdmFjgh72J9cRVJa/0mcjrArwdqb99vxOhKs
 Eo4Lrr4/s4D01EJ3jgau1eTQ=
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

