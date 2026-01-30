Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54981D73EAA
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 Jan 2026 01:16:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AB09040B9B;
	Fri, 30 Jan 2026 02:14:36 +0100 (CET)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43]) by mails.dpdk.org (Postfix) with ESMTP id F175340A6C
 for <dev@dpdk.org>; Fri, 30 Jan 2026 02:14:19 +0100 (CET)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4806e0f6b69so11452785e9.3
 for <dev@dpdk.org>; Thu, 29 Jan 2026 17:14:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769735659;
 x=1770340459; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WlcqFC8n6cBujT0d8pZWE5FvC+E9TuzvyW45n3haPSE=;
 b=KL+2nHYHyT4QHdfC4DC4sfbXUVPxBkbwobP8o0ttambkAB1zdttCSyoRcDiDGUnGn4
 yq/sDdarOY+8A3fy7Hf1SlpEcaeCAYaNrmVpQ58IfffzEIeNMrFYeedS5CVqev9XLNu/
 CAkQ3evMjZS6gdUFsyWH3TCXV0sZOeRbXRfQWo/jQiVwFAKLn/Vz85s49mOIsDwxBwBZ
 qtqXR0uxZTWK2USA34QdPtWn8u8fB4LNmePgDR1f7iXBkmTKSdoHRaFLXOxbTZlnIANG
 TqD1CJzK+OAmAZDwT8OsT3kK8GJK1iR0reEP3HatbUn3C8LkEDTF218DlBebk2IH6K46
 7OYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769735659; x=1770340459;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WlcqFC8n6cBujT0d8pZWE5FvC+E9TuzvyW45n3haPSE=;
 b=ITJC2C78tzThRi84hz/8xTdM2mGAhys/sLLB3TFlY3Q//AjWRjPGK8vicwxiDLmMqe
 EFOOH5cJ6cxxp5QBEm8WnzPvPerbb1GgG7U1vpekdSFr63LazEfW3IYYbWB2I7WuEs6s
 uo8G20HBDHTbs9/UAP7BgiY9jpeulhjgRNSOg/J8OUypO1iIh41JoWAXGIzoSdKSQ3xi
 3QrBVTwKuUnDBXWRwA7qOberVcNp8T22QAayJE93sX3i5LDFG+Cupdj12lZLdWk8jf6p
 robxHNhCIc8ezB93n3OUGNyJr0h1GXAlURfYaJhjm8ZmR3L9HZMAb45JAZmzaBVW6IV5
 ycbQ==
X-Gm-Message-State: AOJu0YxYcqK3OzxeL/PVll6dC77ZU9jpPouFEL3ypMViRqqsADTrclMx
 292fAQ8Av5vT4TJOyuOhK0z+ctyOG8WgsrFaMH8Xo88GLgUu/B8GY2luiGW9aO2v/0kXKEKq79V
 FaBfG
X-Gm-Gg: AZuq6aIV/nW1sXBM8JmB/oga098U9nWbeBtMZMPdZvoKDgQ9UidLeQMByS0egJ/ghgN
 f1vjXI/4svQ9lXgFmP5gugAkoXHpYOved8sMCB89380agq7+nJTUrqVoN5DeuibCVlGSHYFCbz3
 0qZB4MeN6hopperpzI1WhrYsshmf+eDI9fT1w1vBkLXQeuq8qN6RIqFKIN1phO3F4HyM8FMv2YF
 qvJHfQWAcHSvGIojwZSjxVTC630+ybnT0yq92zn3XqpEZEa9C2NHSZWDVexRuRLu+Xpkut0g1oq
 ocCnUQFPX1qQf3gRHDpFK6+XrYF+s52gSVwY900EkRadaZMGm17Pm2gHJHhjyfrF9CrNrk6jG8e
 UgNu0XtkA51BXG9j9/EDciRdS39ca5WRDbc9RqXvyOaCrZlXVA4q5xQI+1AVXU9uFQy4jDCY5y2
 8TptUJN26cE0gYbC3+WHEuJwER1s654RMn1VFbi4qMxXuNsgpe4sqgmMnJxRsE
X-Received: by 2002:a05:600c:4591:b0:477:9cdb:e337 with SMTP id
 5b1f17b1804b1-482db4477a4mr13454245e9.7.1769735659554; 
 Thu, 29 Jan 2026 17:14:19 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-481a5e1d0f9sm2934825e9.18.2026.01.29.17.14.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jan 2026 17:14:19 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v10 17/19] net/pcap: clarify maximum received packet
Date: Thu, 29 Jan 2026 17:12:33 -0800
Message-ID: <20260130011344.204233-18-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260130011344.204233-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260130011344.204233-1-stephen@networkplumber.org>
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
index 5e72a985e4..415de46e22 100644
--- a/drivers/net/pcap/pcap_ethdev.c
+++ b/drivers/net/pcap/pcap_ethdev.c
@@ -820,10 +820,11 @@ eth_dev_info(struct rte_eth_dev *dev,
 
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

