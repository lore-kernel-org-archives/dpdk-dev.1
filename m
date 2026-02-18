Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86C32E9A02C
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Feb 2026 16:05:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8E9AC402F2;
	Wed, 18 Feb 2026 17:05:01 +0100 (CET)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44]) by mails.dpdk.org (Postfix) with ESMTP id 7E7324014F
 for <dev@dpdk.org>; Wed, 18 Feb 2026 17:04:59 +0100 (CET)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-480706554beso54152545e9.1
 for <dev@dpdk.org>; Wed, 18 Feb 2026 08:04:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771430699; x=1772035499; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eTHCsNKUWZmbYWO7Nfjz7k+vTTJK7hhUL+/ELi981Ds=;
 b=Qd8T0nRElHUhgNQ1JJYtYojMAyksGqd3kX7tO0Um/5n1fMW8ICB2pAJw+Z9fAFDRxb
 N3KVy0LDMxeRHwdSrg5tCda4ylHe+KBuHStFiA1xdR6APIYDjM1Y7xUIf2JThmpMMabV
 t+VlvzFmacreGmlU+u5Z1lEaVNknrB2rwOl7YNyEPqEKfIWL/NaOh95Msap/V236ebur
 JzgTSDK7yU36POu0BRiEDyWu2nl3urymZp5OnnELj2TegZEO9FaL1xbr/LgnQiyCWvWu
 nQQsrzIwEkXmsgMsW9rxM5h9p4yvhWiXsvAiVzo1YCeUFZiOHx6V8mZIccFbVwI//k3u
 GYBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771430699; x=1772035499;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eTHCsNKUWZmbYWO7Nfjz7k+vTTJK7hhUL+/ELi981Ds=;
 b=a0Cl456gBkYlnqsTkEYONDU9Xh2sqN6Ymnb3d1nF6DW6B5sx+RyDmJTH96HGb6wB68
 5fHeynXiuA/UDt/VTgfQNPlyaboEcsr24VzEyKK4zpE2/REQR9x618wGxcU4ZTTvHD5d
 bgEo5qhiScfzI5D7207BUyoZAz/40vcVePz3dycqA14+hdTCUjKAHs4V7/Px1qyFurUg
 XxvI6z+hkfj+ziJfzE7xprWzVbIhxY7hV1AgGQ1XAAqmSeneZVqnCLXrOCT9IAJnlwAE
 mfdM0vDqrsn7Td5pH4jcPg2eKAYAQjwNcSaQU4+ymHz1XaGKRH3RK/v8Pf2vJEFDEBkh
 A4sA==
X-Gm-Message-State: AOJu0YzM0AFWgczi+UXtbuE34NS8jkV9+KgRn8f1kzrCBCWOsMMOYdc5
 clQiGjD8k0yCjPM7tQ51esxS1TLkgdrt4lHoMG6JTx9Nu5Jth1F2Mv82
X-Gm-Gg: AZuq6aLoiJNb6SlENU3EWX78eeZzhP4coMrLmrC4KCbid0J/V0ybWRE4l5Mo3AsdZ/K
 AGbmOjKiB5sRPaJkqdeBCApoEZ/dE2TCS0yaoGFx+ctMK0+emnZSV+Z12QiP+HNFABcrQuNaAPk
 8BLZNTRYGktVQ6sUt8dcaOYVTSUcFpnBGMYUUkFBVe6Ix6FaZnAOvWOrdkkMs0Kv2OI0MtcFdsH
 UVkRykUu0eah56SGFTHH7qvQk/faCCt69pmMZgoG334GjNJFzNnVb2LJl6AewIAFj1eKjAedvJV
 rnlhgrvprWoNAv6eZSKV7GcAaRIwxN2VY28EwPFpzC88DKHIHYRr1srImkbE+1NnC/cxgY/y7MT
 0s9g6zl/JfhHH3HaZxneAxpXlcqyTlMIYoSjjWScKx6qHyd3QN6fxSipV/s3gAZGJwk3rHTql+T
 wJBEAQCGEL8kke78mnsrCAPZTWXA==
X-Received: by 2002:a05:600c:37cc:b0:477:58af:a91d with SMTP id
 5b1f17b1804b1-48379b93370mr251509105e9.5.1771430698915; 
 Wed, 18 Feb 2026 08:04:58 -0800 (PST)
Received: from freepad.iliad.local ([213.36.9.41])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4835dd0e327sm604619175e9.14.2026.02.18.08.04.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Feb 2026 08:04:58 -0800 (PST)
Sender: Maxime Leroy <maxime.leroys@gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
To: hemant.agrawal@nxp.com
Cc: dev@dpdk.org,
	Maxime Leroy <maxime@leroys.fr>
Subject: [PATCH 01/11] net/dpaa2: fix queue block memory leak on port close
Date: Wed, 18 Feb 2026 17:04:43 +0100
Message-ID: <20260218160453.142311-2-maxime@leroys.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260218160453.142311-1-maxime@leroys.fr>
References: <20260218160453.142311-1-maxime@leroys.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Commit ae2661c3ea2d ("net/dpaa2: fix queue free cleanup") added
priv->rx_vq[i] = NULL inside the cleanup loop. This NULLs rx_vq[0]
on the first iteration, so the subsequent rte_free(priv->rx_vq[0])
becomes rte_free(NULL) — a no-op — leaking the entire mc_q block
(all RX + TX + TX conf queue structs) on every port close.

Save the base pointer before the loop and free that instead.

Fixes: 46d02eeaaeb8 ("net/dpaa2: fix queue freeing")
Signed-off-by: Maxime Leroy <maxime@leroys.fr>
---
 drivers/net/dpaa2/dpaa2_ethdev.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dpaa2/dpaa2_ethdev.c b/drivers/net/dpaa2/dpaa2_ethdev.c
index b3a79f18d3..cef819650b 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.c
+++ b/drivers/net/dpaa2/dpaa2_ethdev.c
@@ -661,6 +661,9 @@ dpaa2_free_rx_tx_queues(struct rte_eth_dev *dev)
 
 	/* Queue allocation base */
 	if (priv->rx_vq[0]) {
+		/* Save base pointer before the loop NULLs rx_vq[] entries */
+		void *mc_q = priv->rx_vq[0];
+
 		/* cleaning up queue storage */
 		for (i = 0; i < priv->nb_rx_queues; i++) {
 			dpaa2_q = priv->rx_vq[i];
@@ -691,8 +694,7 @@ dpaa2_free_rx_tx_queues(struct rte_eth_dev *dev)
 		}
 
 		/*free memory for all queues (RX+TX) */
-		rte_free(priv->rx_vq[0]);
-		priv->rx_vq[0] = NULL;
+		rte_free(mc_q);
 	}
 }
 
-- 
2.43.0

