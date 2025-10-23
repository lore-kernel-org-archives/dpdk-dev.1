Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3FD7CCD193
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Oct 2025 07:22:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 01404402C3;
	Thu, 23 Oct 2025 09:22:49 +0200 (CEST)
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com
 [209.85.210.178])
 by mails.dpdk.org (Postfix) with ESMTP id BBA9840151
 for <dev@dpdk.org>; Thu, 23 Oct 2025 09:22:47 +0200 (CEST)
Received: by mail-pf1-f178.google.com with SMTP id
 d2e1a72fcca58-781997d195aso360616b3a.3
 for <dev@dpdk.org>; Thu, 23 Oct 2025 00:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761204166; x=1761808966; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YWAgHHFkB9lkXYB0f8T7WAtxnLiLBBOW8vUddgm7aUI=;
 b=EBBWs+J93dfL5csqR0hGLZC4fV7sYHkaQ9/8JZ57iJ4JDI8l1IyxNb3iZX8pkH1hVO
 HXg1He/Izhbh6Q40WXfcXQv847Jf0CFhtOhNu3o8hSk1bPqUZyW9t81ozS/jbdvE6ZUy
 0vuwPzOLI7MxobY80XjFsn+NgT984vJMgDuX6OAHiT00e3WVfjWjmSIEDDzRsJ1LYyMu
 RPob+d6IsK1A9iX/3FcV/I4AxN80JzCsSZMhrNQHjDf1VBihmKNkFxmSod5qe+7IIMuG
 RyaMZ2MqemFoU240ANMlW+hiVCXsNqcunuWEl4rWdi+77aI/z1FLv9SMAiSKATS/ZC3t
 3bQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761204166; x=1761808966;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YWAgHHFkB9lkXYB0f8T7WAtxnLiLBBOW8vUddgm7aUI=;
 b=C/K6zcnVj+WMjNEiqAhCX3ou/Po73sS8DWalElVKHxtotdU6SDR/Q8QmxB+r0bYmYn
 O4RaecC9+ajGonKRHJyvR4j8p5dReG550xG8SuXietOeNoJT9qL+mvu4cILTu1+52GN2
 xwEwBD8cZ3MQDHHfm2BC7LiFkpqeOHEXZjbWhNq2HcrLBnA2lMBwzc6nUQCQHd+nhUdI
 7QXXopjW+zn09dz0RP8DgnRVhVy0NyhTYFYedwn54s+PMldBpwL5jqkcSldAhqAq/mUg
 rcSdKwXKfW4Kg79EisjqlnTStDHom2EUdtjuUYDZ/8jMJ/zfz/xbzU3DqMECg/V5aXTL
 4CJg==
X-Gm-Message-State: AOJu0Yw5wxait/0LZ4Fzd0AsuIFoXnybRN9d054EWeiR9p33gOn165Xk
 Y0pB09lsj9/vL6l8PyrYnIZqFT+lVVTySzU3jRSVuUD/AREqM85D7pk9qV4nBQ==
X-Gm-Gg: ASbGncs5rwtJZ6ie2MwUYyF9646WNZ2omQtVeJOM6DJZlTtsA1kb6k3x+uPKhk/aQ3+
 iBeM+/1YGXenyqKZqMVV/en9pLV3BQvexgpvCKMyEQJkQ+W+QrsPyK9SW2ZAFWoJaNIeBcII5s6
 EWKl8uQKJl4guRd7bOMcN57zPKTPAOoY6sJopDQe49nU5V5yEwuhDEMDpmBKWKBjUPyiD9PaL+Z
 d8jNTUyuKFbA8XiAs/+jY3iXbsQScBJoqUwvbF/J76saUM3iNHN4cg+2aus+jBH/dPDE8bx3QU2
 S4e8wx2Ay/WXQou5Qzf5Tpqxsm7LMnwc1x6uk/UVFOluYkyPk6mbUS7fkEqko5DbbiseI0cJ8pR
 VUk+8uZrplk81APYqE9CDbNhUR3k7oYj4nthXZNOg/mlna0DW3aZITWn6VpTBU3us66fzK5VHTT
 Rwk7hCDtuW0yVulXwqts+FMG/hzQB7w6ql+9kcIvvTYZNd9wrcfWfibCQM6UdzQZTUrzSD
X-Google-Smtp-Source: AGHT+IFMzUZpmcBdZSAiO63SpNpChlIMyuVfDNo1y8GGR7S2dXbuP7tDgztsowFf34DyvqOGx7pK4Q==
X-Received: by 2002:a05:6a00:4fc9:b0:7a2:7458:7fc8 with SMTP id
 d2e1a72fcca58-7a2745880c9mr2244069b3a.13.1761204166418; 
 Thu, 23 Oct 2025 00:22:46 -0700 (PDT)
Received: from amiya73TMT9m.aristanetworks.com
 ([2402:e280:2162:53:690b:e114:2f06:4eff])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7a274a62216sm1554396b3a.5.2025.10.23.00.22.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 23 Oct 2025 00:22:45 -0700 (PDT)
From: Amiya Ranjan Mohakud <amiyaranjan.mohakud@gmail.com>
To: dev@dpdk.org
Cc: amiyaranjan.mohakud@gmail.com,
	stable@dpdk.org
Subject: [PATCH v3] net/vmxnet3: disable RSS for single queue configuration
 for ESX8.0+ versions
Date: Thu, 23 Oct 2025 12:52:38 +0530
Message-Id: <20251023072238.17584-1-amiyaranjan.mohakud@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20251022155651.9818-1-amiyaranjan.mohakud@gmail.com>
References: <20251022155651.9818-1-amiyaranjan.mohakud@gmail.com>
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

It fixes the issue of v4 RSS configuration failure in
vmxnet3_v4_rss_configure() while writing to BAR register. It's very
specific to single queue configuration.

https://mails.dpdk.org/archives/users/2025-April/008236.html

Bugzilla ID:1789
Cc: stable@dpdk.org

v2:
 - Fixed typo in commit message
v3:
 - Checking if RSS is already enabled

Signed-off-by: Amiya Ranjan Mohakud <amiyaranjan.mohakud@gmail.com>
---
 drivers/net/vmxnet3/vmxnet3_ethdev.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/vmxnet3/vmxnet3_ethdev.c b/drivers/net/vmxnet3/vmxnet3_ethdev.c
index f4cdb1bb31..a0306af86c 100644
--- a/drivers/net/vmxnet3/vmxnet3_ethdev.c
+++ b/drivers/net/vmxnet3/vmxnet3_ethdev.c
@@ -534,6 +534,13 @@ vmxnet3_dev_configure(struct rte_eth_dev *dev)

 	PMD_INIT_FUNC_TRACE();

+	/* Disabling RSS for single queue pair */
+	if (dev->data->nb_rx_queues == 1 &&
+	    dev->data->dev_conf.rxmode.mq_mode == RTE_ETH_MQ_RX_RSS) {
+		dev->data->dev_conf.rxmode.mq_mode = RTE_ETH_MQ_RX_NONE;
+		PMD_INIT_LOG(ERR, "WARN: Disabling RSS for single Rx queue");
+	}
+
 	if (dev->data->dev_conf.rxmode.mq_mode & RTE_ETH_MQ_RX_RSS_FLAG)
 		dev->data->dev_conf.rxmode.offloads |= RTE_ETH_RX_OFFLOAD_RSS_HASH;

--
2.39.5 (Apple Git-154)

