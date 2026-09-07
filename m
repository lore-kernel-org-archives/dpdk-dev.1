Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 028E1C79FA0
	for <dpdk-dev@archiver.kernel.org>; Mon,  7 Sep 2026 17:05:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 89B3E40B8F;
	Mon,  7 Sep 2026 19:05:18 +0200 (CEST)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com
 [209.85.214.178])
 by mails.dpdk.org (Postfix) with ESMTP id 02DF140A82
 for <dev@dpdk.org>; Mon,  7 Sep 2026 19:05:17 +0200 (CEST)
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-2d8f265cbe6so27864225ad.0
 for <dev@dpdk.org>; Mon, 07 Sep 2026 10:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1788800716;
 x=1789405516; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JboPMtuKzuZTqzxYqCF5w0bQvjS6RUaphy/EJ73qXMo=;
 b=iPf2k5Io/AOiFkpjlzbiU+R7rZFKmIpvwNHZvyuqmqpfHdlINoLvk5UunkKCCzw0xG
 77MO/K79RlJ0TaVsh2KGeHUc/CnElKIBlG+ouiQ8fd2IVyPUY8tNOBluBD8rmD0QPPls
 EeFI94Qo/S0eDrD31Ga6k0hm/hBY792X8J36TIpNUcCUcpaYzz/5ZtQK7SK5pgonWnom
 xvjhOtUAqWMMjnB79J6HWpXx49Hv/WsyqGaOpeKMUtdrzbSFO3xcY1gU12EJX/gwIZ3+
 101WGGh2QbBMNjzaIx2SN4rdOB8gV3jvt8oQ/7NKBJkaQpeORGzCrXz98Pp5iy0zIznD
 eloQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788800716; x=1789405516;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=JboPMtuKzuZTqzxYqCF5w0bQvjS6RUaphy/EJ73qXMo=;
 b=UqDF5i41JGKI9P8OSbf+lVbefb03q9VxNJlgQEGRROjgyBIElWh5uXaR9X0RDU1L2z
 Wpuk1z480AQcTjv5EanLHc10bgSK5cWbn8JKBK02mPfxN9lYY5CjkNMuwQV/Qy1g8R01
 hnzsocTXXuAXmbxj2DJ9q1X657mRwj0dwl3Yo7iDCNF7Hw9nvOcFtEclBvogi4/kzLtC
 IdG7e5ISUz+WGjd6qzWyvT9GdNjxOnMphAmSimfpqltv9DYXg0JzaB9pRR0O+C5QVfvW
 O7JxUY6Ku4wVveq2DTq3QlADULNqI53WT7fbA5NjOLZMbqTpH9jKknxKtS2xbKREGoRJ
 sxAA==
X-Gm-Message-State: AFuF++nM6CuzAvWZxzquOPZKFro+YFiTZQ/zlwuQbfljRhA8cKuWx8vT
 K9StNGUdlYp6T7XTXmrFrH7yNOmaMxoj6L1vpAZmQB54PWmdapbTxo3l3zLFHyXBPHR22fX5Mr5
 kypDr
X-Gm-Gg: AYBFou0u0YGqwctcSvohsTatywI7ff+9nCjIQSLf+ZH5+FF2xZ0jhy/aXuDQQqnwJvE
 ZqnSZ4NjH7WRg0ERt3l0FAnEHJCmrcgXIFGsjDY4o2ywvh0wCcX5u10cJmikFW6mr6CkW+/WOVn
 DcKC/42keH9kzEouJ9PVQ32tBrOVAwORwNZhG3npQpuC1FLtmOfo5IK1R7gSC8jnMBhQIrXUZ3T
 L1j8qQ6jAl6vqFfxHEEMRKryPyzW6PY85eEKsEVxMW9ucR8EJMOhNuMDsYkweqjHy7sT+q7Zm+G
 9eMlj/u9O+SV68GrLahdj/jJVJBkzjP4O7AQ0CgVK3SxF+Olb/kqs7TBHKvW8gOTOGqybxaen7S
 ovf9hIGfI0/Aaj7AGtaxo1jxWERJFvTWOPzFzKJRq1aKCt6OYJj7qLwsNCvEcAsr4fTBIIzBu6/
 SPbh6fHnM+ftOvKToYHlhMtkCq3djXYHFbjYv+7maG73HQWQ56EXLdNlSiA2Jc/A8bP1ZePFsLv
 TrgfjiBL0vmOAxAueZrSkXzX24=
X-Received: by 2002:a17:90b:4c06:b0:396:b98b:a3c2 with SMTP id
 98e67ed59e1d1-39b26116d9fmr31227582a91.8.1788800715951; 
 Mon, 07 Sep 2026 10:05:15 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39b26123c99sm21509536a91.11.2026.09.07.10.05.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 10:05:15 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v2 03/13] examples/vmdq: do not print from signal handler
Date: Mon,  7 Sep 2026 10:03:21 -0700
Message-ID: <20260907170454.351647-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260907170454.351647-1-stephen@networkplumber.org>
References: <20260906232716.496546-1-stephen@networkplumber.org>
 <20260907170454.351647-1-stephen@networkplumber.org>
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

The SIGHUP handler calls printf() which is not async-signal-safe.

Set a flag instead and print the stats from the main lcore in the
forwarding loop.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 examples/vmdq/main.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/examples/vmdq/main.c b/examples/vmdq/main.c
index 8c9d885090..63ac44deba 100644
--- a/examples/vmdq/main.c
+++ b/examples/vmdq/main.c
@@ -465,18 +465,27 @@ update_mac_address(struct rte_mbuf *m, unsigned dst_port)
 	rte_ether_addr_copy(&vmdq_ports_eth_addr[dst_port], &eth->src_addr);
 }
 
-/* When we receive a HUP signal, print out our stats */
+/* Set by the SIGHUP handler, consumed by the main lcore. */
+static volatile sig_atomic_t stats_requested;
+
+static void
+sighup_handler(__rte_unused int signum)
+{
+	stats_requested = 1;
+}
+
 static void
-sighup_handler(int signum)
+print_stats(void)
 {
 	unsigned int q = vmdq_queue_base;
+
 	for (; q < num_queues; q++) {
 		if ((q - vmdq_queue_base) % (num_vmdq_queues / num_pools) == 0)
 			printf("\nPool %u: ", (q - vmdq_queue_base) /
 			       (num_vmdq_queues / num_pools));
 		printf("%lu ", rxPackets[q]);
 	}
-	printf("\nFinished handling signal %d\n", signum);
+	putchar('\n');
 }
 
 /*
@@ -534,6 +543,11 @@ lcore_main(__rte_unused void *dummy)
 		struct rte_mbuf *buf[MAX_PKT_BURST];
 		const uint16_t buf_size = RTE_DIM(buf);
 
+		if (stats_requested && lcore_id == rte_get_main_lcore()) {
+			stats_requested = 0;
+			print_stats();
+		}
+
 		for (p = 0; p < num_ports; p++) {
 			const uint8_t sport = ports[p];
 			/* 0 <-> 1, 2 <-> 3 etc */
-- 
2.53.0

