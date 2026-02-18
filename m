Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE010E9A047
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Feb 2026 16:05:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1F2074066F;
	Wed, 18 Feb 2026 17:05:13 +0100 (CET)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47]) by mails.dpdk.org (Postfix) with ESMTP id 4F2E640653
 for <dev@dpdk.org>; Wed, 18 Feb 2026 17:05:09 +0100 (CET)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-4806ce0f97bso53935e9.0
 for <dev@dpdk.org>; Wed, 18 Feb 2026 08:05:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771430709; x=1772035509; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=19Tdnu/pklRcSg7QOMg8K5SAwk1CBVRyFwk2G3FOn1I=;
 b=gDq7xuqFXRjfAt5XqCR4Ww4d3VM09bS+02Sj+A0BkYUkiQ+6GyT8+fWzKjOGLAwGzm
 i+6O0CFirXCI9kjHVM+4MTtsjo1NioGAAKRkOJHOi5sK2WZW07KcRK3zaYL3a05QwW9M
 iUYHjnhJBciXRJGbRwew0sZS+Wj3wy78I3cIQuJn5Vg89OOpgHAhNyKDk9+2Qu58ID+s
 MsBWcOrJl2GcxWWHH67sUTZqHLEziWdKUX9MTf4YHs5o3KLv2/wiV1DJp5PeS5ahnJkh
 J+vT0nMxOgT15ao3glbFURHhTrI4QK/hJQ0ME7fOBAPIdxLYU5dL31BhVtlDOgUeeoiE
 kMYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771430709; x=1772035509;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=19Tdnu/pklRcSg7QOMg8K5SAwk1CBVRyFwk2G3FOn1I=;
 b=v1h7sk+6L9q5d9Qv2M5WSNiOpJcNmIkOpDDMMgIgyYRdjIt6YgWTlQFlXMr87ZbVa6
 DqjSeU1yTf106hxn1KwpNDeQTX6uc09SIshy5O/ESkHqZAvCYhTNRpvxbeBAI00wYSXD
 8ifEMEB8Ew28TvUtOiyH8SZ4sxp7Ifry+lGH2yVF681KC9QWd6dUEPL/w7c/c/t4hYqx
 oc25I7di0UycndeJdepQwMRMc2rFX4UDixrq4hJzlisZPY5ud1kzv1EAs8QhJNEZT+VI
 mvzvO6fzO2r5R6lNwH3tk4uMtRCsSjAi0DbWgy1/KRcVwFvdCK8JxgcqqWv449fbFl45
 kw4A==
X-Gm-Message-State: AOJu0YxYjqWxZNPSBwrLpQs3sF8st87UJVqpVII7hSEJ4Mw0MDK3dlTl
 w9Y46VauO+M3MY+HJFpaqAIdDixeYTsxDOgZITvb/MI/xv8Rb6S6fRIO
X-Gm-Gg: AZuq6aLqpNH0eRBytZ5MRUfPsGNyIHPRomRu3zpYn6aKVXW2Elp0Kv1m4+vCfb23Enf
 AgpEj+ZsXJqo6Jm3W/pHJyOeOLJtX3d3GOYtw+gV5w7+uEkKS2NVuKjhyLVrOdAp9Z3QzccmcgN
 G1bTqXAVmLtilpP0psTmD/cYKqtecTvX09cKuyFV8LtySyKe+g9Ed+rVJBdQSB9j5xjTsNUqKxD
 bo+MkFI6skmVmgYq46r775q7JZPZCtCSbD5qE8Hs6Nm5WZxCf/XETCl62DF/wLEmsYL5lMkP5Qi
 I0aKZYKloSFchDehw0OjQ7Tx32vE/aBr4aiEpkkXCRT8cZ8Yvwq8bvD9ywjIztb6VoBTp6HbbHp
 D2oLY7xfWtAkRGlM9rUWxqcIKRLNUf6aNDsS950oKog/TRNu5CdsQv9cDyw2m3fW3Foa5IaEkOO
 5pFPIDeTBYTkpvQFYp/4DYzsC+kw==
X-Received: by 2002:a05:600c:1d1b:b0:47b:e2a9:2bd7 with SMTP id
 5b1f17b1804b1-48398ad716dmr38389005e9.19.1771430708503; 
 Wed, 18 Feb 2026 08:05:08 -0800 (PST)
Received: from freepad.iliad.local ([213.36.9.41])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4835dd0e327sm604619175e9.14.2026.02.18.08.05.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Feb 2026 08:05:08 -0800 (PST)
Sender: Maxime Leroy <maxime.leroys@gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
To: hemant.agrawal@nxp.com
Cc: dev@dpdk.org,
	Maxime Leroy <maxime@leroys.fr>
Subject: [PATCH 08/11] net/dpaa2: fix link not up after port stop/start
Date: Wed, 18 Feb 2026 17:04:50 +0100
Message-ID: <20260218160453.142311-9-maxime@leroys.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260218160453.142311-1-maxime@leroys.fr>
References: <20260218160453.142311-1-maxime@leroys.fr>
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
Signed-off-by: Maxime Leroy <maxime@leroys.fr>
---
 drivers/net/dpaa2/dpaa2_ethdev.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/dpaa2/dpaa2_ethdev.c b/drivers/net/dpaa2/dpaa2_ethdev.c
index 0a68365de2..885f43de19 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.c
+++ b/drivers/net/dpaa2/dpaa2_ethdev.c
@@ -1393,9 +1393,6 @@ dpaa2_dev_start(struct rte_eth_dev *dev)
 		return ret;
 	}
 
-	/* Power up the phy. Needed to make the link go UP */
-	dpaa2_dev_set_link_up(dev);
-
 	for (i = 0; i < data->nb_rx_queues; i++) {
 		dpaa2_q = data->rx_queues[i];
 		ret = dpni_get_queue(dpni, CMD_PRI_LOW, priv->token,
@@ -1463,6 +1460,12 @@ dpaa2_dev_start(struct rte_eth_dev *dev)
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

