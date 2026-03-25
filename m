Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE1B6106B504
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Mar 2026 20:45:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8772B42794;
	Wed, 25 Mar 2026 21:45:57 +0100 (CET)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com
 [209.85.221.45]) by mails.dpdk.org (Postfix) with ESMTP id F2D5B42790
 for <dev@dpdk.org>; Wed, 25 Mar 2026 21:45:54 +0100 (CET)
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-439fe4985efso153710f8f.3
 for <dev@dpdk.org>; Wed, 25 Mar 2026 13:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774471554; x=1775076354; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I6WKXZA4MPJgBwk+2Nivgk+zA3/11IWj2s+KQ25fULw=;
 b=XdS6Bu5bcRwDexYY0Gn4jOB6E36x2P38xRL9DF7pX9U8hLmdcKG3kW/f4HTBqXUiph
 ADlZ2Za5BgaQgA6bu+Yzn/L2PUQzkgTTHDJVGjnKL/K06tEtrQrCIzJ+Ea3uDszw7439
 fu2N79TL+E1FSMIhi1OwyJICzN9vjWMgrnBB8ZH9EOCCPOh734BoxFVv6dF/M1l8L+K4
 aUiYbzbGAo7I8oDn88IDYvogWvmTPMddrPEZ9Q7OC0plNRBvY3QmPxcqMlv+kiCIZykB
 4zYzDNkRtLmHWqmdfzzHh5cTHbyFxyassblPfogV7+Shsoy9M8+kfyKysP+ZXmd/um8V
 ooxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774471554; x=1775076354;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=I6WKXZA4MPJgBwk+2Nivgk+zA3/11IWj2s+KQ25fULw=;
 b=jkryJmV3+AU407ixZJfat8GSah+1Df0kPfY2RLMb7aeDbhmJoTgscIUKG/o/8x2UZq
 CMR3OxGLsf6US5F7X2rsc3HBbko9WS2D8jl+etxMbeCyo1BV+xrjumP5hRdPuBGt8KAS
 HF4BG+hpx1Sx0WODbjC6jhzpss+7MYyjyh7VFkelsIMSEaOx46j7b8s/Wz3+MZspYNDd
 mzYJ6jITf+uKl70JiKr+AA+1RthaFqBCVP644KsgBI3h1xPGXUdWhfChZhhV4T39Tw9V
 3HKYz9uhY9ugrAJPpfKsSLN44Zi38cCZL+qpleQNj2S31O5jxUQUE2U30j6L2hlLYI4m
 32cw==
X-Gm-Message-State: AOJu0YyImpvkJvOgTAW0m0CMAoZRwprt0jsS38AoKNCG1jDDHvRZqTe/
 MdXQLdyiU9GgEkYc/zvMyGXB9W4VZ1CH3Zqm7pHzvDKn0kG9V3Cb8iR1gjU2ZevC
X-Gm-Gg: ATEYQzzkc7gU2IDHIZPML4ddycn2h6Ofyb6ubYbdXxhokzUDldZZrwr45n8ekE6ZFLd
 l49DV+agLwJhAhCm7zWep8NQAqve5lNvZi0l7GybvS6olsk/gsatIGGDjmeoh9+XDHHDaoNM96M
 7brd+xV2YTwE9/KtCAzaMS8uhdLXxPCcpU4nHVmLpOJ8hUkX2OhfXUlh2kbgdiXH7MDkEJuuDiL
 LwKUJBXdAVb7vwcA+kezTMdpB2YtI5MfsBzUMS2yI1Vg9HSOYxA+eXFPaExRYigcbSpGqeZ0tUF
 E1vyBcUuvWEW7xlQnb789Qx08mlfsPmBGWA+9+hc1pPp/3EPyegSfIXXhCZC5muwaqdRglUW0+H
 xxaLXZgttAW6gM12wXqxSLI24J9zV7VqwW07rOQfQwAEOPU4KRFHCYG3sa94orGnw/sSz2TxOLX
 sMPApIBeel9lmqga9OykzyNlwhY0E=
X-Received: by 2002:a05:6000:2287:b0:439:cb5f:8395 with SMTP id
 ffacd0b85a97d-43b889a8773mr6962358f8f.16.1774471554376; 
 Wed, 25 Mar 2026 13:45:54 -0700 (PDT)
Received: from freepad.. ([2a01:e0a:6f:bdf0:224a:2b64:3d43:500c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b919df903sm2357006f8f.30.2026.03.25.13.45.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 13:45:53 -0700 (PDT)
Sender: Maxime Leroy <maxime.leroys@gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
To: dev@dpdk.org
Cc: hemant.agrawal@nxp.com, stephen@networkplumber.org,
 Maxime Leroy <maxime@leroys.fr>, stable@dpdk.org
Subject: [PATCH v4 01/17] net/dpaa2: fix queue block memory leak on port close
Date: Wed, 25 Mar 2026 21:45:28 +0100
Message-ID: <20260325204544.101444-2-maxime@leroys.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260325204544.101444-1-maxime@leroys.fr>
References: <20260306133035.179709-1-maxime@leroys.fr>
 <20260325204544.101444-1-maxime@leroys.fr>
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
Cc: stable@dpdk.org

Signed-off-by: Maxime Leroy <maxime@leroys.fr>
Acked-by: Hemant Agrawal <hemant.agrawal@nxp.com>
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

