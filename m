Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 786A4F417F3
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Mar 2026 16:13:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9033D40663;
	Mon,  9 Mar 2026 17:13:47 +0100 (CET)
Received: from 2.mo508.mail-out.ovh.net (2.mo508.mail-out.ovh.net
 [5.135.90.177]) by mails.dpdk.org (Postfix) with ESMTP id E623E40261;
 Mon,  9 Mar 2026 17:13:45 +0100 (CET)
Received: from DAGFR7EX1.OVH.local (unknown [10.109.254.241])
 by mo508.mail-out.ovh.net (Postfix) with ESMTPS id 4fV2BK5ZCNz7tGy;
 Mon,  9 Mar 2026 16:13:45 +0000 (UTC)
Received: from laptop1704918.desk.int.gns.ovh.net (109.190.254.56) by
 DAGFR7EX1.OVH.local (172.16.2.20) with Microsoft SMTP Server (version=TLS1_2, 
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 9 Mar
 2026 17:13:45 +0100
From: Xavier Guillaume <xavier.guillaume@ovhcloud.com>
To: <dev@dpdk.org>
CC: <stable@dpdk.org>, Xavier Guillaume <xavier.guillaume@ovhcloud.com>
Subject: [PATCH v2 1/3] net/af_packet: fix MTU set data size calculation
Date: Mon, 9 Mar 2026 17:10:19 +0100
Message-ID: <20260309161021.2790684-2-xavier.guillaume@ovhcloud.com>
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
x-ovh-tracer-id: 17417953036239647089
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: dmFkZTFTg4y6aAqb8ym/WdxAMz+3uomh+JJJIEYIUYy3zLbldYTzskbD0vIDSbWU1zIV74jZij20oSYQ34Lj5z9+n9PsyQWW7OiZRiUH0ze6wdTQALvdl2s4IwvjmONDDGEltBZlAt0SCMZiU0wy1wImA6scjRzDITQDAxGrAM1aauY9oLoxgh11nFhJVIhe0RhX8cjc8HjSuABNIovt2e7W+QBz+WFotiKEs7Nm3cJkZTJyhE8ehS0ldnaN/6FC14+xr2NrmXFXjBDw6sdMqwvzq7NTdhweVALHf5VhVNAwGK2SQIFg7Jyu4pqrBDO1CefSdgkJhnrGZwQYhK1N4MNONePJmVHJcGVFaGsht9IfQCvucsfhbDBY0uobwirWs4A4rxTOhfidTbRsGuPKZWwn593RMOYxvth957TtsquicJDBdf/dxN1PdQnBXdIGrasOSaOxH3Zyj8WWa/hyibIscut2lnKXI533lPBH3nffhNNt0v5pfvmRE43CazGw3tilcgMyLCbTCuu2rZHgE929p0z1+LKHaN7zmHVHww0l/blxcqY42IUiQk1yUxdIvIsrY8JmW73P3z4zbyfTMJT5GxI52M6jvZksC9iQzAQ9FHelKYBF0VNFhnmynwTE/EToBgnVRc4N4p1xSgSp97hhmFEwgemTEOee8PwmzRvinOXv1g
DKIM-Signature: a=rsa-sha256; bh=fG5zSILIBKer+isDgKUubVt0gqC2KM7+Mt3hO877aUU=; 
 c=relaxed/relaxed; d=ovhcloud.com; h=From; s=mailout;
 t=1773072825; v=1; 
 b=stuwsq+z4eKC0qKK1NFm/kboqHiRHlje89NRu7nxF4CtlxgQonrqUNAmlN0DbIfv3CCdXsgX
 kxlmdbmaB6lJi9qO1XTGDejg8m0hf3ge02v9KymN1iJql6f8R06dITSLn/ltvCKajxvSgtlooCE
 pU20u0Fa/Ub3dxzWCqhTsEc0=
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

The data_size in eth_dev_mtu_set() is calculated as:
  tp_frame_size - TPACKET2_HDRLEN

Since TPACKET2_HDRLEN is defined as:
  TPACKET_ALIGN(sizeof(struct tpacket2_hdr)) + sizeof(struct sockaddr_ll)

it includes sizeof(struct sockaddr_ll), but the actual packet data
in the TPACKET ring starts at TPACKET_ALIGN(sizeof(struct tpacket2_hdr)).
The sockaddr_ll does not consume frame data space. This makes the
current formula 20 bytes too restrictive, matching neither the
RX queue setup nor the TX queue init path, which both correctly use:
  tp_frame_size - TPACKET2_HDRLEN + sizeof(struct sockaddr_ll)

Fix the calculation to be consistent and accept all valid MTU values.

Fixes: 8020573894a8 ("net/af_packet: fix setting MTU decrements sockaddr twice")
Cc: stable@dpdk.org

Signed-off-by: Xavier Guillaume <xavier.guillaume@ovhcloud.com>
---
 drivers/net/af_packet/rte_eth_af_packet.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/af_packet/rte_eth_af_packet.c b/drivers/net/af_packet/rte_eth_af_packet.c
index c0ba3381ea..bfa68297a6 100644
--- a/drivers/net/af_packet/rte_eth_af_packet.c
+++ b/drivers/net/af_packet/rte_eth_af_packet.c
@@ -612,7 +612,7 @@ eth_dev_mtu_set(struct rte_eth_dev *dev, uint16_t mtu)
 	int ret;
 	int s;
 	unsigned int data_size = internals->req.tp_frame_size -
-				 TPACKET2_HDRLEN;
+				 TPACKET2_HDRLEN + sizeof(struct sockaddr_ll);
 
 	if (mtu > data_size)
 		return -EINVAL;
-- 
2.34.1

