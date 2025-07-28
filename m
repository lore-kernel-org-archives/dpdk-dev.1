Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E47C4C83F17
	for <dpdk-dev@archiver.kernel.org>; Mon, 28 Jul 2025 22:10:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E6F7340A82;
	Tue, 29 Jul 2025 00:10:07 +0200 (CEST)
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com
 [209.85.222.176])
 by mails.dpdk.org (Postfix) with ESMTP id 3BBC340A77
 for <dev@dpdk.org>; Tue, 29 Jul 2025 00:10:05 +0200 (CEST)
Received: by mail-qk1-f176.google.com with SMTP id
 af79cd13be357-7e344e0212eso39123385a.0
 for <dev@dpdk.org>; Mon, 28 Jul 2025 15:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1753740604;
 x=1754345404; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8JBnpPYalxjvG7xml7r8CXLliDz8gCzqjgPTUVLzfGo=;
 b=O9APTsUP9yzTG6mOOZODJfkax6c4rU0PzIdjzecmb5ojEzVkSMEk6Tw4ayzpw8SVvr
 izmDvAEqIqwQgTEccMFKvLotGxTvGOuHgCqs6w/0wc9eb4TuzjV+F+urwb3/WoKDWoXP
 gL5mb9TdYkTVWoZ4N81LnUwCPzPw/8BR173EZWSmGuCuIX18FJASQLbFqh54l0/0OXgX
 EJe8MHIhdJp+Okm1kldECmqrpxOdXB85ra2yQLqt/5f4t05sY+TiYC5s7xEFZdkYsjFN
 Smd9eouJACxR4z6SU7LI6xO36u2pPyMkp/Y2MbxctpIVBxbx2FkVJ0c3SWVURaTSqoYJ
 PTsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753740604; x=1754345404;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8JBnpPYalxjvG7xml7r8CXLliDz8gCzqjgPTUVLzfGo=;
 b=VvNogj+yRnCgEzuWiSPXVWIlbdAVwGQKZeGvRocqMmwaOCU6ZTLq7PLi1ILkIkAaaO
 tJrA5HPY39mHMS2OpxTwVPQ0eGuQS2VtSNbU1cCZWTzRmEV7AS65EC57+eHpLlVtb4vk
 9BBUjO5sWYo6J8HbuXQYac6PlS2JmIQQAmFJ6GrBMOUOXaSkLYcaKx8CDu4pBP7d/s3B
 t6isW6K/GteE/BJzCtyRNDPuKk8PgUuGzya+OiWAfbMNXc1jWIGBNQc0q0P8H61r+fH4
 xqgY4q/gSbW2trOK81HcE3w3gMKAyP2VB/SZrKR1uATr0B1hfjFCCfVq+1eSnbNP3Jrj
 X/dw==
X-Gm-Message-State: AOJu0YxODjdG9/VJtwHVL9KDnx8oHnoj92fz7rUdcZXnQcAMaX695I9a
 Z2TAgDRHFGB/1VdeXy9XJB7uFip2pBCUt4Oh0NaiaAlpOe2TfQe8HpQA43fNXeHqADiUF4UvG96
 i62NY
X-Gm-Gg: ASbGnctrf1W++y0+EKDC13HqbyQl36rom0hU9dXLSrqgk7sCEB/jArjaHYoMiJPrFia
 8SU27JSR0bIb4lz999M60m6K1zezZOpT9Yax/piVdtQcICQ5EinvypyXZWv81nVQEUfzph5kjpD
 Q1RdSNvbTwKL4Si5OWtj4eZUxTXR2m2tRbth63bGfoP0PboFrr991Okh/i+zp8jn68/oi1cucjA
 pINWAMBW6ePWu3EFJ+hJKFsiYRAuWLOxcpCUwis33PPwcfi4bDf0wvj1SQPcwgBTA+FaH//LoTt
 8Kbl9eJGpVof3TbGUOkBKGk4epIw2A6p8Ar6S8/5lqy7ugUsF6FRBPYcbET60+R1OZYdSXVWZCI
 MzeGdortUxYqbhyb4TpmzFTpSHotOov+Mm7SBSytIm4UI8a87skQt7Prndnc9FA0bqqZff3w8
X-Google-Smtp-Source: AGHT+IGyeO7VA/Fofnx3rRYj0n+DuXsvCrJoKEa2SFwTuXqcTzRv0Mux5I7i6yYPVuMjrE15radO/w==
X-Received: by 2002:a05:620a:268f:b0:7e6:3028:197a with SMTP id
 af79cd13be357-7e65f281b15mr197561285a.10.1753740604548; 
 Mon, 28 Jul 2025 15:10:04 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7e64327d41esm344024785a.15.2025.07.28.15.10.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Jul 2025 15:10:04 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v7 04/12] net/ring: allow lockfree transmit if ring supports it
Date: Mon, 28 Jul 2025 15:08:12 -0700
Message-ID: <20250728220955.332924-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250728220955.332924-1-stephen@networkplumber.org>
References: <20250411234927.114568-1-stephen@networkplumber.org>
 <20250728220955.332924-1-stephen@networkplumber.org>
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

