Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AADDF01832
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Mar 2026 13:30:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7621940E27;
	Fri,  6 Mar 2026 14:30:46 +0100 (CET)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46]) by mails.dpdk.org (Postfix) with ESMTP id 3DAE040DDE
 for <dev@dpdk.org>; Fri,  6 Mar 2026 14:30:45 +0100 (CET)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4833115090dso95267955e9.3
 for <dev@dpdk.org>; Fri, 06 Mar 2026 05:30:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772803845; x=1773408645; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qXccleD8GXH7n5QzG81YO2bJkrRnjdSHWTuWDBXgg4Q=;
 b=c/Rsx+ylXVfmOeNTx1EdTycWdsKD8jcAQE4TYG47nQ2XdOK/qpJLVrO5DJ5FEBiUpw
 sAppZtJeWbHKUfVvI+LnbNVxV8uAR1eTDDiONsUBGbUOU5G+aLXvmMU4mACwoRJ4Aavp
 h+Zezfu+DAHcBKMZG5PAarAwIWOZrEg1sEC4jDAHdA25MPw7PsJYKXlT9w68w4KjZLTf
 AbTFUn6NA+39NnjYL8wIywYqYWac6qkmIShpm8oSFBSyURuKU8P8QZTrOcOjfQGs+j4N
 AsBMkjZTNFTCDfHJncwmzUO/YBx12ozqebS+5MEi723pjYfSyo8XD8Xa95/rZn4aFMFn
 LXTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772803845; x=1773408645;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qXccleD8GXH7n5QzG81YO2bJkrRnjdSHWTuWDBXgg4Q=;
 b=LDA1+NkoEuhh7c7IEe7fEAwjW0mmQpuy7dC0jMT1UKfrunRxz/0wEAHkjB6wXeR8Md
 Nt1EkIaGlVbu4W6LrpVGfK9+5iJl6ALyov010wYsSOYheJoX89RLXUr9rGgwwjv7cPYZ
 ukAj9ZAT6bAamQe2Yq5oVKnV2HCTBS0kEWLULrppyqd6YVyBPCArtKepvQN8vbWHQPKt
 o4ZJNCpOSMJdMXpkal0OCgFj1kmrR89zNdTGPrAW8F5NY4z7pQjndO007/rwUF52c5tj
 ZHYX9vBVxHBIJl45cz6POHmHjJ91SOPZeRnSrt9hGOFGiFognCOk9GTKxzmQ0cdoju+F
 3Mtw==
X-Gm-Message-State: AOJu0YyN8Pjsu3boDaCE0teZV0DQ+fProhuyHRiS4CsdmFAQ1qTNfsBk
 QoWwajt3TJHY9eUPDbom3YRhpiwPnL+QEBMWEwhazbetdGxEHvG6Urkw1qRd3GmW
X-Gm-Gg: ATEYQzxfUQw0M927ai6vy1R1pePrR4S/mfGgqEVFxIk+vAnqYsO6n8sMWwa/woPX/6/
 C1zZZLL/VjgnsiprtRvxYWSPHQtmRy/g3cNJqBdQNb+oVS7Sd/BAiimAL2KwogyTCcQTOoNtOhw
 fXaSjFbyo+Vb1KdXaSSWNcR90FlosKmZUAFLpoZoLxLtfxSL6v/dB4XEWuP2jZw1Cc+UvEAwZV3
 aySilvJpcHf88sGF4sJOMVjgUaXKnGmXhJViyRmcdNxiaOws6q5bdE8Th9d+rxWAZperUBVvqsK
 MvzHcgpV6vd7GnX1JgOKccmJVx4hhCJiHDnmdQpqhbGNU0Fxbci31V2Kd1pXAMWcLjFOards8m2
 /oRlPkdntZdw1kuc7TgQL6c1CO72kk4c9LJK8Jy9l6M3GVCOhuqceLeAPdRJVVYZOytBb8ud8d+
 qiidh0D6JUluEkXw3+fDJo/jwXHk0=
X-Received: by 2002:a05:600c:19d4:b0:477:9eb8:97d2 with SMTP id
 5b1f17b1804b1-48526923b15mr38994095e9.8.1772803844560; 
 Fri, 06 Mar 2026 05:30:44 -0800 (PST)
Received: from freepad.iliad.local ([213.36.9.102])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4852767d8e4sm34668115e9.2.2026.03.06.05.30.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 05:30:44 -0800 (PST)
Sender: Maxime Leroy <maxime.leroys@gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
To: dev@dpdk.org
Cc: hemant.agrawal@nxp.com, stephen@networkplumber.org,
 david.marchand@redhat.com, Maxime Leroy <maxime@leroys.fr>, stable@dpdk.org
Subject: [PATCH v3 01/17] net/dpaa2: fix queue block memory leak on port close
Date: Fri,  6 Mar 2026 14:30:19 +0100
Message-ID: <20260306133035.179709-2-maxime@leroys.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260226143341.282188-1-maxime@leroys.fr>
References: <20260226143341.282188-1-maxime@leroys.fr>
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

