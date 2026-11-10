Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C72606A321
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Nov 2026 08:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hOAgCMcI
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5C04540E12;
	Thu, 12 Nov 2026 09:07:38 +0100 (CET)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by mails.dpdk.org (Postfix) with ESMTPS id 02DF540281
 for <dev@dpdk.org>; Tue, 10 Nov 2026 16:13:25 +0100 (CET)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4a140e7405dso17774535e9.3
 for <dev@dpdk.org>; Tue, 10 Nov 2026 07:13:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794323604; x=1794928404; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4vGJbQAFgrxKDxMAlRBu+QZ/F3hGCGgNU6B+atNn+I8=;
 b=hOAgCMcIy/rz/DEpLmBrjUx03GbboWZh9BEcnQxHFyew6B3IZbt952Wi8fRw17iiYe
 ohiWOvOBvM+9IuzLxX+NuWAqF5DcscD4oXKaEFHPpf4/VOXEdOtwF/DSaXkRdqtnfqQ4
 0/1gCqcxfxnKO9wZCDjYDn8dCEO7infru8dV54K8MN6qE1F1QptDCx3rw7Bh/UIWaAJw
 AJiIuRE1AZmvBaxq6jZdfoQk3r47MJy4CfqARqwZ6DHeEvjc8DKvpLJtyXurji64o8UK
 +zUplzcUrR9fWQ2sLA8uDtz95gDMwTW98yfr/LtJAtmxQAy21hw2N/r5OhglE6IAs6d7
 Ao0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794323604; x=1794928404;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=4vGJbQAFgrxKDxMAlRBu+QZ/F3hGCGgNU6B+atNn+I8=;
 b=DSWJVojWQ08t64by+4a1wRxoaW2JDtwemLa4Xhkq8WF7GWSDR4wuQ/P7A+bLTuOi2B
 xu4eCrRQo4mFLzqG5pwU/V2bc0CG3u1dTe9lT0l3OUxdMNvcTCrRG36n3RNWqiJKY6ns
 /IIVpHp2A9t8gH/g0sWUNU2aFIoVTUtehLQvt4BzyXwRx4R7rZ23dISej8DHLtpUTEKx
 EqWDc42k6AXPPJaGJe70+PslemOfgrdkezhkwV3WhPzKCS3XDfbfwH1oiDMoULBcDu2U
 /AV/z3y89unV+pIypFXuFaKJ2grcl4iT83zusDWITzcuUR5bqzqPGITOrEw7t0TxU7QE
 iRuw==
X-Gm-Message-State: APuU4Z9t/ZkZPTp7c1R6qGwW6OEC8stusHSz5qdIAEPthyGZl/XZdjkT
 GZMQ5Z4a7fSv07lt/IHg0uBTf0m9ozUlpqWhcTAOIbXGehfq8FgE6rm5Vxlj0afR
X-Gm-Gg: AYBFou11guLdp/DJXbQqp6FagK5vszvRBZ1aZ/Ivmd3g6jBRFUwZutnGBx6iRA5mkrM
 vuGLnUldGoZPvAAbJndF3yGfYU9Tnhr+AuOOtfuwwRgc2oixQBJ2Zsx6eHVcTz1vqH6w+E8RPrP
 dU3L7ruv+psWJccypqJDHM8LwYX8W+MWGl8a2Hev3+31NJg8UYDe1LwgHGQ0k66+oVYZVqXG5Jg
 zVPE0XgZKtAGrIzDgZOyKNP5ba7ROUdDAQrh3S80ojhy4AKX1sBA6O55Gymn92HxjAu73Gx+NfA
 zsyC/B3axS40IaPN+/GtOAzyo+MQ7IKkrUhFY1tfD00AwSN7CmvbVEhb8CQnnjGgBHAMf4a96xO
 p9vmNh0CsMyPaekWJE/stJV7aPNITrTD8ntZ3xjZQ6i4ZAr4oitnAL/JXkAtgDx3JRWoAUeiVlI
 dmRF7HgdyqZNN7nTYvo1cE10yd/U4AzuQBoKVzGHKeAedpLvovNqPiZM8yyv60L2s6ZzklSXZhj
 bFraa9r/M9THLFgadO1nY+HNuau2ra5u0ppSxMaO02uy4WL0kGqx/HD3VqwMeFnOXX7YHCWUL4T
 CAQuXRI92dAkhxaVDTm/mxguqo/crtwpKV0YM/iWpgVS55VxCt2Gy1WOZ6mf9b4wIoTBigl9gn3
 zYfcrmJ/EdjodVKuMFTI/yPTdZ+O3tfoO3eMvilvnwkVMGFwAneznhQnjArd2kge5cNWg
