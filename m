Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDA48EB104B
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Mar 2026 11:22:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BA68E40B9C;
	Tue, 10 Mar 2026 12:21:47 +0100 (CET)
Received: from 2.mo15.mail-out.ovh.net (2.mo15.mail-out.ovh.net [5.135.90.179])
 by mails.dpdk.org (Postfix) with ESMTP id 7629740A6B
 for <dev@dpdk.org>; Tue, 10 Mar 2026 12:21:43 +0100 (CET)
Received: from DAGFR7EX1.OVH.local (unknown [10.110.0.234])
 by mo15.mail-out.ovh.net (Postfix) with ESMTPS id 4fVWfv25j6z3wwJ
 for <dev@dpdk.org>; Tue, 10 Mar 2026 11:21:43 +0000 (UTC)
Received: from laptop1704918.desk.int.gns.ovh.net (109.190.254.56) by
 DAGFR7EX1.OVH.local (172.16.2.20) with Microsoft SMTP Server (version=TLS1_2, 
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 10 Mar
 2026 12:21:43 +0100
From: Xavier Guillaume <xavier.guillaume@ovhcloud.com>
To: <dev@dpdk.org>
CC: Xavier Guillaume <xavier.guillaume@ovhcloud.com>
Subject: [PATCH v3 3/3] net/af_packet: support jumbo frames
Date: Tue, 10 Mar 2026 12:21:22 +0100
Message-ID: <20260310112122.2930093-4-xavier.guillaume@ovhcloud.com>
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
x-ovh-tracer-id: 18358642409434984864
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: dmFkZTGUMtlrB8NvDWyrIFgd9vPeh5wE/1Aq8XERSU6szKcyggOJOK+CKqoxMRqHt3FDT8sgDJ4nC8uCCj6gi8Ml3gtQFLe3+Z7Vem0JQ8RLloqFz4MuC8q3/pXsEcad2VpLAndiGH3Bjd7E9jeCSDe0qUqmxad+Ae6weDCbq8o3eJRh/gVxRBVBwNJN6tSEo0R2d88jUzizjrIY8/4dbjcRn3nw+9NYzkibyVRCqHFxkoVNAGzlh1Uu3HPH1jfrT1Jh1mYPEgi1gLSQb+WtTwc417pNmESPXNqGAQq6801IeXvqHYBSt/YND61juaJhPVFAM5Unmtcx2AUdyI06tJV33DIFm/5ZQGrf+bskJGx3Noyzq16ceueqls8iWPJy0bgNN39Idi43FlL/LhwybgxTj4tIeTo4i2UyVx3P5snGDWShfNxksRRL0cr83GvgAlvpCRG7Wwu0+sdroXDfrOFlthVe89OTOlxycLgIdZwpAJNQkcc3PmImPatiFJCMlcPS9sADpgc9KiOw0TNDSx1EtjRE6PvNaiXk6bKjJ4b3VMeL65F4nCsd1KU2tgbSVldNnu/3BrOwaXCVmcJvEBj5+FUySToeLvMiwRm0rlPcayMMszS+laxUCew/cmt+6y+5qimvvDBzBWEXpgx+xLze214L0QlHwAzwG7bPjvFkUq/E6w
DKIM-Signature: a=rsa-sha256; bh=qRTlv6/JgHQLEnNEvTGEV/tp2kAJrgc08gSe7KpD3f8=; 
 c=relaxed/relaxed; d=ovhcloud.com; h=From; s=mailout;
 t=1773141703; v=1; 
 b=jqAHoknQcKcJ14Z04UBsI3lvegLPXa62rWELeza0BINC5iQ1ZNO3FdunYL5TxQSbiTepLQaz
 bDim7vbDCn+0LzetaRS4xxeaopQqegxEGPTDSJ21W6X67vRj2nIiJv4ZpjpA6fA4OhDHdURPcNU
 W90wnG+e3eZAyLDVla4p++7M=
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

Since the ethdev layer now validates mtu <= max_mtu before
calling the PMD callback, convert the data_size bounds check
in eth_dev_mtu_set() from a runtime error to RTE_ASSERT().

Signed-off-by: Xavier Guillaume <xavier.guillaume@ovhcloud.com>
---
 drivers/net/af_packet/rte_eth_af_packet.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/af_packet/rte_eth_af_packet.c b/drivers/net/af_packet/rte_eth_af_packet.c
index b04987aaf7..e132dc387b 100644
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
@@ -624,8 +627,8 @@ eth_dev_mtu_set(struct rte_eth_dev *dev, uint16_t mtu)
 	unsigned int data_size = internals->req.tp_frame_size -
 				 TPACKET2_HDRLEN + sizeof(struct sockaddr_ll);
 
-	if (mtu > data_size)
-		return -EINVAL;
+	/* ethdev layer validates mtu <= max_mtu before calling this */
+	RTE_ASSERT(mtu <= data_size);
 
 	s = socket(PF_INET, SOCK_DGRAM, 0);
 	if (s < 0)
-- 
2.34.1

