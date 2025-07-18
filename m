Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10A1EC83F1A
	for <dpdk-dev@archiver.kernel.org>; Fri, 18 Jul 2025 16:33:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5973B40E13;
	Fri, 18 Jul 2025 18:32:52 +0200 (CEST)
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com
 [209.85.222.176])
 by mails.dpdk.org (Postfix) with ESMTP id 1E0F240E03
 for <dev@dpdk.org>; Fri, 18 Jul 2025 18:32:51 +0200 (CEST)
Received: by mail-qk1-f176.google.com with SMTP id
 af79cd13be357-7e34493ecb4so228378385a.1
 for <dev@dpdk.org>; Fri, 18 Jul 2025 09:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1752856370;
 x=1753461170; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8JBnpPYalxjvG7xml7r8CXLliDz8gCzqjgPTUVLzfGo=;
 b=wKlLQPrLz8xGUh4cN6OUsoIBgoIgJwIsBnM0jbR1LGf1nRtdEcCN8hDawtiddYB+aE
 j4jkCwL6Uo+3UkakcDZb+7qbDy5sZa7Qe+un+GyfWffcnjQPlpNIYl74VlyjyQuhYRCX
 Rh9MxiyMiqTVLCdse7IZwKwGMTusS+HQLkgQXkl7Z8AGkOSXDZE3T12G+p/JA33FMrgj
 a6NF4bzEbTcRwLchef8rMZRfwdjDiMKJYQjU7tcV/WiM01LchFxVN19ZAvymUZptC7Tk
 ngWOQfnGBAsUoJ0rJfIV3T7As5Y2A+ZP9Tah9pwG7Kl14mmM8CXEToG+YsizpQ9hFzS/
 8BPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752856370; x=1753461170;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8JBnpPYalxjvG7xml7r8CXLliDz8gCzqjgPTUVLzfGo=;
 b=nPuqePqF/sNRhX5okNEB4au0tP0LXABRC0egvAQhIMvdIFJMIn/tVSNaAoqnd/TiZa
 DFqwj8NgTJ/b2TdM929s0VpqR4XzobHuxNl1C0ODqEstbmXUi1pGcCo+JE0iYzcweNQn
 Erap5W2toIJfvfSLrK2mI/kdkzzxTRkqhOpPqtLVv/a+ii2Wqcq4aAYgAl0Y1YTbNcJJ
 3FucwJgf0HYjeMJLpLhwPWBSjAR5pE5aZLZqdk96RUybqMxUFz//j8cPHn1194bTqUPr
 mYAJOA+prbrPfq54DvBPm9DSNwUTmIIpD9QSRA+JQ6B+lrP6mXLL7jt3UHfdZ9h06Hgy
 qWoA==
X-Gm-Message-State: AOJu0Yyyyppk2nh4BqwZMRGHZUBa7FYvxbSNrtOCLfbxzAPz5cuxdu2z
 SNRcAwbXcph02cqtcHYv+v2OBLs3AkPnbMrtczq+cZpjhWo4SWuM7MQVtJA9C3u3mmDbKG+sG8z
 iWRO5
X-Gm-Gg: ASbGnctWHweLf1eJ2wUENqYkVkmeqx1RO4fk9K66o2IztIjKbS0wuFKqpeNhIHr+u5r
 iyr5BWuNhaOh9KswLZ5o/wfyaqTDQpHAXM5AoFbjnIX7mHEN0pN5k9l6ZqUNzhjq2wp71sh6Sfx
 4ytLCMp6/hUZ2He15QibUSlGyJ2HMFxJm340gmNRvLf6NlIFP2nTG0ejPLf0FM9TiIEEk2/L4Ru
 YRYDZzZC4dUZP+Y2QS5GrVrr3p4hmtWIiz2XxXOGNrK7lVfgSzAq4+zb2DffvQa7+4DipsHEdNm
 Ne/Tq8BgqdOwvi7Jqy/r0UDmxqVDn6vCoVgFHR1FXaf6brkoqWvtF7EUPB1V1t3aPIqjEKwtILY
 WroA1hM4fY2xaFLeUB6eeVUXXWpimEE/BZwsdbq0zr/H0UP/p1Etrxu9PJXAb69sVOiiJVRoysw
 T/z1FUJQQ=
X-Google-Smtp-Source: AGHT+IE/ersjJ5Y41s72rbK1qt66A3N+IVEK4ymOCQK53qTnLtTbYKIDS9SJY5OXsqhxlvK3e3qrSg==
X-Received: by 2002:a05:620a:1927:b0:7e3:3e1c:ef0a with SMTP id
 af79cd13be357-7e343350d91mr1330124285a.11.1752856370195; 
 Fri, 18 Jul 2025 09:32:50 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7e356cc1aa8sm103392685a.111.2025.07.18.09.32.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Jul 2025 09:32:48 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v5 04/13] net/ring: allow lockfree transmit if ring supports it
Date: Fri, 18 Jul 2025 09:28:21 -0700
Message-ID: <20250718163236.9870-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250718163236.9870-1-stephen@networkplumber.org>
References: <20250411234927.114568-1-stephen@networkplumber.org>
 <20250718163236.9870-1-stephen@networkplumber.org>
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

