Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BE83FCE08C
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Feb 2026 14:34:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7349D40658;
	Thu, 26 Feb 2026 15:34:08 +0100 (CET)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50]) by mails.dpdk.org (Postfix) with ESMTP id C7CA14026F
 for <dev@dpdk.org>; Thu, 26 Feb 2026 15:34:04 +0100 (CET)
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-4398f9e3b40so900101f8f.1
 for <dev@dpdk.org>; Thu, 26 Feb 2026 06:34:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772116444; x=1772721244; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qXccleD8GXH7n5QzG81YO2bJkrRnjdSHWTuWDBXgg4Q=;
 b=G6pr6cEcr17Dq4VNH8AxTkuMAknQfOqb0HibD6KKqjipurgNi5F722iJH1ukOFql4p
 zJgBPFFC7YBNPdBzudm6+QC6zPezzHuMd6dra8y0g1ECRU0w1xckcYjznRD+FxQiy/WC
 8cwNAjuQjeQBX1uefFwqDHz5mFP2TBI3RHMmwqLNkeB7IdmzmMzh5av0zfQyYnzqTwzf
 XPNIM+Ud2a3A+oIYDkrELi1YBPuxQqo94rvJn4nu5lOTnC8J71odc3nivDXfAHtA3FbJ
 KoBsVaeAUCbYlNgwaIi4AbH47OWPJMtzMKVep8LMk3ozhtZaOkq9ARXc6KFfcKpHRpXh
 nf3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772116444; x=1772721244;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qXccleD8GXH7n5QzG81YO2bJkrRnjdSHWTuWDBXgg4Q=;
 b=nr6unj1u2UjNVrLgwc25nD1jAgrUW2ZBWmsIb2SF2bVpqSSuimc4uZnekf8RX9c/mw
 xhQJ4M0rGJ8IGp8Sj21C8WZIRSYSevxDeOzf9xzk8GDd2eRPuswV9FYqDAveDT4nRaJ/
 TsFOG1jIOvBXVos2hQKpvYO+Rnxj71wcm4k7hZgPOPrM6GHCag0VcsTug87kLSg9zx5B
 2KuczbbsLWhRX72Q8Tt+Gdo75VrjxkaioTCQNypHJjwB3eRQGdLdU9W+7zKYuri5Vi5i
 QFl+fVz9ecG43K4ufNcJ26mB0YlBB5nHfOu5kFwH+IElyaa2RbqXoOTMfTzRyx6zOXQ6
 ZJkA==
X-Gm-Message-State: AOJu0YzAcpcF4GcAvmoDOBFc3tN+9zfAPnDj7gpPHOE/UGVDPQ8J3XBR
 8hyPOrLUnUhpAwUqRCxxsDpg/srqlwCXI5o8B1nQ3pFbn9z8BzW9HtGbBH4O3A==
X-Gm-Gg: ATEYQzzGo4q6nLpmr+REe57OmO8b49F8L7z/+cm2v6r5jNkA8FNwCaTzT82Qa7KEENS
 F0eCeD1A8E3DLx31Nxi1Y5RIKcGwnAcy0PuGlEJ/lwva/5O/QVzdnHheXNQuDzhDdost9wZn76g
 nKk7fg//637J2va6KMf7tm8dO+tAxDdGDi3hvO6qZBX3kVG/QuNorghwVaLEPyVTChNHRhTwdff
 WBwt9wWR13jB3Adb0tYSDdLxwgHwbFT/wsaGGEpGSYOoKE59DxLy/RA7vlKglltdf7tH54DXDuu
 y9uajGqcK/dW5Uv+2j0NAfSVKHtvW4iU70plrhM5Cas9rR5PL8i8A/y6ShRGHQYFs9tJEyLuPrq
 geHlUP09pzD/Soacs1ePLeeoQhyy0T9R9qZdGJ0kETh1HfD8xYhAnrxRAGZvrLrEo1+mJ7K5ZQW
 8ZSdK/94mSAhjPx8HBZvhGC5vTnA==
X-Received: by 2002:a05:6000:288c:b0:439:9465:906d with SMTP id
 ffacd0b85a97d-43997f3ee06mr4698133f8f.44.1772116444177; 
 Thu, 26 Feb 2026 06:34:04 -0800 (PST)
Received: from freepad.iliad.local ([213.36.9.96])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4398bb96b90sm17993866f8f.9.2026.02.26.06.34.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Feb 2026 06:34:03 -0800 (PST)
Sender: Maxime Leroy <maxime.leroys@gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
To: dev@dpdk.org
Cc: hemant.agrawal@nxp.com, stephen@networkplumber.org,
 david.marchand@redhat.com, Maxime Leroy <maxime@leroys.fr>, stable@dpdk.org
Subject: [PATCH v2 01/17] net/dpaa2: fix queue block memory leak on port close
Date: Thu, 26 Feb 2026 15:33:25 +0100
Message-ID: <20260226143341.282188-2-maxime@leroys.fr>
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