X-Received: by 2002:a05:600c:34c7:b0:4a2:133:45e1 with SMTP id
 5b1f17b1804b1-4ba0234cccemr47043775e9.24.1794323604356; 
 Tue, 10 Nov 2026 07:13:24 -0800 (PST)
Received: from center.jhjvjihww5qejoy14qwv1cc4td.frax.internal.cloudapp.net
 ([131.189.143.225]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ba0234a5dcsm70933495e9.2.2026.11.10.07.13.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 07:13:23 -0800 (PST)
From: Orgad Shaneh <orgads@gmail.com>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, Wei Hu <weh@microsoft.com>,
 Long Li <longli@kernel.org>, Aditya Garg <gargaditya@microsoft.com>
Subject: [PATCH v2] net/mana: do not block Rx interrupt calls during a reset
Date: Tue, 10 Nov 2026 15:13:22 +0000
Message-ID: <20261110151322.238955-1-orgads@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261110064712.6b1a3eb7@phoenix.local>
References: <20261110094243.151321-1-orgads@gmail.com>
 <20261110064712.6b1a3eb7@phoenix.local>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 12 Nov 2026 09:07:37 +0100
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Rx interrupt enable and disable wait for reset_ops_lock and then
return -EBUSY if a reset is in progress. The reset thread holds that
lock across the teardown (mana_dev_stop(), the RESET_ENTER request
to secondary processes, mana_dev_close()) and across the re-probe,
and each request to the secondaries may take up to
MANA_MP_REQ_TIMEOUT_SEC. An lcore that calls rx_intr_enable or
rx_intr_disable during one of those steps blocks for that long,
only to get -EBUSY.

Retry the trylock while the device is active, yielding the CPU in
between, and return -EBUSY as soon as it is not. Outside a reset the
lock is held by another queue's Rx interrupt call or by a control
operation. The data path must already be stopped before
dev_stop/dev_close, so the wait is short in a correct application.

Suggested-by: Wei Hu <weh@microsoft.com>
Signed-off-by: Orgad Shaneh <orgads@gmail.com>
---
v2:
- Yield with sched_yield() instead of rte_pause(), so a preempted
  lock holder on the same CPU can run (Stephen).
- Fix the commit message and comment: outside a reset the lock is
  also held by control operations, so the wait is short only in an
  application that stops the data path before dev_stop/dev_close.

Applies on next-net for-main, on top of efa36b47334d ("net/mana: fix
Rx interrupt enable failing on lock contention"). Squash it into that
commit if you prefer.

Builds with meson -Dwerror=true (gcc 14, rdma-core 56). A MANA reset
cannot be triggered on demand on Azure, so the reset path is untested.

The rwlock (tryrdlock in rx_intr, write lock in control ops and the
reset thread) fits the burst_state follow-up for main; I'll look at
it there.

 drivers/net/mana/mana.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/net/mana/mana.c b/drivers/net/mana/mana.c
index f624cde6b9..71a3fd20d7 100644
--- a/drivers/net/mana/mana.c
+++ b/drivers/net/mana/mana.c
@@ -2,6 +2,7 @@
  * Copyright 2022 Microsoft Corporation
  */
 
+#include <sched.h>
 #include <unistd.h>
 #include <dirent.h>
 #include <fcntl.h>
@@ -451,14 +452,24 @@ mana_reset_trylock(struct mana_priv *priv)
 }
 
 /*
- * Like mana_reset_trylock(), but wait for the lock. Used by Rx interrupt
- * enable/disable, which every queue calls on each sleep and wakeup: they
- * must not fail just because another queue holds the lock for a moment.
+ * Like mana_reset_trylock(), but wait while the device is active. Used by
+ * Rx interrupt enable/disable, which every queue calls on each sleep and
+ * wakeup: they must not fail just because another queue holds the lock
+ * for a moment. Outside a reset the lock is held by another queue's Rx
+ * interrupt call or by a control operation; the data path must be stopped
+ * before dev_stop/dev_close, so in a correct application the wait is
+ * short. Once a reset has started, fail at once instead of waiting for
+ * its teardown or re-probe step.
  */
 static int
 mana_reset_lock(struct mana_priv *priv)
 {
-	pthread_mutex_lock(&priv->reset_ops_lock);
+	while (pthread_mutex_trylock(&priv->reset_ops_lock)) {
+		if (rte_atomic_load_explicit(&priv->dev_state,
+		    rte_memory_order_relaxed) != MANA_DEV_ACTIVE)
+			return -EBUSY;
+		sched_yield();
+	}
 
 	if (rte_atomic_load_explicit(&priv->dev_state,
 	    rte_memory_order_acquire) != MANA_DEV_ACTIVE) {
-- 
2.52.0

