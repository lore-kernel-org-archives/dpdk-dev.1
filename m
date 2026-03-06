Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1B25F0182F
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Mar 2026 13:31:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DD5B34278B;
	Fri,  6 Mar 2026 14:30:55 +0100 (CET)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41]) by mails.dpdk.org (Postfix) with ESMTP id ED7C44161A
 for <dev@dpdk.org>; Fri,  6 Mar 2026 14:30:54 +0100 (CET)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4836f363d0dso82307175e9.3
 for <dev@dpdk.org>; Fri, 06 Mar 2026 05:30:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772803854; x=1773408654; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4GID3l3YLkEHrFvewdL3jt57nQ8t/3gTJ/Gf1NUDTj8=;
 b=DZAoKv2/PsHmTVYfOEl4MzjlhSpynNkYU/nK5FEEFQLGiopLPC/322cIinAVSmJX/e
 zcnSL4r1nXXGEw68zilu9/tRdM/2xWDk7Ki2lYcAsVAaM/MkYX5lVKng12fLGxi7/1++
 Eyr29vMO0cca9F6K8bp9kKx4oiW7YhIPMAjWcmXie3MEwaJccunfZRDaXf2E4wRjUvFM
 t5o/XW6tlZU17h5vRP/pSi5iTs9KvPImXrAGlNlmQvELNpPCXHPO7qyuLfmaO8EMDkHV
 XG9G4brP7zqp8dmnVrlg1TikhS0k6qYNke1qIVYngk5cMfrZVTGCXOP217fglGg41uRy
 vcQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772803854; x=1773408654;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4GID3l3YLkEHrFvewdL3jt57nQ8t/3gTJ/Gf1NUDTj8=;
 b=XAEFKVwbmOK9sav0T39tiSR1IRQaynSwCD2Bti9mhNFrkOiTJ2JYUqGpCTxPfv9DGW
 cV7JUddgsLp31syAUZdn3HEZZTmt6w0ID1Na2wU8uWQn/4Au5EONzJDyFTHW4sZyLzmu
 gn2EPtw/AICQEvpKE5xsbqDmoXAO7fc5uzDMKIdJjCxJxE+drnIqCMV1JVkUnNXw1qZP
 dJGC853XfxZMXDDTErCw97Fcm5muad8mRukeH90pJMOZAzYYwBEn5P9vH9lqIGyvGxp8
 Ji4BjxmcSG63at5PynEYk0b6Uja19MfUKzuNNJCgGhvFAyT4cUdMnbtbKd/92WVeM+DU
 60Ug==
X-Gm-Message-State: AOJu0YytWq18fDCLqM9n9VtyCuNoeOqV32iWHP3kPxWsoc7pRjkNNjXY
 y08m8Gv3rJ72mGTfEh5kDUQ2+MDjlMk5AMmNcq3U7jUfYeoPM5CKwXrS/yEcMubO
X-Gm-Gg: ATEYQzz+lRvBPv+tFH1mcAYoXOsYL687cREQw3vV3xbZ1/GdaPVJZV30FDplmOY05mQ
 /Blgfvu1PIDa4C5Yk/SJsLX2mzqRZ31Np6o75wr377dbtlhqzLIgsFpXFik0i//eGuNLDqe12z3
 x1U6tHkv/K5v5EVhqhtGE5Q5n7gcIGlc2GO6++DXWHTKCcHyOa+J9pE9udbplyXWExCJ7vr5AT6
 boy2dxob2MXT4O9wyhOa03IgIUt0XqTav3l4C8NuA8QLYnh6sFaA7VrKlutHrjgHNY/TckgVBGE
 65gWvt3GEBfnTezyaadwrMaubLoHZQmDPTG0a3Rx/sHj0EG7KHdW/oiwD1qCWEBwI2Hm8EPWeIT
 3hxflJ+M9DD28imAp12QgTRNPwxZhheVbP+Xs6rsG9h5daG7bUfRMTIVtDQjlhxU9rhIV8Ck40M
 /63hPHFZolylugK1fzvR5t3YJhmz4=
