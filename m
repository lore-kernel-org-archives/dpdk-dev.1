Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3FB60A2600
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Nov 2026 07:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eB8pk35G
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2480240E1F;
	Mon,  2 Nov 2026 08:22:38 +0100 (CET)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by mails.dpdk.org (Postfix) with ESMTPS id ED9E84003C
 for <dev@dpdk.org>; Mon,  2 Nov 2026 08:08:12 +0100 (CET)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4a3517554f7so19641235e9.2
 for <dev@dpdk.org>; Sun, 01 Nov 2026 23:08:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793603292; x=1794208092; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0Q4gTNnnTyB1PGx/t9t06vAmjv/cfxlKKtHLRP02n3E=;
 b=eB8pk35GuEY3Q1J998QG6Xb/R8Z7x+Ek5ftW39gsqRm7K56fAJpZocLFhjOmFdinU2
 BIW14QRqxWgUdAIp1i6nMiraL15G8r32qGnQzFIoR2BRBjOIdf/ETfP5bFM7Qmk+JF4W
 esONp+xYx4xfHFHWymcjI3nH/KZ/++xtBClI6+PSWokCAHoEcVWEKasIjB3grjxP+Btc
 BIS90/STyHBpbjfZIgy8/6Hh1WEMKJ7TPs8TumtvDNxZoLWUK8EtmjM0Gl1mNW6TCoTu
 RIng1ADiXBj0CrKSpO4nZ7E1e1iN8EqZi1CjyIKWCwKCYkzqXOmZrtGzihSUCihfjhbP
 QB4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793603292; x=1794208092;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=0Q4gTNnnTyB1PGx/t9t06vAmjv/cfxlKKtHLRP02n3E=;
 b=EaAvaA7q4DS2dn+lbSn6zw8kMFJR7dSe3QnjmcJEbkIfNCEr1tpd3MD9IzTbrMb+0R
 LLU20G+SsdM3PQ1N60OWImpxS3xct2yRwBzCXy5+vc1Ut/ARfZt7mNmeXAEd4NlBqP5S
 HH/r6WRezqDwmTlinOgd+UPrGbYVBg1qSZ6VaZ/28HH5Y+dB2FsJll+j00NO/4AFZ/R4
 sYir4IVs8afTRW6JZ/UMowb8lryNWogE6eTALGGsGKjzxAm0S6RXyO9hmJ0Ozztj2ZaU
 F05sL3fyVS5pTOynPWGFXcEzgt9cz9022Ry7B/w6W1Xictz6ayTNGIV73Y5G6ZbJnNG4
 TL5A==
X-Gm-Message-State: AFq9FYIdYZ+/6x/bKtawzmG6PCO6IWujOB0yyb+qv7DWRgnc6dj1/WQ4
 upNEGAM4ZeAc6tXordQ6piMSLCTmr3sNOQEn+ofChNxfVjws4O7Gih7jknOuf3kk/Tw=
X-Gm-Gg: AYBFou1wY40tJiH4G2T0SSyU47OFP7BpFHtE9FF6HzuQIMpC3hy7nfZl8AEOa2k1HSZ
 mNRgFzQdQyxvYGgHT9eqOjRQAb2LPo/VHSHEc40dcDkmmImMILL2lg+QCLZRnQpPmW9Bjvr5GEE
 qdNf/7n3Sz4CodGWcHhJTXsC7bgAtfF9w2uqQJBswRjTNULFo8472TX/neK6C0JUfMBxw7IYSI9
 Tb7hypR3Y+jSEPAN623NGYGX/EoeiaHThIgyyuYC2xvLqSWQQAMbRW+O/4+iqpaDqabBJXhPr3e
 lTmQZZI6aPuOSQhksUKmnDf/PKbeONic2mYCbNGLJIvoge3zKvCTD9oq3xel0Ubjr9vafa0Py3N
 AEP+XCj3KbUhru1jKzM+CDdbwygATDepcHc+eirqTicHRLh4qBl3AkoPrYdSUQ18LfiUbCgsPZF
 MTbe1HGvkkvvaD8vR9qYgC9og5AgZtScCK/bhP9Vp3DAOn/HRIF9aFD5lrfoDegqI+kXr4DeUx5
 1pFeOL9IichySAqax9JTxYACM+BxX+mVxjfm9hQha/Z08vj6lX6YJYx5D/RPBnwukbh3hsaiNK6
 8iZ8IHguAy0nbR5DvMY5STjXnULQbEKazHbKjDm7C6WmEP8fge1lppQ62Qg29+EIgV/FZ0x66D6
 AOQmSuIC31xy1HXkBEJ8PbMahhDUwUjcQ2i6WTBisxFSGf4s4
X-Received: by 2002:a05:600c:3510:b0:4a1:dec1:4e1 with SMTP id
 5b1f17b1804b1-4ac1765d674mr209675965e9.22.1793603292436; 
 Sun, 01 Nov 2026 23:08:12 -0800 (PST)
