Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FBB9C79F9E
	for <dpdk-dev@archiver.kernel.org>; Sun,  6 Sep 2026 23:27:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 25E8840678;
	Mon,  7 Sep 2026 01:27:39 +0200 (CEST)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
 [209.85.214.175])
 by mails.dpdk.org (Postfix) with ESMTP id E11F740664
 for <dev@dpdk.org>; Mon,  7 Sep 2026 01:27:37 +0200 (CEST)
Received: by mail-pl1-f175.google.com with SMTP id
 d9443c01a7336-2d715f4a587so42356425ad.2
 for <dev@dpdk.org>; Sun, 06 Sep 2026 16:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1788737257;
 x=1789342057; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BrGiv4V1YWyZpwB7lL/BbrTKnhDaSTmQwVxRcT69rBM=;
 b=k+p2HET7kXlPAccmi9XxsBvntVbi9nhYoHkKkb1+sihIHel6f97bjGmu+21DqH9jjQ
 f06odjSAqiGubrLDJcgTXRmLhutMPo8IQSpwTvqq9+nMZQHwAOJbA2eggaWFK3pX/fUv
 cvKSRiWFf+9SNNFkgYvqaE7AwwdOfetqXhVtDsX52feMKuL1DVlKvLJSzn4VUuM2szk5
 lkzvRTz7s3JPZ4pVMpXSbLcSKN/j+4/0Enbj5Nv/9bsCVecOx3z0HxFjcBokNuGtsaTZ
 lU923o5CIX1TLcMcGRWNiCBKpyjWKIjryi0Nltr3KKHL5FQ2DPU6NSJ0y5zRTtPe1b0I
 qnUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788737257; x=1789342057;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=BrGiv4V1YWyZpwB7lL/BbrTKnhDaSTmQwVxRcT69rBM=;
 b=GzZ7Ovf5F21YAHrRZHem+Z8dyxPrU0WuMJ1rmjBQYIJ9zb5uVD0gx/RY31CFe8zgmN
 dHQi5bEbnbMIJWRWv9F0/P17C1eAUh6EF+qMIJMDlRO/A26h5covWWEDyOeb+wkATfqe
 p/WpHFO3CuEIWe9iKIHkPOq+4b15guknZV0+RjfUv0TF4OTxBkAHeBURlGqxrmZIZ6TT
 JNEF9TCr6/l2HI/egPU2gfZp1GiyAkTx9JWk76MrrQgsk2qWTDYuYbl9Y1rmYPpV6Qhs
 yxapaEJ3UcW3g4EwfeEihT6b8GOzuY6/H38QvNyzJ3v4++2M/k0g95l7HaPP6E/hxZ85
 LrEA==
X-Gm-Message-State: AFuF++kNVBANdgPfC/yOnZQaAZSYV9eBtJXYp0fIeGrEWuWE05M3m7YR
 BiLfDNeOhOWZBRnxks2u9s7JCRxNTlg8/lm1uq4DfuPhM7lzAlvFIMBnygrvMRETu/4V+amZ0eY
 2YOLD
X-Gm-Gg: AYBFou2gC4mR95y3j42gdJkFLCLsHZ8xmE7xYfYtcL//jRRR74dDTdPRUoJFY/clkO/
 45CE1A9pr56NLDqgLicV8VQzRWgSHsBkgrcKWlobQf9hVxh7aND0sySOCyMgrIirw6cCjDTZiBq
 F6ADL68f7/C3r7/V80aLQy8QLSAqq41SqPJgiYuzcAM/VoaMJcM0mZK9lYxesk2HGZtzbsPr9Ok
 8JC8o6EcC8A4q09O3w7fpG7tVfBbFKEEHkus7RMkupZXmH2QwqR4yu8wHoBUrYpQYF36y9HQGXM
 oKBFl87WtVtx3ytrEHAyUeBp4303NqmxC//9Bn/2ekGUk1RzEB/TkQV6XfkUeBxDm0PsCsop+Gs
 C48N9PQO1JZKpu1oURMrembrAKfq2KGVPCpoZ8tpImrdn7YlPGmK7LNW250nD1ual7ahKH/ihFH
 MEC3J70OigWd39Xu9xLq8tfax/qMnLxJNpDHyn0u9WryslmY7WzK10yOtG8cDfDCOlErdicoHbs
 8R3gpfJE6GLYY940LZv/6eyfpY=
X-Received: by 2002:a17:90b:28cc:b0:36d:b424:4f17 with SMTP id
 98e67ed59e1d1-39b260e13d5mr29488456a91.1.1788737257099; 
 Sun, 06 Sep 2026 16:27:37 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39b3312f9a8sm14491741a91.2.2026.09.06.16.27.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Sep 2026 16:27:36 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 03/13] examples/vmdq: do not print from signal handler
Date: Sun,  6 Sep 2026 16:24:38 -0700
Message-ID: <20260906232716.496546-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260906232716.496546-1-stephen@networkplumber.org>
References: <20260906232716.496546-1-stephen@networkplumber.org>
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

