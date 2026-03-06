Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3277CEF36F7
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Mar 2026 07:48:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E132840608;
	Mon,  9 Mar 2026 08:47:47 +0100 (CET)
Received: from 2.mo15.mail-out.ovh.net (2.mo15.mail-out.ovh.net [5.135.90.179])
 by mails.dpdk.org (Postfix) with ESMTP id DF9AF40278
 for <dev@dpdk.org>; Fri,  6 Mar 2026 10:20:39 +0100 (CET)
Received: from DAGFR7EX1.OVH.local (unknown [10.109.231.79])
 by mo15.mail-out.ovh.net (Postfix) with ESMTPS id 4fS1935RD0z3wnm;
 Fri,  6 Mar 2026 09:20:39 +0000 (UTC)
Received: from laptop1704918.desk.int.gns.ovh.net (109.190.254.56) by
 DAGFR7EX1.OVH.local (172.16.2.20) with Microsoft SMTP Server (version=TLS1_2, 
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 6 Mar
 2026 10:20:39 +0100
From: Xavier Guillaume <xavier.guillaume@ovhcloud.com>
To: <dev@dpdk.org>
CC: <linville@tuxdriver.com>, Xavier Guillaume <xavier.guillaume@ovhcloud.com>
Subject: [PATCH v1 3/3] net/af_packet: support jumbo frames
Date: Fri, 6 Mar 2026 10:20:13 +0100
Message-ID: <20260306092013.2205076-4-xavier.guillaume@ovhcloud.com>
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
x-ovh-tracer-id: 11269976595859648822
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: dmFkZTFh2na8x+FrMpf+EgdYNge5r9uU32ke3iCP3EMXSFIoZiTre7rOZ/BWKW9uA07tfM07psGiPYyolTGbuk4HuGhYH9Yv887NykBIT4jL52wsAZZvQ02AlBBroQRMjfgWQhIP/nqOusNmxHuYQBlcZQWzNCkECe0BGeltl1mawXW5DcfyquxN17rV4LCad1QYGlozPEdm4tHQ2fvwKCvNZMA6gWiiPJjL3dhy2M/DNpT0ELXD2CDEV0AZBRBBnjVegFp7omvHx+1G9OgU8LEwmnF1KpkSoDRUBhejmzqn/Q+df97ukiujgOuiKx2eKmZCaR2sQRKtyk0gzVjsWqZ8WVAtMeBShSKmiebAeBB9BzFvWE37pCtQUlqLx+/szlBG+IwrxGdUNtb5v2nARlzijLbV0trFXz5sxnGFEgcWBiX5B+keRLMYgimAJzz8UadPUs/7fGkGfsaayo15NRb/kSWyO9dKclVvId7jtORuHyff/eZ31l859s4sFAdBur2WUyv1DR/ugglkfKiRWgjfDAfByCka4pCUWTiu96YTuGo9jdGpA1yoxi4j/Ho0alnKaBypZe08Gwh200McMc6O0Vs9S4nc9E8g5sFz6C250+pvi4n5HNMr2QOWB3JWwlROwPDp0j1RA8M3ofFBTQ0aVDiOL9t7VNfjjerxvLj72BgApw
DKIM-Signature: a=rsa-sha256; bh=C0b7Ex/CONdxoUTtQXpGd5czZ2zhWNZq0kA0XnNBd9o=; 
 c=relaxed/relaxed; d=ovhcloud.com; h=From; s=mailout;
 t=1772788839; v=1; 
 b=UnrkOIurkW76gfxZiGPVvT/QbI+Dzu5o+lpJclkesLj/DnOIGJRt1VsUD9tc/ED5MwPLONNq
 2TAl8SgjZ3oXVLKCd4ddwt8YaccGZ1y4/TH1QxW81VxuFGL+QcTY49Z2bejdguhfUdVB0qnOEcV
 pUdOLHlcvbxJ7QpHMg5D4DH8=
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

Derive max_rx_pktlen and max_mtu from the actual TPACKET ring
frame size rather than the static RTE_ETHER_MAX_LEN (1518).
This allows jumbo frame support when the user specifies a
larger framesz devarg at vdev creation time, for example:

  --vdev=net_af_packet0,iface=eth0,framesz=9216

The advertised capabilities now accurately reflect what the
configured ring can handle, avoiding both false limitations
with large frames and false promises with small ones.

Signed-off-by: Xavier Guillaume <xavier.guillaume@ovhcloud.com>
---
 drivers/net/af_packet/rte_eth_af_packet.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/af_packet/rte_eth_af_packet.c b/drivers/net/af_packet/rte_eth_af_packet.c
index b04987aaf7..bfd2693a69 100644
--- a/drivers/net/af_packet/rte_eth_af_packet.c
+++ b/drivers/net/af_packet/rte_eth_af_packet.c
@@ -402,7 +402,10 @@ eth_dev_info(struct rte_eth_dev *dev, struct rte_eth_dev_info *dev_info)
 
 	dev_info->if_index = internals->if_index;
 	dev_info->max_mac_addrs = 1;
-	dev_info->max_rx_pktlen = RTE_ETHER_MAX_LEN;
+	dev_info->max_rx_pktlen = internals->req.tp_frame_size -
+		TPACKET2_HDRLEN + sizeof(struct sockaddr_ll);
+	dev_info->max_mtu = dev_info->max_rx_pktlen -
+		RTE_ETHER_HDR_LEN - RTE_ETHER_CRC_LEN;
 	dev_info->max_rx_queues = (uint16_t)internals->nb_queues;
 	dev_info->max_tx_queues = (uint16_t)internals->nb_queues;
 	dev_info->min_rx_bufsize = 0;
-- 
2.34.1