X-Received: by 2002:a05:600c:3e86:b0:483:8f0f:36fe with SMTP id
 5b1f17b1804b1-48526919615mr35489255e9.1.1772803854402; 
 Fri, 06 Mar 2026 05:30:54 -0800 (PST)
Received: from freepad.iliad.local ([213.36.9.102])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4851fad27dbsm97514985e9.2.2026.03.06.05.30.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 05:30:53 -0800 (PST)
Sender: Maxime Leroy <maxime.leroys@gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
To: dev@dpdk.org
Cc: hemant.agrawal@nxp.com, stephen@networkplumber.org,
 david.marchand@redhat.com, Maxime Leroy <maxime@leroys.fr>, stable@dpdk.org
Subject: [PATCH v3 05/17] net/dpaa2: fix link not up after port stop/start
Date: Fri,  6 Mar 2026 14:30:23 +0100
Message-ID: <20260306133035.179709-6-maxime@leroys.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260226143341.282188-1-maxime@leroys.fr>
References: <20260226143341.282188-1-maxime@leroys.fr>
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

When LSC (Link State Change) interrupts are enabled, the link status
is only updated by interrupt events -- rte_eth_link_get_nowait() reads
the cached value without querying the hardware.

During dev_start(), dpaa2_dev_set_link_up() was called immediately
after dpni_enable(), before LSC interrupts were registered. The MAC
needs ~30ms to renegotiate after being re-enabled, so the initial
link query returned link down. By the time the link came up, the LSC
interrupt handler was not yet installed, so the link-up event was
missed and the cached link status remained down permanently.

The issue does not occur on the first dev_start() after probe because
dpni_reset() during probe does not bring the MAC down -- the kernel
dpmac driver keeps the physical link up. Only dpni_disable() during
dev_stop() causes the MAC to go down, requiring a full renegotiation
on the next dpni_enable().

The problem is more likely to occur with many queues: the queue setup
loop (dpni_get_queue for each RX queue) between dpni_enable() and the
LSC interrupt registration adds MC portal round-trips, giving the MAC
more time to complete negotiation before interrupts are armed. This
makes the link-up event more likely to be missed.

Move dpaa2_dev_set_link_up() after the LSC interrupt setup so that
any link-up event occurring during MAC negotiation is properly caught.

Fixes: c5acbb5ea20e ("net/dpaa2: support link status event")
Cc: stable@dpdk.org

Signed-off-by: Maxime Leroy <maxime@leroys.fr>
Acked-by: Hemant Agrawal <hemant.agrawal@nxp.com>
---
 drivers/net/dpaa2/dpaa2_ethdev.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/dpaa2/dpaa2_ethdev.c b/drivers/net/dpaa2/dpaa2_ethdev.c
index 3658e24dd2..e58b93c564 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.c
+++ b/drivers/net/dpaa2/dpaa2_ethdev.c
@@ -1391,9 +1391,6 @@ dpaa2_dev_start(struct rte_eth_dev *dev)
 		return ret;
 	}
 
-	/* Power up the phy. Needed to make the link go UP */
-	dpaa2_dev_set_link_up(dev);
-
 	for (i = 0; i < data->nb_rx_queues; i++) {
 		dpaa2_q = data->rx_queues[i];
 		ret = dpni_get_queue(dpni, CMD_PRI_LOW, priv->token,
@@ -1461,6 +1458,12 @@ dpaa2_dev_start(struct rte_eth_dev *dev)
 		dpaa2_eth_setup_irqs(dev, 1);
 	}
 
+	/* Power up the phy. Needed to make the link go UP.
+	 * Called after LSC interrupt setup so that the link-up
+	 * event is not missed if the MAC negotiates quickly.
+	 */
+	dpaa2_dev_set_link_up(dev);
+
 	/* Change the tx burst function if ordered queues are used */
 	if (priv->en_ordered)
 		dev->tx_pkt_burst = dpaa2_dev_tx_ordered;
-- 
2.43.0

