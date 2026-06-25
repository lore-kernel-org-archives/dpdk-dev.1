Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12833CDE000
	for <dpdk-dev@archiver.kernel.org>; Thu, 25 Jun 2026 17:49:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3B30640689;
	Thu, 25 Jun 2026 19:49:21 +0200 (CEST)
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com
 [74.125.82.175]) by mails.dpdk.org (Postfix) with ESMTP id 4318440674
 for <dev@dpdk.org>; Thu, 25 Jun 2026 19:49:16 +0200 (CEST)
Received: by mail-dy1-f175.google.com with SMTP id
 5a478bee46e88-30bf132969bso243872eec.0
 for <dev@dpdk.org>; Thu, 25 Jun 2026 10:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1782409755;
 x=1783014555; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d2NStqsu47+OMRiowPQGBM0acnFpHR1JDR9IU6tZrmY=;
 b=iRpxS7DH4aMEwSx7C4uBP+qRnAsGbNNDME0u9UqKjKWWO/8Jt6zIy7J0f0iUrJmaNm
 Z/sAn10mbPVFAg+hxFuRRxoA2RRQ0/R2gI9j2MncJn68szYI1mhDvEWR1adBa277lF5u
 i67AM9sHUUU9Bvy7rPrdSox3CXylrooT45Va0X+yKkPTgCWmarC81hepZFEdYGic2YCJ
 g+NhGPLt/4yzkLX1+Csxx16KF8qDIVvtyuFRY8+HAE1dbaB4+Cr/JK0GAkFgjz7Bml4g
 MqzKZs/SVrjulEnqr0h4vJm8288Xa60k9F6ORypwivMnLnt2Z4T0yu5pl88FREeOu1/K
 kARA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782409755; x=1783014555;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=d2NStqsu47+OMRiowPQGBM0acnFpHR1JDR9IU6tZrmY=;
 b=IgABvV3W0OZZ9wzlWu9xGfL/Tk1gu30bPdEYQHfM032p2fz4k3q44S0zf47wQpzVHP
 96Qv9UvOwAJqYUc28oLXOe3hwacDufUS3E0cW6hqosem6DWXinxjjdHcK9UHJPXjRFK8
 J1Xsr9EbyCgQpsZa0JtYxSlh/5irpt3ouGa7KBs8NOILqsajtbZAUhJ7SZ1GMe30Nupl
 UAKEpVlW2KIMytd811MblE3j05CnXh3a5KAjYKinZDk5ssgUeGOJkdXuFRrH/Dd8w1f8
 qg7+Tm2lSL3juUvwaCYaeSrz+Nna8HgRFjtupkrxqrdiMEJdj8N24keUL6o3IaGwTHBi
 EXeA==
X-Gm-Message-State: AOJu0Ywb/eins9DM3x09fSG2mZhfX/KAaqxcFKJLlCnApE0D7+HJvT/o
 JDUQmp1EVUsBrTr7VLoql5V6ZEGqe6XYS6znVIxVIzIBWs4t7oPSEFT7tsnwQbuS3Au3Y+WhjjA
 xNgdu
X-Gm-Gg: AfdE7cliQVFLXgegScMxIj5X8ZPgpK6zHknXqLid1TOkbAWPIgSI09CVRWajghQQj+a
 /XRwtngON42N4/Ml4tzW27bXyICb6D6LIZpUtzzzY3Ooxvx57fa8RuBRCVIiEnYGPiW0SicotHL
 xsM8Enk56QMNizXTqo0HuW7K5xLHyzG3xHMCynKJ/smTNq+BTts7x1deySywWUUmvZsKH/M0T5G
 wpLOz2ZVS2V0f1mgQgH0OnmKraXkZxFlJw4652uZ0OTOaQddGHRExp90J5XAAFaFfe+i70xVLjn
 r8L903jvGrejRM7/tzIuYrbF2xzZrzJ++5QznBwWqj7yKt1d9hSvl8DOke30Li+pxaqA8WbS1d+
 h0HrsI3m1Tt5fDE1vr6OeFZmCAqYr2/CZ7pPYQDaFGBPlNoVJ9wV+ggEuc4tBLJhRw41DuMzOm7
 g1Yk68t2U8jgsLQKNARZjrvsYZmS1Kk4Px2OxNw0CdoTNIwHvCs4U=
X-Received: by 2002:a05:7301:6583:b0:30c:7b76:9047 with SMTP id
 5a478bee46e88-30c84d4a202mr3613703eec.17.1782409755264; 
 Thu, 25 Jun 2026 10:49:15 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c7c4ca240sm10594472eec.4.2026.06.25.10.49.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 10:49:14 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Sivaprasad Tummala <sivaprasad.tummala@amd.com>, stable@dpdk.org,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
Subject: [PATCH v3 4/6] examples/ip_reassembly: remove redundant Tx queue limit
Date: Thu, 25 Jun 2026 10:46:54 -0700
Message-ID: <20260625174908.278408-5-stephen@networkplumber.org>
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

In `ip_reassembly` application, Tx queues are configured per lcore
to enable a lockless design and achieve optimal performance.

The `MAX_TX_QUEUE_PER_PORT` macro, defined as `RTE_MAX_ETHPORTS`,
introduced an artificial constraint on the number of Tx queues
and limited core-scaling performance.

This patch removes the unused `MAX_TX_QUEUE_PER_PORT` macro and
redundant Tx queue check, allowing Tx queues to scale directly
with the no. of lcores.

Fixes: cc8f4d020c0b ("examples/ip_reassembly: initial import")
Cc: stable@dpdk.org

Signed-off-by: Sivaprasad Tummala <sivaprasad.tummala@amd.com>
---
 examples/ip_reassembly/main.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/examples/ip_reassembly/main.c b/examples/ip_reassembly/main.c
index 520fbea1c2..0814d47a66 100644
--- a/examples/ip_reassembly/main.c
+++ b/examples/ip_reassembly/main.c
@@ -144,7 +144,6 @@ struct tx_lcore_stat {
 };
 
 #define MAX_RX_QUEUE_PER_LCORE 16
-#define MAX_TX_QUEUE_PER_PORT 16
 #define MAX_RX_QUEUE_PER_PORT 128
 
 struct __rte_cache_aligned lcore_queue_conf {
@@ -1097,8 +1096,6 @@ main(int argc, char **argv)
 		fflush(stdout);
 
 		n_tx_queue = nb_lcores;
-		if (n_tx_queue > MAX_TX_QUEUE_PER_PORT)
-			n_tx_queue = MAX_TX_QUEUE_PER_PORT;
 		if (dev_info.tx_offload_capa & RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE)
 			local_port_conf.txmode.offloads |=
 				RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE;
-- 
2.53.0

