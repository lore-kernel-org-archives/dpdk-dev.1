Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA2AAE6529D
	for <dpdk-dev@archiver.kernel.org>; Sun,  1 Feb 2026 17:20:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 378CA40615;
	Sun,  1 Feb 2026 18:20:02 +0100 (CET)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53]) by mails.dpdk.org (Postfix) with ESMTP id 41311402F0
 for <dev@dpdk.org>; Sun,  1 Feb 2026 18:19:48 +0100 (CET)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-4807068eacbso30336925e9.2
 for <dev@dpdk.org>; Sun, 01 Feb 2026 09:19:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769966388;
 x=1770571188; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hlGzhNSoAzCHfVx1IyY26gUFL7pOwmsiB1weIHNj23s=;
 b=Xhm/Ndty+QlraHYIYGo6/jvw6NcxvS/lXytlljy3EszxCmvhWk/84cY2rjyME0cryf
 1xIgLQ+4VNgnXRdypO98CMOxot5sQhs/H0wVUIvfxwiPPtrqXfZH94AZwjVTDMm7E7/D
 jrwXcA8cbJOYpTv4wjhRNemT5sUAcJ7jO6Sl+au6+MuXaDygpqEiSVbp8TqSbAjwWafx
 otVNA8XiH3E0yijr5Dr5xUXx1p7+KpI8BtkMP67AuCjoaAcRN40U3bmp7PZuCaseVxVc
 TyKzows5b0I/cAehLyyXoKUPTXR/GVrTKGpyn8NgK8BOH4+tnEzsB1COp3xb8PPZY3gt
 bD0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769966388; x=1770571188;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hlGzhNSoAzCHfVx1IyY26gUFL7pOwmsiB1weIHNj23s=;
 b=NyKgNPCSK2P29sVb4JbuhNpxMtDv0MfzIhTPoJ3v/X1we4pZLIfxikW38g1Vp4tc9R
 hLq8QxepbGG5hqWGqRjdEelQWgkWE5oFq7zu89poMLKY4dI+4Pj78uxkLssbGcR+N8u5
 0R80dlJbef0jGvOgFVYb1zQwyGAzUkFLuFRIvbyJ6xrQCvRzug/QQnCW8mr6xOmJhNDB
 WOTexE2cYFF9m2cHzZo5KB+P/3mpe6TeGnqaSzeeDxlY6IvIsh3osWZkXDxJFaRVrCah
 gUmK0yN+oTrib7oeOlVRHdgodmNQGkOmL5wHzEq7S3RmHKtw50v6cju7P6HM9kv7W3/Q
 MqKQ==
X-Gm-Message-State: AOJu0Yw3cL2UdRSQJNTBsr6i0i0pmubMFM4D8F70QQPlJKjOYY0d44lV
 jedrC+JgPb+nbI3BT8QAC4PG7V2X/FwkdaEGVcZkXNUprZYrUFFiow4udbTLxsYnwjY8uBaNr8Y
 iv5ja
X-Gm-Gg: AZuq6aK4RBnNfF1P/la0iKwBxuqUXoZvv3bVegpM4gJ24EOFzm4mLnvnyTdNHH9ytVb
 QYbFGVdzhgwibxZ7+vgR4vBhdmT+YSYOufWz2iISf4LNKHlLMbK9aEwKmfak1J9799mySN65wMV
 RDgENRxwKLnEhyS59ihkjFot/eLXR7xwPxgTgJ+41tVgAjZb7UZeZIQa25YR68HSSKuAuLofHj2
 1jsOJS2r9M05HmlWS3WCVFyEur8olqM8PQWCDV1dOhB2x75qVjJb+lQLMAyYa96asPYUWym8CV8
 +Q2WMQzAywf9G76LZUTcM6DZ2gMdwNHlMi0ma+7kDDf3MexRkbXJJ1YHA5BgpPc20b1b/Mmwvbl
 3Fz+FQiWxoxMnwRZFchq2gBOLnFB/q2iHy760LcE56blNpvqW6bQNxjF4NUPVmQKda8ewpjzU79
 FeAl2q6q6Gh97say1aiEYaFFxhvbRWOLjvxrSpnULtgev1QBjO0A==
X-Received: by 2002:a05:600c:c0cd:b0:471:700:f281 with SMTP id
 5b1f17b1804b1-482db623765mr100112675e9.25.1769966387862; 
 Sun, 01 Feb 2026 09:19:47 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4806cdd79c7sm346810765e9.2.2026.02.01.09.19.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Feb 2026 09:19:47 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Tetsuya Mukawa <mtetsuyah@gmail.com>,
 Bernard Iremonger <bernard.iremonger@intel.com>
Subject: [PATCH v10 2/6] net/null: cleanup info response
Date: Sun,  1 Feb 2026 09:17:33 -0800
Message-ID: <20260201171938.89492-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260201171938.89492-1-stephen@networkplumber.org>
References: <20260104222523.329760-1-stephen@networkplumber.org>
 <20260201171938.89492-1-stephen@networkplumber.org>
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

