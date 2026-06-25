Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9440CDE000
	for <dpdk-dev@archiver.kernel.org>; Thu, 25 Jun 2026 17:49:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5DA15406B4;
	Thu, 25 Jun 2026 19:49:22 +0200 (CEST)
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com
 [74.125.82.177]) by mails.dpdk.org (Postfix) with ESMTP id 48CF040650
 for <dev@dpdk.org>; Thu, 25 Jun 2026 19:49:17 +0200 (CEST)
Received: by mail-dy1-f177.google.com with SMTP id
 5a478bee46e88-30c8b23420bso238823eec.0
 for <dev@dpdk.org>; Thu, 25 Jun 2026 10:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1782409756;
 x=1783014556; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Em3Z0w9pnqIR+MjHKuiv5Uda7AxWQi5F9PssFBZhLmw=;
 b=QPrblz5ApYDVflqdzCbXcJAM5/1/CLfn6fOv/zicgkemvxes40WXtbEV7h6dq+WCby
 MPsa/WOLJryT1/U8JsoBxU/3tMPCEcWWoYJpQQrZsh3cRip7KHIOITxBeFfrOr8R6ivx
 Syg0jfd5+gI8hyAA+NpIhJQjZkw8VR5+1aEO1MONKz0RDZhJb3VepV+tivRiJ0vFz4Kb
 N7irHmgtnh6ddNZb2jz41AEPKBq4qXBQRusmOnrW6No3sj4P9Sx49pHiguWWG4P3ybxY
 H+lkOemFIXV1/aowWge1k8fp0YJ8RahmCPSSYHTOD+QZVoOEgWg3mY0mPxBzlh7LGbeB
 E5+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782409756; x=1783014556;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Em3Z0w9pnqIR+MjHKuiv5Uda7AxWQi5F9PssFBZhLmw=;
 b=Tyjcoul0iDBAw79LsMDdcDv8AZ8Cd6QP+rjxKbTP2gfaaPlFkG3AGcpIBZIXqvGW0R
 DD4XPBSPtElQm+XS2TNmBzoO+WyV9L1hCUt/tQfAujBh0AdC++LSx9a9IYWm3vdik1Au
 GvC2Opb3bYIsNcGBIAlu+t9ymDAPrCiWGlqo1Y9d8GxSE1bztwl4LxHwSq0ZOLXDr6+4
 GHUuWi6weWFqvq/s1cQPVPmvnVzJnCmwPGAG/JEApGVU3grtuUdee0xqKR3kn8fBw27y
 USx3RTVU5I2d5UxFifeS0V/H2PJmyrvTDDU2cNg8oh2hFAChKLr1wSzOEaYcTbr/16ct
 CUjg==
X-Gm-Message-State: AOJu0YzqAZt1IWGfxvXidCXsgrYwvqpctw6Y3n7aCQujeJ/2Z/RxxYjF
 LH8n+KvshITkfCUYBsNznR89Jt4PrVQNjyzZHUsMvZdmhrpdI4Gr0KtgChB4EkCLBWtgYtevt0f
 GEiHD
X-Gm-Gg: AfdE7cnwgOvLluwpEoqGsH9yMHox4KNx5c3WJdlzfH/4bz4r/iZkp+9H8/RxMCrgEF/
 BIuJcCLPCyPBFLd4fyqWLdHSXS/NmeoQwvCxzaPbVqfANq+wJfwlmjqv/YKMqDbPgF3aK8JInjl
 CV/y/cScmmKAMFi8cX2VfFaw2DF5jV6AuHsCxpOAYvi1X+LJgbMsO25C2w3k/Ygif9kj5qK7mzO
 OesFM5FWk0qaSoZWjXxohrw5zt94Pkb/TpP/0bH1g5DPIovflaWnUd55MrMNUvbc5sGdNuP2WVx
 8UiqUmAhJdgO2/uXCZv6vGy3qeeA9z/kNYdD6bLLeSymVUpcDf5r/anNbWY/LcsfHNTYLOnK1CJ
 O+jCpsmm64Ukt9vC1hx/u3TkxrmaKh0ONy5By7Wy8aH4NAFkdeXO/+pGp79L5dqwUKkAimuBHUr
 Fv7uqy3b9pzj/Fz7idgKxZSNlmm4W+5KwaLTkjDKU3ftAdwts4igg=
X-Received: by 2002:a05:7300:7643:b0:304:6448:dfd7 with SMTP id
 5a478bee46e88-30c84f42aadmr4123534eec.18.1782409756303; 
 Thu, 25 Jun 2026 10:49:16 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c7c4ca240sm10594472eec.4.2026.06.25.10.49.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 10:49:15 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Sivaprasad Tummala <sivaprasad.tummala@amd.com>,
	stable@dpdk.org
Subject: [PATCH v3 5/6] examples/ipv4_multicast: remove redundant Tx queue
 limit
Date: Thu, 25 Jun 2026 10:46:55 -0700
Message-ID: <20260625174908.278408-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260625174908.278408-1-stephen@networkplumber.org>
References: <20250901154400.2333310-1-sivaprasad.tummala@amd.com>
 <20260625174908.278408-1-stephen@networkplumber.org>
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

From: Sivaprasad Tummala <sivaprasad.tummala@amd.com>

In `ipv4_multicast` application, Tx queues are configured per lcore
to enable a lockless design and achieve optimal performance.

The `MAX_TX_QUEUE_PER_PORT` macro, defined as `RTE_MAX_ETHPORTS`,
introduced an artificial constraint on the number of Tx queues
and limited core-scaling performance.

This patch removes the unused `MAX_TX_QUEUE_PER_PORT` macro and
redundant Tx queue check, allowing Tx queues to scale directly
with the no. of lcores.

Fixes: af75078fece3 ("first public release")
Cc: stable@dpdk.org

Signed-off-by: Sivaprasad Tummala <sivaprasad.tummala@amd.com>
---
 examples/ipv4_multicast/main.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/examples/ipv4_multicast/main.c b/examples/ipv4_multicast/main.c
index bd4c3f335b..1cb621cb8b 100644
--- a/examples/ipv4_multicast/main.c
+++ b/examples/ipv4_multicast/main.c
@@ -96,7 +96,6 @@ struct mbuf_table {
 };
 
 #define MAX_RX_QUEUE_PER_LCORE 16
-#define MAX_TX_QUEUE_PER_PORT 16
 struct __rte_cache_aligned lcore_queue_conf {
 	uint64_t tx_tsc;
 	uint16_t n_rx_queue;
@@ -735,8 +734,6 @@ main(int argc, char **argv)
 		fflush(stdout);
 
 		n_tx_queue = nb_lcores;
-		if (n_tx_queue > MAX_TX_QUEUE_PER_PORT)
-			n_tx_queue = MAX_TX_QUEUE_PER_PORT;
 
 		ret = rte_eth_dev_configure(portid, 1, (uint16_t)n_tx_queue,
 					    &local_port_conf);
-- 
2.53.0

