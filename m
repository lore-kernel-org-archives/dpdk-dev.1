Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9381BC87FDA
	for <dpdk-dev@archiver.kernel.org>; Fri,  8 Aug 2025 16:59:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0897340A6F;
	Fri,  8 Aug 2025 18:59:03 +0200 (CEST)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
 [209.85.221.48]) by mails.dpdk.org (Postfix) with ESMTP id 4B5CC406B7
 for <dev@dpdk.org>; Fri,  8 Aug 2025 18:59:01 +0200 (CEST)
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-3b78d337dd9so1457601f8f.3
 for <dev@dpdk.org>; Fri, 08 Aug 2025 09:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1754672341;
 x=1755277141; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8JBnpPYalxjvG7xml7r8CXLliDz8gCzqjgPTUVLzfGo=;
 b=sKuQX/xU01uVt4fUPI1FIZxhjX0WsGj9Mh+fGUq5rI4bC03bCT+1MQiActBa/ypbgF
 1dpmfZjpdLcyauonMXlo+slcxfhA87QFO3hN3vIZ+SavVzdSUN3Ns2uauls1ovdv1/0R
 Grt8RAUBEOvM8TdJMI5/LUHltNW8UfuG3t7EC5e2NUOJYjSt6ollBvzdOg68+Y1zbTK+
 R8PZP/iSAYGKYUED4YL8z8RZ2hmQhF+ouVfBfHpW/dXaCrkEHAEoC56as+yxILiAlY5v
 HSxFIFgqjPEFCo+CJ2n8BaoVrx3dDsWgLr8+X78KCcHGGpcheP19Ebiji92WKTucMg2v
 8qwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754672341; x=1755277141;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8JBnpPYalxjvG7xml7r8CXLliDz8gCzqjgPTUVLzfGo=;
 b=QBLUa9keZjGSKFm8397k6z5i2WHbewgtDXoMdd+Cz7YU0iz7/iakzez2Zvqt8ICQIT
 k+PDyJQUrINKg/B9W1bHhkLArZHanq+TLepZlVdIeu6xANVTmiWj3YGH9i4W7VwU3lXq
 AqjjmjVnSQh4WKrcqFE4lSiavdI5zfzn08/B7JyHNBfZJGxrbH93F8GRrkGhyhYxt/uG
 78/SBqXYGvbRqek3Xal9DeQXRK4Ey5Dq8VDVi0USyJiwJ06PK8diKrOzsO0Xmd49s0fz
 4K2oDxdJEFMSPQgQN5L67RjspqJ+s12fqGFYTRK9vcDzb2ZzUFmiv2nzCm0FwtVyuNx8
 9AFw==
X-Gm-Message-State: AOJu0YzSHdy/hFE03Fuc8bnYb0I4ac4TqPVjZCDJHzxvo8stI5AzerSD
 SEPec8V1/g4hMD41ezxjwAUAdn7J0wkhUExc8aQVdEG5FOzNb41Ydef+6Q2WUe+3egH/FUpAX2x
 VcIjF
X-Gm-Gg: ASbGncusHBp6U2jou5VDJUomzQ+fCp/ibw6MPeRVCgSLHC8vuIaOZINoHQNtZQpZTtG
 rkKNDt8YOgz4y+JbZ4XStjEPLKaF64wc0RrSSajL1LpEJ2rE4cWSx2sX55LJY4w+yKUZUogb4/e
 V7gi8P6h88f+P/FuCv6l9cZ16wObiJqzT0MnywcFLKt69+l6DtSMvYc88+1M1eSOsW7LwZEPkum
 3w9SGPGa9mCcFgvKP6sbv5WRKUOkoFn7Gh5qDmnRQ6YCvczrDAm/o2OEe/TwlI1Ca8cx9okC43R
 T9jQ19Cah0OTIBJFFGKDYcc7HmL7+sVnHCJa5KYAje+hJypk539Az/s3i7eo7Tki7wWMjAL3mmE
 Q0NJ4EC/5ugzmvU5WuUzGqdJ87Vc+Dg7gwVHNJm3Ll/uG2MDQR28pBaX3tu673B8vEYeq0Toj
X-Google-Smtp-Source: AGHT+IFzWuBQXcJfLxISVS9J5cd/G6qB2kTE+ku8GOEQRpVJ5iEsLEcw9UJ/PRGZpghNScHHdERmZw==
X-Received: by 2002:a5d:5d0c:0:b0:3b4:9721:2b32 with SMTP id
 ffacd0b85a97d-3b90092c994mr3173965f8f.10.1754672340877; 
 Fri, 08 Aug 2025 09:59:00 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c3ac115sm30997531f8f.12.2025.08.08.09.58.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Aug 2025 09:59:00 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v11 06/14] net/ring: allow lockfree transmit if ring supports
 it
Date: Fri,  8 Aug 2025 09:55:44 -0700
Message-ID: <20250808165843.39075-7-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250808165843.39075-1-stephen@networkplumber.org>
References: <20250411234927.114568-1-stephen@networkplumber.org>
 <20250808165843.39075-1-stephen@networkplumber.org>
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

