Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0396E83821
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Feb 2026 18:16:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5DA9840B9D;
	Mon, 16 Feb 2026 19:14:41 +0100 (CET)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com
 [209.85.221.42]) by mails.dpdk.org (Postfix) with ESMTP id B1BDB4065B
 for <dev@dpdk.org>; Mon, 16 Feb 2026 19:14:37 +0100 (CET)
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-435a11957f6so2948735f8f.0
 for <dev@dpdk.org>; Mon, 16 Feb 2026 10:14:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771265677;
 x=1771870477; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2lJG/yEZseHIEHL5ISZIRni8hWk96t00gREDMlLbSLk=;
 b=G25Ejtnsot/w0emUY+V2UnSBCgUXbVbhNLEG7xVnc2an5+hU3jJLLXZdqcs1TcTZGJ
 CIqeAVSGVTYXPivVm4Md+qgm02dj6+QGkj91QQTl/oZ9WFug/3h4no1bWWh1V4nMJ5gT
 +S4cXfLf3/eiGTSESGCTiXcbLzkr565QkJFQIoagCVl60XpC7Qx3xH4dllCTFfM5JPk4
 ReSF/tjTV3bupSUhTM9fTJ/Y7D5MoXECCsGhXCj0+dIGqqv6AlVoO2dAvXxTtWj+iOuy
 1WycMTXuSQpVZ8usKHN8VfPg6nsTa2M2fdzdgDjOOqTZTQh80PFXlSxPcN3yqmAhPI2N
 cAng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771265677; x=1771870477;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2lJG/yEZseHIEHL5ISZIRni8hWk96t00gREDMlLbSLk=;
 b=u8RaxqEmUmSG9sLXfzFjrzifWcucOJNbNeU2zp9wJwWtnzGTpfn7Qd1zjQDcpFNUdU
 MacSKok1SPmYv+w+hPkGet9gctPMhhivxLXQGP+XeaV5OCrzHj/if+Bh3ifyB4QMnVMK
 xa5hi4rQch+jM9a31S4PaVH0uOCy7P46kkxvqtd1l2er5xOcb2HBJSEJTSqt0e6PaI42
 SiUWLEBQ0tPkoSdggYq+mOxpX2xFQih4X5XPvXDB0lM44HgV1SdjXgJ3iTebcHzGsIJM
 wDua//He794Sa/OLknk/0kmiTKRCsmEuBzu8HNmhqk75rgEeEtqXPqY2rKAR+QZBJiHy
 6JGw==
X-Gm-Message-State: AOJu0YwWrUqptU9LUOtMy/CsnAoEnIIPMLVOa98pp9ce7Mggd8xwuUsJ
 2AAojIILPMRDR1DXSw9C07F9ICILmPjWV+96bqjguQyOjdMA+in9au9hxgCbO74RDGWKh/9stjM
 beDn88a8=
X-Gm-Gg: AZuq6aLyiqTOlSrwfNXf/RsdeYwHfHtLhP1EpC2FGE5SBhS1c1+9mPpFOZXYrNmlBKj
 lPfYFoWGngGpK1m559UHOBFwQXnGAHxvlPr/W9GiknPSWSs71ObzWyauO6lJ8Daas9ys7duAFYM
 BB9Yd9IiqpodYyvq+LutX8ZTK4u600YI/R0SyO7+2QmQRA/Ilr1YRrKTw7JRQGpqleo8rrONvxN
 G/ixb+A+r3mVtLVzd7mj3CpQydJgXICY7dCHdz9NAjuZHS5H56P+9PJO2cpjdfZ0Vo+zfdKG7j6
 nHWasA9/OEKC0eeX/kgWfNu01aFN42Y9UXG5Q173Px6GnRQ91twiqbQe0cpdxrw9p5NdbZ8uMW5
 jqtxV9oID/8yXlHgEKAiHaZfqu8Z4GojD9+XQszIsoe9o+ZU0oBcAgAlQTjpVOBGwhyuKPu8Q9E
 HwCZjHzCn454dI9MO1/zgpHQqbDBZVPALMfnBYuJhrwnrxLRo/eX7Dfy9Eu+R/Rw==
X-Received: by 2002:a05:6000:22ca:b0:436:68e:3302 with SMTP id
 ffacd0b85a97d-437978c99cdmr19824489f8f.13.1771265677238; 
 Mon, 16 Feb 2026 10:14:37 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796acffcesm26064725f8f.37.2026.02.16.10.14.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Feb 2026 10:14:36 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v16 17/21] net/pcap: clarify maximum received packet
Date: Mon, 16 Feb 2026 10:12:12 -0800
Message-ID: <20260216181407.428877-18-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260216181407.428877-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260216181407.428877-1-stephen@networkplumber.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The driver has constant RTE_ETH_PCAP_SNAPSHOT_LEN with is set
to the largest value the pcap library will return, so that should
also be the largest receive buffer.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/pcap/pcap_ethdev.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/pcap/pcap_ethdev.c b/drivers/net/pcap/pcap_ethdev.c
index fc425109d5..9a5bab9932 100644
--- a/drivers/net/pcap/pcap_ethdev.c
+++ b/drivers/net/pcap/pcap_ethdev.c
@@ -910,10 +910,11 @@ eth_dev_info(struct rte_eth_dev *dev,
 
 	dev_info->if_index = internals->if_index;
 	dev_info->max_mac_addrs = 1;
-	dev_info->max_rx_pktlen = (uint32_t) -1;
+	dev_info->max_rx_pktlen = RTE_ETH_PCAP_SNAPSHOT_LEN;
 	dev_info->max_rx_queues = dev->data->nb_rx_queues;
 	dev_info->max_tx_queues = dev->data->nb_tx_queues;
 	dev_info->min_rx_bufsize = 0;
+	dev_info->max_mtu = RTE_ETH_PCAP_SNAPSHOT_LEN - RTE_ETHER_HDR_LEN;
 	dev_info->tx_offload_capa = RTE_ETH_TX_OFFLOAD_MULTI_SEGS |
 		RTE_ETH_TX_OFFLOAD_VLAN_INSERT;
 	dev_info->rx_offload_capa = RTE_ETH_RX_OFFLOAD_VLAN_STRIP |
-- 
2.51.0