Received: from center.jhjvjihww5qejoy14qwv1cc4td.frax.internal.cloudapp.net
 ([131.189.143.225]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4aa81a896ecsm339616535e9.9.2026.11.01.23.08.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Nov 2026 23:08:11 -0800 (PST)
From: Orgad Shaneh <orgads@gmail.com>
To: dev@dpdk.org
Cc: Wei Hu <weh@microsoft.com>, Long Li <longli@kernel.org>,
 Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org
Subject: [PATCH 2/2] net/mana: fix Rx interrupt enable failing on lock
 contention
Date: Mon,  2 Nov 2026 07:08:09 +0000
Message-ID: <20261102070809.813033-2-orgads@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261102070809.813033-1-orgads@gmail.com>
References: <20261102070809.813033-1-orgads@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 02 Nov 2026 08:22:35 +0100
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Rx interrupt enable and disable take the per-device reset_ops_lock
with a trylock and return -EBUSY when it is held. Every Rx queue
takes that lock on each enable and disable, so with two or more
queues on different lcores the calls collide routinely. A failed
enable leaves the CQ unarmed, and a thread that then sleeps in
rte_epoll_wait() is not woken by the next packet; it sleeps until
its timeout with packets in the ring. A failed disable leaves the
event unconsumed. Applications do not expect -EBUSY from these
calls outside a reset, and l3fwd-power ignores the return value.

Seen on Azure (MANA VF) with 2 queues and a 10 ms epoll timeout:
about 550 lost wakeups per queue in one run, p99 latency 9.9 ms,
and 22.7% packet loss at the higher rate tested. With one queue
there was no loss.

The section under the lock is a doorbell write or a non-blocking
read of the completion channel, so wait for the lock instead.
The device state check is kept, so the calls still return -EBUSY
while a reset is in progress; a caller that arrives while the reset
thread holds the lock waits for that step to finish first.

Fixes: 077ca514d641 ("net/mana: support device reset")
Cc: stable@dpdk.org

Signed-off-by: Orgad Shaneh <orgads@gmail.com>
---
Builds on main (meson -Dwerror=true, gcc 14, rdma-core 56).
Tested on Azure D2s_v6 (MANA VF, Debian 13, kernel 7.2.11), main + 1/2
with and without this patch, 2 Rx queues, 10 ms epoll timeout, no
retry in the application, one 12 s run per rate:

  pps each way   without: loss / p99 / lost wakeups / -EBUSY   with
  25k            0 %     /  8.3 ms /  300 /   913             0 % / 78 us / 0 / 0
  100k           0.047 % /  9.9 ms / 2232 /  7733             0 % / 88 us / 0 / 0
  200k           22.8 %  / 10.0 ms / 2472 / 10093             0 % / 87 us / 0 / 0

With the patch, 400k pps on 2 queues and 100k on 1 queue are also clean.

An alternative that never blocks is to guard these two calls with the
per-queue burst_state gate instead of the device mutex (the reset path
already blocks and drains it before teardown). It is a larger change,
and the dev_state check would still be needed after a failed reset,
which clears burst_state. Happy to switch if you prefer it.

 drivers/net/mana/mana.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/net/mana/mana.c b/drivers/net/mana/mana.c
index 0ea6d9a54a..a25c7590ef 100644
--- a/drivers/net/mana/mana.c
+++ b/drivers/net/mana/mana.c
@@ -449,6 +449,24 @@ mana_reset_trylock(struct mana_priv *priv)
 	return 0;
 }
 
+/*
+ * Like mana_reset_trylock(), but wait for the lock. Used by Rx interrupt
+ * enable/disable, which every queue calls on each sleep and wakeup: they
+ * must not fail just because another queue holds the lock for a moment.
+ */
+static int
+mana_reset_lock(struct mana_priv *priv)
+{
+	pthread_mutex_lock(&priv->reset_ops_lock);
+
+	if (rte_atomic_load_explicit(&priv->dev_state,
+	    rte_memory_order_acquire) != MANA_DEV_ACTIVE) {
+		pthread_mutex_unlock(&priv->reset_ops_lock);
+		return -EBUSY;
+	}
+	return 0;
+}
+
 static int
 mana_dev_info_get_lock(struct rte_eth_dev *dev,
 		       struct rte_eth_dev_info *dev_info)
@@ -1126,7 +1144,7 @@ mana_rx_intr_enable_lock(struct rte_eth_dev *dev, uint16_t rx_queue_id)
 	struct mana_priv *priv = dev->data->dev_private;
 	int ret;
 
-	if (mana_reset_trylock(priv))
+	if (mana_reset_lock(priv))
 		return -EBUSY;
 	ret = mana_rx_intr_enable(dev, rx_queue_id);
 	pthread_mutex_unlock(&priv->reset_ops_lock);
@@ -1139,7 +1157,7 @@ mana_rx_intr_disable_lock(struct rte_eth_dev *dev, uint16_t rx_queue_id)
 	struct mana_priv *priv = dev->data->dev_private;
 	int ret;
 
-	if (mana_reset_trylock(priv))
+	if (mana_reset_lock(priv))
 		return -EBUSY;
 	ret = mana_rx_intr_disable(dev, rx_queue_id);
 	pthread_mutex_unlock(&priv->reset_ops_lock);
-- 
2.53.0

