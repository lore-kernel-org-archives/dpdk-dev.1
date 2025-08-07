Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A7EDC87FCF
	for <dpdk-dev@archiver.kernel.org>; Thu,  7 Aug 2025 17:35:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 123B040676;
	Thu,  7 Aug 2025 19:35:01 +0200 (CEST)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42]) by mails.dpdk.org (Postfix) with ESMTP id 8D22840676
 for <dev@dpdk.org>; Thu,  7 Aug 2025 19:34:59 +0200 (CEST)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-451d3f72391so11003795e9.3
 for <dev@dpdk.org>; Thu, 07 Aug 2025 10:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1754588099;
 x=1755192899; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8JBnpPYalxjvG7xml7r8CXLliDz8gCzqjgPTUVLzfGo=;
 b=ltYUIZHxmZ+DJne0ralX9BJ8npsoBAbnA5XznzNky9xJ8+fYl4W9AyWJ4+FzjRMCQH
 FkFJM4Q9UseM/ntCINd+xoMjs8hXtxCSXpBdt5KYzvVVllrQzGAO9B0mOutooUQnEpio
 6RVhAlKaGh5ZLb66gl3Os0x2kKxUdVPNW/h0Gpp5JY37iF7xkfYzpxfZGH9FdE5Cs0qY
 8Si4AtUYH8hJ0+9/2XQAbG0uf+NvPvQtUv+J/tZVwnYLVUxtE0J4jve7r2qWhpegL1ZK
 XkhZcMEP0onktDzWXhT8wioADDyShHQki1BUUXalvhP+hm4BcZAfrZSpSwx9n/82kU8o
 0RtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754588099; x=1755192899;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8JBnpPYalxjvG7xml7r8CXLliDz8gCzqjgPTUVLzfGo=;
 b=TmW36V2viGOrl8+VabEVuWIfZPHBXW6k3vbroi26KVdsr2ncDFy5RXPF93r0u3r3xu
 w63SzxS92Q+V9MCsuHj7NatTgq0hJl+Ju71pdxuBfj3r4EHhhFZka58btyyNCZVo4Z1H
 /OijJ0ZGClMmQG1Eq5L2RzrOMea1ADUYb8NtULD0/gHzsOUEHqaFQXkWD0BonEAA6nve
 pN9wTNi+FyXiBEHxwHFDPJoLTlb5fBQ1/P9ujiKFTLSRaNdsXD3gyOqKMWFbG3NBnkK7
 Ahn21BLAHdIkxia1Rk7nGagABML9jehKbVXtIksS5V9Kx5oCkwTsoW8FooTO0gjwPN0o
 lqAg==
X-Gm-Message-State: AOJu0YzOfVWTsDCYr3TmExM0frKaLq9dR6sP7j/TOMCExSbWp8KH/bFo
 +yqVYvB1H7qwtVr8TrTahy5HhTTkoz4ssKF7z2Q+FxvPzM5slhnj+FTmDC9Q1t80ow8Q9VcKzvp
 NiZeM
X-Gm-Gg: ASbGnct6SCbx/73n7XyR9IHwnHAtrEX5503yriKGoQKU14sDzp9okvF2bdkp/fgtdBQ
 3Pd6wZUWuo1w7niIXnKepDfg5WavT9XAkinBYN6lnuI47nUXUUn1kARXj10hJ2YmnSmqcWZyL8X
 FA98+3DeF8w3MGyZojhPlFYQswy92M3ttS8gLpWjnLQ58f3rxydAaRadZ47gPI6shFxlZF3uB62
 PPqJXyowa+r/cwFaZCWR7XU7S5qN7OG8UYlGmqLhiopleqnrv9TSf2EHR4BQugXQx76x5NlyoOp
 iGmXAZImer2m1jzuEjyJYIGekryuGsRjTSnI0F293t7UpxVIk6+sheQlPZmET9gkrFzN63/dOWI
 Dj0tGOKwkDNbN5jgbmQP0/m3I4M85vu1BQg3U6SVpE7kTfCITfBfE9mW4wIvvlpvYc1vLKs5y
X-Google-Smtp-Source: AGHT+IHstH9AhFe7qfRWWgqFVlpktwfsJvPbJ7gA8YVp3j3irbUmEHqtnjeMN0SHUL7xJkMy6G0JBQ==
X-Received: by 2002:a05:600c:1c87:b0:456:18ca:68db with SMTP id
 5b1f17b1804b1-459e7087893mr62788705e9.8.1754588098996; 
 Thu, 07 Aug 2025 10:34:58 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b8e9464f46sm13242838f8f.19.2025.08.07.10.34.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Aug 2025 10:34:58 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v10 06/14] net/ring: allow lockfree transmit if ring supports
 it
Date: Thu,  7 Aug 2025 10:33:20 -0700
Message-ID: <20250807173437.11442-7-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250807173437.11442-1-stephen@networkplumber.org>
References: <20250411234927.114568-1-stephen@networkplumber.org>
 <20250807173437.11442-1-stephen@networkplumber.org>
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

