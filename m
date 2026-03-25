Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEC86106B504
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Mar 2026 20:46:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B00F0427A0;
	Wed, 25 Mar 2026 21:46:08 +0100 (CET)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50]) by mails.dpdk.org (Postfix) with ESMTP id B2347427AF
 for <dev@dpdk.org>; Wed, 25 Mar 2026 21:46:05 +0100 (CET)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-486fba7ce4cso2978125e9.3
 for <dev@dpdk.org>; Wed, 25 Mar 2026 13:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774471565; x=1775076365; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c85ZKSJRZIlOYEyxggjXhtmcvA6ik31Gcxf3K4XoefE=;
 b=sAWKSUjhMuiZ65F+rgpWuu6MNxEXCqCuNbLevSdguT7TT7rw4uRwX/u7lxqiRtWQkn
 Cip6Zilggvskw5t+X7xnE5fbxf0HJAEOxLQBqa+8XL05GG9NJegibirLIrFlauaIMQFB
 yIwtSKWLeCSichXuNbxoDqzWojgpRXk1RyVMJrGE4qObxjX034ODLk34vDZ33ZFNDCB+
 lLbWe+KS31a7S9ZgbaHA7XHp2dDTWoUM/8VxTmkWoU+xE3fcjNQx6sPzMt3I3OABxz50
 D5wenvyAcbNvoXgnZ2lq9/l4g6LY2o7JxLqe6SPUGWwRLyKup7av2AQnVXfa3BUMz7FB
 0G0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774471565; x=1775076365;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=c85ZKSJRZIlOYEyxggjXhtmcvA6ik31Gcxf3K4XoefE=;
 b=Srdz8sXe7oUbkMWXDIgb3+E/ikMV7jRCPb0tUKiov7XP+6QRjNSCqiANReww/sz56w
 9yTCuFO7qePNupX2H3E0xIsDypFTwqZiP/6Ln59548syebivMCmozAeqNVom4t+tpqX4
 f0El60px/wVNkFhcBdoLDPmjD/0kp/jliRqRdXi+1Msq/pBr10Sdds2iCt3ySPyWb3ni
 1eelLFKBVyn1OOozCWVl8PJJDBQCd/hnePlPSSMj/rnSf0hrHS033VPU5Z1g8OQZE8/X
 q3jVmEdLKtKTL3nKoxWHIGyjZlaSVFAyU6MGDAlClw98N+F2A17876MekpV4Xpg6eIxe
 PU/g==
X-Gm-Message-State: AOJu0YzPVTYS4o+moJG8X1OwjutkmjTDXrKXKFhxCDydibdMpC0kqpvb
 fuEJXrDzvgAFVfWwrr1uUlE3+u9XgfGCHYYLTyonxEMyNdKUj1WDv7tes/selKyF
X-Gm-Gg: ATEYQzxlp5bJKOgIAUWc4GWjCix2hibw7v03ln7R36zkMy08GJP/LLca0WFkZh/Bz0Z
 3zNOBmWZfTkoPH3pN69oGGrAINjO11p0sdmFZ6T1aePErcLPCoNlh4AasVNLSCtE3Hr91ELq5Bo
 0HVqd6O+9hgaN94ZmKrSRIiF8flJNUkMvcTAKsOQsQ/OZCNRZ373NNLioz/rwtQgyKwxvA/v24j
 txm7wkY2LoufeBkgW290h4qjYFKBBeTj2Al8vMAax3ptFylNRp54u4/n6GZDEva7ZFKO/mA51zG
 Ia0amXwoFg/TH3woofbPuosN4Qr6cVEuGMHM+CUYxh4mnLZ800tCtFUdOUFusf9bidge9WM9UNU
 UCdF8VG0daq3n3lS0G7UGgGz9OLSXrG6z4+uKsMZj5Eo17/qA9Xxw0/4oKlAlH0p6Gzu6zUwnui
 4J6q0xmsN0HsGnLfMwPQ6OiW9yJyc=
X-Received: by 2002:a05:600c:4ed4:b0:46e:4e6d:79f4 with SMTP id
 5b1f17b1804b1-487160083f4mr80482705e9.15.1774471565205; 
 Wed, 25 Mar 2026 13:46:05 -0700 (PDT)
Received: from freepad.. ([2a01:e0a:6f:bdf0:224a:2b64:3d43:500c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4871fbb5a57sm1659785e9.9.2026.03.25.13.46.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 13:46:04 -0700 (PDT)
Sender: Maxime Leroy <maxime.leroys@gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
To: dev@dpdk.org
Cc: hemant.agrawal@nxp.com, stephen@networkplumber.org,
 Maxime Leroy <maxime@leroys.fr>, stable@dpdk.org
Subject: [PATCH v4 05/17] net/dpaa2: fix link not up after port stop/start
Date: Wed, 25 Mar 2026 21:45:32 +0100
Message-ID: <20260325204544.101444-6-maxime@leroys.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260325204544.101444-1-maxime@leroys.fr>
References: <20260306133035.179709-1-maxime@leroys.fr>
 <20260325204544.101444-1-maxime@leroys.fr>
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
index 5e0a897ed3..cae81d3a20 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.c
+++ b/drivers/net/dpaa2/dpaa2_ethdev.c
@@ -1392,9 +1392,6 @@ dpaa2_dev_start(struct rte_eth_dev *dev)
 		return ret;
 	}
 
-	/* Power up the phy. Needed to make the link go UP */
-	dpaa2_dev_set_link_up(dev);
-
 	for (i = 0; i < data->nb_rx_queues; i++) {
 		dpaa2_q = data->rx_queues[i];
 		ret = dpni_get_queue(dpni, CMD_PRI_LOW, priv->token,
@@ -1462,6 +1459,12 @@ dpaa2_dev_start(struct rte_eth_dev *dev)
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

