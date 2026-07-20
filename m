Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF171C4451B
	for <dpdk-dev@archiver.kernel.org>; Mon, 20 Jul 2026 08:01:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DA22040696;
	Mon, 20 Jul 2026 10:01:12 +0200 (CEST)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com
 [209.85.221.53]) by mails.dpdk.org (Postfix) with ESMTP id CB6B040696
 for <dev@dpdk.org>; Mon, 20 Jul 2026 10:01:10 +0200 (CEST)
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-476d8e647e9so8899372f8f.0
 for <dev@dpdk.org>; Mon, 20 Jul 2026 01:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784534470; x=1785139270; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=H4xTEMC6oIHPfDe6f/4kNlgEpWvgGpuG6Kw2qHleZSk=;
 b=p98ztPg/12jvZa3n/HYuofL6uH6rTfofQ14Nb7lGGjpajwtAzwgmLmMt0MSHTudZ0H
 n9RN0FVyNTaLzl3RCyYb8BB35r1V705ilvLkQ04vF+pieKMDMbCNerJ8SWIZ+0PrXWT0
 /9sRg0amYA3cMCIiwLIb8XO0S9u101xqlFsu+bHJTd4pt+6mz5/TyENr0pHsFJCYxmlU
 ephAFcqaEu5EtqQnKmhQB4UYYFC90xwIghIzs443n2pErGBg0IWQOvUSDbChf24jWRAX
 1fJcSLDNKA5zflJo9EZTScWoNPgoPAkDegEo34ZAM+JdFqAZ2msWawrBsxd91UrIEcU6
 3HYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784534470; x=1785139270;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=H4xTEMC6oIHPfDe6f/4kNlgEpWvgGpuG6Kw2qHleZSk=;
 b=fYqWQFPxayVzDgc4PLpRKBqS4s/KqlCQkmhdZbaSYw1dI9Gt0Lx4j5QQG5Bk/tlssi
 pCIRqbvmDddqe2y8Xmaa5YMUBKhufVqaERIkOASBfc3EERbBNUqWmAZBZy53R50tEvAe
 6/HP8ROdwMeuSYC7CZ/5fS1JkTXjiOFMpFlkpNzgkLRtANoT+1skmPDpnDIBun8wyph7
 Hv7rqgBEO1N2ReIVRloIz/tp5+cp+a8YlfCsMhVdgtXOehMTkRhgl/UzZbzxCFkjb2cx
 pc3iVL/hulTaKUu78USefKLyds/1le2r4xPJSeku1Wx1scDzZ2PgHRaOrnr/4ffsRAdM
 AmYQ==
X-Gm-Message-State: AOJu0Yzgh8A49YFJocZqNtZKJovpR8kI5hc5jhqkHbhyB4mdtPPj1G1S
 9bEJCWFQxYiAd5B4AJlctKEuwl3its88Km3aooDrlKWaNBD3WeoR4RZ3b8WxwQ==
X-Gm-Gg: AfdE7clhmvgE1msOIG2qHgL842SAI6KCMKncVdC8aqyVlmZnBHpqHZ4wJgcA4vXIP6i
 FkPTSwFu/zb4CU+oGQzjGFqECYfqpuQemc7DHmhbdzw2qV4a9TqY6s4ND7nYyze0zyKH3v6mdez
 +IIUE7vb6+tJ8nvngs6VriBgfotdekAUQVRCHNmx/bQsa+v0KL+uW7vJZ7zDzYOmYwMOWN8p7yS
 5G5jDuzNXcAzYvj8gpH6/gqWUfmrARz07HD5wHUksfAe4HCadH1M/v7L80Vdj2EX3fqYGMKzk1g
 /h8XQF+fusGzFGD7ISISEoog9FKmHLuLm/zz+A9UlpPg3g9za4YkEAJN266C5vRVG/+g/6GHUfw
 aULmqDFjQgQm1aN47+WB2CzJdzkR/UD0I5g+FbEKSt7Ge33uFsjx05CRtA1ryMPbneqpFCEsJQ7
 bOJeOjat0jgUtfuPcvaf4hSo0kkZfkGc8gXYqQzBIw
X-Received: by 2002:a5d:5d0a:0:b0:475:f0d1:eb6b with SMTP id
 ffacd0b85a97d-47f62343e6bmr15533901f8f.56.1784534464979; 
 Mon, 20 Jul 2026 01:01:04 -0700 (PDT)
Received: from freepad.sicorp.iliad.local (free-mobile.vlq16.iliad.fr.
 [213.36.7.11]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f63ed2313sm27066068f8f.23.2026.07.20.01.01.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 01:01:04 -0700 (PDT)
Sender: Maxime Leroy <maxime.leroys@gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
To: dev@dpdk.org
Cc: anatoly.burakov@intel.com, sivaprasad.tummala@amd.com,
 Maxime Leroy <maxime@leroys.fr>
Subject: [PATCH 5/6] examples/l3fwd-power: recheck Rx queues before sleeping
Date: Mon, 20 Jul 2026 10:00:34 +0200
Message-ID: <20260720080035.673782-6-maxime@leroys.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260720080035.673782-1-maxime@leroys.fr>
References: <20260720080035.673782-1-maxime@leroys.fr>
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

After arming the Rx interrupts rx_interrupt_wait() sleeps in
rte_epoll_wait(). A packet that arrived between the last poll and the arm
can be missed on PMDs whose interrupt is edge-triggered on an empty to
non-empty transition, such as dpaa2: arming a queue that is already
non-empty raises no notification, so the lcore sleeps until the next
packet.

Before sleeping, check whether any queue already holds traffic and, if
so, skip the wait and go back to polling. NICs with level-triggered
interrupts are unaffected: a pending packet keeps the interrupt asserted,
so rte_epoll_wait() would return immediately anyway.

Signed-off-by: Maxime Leroy <maxime@leroys.fr>
---
 examples/l3fwd-power/main.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/examples/l3fwd-power/main.c b/examples/l3fwd-power/main.c
index fa64e28e5c..c423b0dba5 100644
--- a/examples/l3fwd-power/main.c
+++ b/examples/l3fwd-power/main.c
@@ -949,6 +949,26 @@ static int event_register(struct lcore_conf *qconf)
 	return 0;
 }
 
+static bool
+rx_queue_pending(struct lcore_conf *qconf)
+{
+	struct lcore_rx_queue *rx_queue;
+	uint16_t queue_id;
+	uint16_t port_id;
+	int i;
+
+	for (i = 0; i < qconf->n_rx_queue; ++i) {
+		rx_queue = &(qconf->rx_queue_list[i]);
+		port_id = rx_queue->port_id;
+		queue_id = rx_queue->queue_id;
+
+		if (rte_eth_rx_queue_count(port_id, queue_id) > 0)
+			return true;
+	}
+
+	return false;
+}
+
 static int
 rx_interrupt_wait(struct lcore_conf *qconf, int *intr_registered)
 {
@@ -968,7 +988,12 @@ rx_interrupt_wait(struct lcore_conf *qconf, int *intr_registered)
 		*intr_registered = 1;
 	}
 
-	sleep_until_rx_interrupt(qconf->n_rx_queue, rte_lcore_id());
+	/*
+	 * A packet that arrived during the arm window raises no new wakeup on
+	 * edge-triggered PMDs, so skip the sleep if a queue already has traffic.
+	 */
+	if (!rx_queue_pending(qconf))
+		sleep_until_rx_interrupt(qconf->n_rx_queue, rte_lcore_id());
 	rx_intr_disable_all(qconf);
 	return 0;
 }
-- 
2.43.0

