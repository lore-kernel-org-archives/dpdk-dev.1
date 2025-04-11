Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4F37C369AE
	for <dpdk-dev@archiver.kernel.org>; Fri, 11 Apr 2025 23:50:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B374340DF5;
	Sat, 12 Apr 2025 01:49:46 +0200 (CEST)
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com
 [209.85.216.41]) by mails.dpdk.org (Postfix) with ESMTP id 2033F40DD3
 for <dev@dpdk.org>; Sat, 12 Apr 2025 01:49:43 +0200 (CEST)
Received: by mail-pj1-f41.google.com with SMTP id
 98e67ed59e1d1-3081fe5987eso1880440a91.3
 for <dev@dpdk.org>; Fri, 11 Apr 2025 16:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1744415382;
 x=1745020182; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8JBnpPYalxjvG7xml7r8CXLliDz8gCzqjgPTUVLzfGo=;
 b=NDh0rcwjXlxBBkgEDyP1UDLNDgWOJTGGT+6xzRbFWsq0n1HZB+Yy74t2pJaKWrdVxH
 Ibmc8StaAF2lmMyRKl9eiK+dgwgCYCQtny33mywETH8wFEuiuwHxLvFglxUiDgQ8tBrb
 CR+SQV+/oFDWikBEm2UGIImQjqZaf3XxU6fa9wvFwfJdd9HCXxzHNT0SxGYeNS7Gz2rN
 PniniBMxYDOVbmc2G8A0xSGuoAQCoy9eWBZO7R8KLxa2dy+8XU9UvV4H77x4T038cvHs
 PzQjIRV2j//kZAu0ExVVPWiGY6v20vhtsjOJLrOEx2nY8D1Us1Rkl/2sB4BfRS5FEmEd
 +lUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744415382; x=1745020182;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8JBnpPYalxjvG7xml7r8CXLliDz8gCzqjgPTUVLzfGo=;
 b=BmYqZEgSccR1/CmfpgAbBUw69RDFPGuPJ5enmRiel/AmoK2ekgEeDHhySSdnXEm5xT
 wuTtdEXHZIU4BvqCg4NLO8QnA6qFqCkWmui+0QjZ8z8N+xt+2LwbpJ/4zybpXb9kDKqc
 yCAoC91I/s0gQ32tlcng4QHh4/k/G1glGPVdQ9ooUVsZhP1U1d0XwB2nGO2DH3Vr8xmR
 g7FCFXlDyqy9snVtXMGdCusZW//alWD0dvksp+rKbUmhmngvOZZkBCsUUxRMhaOsFuLU
 1VBWT1ChBvAl8uwkScvrc6OIFCfq4TjwLMA/yG3+YQX+8ghrswRg5KhnYNQCLCBJ6Uh9
 h5Cg==
X-Gm-Message-State: AOJu0YwlVTIxNEgX2FlzhNtlPgzCfakQXNiMjOM1W7FW5AHRcIrGOFC/
 jTTSD5R8YB2Pd29oW7orU3O8UEfon9PgSTdbqkHNXxtMHstRaSaMkUEmTS0nsP0Ec/80yrTu7qa
 V
X-Gm-Gg: ASbGncs868dlJZ7Nf4Z0LrmBdNuc/WbwSma66U/j9m8LJqM+yYC4HdLk2bzCn0gjCAA
 gWrX9funowuGu+JBNT0/l7KblaUpqNdC6gPfS2E1A1wlib8QkizDeMOMypGNHeuZBiFnpXUyyCQ
 xhCVnsZ5uEwpscdvxTdATkBJWY/QeavoZ57JV1wCVenFPFUdMcAVFhz+wqrNDcFigGEWg95qKLC
 f+HSH/Qh3B8DhzI4ErWiQMV3LD+qEszYgwIITDCFAlrDK1Uxy0Hzcqa6GPLTuQ0qWcaXKSnevNY
 HpouplrsYpRx4+zN/HRv7LwLvRJH+jnmB4II1jRhj3dFqsdFjKSOAJQe8sM6MdKG2ZLZ8QL2y1Y
 YBZ6Or03uLaxy4aY+
X-Google-Smtp-Source: AGHT+IFbyDTGmBmkZAqhaN1HZSq9pjzRJdjZgrOc534uxS7qclHAVzKrfvGHqSe4b3ipZES2ml/j4g==
X-Received: by 2002:a17:90a:f946:b0:2ff:64a0:4a57 with SMTP id
 98e67ed59e1d1-30823672347mr5637543a91.26.1744415382212; 
 Fri, 11 Apr 2025 16:49:42 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-306dd11e643sm6538661a91.12.2025.04.11.16.49.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Apr 2025 16:49:41 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [RFC 04/13] net/ring: allow lockfree transmit if ring supports it
Date: Fri, 11 Apr 2025 16:44:41 -0700
Message-ID: <20250411234927.114568-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250411234927.114568-1-stephen@networkplumber.org>
References: <20250411234927.114568-1-stephen@networkplumber.org>
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

