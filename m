Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3050BC83F17
	for <dpdk-dev@archiver.kernel.org>; Thu, 10 Jul 2025 16:43:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6886740A77;
	Thu, 10 Jul 2025 18:42:47 +0200 (CEST)
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com
 [209.85.222.175])
 by mails.dpdk.org (Postfix) with ESMTP id EBA2F40673
 for <dev@dpdk.org>; Thu, 10 Jul 2025 18:42:45 +0200 (CEST)
Received: by mail-qk1-f175.google.com with SMTP id
 af79cd13be357-7dd8773f9d9so48998485a.2
 for <dev@dpdk.org>; Thu, 10 Jul 2025 09:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1752165765;
 x=1752770565; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8JBnpPYalxjvG7xml7r8CXLliDz8gCzqjgPTUVLzfGo=;
 b=ZMBcVGLMAZUGVUI1+E2ZKvdoot7ECtkug0wlDKaN7k/cOS2kfEaBQfYH/jyKxxqImy
 Q/gjefCjcGa7YgVb0t1agip72hDOraO43nshY8M9drUKNbC/1N/mPJHEndcx7I2s5Z15
 ydBc0ZBTvkcXwRKqSrk9zL8cK+eiof4AOMxsfwJJ7rWyV1DwdC18QZaeCd2GLZjpjtFc
 1096PFZPkb8qJSqwik1sbYqDbHq55od2MPsA3nnvMeiJv85ErdpWi56QWaRUfoY/NqNl
 57aFfAf1Ay0+H6lrmPWGxgPpu2LDv3XzOfi/3UpqNz6HQuYEcIoU7to71AJTECs2L0wi
 gjvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752165765; x=1752770565;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8JBnpPYalxjvG7xml7r8CXLliDz8gCzqjgPTUVLzfGo=;
 b=uSSAu39N9NtRoHse2yNQYzyNZzNc7vQQNVUiZ49aF3mBbldfqbTsJEXSa2zHsGNF2j
 /L0bPsEQEYBNWkIp7LFmt0EDRq4uzNvjKX1GKM/MnB/I1qT6kGpJyyZMB/sD4BbPejtw
 5eiqFTpkCN8lNWx/lS/bt3xM1MJWJd0kFn0qTM9jvvGgIaQiHhbD4qmWQtg6yuX9IGxU
 yZvJezPharCZWOASrn8PuRY9PoRsw2j8Vievb/napRqFQ9pCGXaaxmLIPD/lnnuIXv+/
 R75rFrfew2QCre60XtYhYoaOjKUGUYE4JZMgBCaxpMivgmnJFbqNOpngwcvdvrICx2cX
 s1Tw==
X-Gm-Message-State: AOJu0YwNzxQOmYubr6d8VxJWTMFxthugFz3swaf2Iioytyqwwkd0FQbp
 ptJDB/3llkOiMmiGhKdJUw48IcmCO7kMfV4Nq685Lo3lmrfYHhE9+f5ZYgs32T/dpw2UJTtA6m1
 KqSQL
X-Gm-Gg: ASbGncvKiNvCVv+qkqbQCC7YjkVaH1SPXUaRYYU1jPtCCjrTWSygyVC0GJdVTYJZIfi
 EokgFkT9zEqgkouM3o0oZJGAImEZhFBec2Kvi6E/UV6TfbReostcxbdaF/jl1OwVOdhlV3z5kIP
 TV3JNMW9JjbAkyvoMnPlotd1Po/b3WCYe2IcM3fAW6M+pUStya+wgOaAt+p/vBJSdiGecJ9/2ay
 FanvUnZ6shOIYO8xmXAeUrSpFCayQ2pAWHADhD8iPPwsS3vcO2jogvnbW9tt5QVwsWTgJ8o1Dg8
 hnLA7otopjGg7VDMl7GEXMAwJQrMqREjEf/1WEJNU9AOlmln1RNdItrRokkdCFCyfPJ6aog/X13
 +wa7jMFDPVNRqKxoGBcXWl0azcKht1/ay0IfK
X-Google-Smtp-Source: AGHT+IHbZDIRaclIJ8dnXTKSeIBm7GIPJo4xi7aHibR3D7q7+8hL2jZtGBEY588sl8TFXHeaYL5Xpw==
X-Received: by 2002:a05:6214:1d28:b0:702:bf75:f0bc with SMTP id
 6a1803df08f44-704a39bd1a7mr187906d6.37.1752165765280; 
 Thu, 10 Jul 2025 09:42:45 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-704979b49b3sm10167966d6.30.2025.07.10.09.42.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Jul 2025 09:42:44 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v3 03/13] net/ring: allow lockfree transmit if ring supports it
Date: Thu, 10 Jul 2025 09:16:44 -0700
Message-ID: <20250710164237.8630-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250710164237.8630-1-stephen@networkplumber.org>
References: <0250411234927.114568-1-stephen@networkplumber.org>
 <20250710164237.8630-1-stephen@networkplumber.org>
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

Need to be able have multiple threads all using same
transmit queue when using SPAN.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/ring/rte_eth_ring.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/net/ring/rte_eth_ring.c b/drivers/net/ring/rte_eth_ring.c
index b1085bf390..966c64d9a5 100644
--- a/drivers/net/ring/rte_eth_ring.c
+++ b/drivers/net/ring/rte_eth_ring.c
@@ -177,6 +177,19 @@ eth_tx_queue_setup(struct rte_eth_dev *dev, uint16_t tx_queue_id,
 	return 0;
 }
 
+static bool
+eth_tx_queue_lockfree(const struct pmd_internals *internals)
+{
+	unsigned int i;
+
+	for (i = 0; i < internals->max_tx_queues; i++) {
+		const struct ring_queue *r = &internals->tx_ring_queues[i];
+
+		if (r->rng->flags & RING_F_SP_ENQ)
+			return false;
+	}
+	return true;
+}
 
 static int
 eth_dev_info(struct rte_eth_dev *dev,
@@ -189,6 +202,10 @@ eth_dev_info(struct rte_eth_dev *dev,
 	dev_info->max_rx_queues = (uint16_t)internals->max_rx_queues;
 	dev_info->rx_offload_capa = RTE_ETH_RX_OFFLOAD_SCATTER;
 	dev_info->tx_offload_capa = RTE_ETH_TX_OFFLOAD_MULTI_SEGS;
+
+	if (eth_tx_queue_lockfree(internals))
+		dev_info->tx_offload_capa |= RTE_ETH_TX_OFFLOAD_MT_LOCKFREE;
+
 	dev_info->max_tx_queues = (uint16_t)internals->max_tx_queues;
 	dev_info->min_rx_bufsize = 0;
 
-- 
2.47.2

