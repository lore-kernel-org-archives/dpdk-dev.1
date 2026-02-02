Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07296E7FDF2
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Feb 2026 22:18:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8FD61402F2;
	Mon,  2 Feb 2026 23:18:31 +0100 (CET)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52]) by mails.dpdk.org (Postfix) with ESMTP id D61E240655
 for <dev@dpdk.org>; Mon,  2 Feb 2026 23:18:29 +0100 (CET)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4806cc07ce7so49879675e9.1
 for <dev@dpdk.org>; Mon, 02 Feb 2026 14:18:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1770070709;
 x=1770675509; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hlGzhNSoAzCHfVx1IyY26gUFL7pOwmsiB1weIHNj23s=;
 b=PtohRTJUU+3n3ls3RBQWeHnPAuzCaawktkknxeWwe7RaK89iJnW9HUaToQzm1Rh1EE
 XHLpsky1Y7LJ30kOXRtf3WpaTSRe64ewKlTaDSh6wylTiJJP7GB2RI9Hjyhnyy5rEyWi
 J10gFGD/quhRGmtHiX3r+Yjh8ImGjMy++YvWNcHHnzQoetQRi6ey1kUuJ25mV6XIvN0q
 dSatFqeClwWuNKCtKccjvYftjMHaeA4AhYEiP/bFPAvjsoEsc7axvI5TRY9LbCqhfSaR
 ZqnfEAMQERP849qvHwwb1kgEIla4l6D896aR0cWkGeiEE4v/OH/e/ffZkc8LcreXktRh
 2N+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770070709; x=1770675509;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hlGzhNSoAzCHfVx1IyY26gUFL7pOwmsiB1weIHNj23s=;
 b=jVrxsK51vcTYWnDOqSkmmPQSm7etHR3SnFIbyTFjbWYanYd9KRyHszRRfYBz35lzVF
 PeN3hnXWBNGK2G34aMaJdxZ+7MgvQPt9rp4nufMTwCe9pNmA+e9CYQHdebpAl+5dpArl
 N3RxkLvdKd8ZYcsnW1JpeZrayzovjQndvOk7bkd/ounrX+yZhs8+X16fzNQWboOnj2+b
 3GxCj2RUteVYctbdZ+7DQbTUhL1MlIrT6xTxJ5erhJlAhVcjx1fQzp74ld6KcAXkNylt
 U/mUKmEckshH2ldetE1bw7Ye5tNBOLH3Q1T+7eQ3EqEIXXNpIQ4ogmonkSLGq+hfC4MH
 DOAA==
X-Gm-Message-State: AOJu0Yx79fdSH22Yb9l+zck54x6owbB1FmdLonladuG9KsPEb8hnQbtV
 mfGOI7coQ2l9elfNqPduhtZFTX/VdGQSIkOw4FHOCZN/ABK+shD8cQUWNW1cnNRWjCHNQmM264Z
 G7MiG
X-Gm-Gg: AZuq6aIAkf1Voc0KHQWJ/NnYGCD6DKjlJNRfoO44UYHmYwPaOwOrQEa/vLgoZw+7vMB
 5jyuRz61UHADVNDsxq4DfifWRZlGzO+/S95BaY6i+elFbFLBP6NKH4JvgrCU1verhOdDr5vTaLa
 I+JEbgnKCSB8kzBKHMV9i/p1oaTbxZdvhQWosILkmjKYCOEBsVBaer6yssEs2+LQolhW8qHfA1j
 6EiZqRhGMiGsUSdBMUUu0R6uELNT08AN9G7eZvd1qAwtrMSQL5vNSZlIHJYo9TY623x6d2fYWZd
 wlltiOLRS9+8EuyhhUzutLzcBPNPHjvheRVvzEAnkLhJhtYVgj4sgL8C/jJaj+0If0FHI5lr4Mv
 8PZMup21Trh3fv0R4MrZuckyc2XCiNoVJI+Uce+6YoOdvsMu6zBMskMm8kW0bm+sTE6ahoIeAS1
 fgph3FPeFIu8NarFNT0Vvy6Pye5CDH2i77krF7u18Rs4Fbw7cSZQ==
X-Received: by 2002:a05:600c:474f:b0:477:98f7:2aec with SMTP id
 5b1f17b1804b1-482db4592e4mr197684625e9.3.1770070709089; 
 Mon, 02 Feb 2026 14:18:29 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10ee04csm47109336f8f.12.2026.02.02.14.18.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Feb 2026 14:18:28 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Tetsuya Mukawa <mtetsuyah@gmail.com>,
 Bernard Iremonger <bernard.iremonger@intel.com>
Subject: [PATCH v11 2/7] net/null: cleanup info response
Date: Mon,  2 Feb 2026 14:16:47 -0800
Message-ID: <20260202221820.204680-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260202221820.204680-1-stephen@networkplumber.org>
References: <20260104222523.329760-1-stephen@networkplumber.org>
 <20260202221820.204680-1-stephen@networkplumber.org>
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

The info_get callback doesn't need to check its args
since already done by ethdev.

The null driver generates fake packets of configured packet_size.
The mbuf pool passed when setting up Rx queue must have space
to hold the requested packet size; otherwise eth_null_copy_rx()
would generate invalid mbufs.

Setting min_rx_bufsize to packet_size enables the existing
validation in rte_eth_rx_queue_setup() to reject undersized pools.

Fixes: c743e50c475f ("null: new poll mode driver")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/null/rte_eth_null.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/net/null/rte_eth_null.c b/drivers/net/null/rte_eth_null.c
index 0931dac12e..f2ffdc2b2b 100644
--- a/drivers/net/null/rte_eth_null.c
+++ b/drivers/net/null/rte_eth_null.c
@@ -299,17 +299,13 @@ static int
 eth_dev_info(struct rte_eth_dev *dev,
 		struct rte_eth_dev_info *dev_info)
 {
-	struct pmd_internals *internals;
-
-	if ((dev == NULL) || (dev_info == NULL))
-		return -EINVAL;
+	struct pmd_internals *internals = dev->data->dev_private;
 
-	internals = dev->data->dev_private;
 	dev_info->max_mac_addrs = 1;
-	dev_info->max_rx_pktlen = (uint32_t)-1;
+	dev_info->max_rx_pktlen = UINT32_MAX;
 	dev_info->max_rx_queues = RTE_DIM(internals->rx_null_queues);
 	dev_info->max_tx_queues = RTE_DIM(internals->tx_null_queues);
-	dev_info->min_rx_bufsize = 0;
+	dev_info->min_rx_bufsize = internals->packet_size;
 	dev_info->tx_offload_capa = RTE_ETH_TX_OFFLOAD_MULTI_SEGS | RTE_ETH_TX_OFFLOAD_MT_LOCKFREE;
 
 	dev_info->reta_size = internals->reta_size;
-- 
2.51.0

