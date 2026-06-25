Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6E8ACDE001
	for <dpdk-dev@archiver.kernel.org>; Thu, 25 Jun 2026 17:49:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 150B24066C;
	Thu, 25 Jun 2026 19:49:20 +0200 (CEST)
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com
 [74.125.82.181]) by mails.dpdk.org (Postfix) with ESMTP id 5A3E640661
 for <dev@dpdk.org>; Thu, 25 Jun 2026 19:49:15 +0200 (CEST)
Received: by mail-dy1-f181.google.com with SMTP id
 5a478bee46e88-30c8b23420bso238789eec.0
 for <dev@dpdk.org>; Thu, 25 Jun 2026 10:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1782409754;
 x=1783014554; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8apB/OIyc/5/wrrl79xqrNQwXoFeYA3+uHaA9Z67ruI=;
 b=vrt5anft8qpE5sQfOokLDHr1lvucE6uydXUu544IG3uN5XFJgD2D9Am4HB0wquph1J
 U9+ifiwOWCulILpIq490MoCHAwRaJluZvm6i/RBDRMmcoS5kClopXu9AKFMkswLNCQox
 EiB/QRinEfwX60i9NtbkDh879Sm+SBDObairQJjSDqkFdNNTrw3YYqRjoN2mfuNUJcoR
 8PC995vyPc4Ys8bnudGTkGUIQ/9Ye/cXq6kqAH20Q/fvW0UDEjFRYKyB3F5iqMnuytyc
 1C1C5ujX1eBnIaPCNvf6njXZrijtu+8XkXQpoHDaeEI5hWNYZbRQlUG+8B8c/qEt8IkJ
 djPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782409754; x=1783014554;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8apB/OIyc/5/wrrl79xqrNQwXoFeYA3+uHaA9Z67ruI=;
 b=drqBtCeKY7r0+BiV19BdHtiFFGziFm5dd1y6f7zuFe2I1Hl1+gpZu1PX2is6Qu8NEo
 us0LFKkTiPA+QUyHXuBmzQywlJGtcltIl3nHZ81BppuPSZG0hW7G8W5tBaX2UoYNik6A
 MgeitElCs6P1ZMTn8X8SEqxs6Mtp3NDtYQeyc4vKbYvHtSJonSQHEfVkCXKTSdukTKMd
 v2hoXfW4CzT9Ah2Yvvju1pJfIQ98Bu5tjv93o4r2RTdJUhHVLA1bcCNK0r9pYVHkIKdD
 D2auGeh2DBt6VCq4SAsDY+qJHBrFE3GUAl6dL4yZYeUxzEh8YAoztRPM9rZMukXekhfv
 3Tow==
X-Gm-Message-State: AOJu0YxRXuezBKSLC7khqOxM/UdyPmQ+ECRUeqlNWSxt/094NXS2QGUz
 f0E+P+IF4jWroXcsutudcOpL1lYyUTlNns8V1iv+h3FEGs65pHRNaJbzMliJ97klDSh58fKDv+E
 hoCPy
X-Gm-Gg: AfdE7cnHAzMv0mDvf2SSnGBru23Q9omiodG3ihtxinqREh4HFnThviT6YmkmkbkQjHo
 AXhV2YQiz+3VJfCEXyKczhfsfUPZU/TzcYc6yAsbrUnfn5Le20qetTuBi9nBW2qHpJDKFfonGjw
 LDlBjdRayV4jHukbofluW4EY0FUJsPWqRtuFMMN9DkmRbnl17Vxo4plkdcDasqstLau5/jRPnuc
 6ecIFYdaE6MQ8UER1jZn+6CgEu4tmWDD+WE+jzEQN6ZUqKsDwD2IwotbCe7kZetF3aDIiX4znNg
 1ET/ytT27EoYuItvbZXpwXyqPBfYTRZPTZAFA+bEgQZdhQrjwv/QbdgSrsTo7b0C8dp8j7Aungy
 lIxFXOEunR+xqIX2m2Ybt8Uiuy05bczlMiFtqsAeKU8M7Y/GuIMvjVb1rSNaB71EGkYbmWUmccu
 dFQafgd1fvP51Abssahhtab7+4jq3wY5CtegI5SZ6mSwSAReV8ezg=
X-Received: by 2002:a05:7300:80d0:b0:304:b93a:5107 with SMTP id
 5a478bee46e88-30c84f41ad0mr4439553eec.21.1782409754242; 
 Thu, 25 Jun 2026 10:49:14 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c7c4ca240sm10594472eec.4.2026.06.25.10.49.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 10:49:13 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Sivaprasad Tummala <sivaprasad.tummala@amd.com>, stable@dpdk.org,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
Subject: [PATCH v3 3/6] examples/ip_fragmentation: remove redundant Tx queue
 limit
Date: Thu, 25 Jun 2026 10:46:53 -0700
Message-ID: <20260625174908.278408-4-stephen@networkplumber.org>
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

In `ip_fragmentation` application, Tx queues are configured per lcore
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
 examples/ip_fragmentation/main.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/examples/ip_fragmentation/main.c b/examples/ip_fragmentation/main.c
index 2180682373..132550e497 100644
--- a/examples/ip_fragmentation/main.c
+++ b/examples/ip_fragmentation/main.c
@@ -133,7 +133,6 @@ struct rx_queue {
 };
 
 #define MAX_RX_QUEUE_PER_LCORE 16
-#define MAX_TX_QUEUE_PER_PORT 16
 struct __rte_cache_aligned lcore_queue_conf {
 	uint16_t n_rx_queue;
 	uint16_t tx_queue_id[RTE_MAX_ETHPORTS];
@@ -947,8 +946,6 @@ main(int argc, char **argv)
 		fflush(stdout);
 
 		n_tx_queue = nb_lcores;
-		if (n_tx_queue > MAX_TX_QUEUE_PER_PORT)
-			n_tx_queue = MAX_TX_QUEUE_PER_PORT;
 		ret = rte_eth_dev_configure(portid, 1, (uint16_t)n_tx_queue,
 					    &local_port_conf);
 		if (ret < 0) {
-- 
2.53.0

