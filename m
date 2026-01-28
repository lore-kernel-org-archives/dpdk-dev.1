Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F28CD46BEF
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 Jan 2026 19:01:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 69B8740652;
	Wed, 28 Jan 2026 20:01:40 +0100 (CET)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com
 [209.85.221.41]) by mails.dpdk.org (Postfix) with ESMTP id 9085E402E7
 for <dev@dpdk.org>; Wed, 28 Jan 2026 20:01:35 +0100 (CET)
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-42fb6ce71c7so200763f8f.1
 for <dev@dpdk.org>; Wed, 28 Jan 2026 11:01:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769626895;
 x=1770231695; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m2OvcbiAcedIofAvdorrc2sAIASIWRfcBxG3i0qW1is=;
 b=dcwMoEcuv7L2hBdyp2miESmHcGqrXDZa2YpqPia0XsRmqBqoMa7RnrGDdPn9WHEJiv
 NkX97Qw0QvPkZakB/HMjgJe986lbLkxjZlDBy3OENdAlGCYCaL1kesPgtcHWGQmklMQs
 nYCHTzDmvDP5fcf4x5OHvc6Ir4O6rG1tLW6zvdEQTtoAJblhMXs7o3Hj3sR1BxhYDsab
 QDY+kkgcUBc4cUwELgvjjGFTaF6c/lgtPUEs0Bs5UPIabL/bgxt6ipgGoedX7LXZj8J2
 UgzaanxpLWQJMMtWF984oH7fLsI7plGmTqvt1J8ynb/xa/noCPmnVuEwM5yiouPSDLAt
 ZARQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769626895; x=1770231695;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=m2OvcbiAcedIofAvdorrc2sAIASIWRfcBxG3i0qW1is=;
 b=QJ9k5EX5hp5CwOZNz8npeR/NgeYsey8gawDb4z/wGrcOsAC6cMMIGfW/coxGKGobQA
 HrvT7tUfkrAXLdYvWpJtnJlX+45oxxrWb6cfbc7kWHGB30KEIipHzrednQen6qebyEvk
 LO8LUV7MT6a17+NU+jm2ADO4KBHuYg+uLHzV/MsPCCQcxKNpNY8zUU8GD8tDQMfwXS9n
 aZl4qKJmV/4CHI/UlxTlM2oI0OnhTIcGTlqu5E46mFYqP9bgKNHcUkRMJ221HgohLmSn
 64zUwiNiqeUCtlgJ8uiRixAEzCiUMJ2vQM7TsOe0qluUIlrc32r6DRyXVPf+CmTB2eR8
 dY5A==
X-Gm-Message-State: AOJu0Yxk8AxHVK4/EaP3cbLCL8T5LK1n/trXU7jUiprS/8zrz2ZipREY
 KJIZEyL6YIuvCyKaPjKXBzxWcKmoWJt47kkj4Km2Bk5L+JW1hXhEggh800k1B1scumghT+zGbv6
 x0iHf
X-Gm-Gg: AZuq6aLybtzis9/m6mFtbQbuVjIz4bf90L65LZiKGVEifnut2WDkyUYyDgZdcPb7NVp
 CCzEwJup9WhCzwpa3cX2/qdW4FYFppc+0Gnf7QSEDseVwv3Ekd/AQetyKNTyHJx5itfIg4asfFE
 FnwQsu67tvBsm+f0BGvDUJeo00F3mVa5iAkHcHoXAsB0ohzZTiaTweCVvkHkIhjhdklmUIPFicl
 oB+WsTfOUdCLuo7YXzC+P1C5DBA8RMpNRhd/gI/q6vdrTHCGeVNjWgQDf4JP+PeMsMto6o4/evL
 FqHJomkPqtJ6QZkfx8mR8MvhqwcNLedJZmh+wg+Ywh6j9yS3MoRASpnS2s8J+1dy2IzO2hrmuje
 tpYKaUWpTofIKbvnl20ZVp3n9JK3W8qSMzS/me+HZ63UPuHvlEdQnrq6BDnxoVnuX5mAytPm3QV
 NiBeaLAU5pLo6Rtxu5XpmrDKLC5wSbvPYEm7KupxR+RxzsmDmiew==
X-Received: by 2002:a05:6000:2408:b0:432:c092:ee3b with SMTP id
 ffacd0b85a97d-435dd1d325dmr10416277f8f.62.1769626895149; 
 Wed, 28 Jan 2026 11:01:35 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10e483asm8673333f8f.3.2026.01.28.11.01.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jan 2026 11:01:34 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Tetsuya Mukawa <mtetsuyah@gmail.com>
Subject: [PATCH v8 1/5] net/null: cleanup info response
Date: Wed, 28 Jan 2026 11:00:09 -0800
Message-ID: <20260128190127.465743-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260128190127.465743-1-stephen@networkplumber.org>
References: <20260104222523.329760-1-stephen@networkplumber.org>
 <20260128190127.465743-1-stephen@networkplumber.org>
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

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/null/rte_eth_null.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/net/null/rte_eth_null.c b/drivers/net/null/rte_eth_null.c
index 46e7e7bd8c..4496c093a7 100644
--- a/drivers/net/null/rte_eth_null.c
+++ b/drivers/net/null/rte_eth_null.c
@@ -298,14 +298,10 @@ static int
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
 	dev_info->min_rx_bufsize = 0;
-- 
2.51.0

