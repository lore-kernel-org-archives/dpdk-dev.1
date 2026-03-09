Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49899F4180E
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Mar 2026 16:14:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DC56E40678;
	Mon,  9 Mar 2026 17:13:51 +0100 (CET)
Received: from 2.mo508.mail-out.ovh.net (2.mo508.mail-out.ovh.net
 [5.135.90.177]) by mails.dpdk.org (Postfix) with ESMTP id BBC024066D
 for <dev@dpdk.org>; Mon,  9 Mar 2026 17:13:49 +0100 (CET)
Received: from DAGFR7EX1.OVH.local (unknown [10.110.43.220])
 by mo508.mail-out.ovh.net (Postfix) with ESMTPS id 4fV2BP4grxz7tDg;
 Mon,  9 Mar 2026 16:13:49 +0000 (UTC)
Received: from laptop1704918.desk.int.gns.ovh.net (109.190.254.56) by
 DAGFR7EX1.OVH.local (172.16.2.20) with Microsoft SMTP Server (version=TLS1_2, 
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 9 Mar
 2026 17:13:49 +0100
From: Xavier Guillaume <xavier.guillaume@ovhcloud.com>
To: <dev@dpdk.org>
CC: <stable@dpdk.org>, Xavier Guillaume <xavier.guillaume@ovhcloud.com>
Subject: [PATCH v2 3/3] net/af_packet: support jumbo frames
Date: Mon, 9 Mar 2026 17:10:21 +0100
Message-ID: <20260309161021.2790684-4-xavier.guillaume@ovhcloud.com>
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
x-ovh-tracer-id: 17419078935494799729
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: dmFkZTGytR4gYtPt7e0e4kfqLZmo0v9gtknYBMZjqwx2qwke15EDYC11TeVqSDWlD0Akj9LuFZYQJ/AT0EOt01NOdo17IAOJ/KG7R+JK3Zo/OVA7vCNg+o/7rNuz+3Kcz6XpvkYOMiuzhp4QKcXyxdUhYPx/0eLRqpVR6Iuejg1BwwQeGpu8H3A9Y/77W02dZIh/wRFdphLpfs6WquRLhVsnKJ+aXT9dIQY6NWQnjGqN9bkBjNJdQI6zWVHsfjY1YWH9iDPEI+LnyVLYJ18TH5t7zOSaIwhlB8OCGKPItfqaxzR2dyL5qrBAuZZBbTK2R0cFA9gZaDXVX83IPA5Z6s55iVSGRLYssvyVFRvPK4oiSEVOtfiiHxVMUvlIN/66JCXN3CXCwItijkjbJxTVu1+kwvmtC+sweBuVpl/OHGAIZ9MN7NoXVM6IITW/vB1ENv4hZfuBEKVO27Hchv2TVDJ11Yz7m6os89hgVfRqWFP4SZ3hQMrRKcxq1Bpr26lwqDS21aYQoPn3EpNUgWYKM5ndK0NGcL7p/lsjNarN241DDjS3nMqncwuUX87RY4kkk/oejgAOEDgX2Jo1Krie/0DgqMmx3m7u/+di6RkOE93t0UlHzOPcMBnKDGbJIRnMceL71LZVgMWYEZ6R56ozBu+CcZOHRXR55D81ZtdgPJyUuXpgVw
DKIM-Signature: a=rsa-sha256; bh=C0b7Ex/CONdxoUTtQXpGd5czZ2zhWNZq0kA0XnNBd9o=; 
 c=relaxed/relaxed; d=ovhcloud.com; h=From; s=mailout;
 t=1773072829; v=1; 
 b=RGjVft+YlMJGbHsbi8ySae7JgwgPNe47Cz6MzjPdvDz+xIflBn1hi7mtaOwajhBLkZg7HSnc
 /r69RxRGrT7njnvwANS/sw7CpUygBpaYcIBnlu2Isnf2i/9IVUoGXzKGihA7HG/WDIAiOXq0cEp
 9P4OrrbG/WnF+sDwtS3ZCaOs=
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

