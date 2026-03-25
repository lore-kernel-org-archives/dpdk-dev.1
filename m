Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B69C106B504
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Mar 2026 20:47:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3F4B3427AB;
	Wed, 25 Mar 2026 21:46:33 +0100 (CET)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42]) by mails.dpdk.org (Postfix) with ESMTP id CFCA5427D7
 for <dev@dpdk.org>; Wed, 25 Mar 2026 21:46:27 +0100 (CET)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-48334ee0aeaso2446815e9.1
 for <dev@dpdk.org>; Wed, 25 Mar 2026 13:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774471587; x=1775076387; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NZnXC80T+aJdgu4mNfhhi99ZiA0JAVSD0Bpz1w31txw=;
 b=jqePklsyiqQxMqvfGFrilZ5evg/kyWt2pqunRsst3GfIlNO7txe9F7OyGvGDrSAoRD
 YMbdAR9fyI6PasP0ZvtZfpIUmbW5QcZR5jnpwlUhrw9CYTTnoE08fYjoYCyuGcyF0xij
 53FQDhFzVZjsnq+ngvOGDZFNlU7KMyKyDmQZuR+OgLBODeugeFKH2wKbvWXIgfChKLph
 Ud8BWj4RfCc7EKhiui0HXWZnD9k7iXJcRL6MIMO+lZVKs9mtcYakQ1Yx7alSNkMRRFUg
 9wS01tPFiAH+vKrWlhzCO2keV5QgERJXdDjyghcHEQWLnEP7C2MJu8NSt19RRaOKYPP7
 z1wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774471587; x=1775076387;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NZnXC80T+aJdgu4mNfhhi99ZiA0JAVSD0Bpz1w31txw=;
 b=P2DcjwxGuqeWMjHMaaCZiqlPhsTgvEnmvN6TZH0eAOip1HW9pZQKsc0zz6HaE87tuW
 JWsG0VFcZQUcRbTphlqeV7cTV618xtXtLGPOT2QP9R29Kp30yXzZ4BvDIQj+LivnIwHi
 fSOtJ7omqWAKzAZKYGfCxBBoc8HU93OASI8iyn9scEY43Hc8J9eicmyw/L2Cli+7K6by
 amYSGdJIINw+7a20pxasYFrX32HvTx5tlLePqPnFH/jG4QlGEuOZ8n4YHEebSIwoSx2s
 UzFmrlGBq63LVRj19LOZNQhtbySRXOdLZHwzUI0eGPpXuFhmbjFxvLmZYcuRGkatqsCo
 +xHQ==
X-Gm-Message-State: AOJu0Yw6YSwIDaTCHuAubVr6vRPv1LsP3Np8qfdw9JVAvPxvXpsLLWJG
 vJalhUdxSs/Jq6Bjkahf6gz0QRLymz7xBy6ifl7VXrOcQKQHjHSYEB0pqx2e2Q==
X-Gm-Gg: ATEYQzxyS9zqN2t+1MFH+3PrQ1SRTku4KmBN+YImRZO8hXa8xavCEvplkfM75wzDdSj
 CnZPqVXKyPyPiq8SMp2sgN5kdPww6/rbN8foRAbQN0+fxu9mom2hPqre9U6kDLgieoWfb6uyP6D
 7+WplwbxotRP3d18wYHYUkSvbLuN1J/WQPG+X97nabtpOkprNmPQllcpnt/0nzCEVYMYXunDAkd
 DcO41H90pRvCkif/Lym09O6V6O2NgoTD3NLYSgiNwTNscRgS5xNOCK4GK4L+82cOI7Gm9rv3wSC
 MduekNK64v1mpAtpGk9RSTOs0qg99lhrisD6RgEObg9GzJmn5qVwICkPgYaiIRfsoaUNCWiFgQb
 6O3FpT6GCgviZyGgZ3vPhk0TudqVXDUmeBWxjrIwz003vI8MKWCqsfVgsUD0dZ13mI6EPKThzYS
 ObwP0QOP75SIVvRhIn
X-Received: by 2002:a05:600c:8489:b0:485:6e40:5584 with SMTP id
 5b1f17b1804b1-48715fc38femr71744935e9.6.1774471587248; 
 Wed, 25 Mar 2026 13:46:27 -0700 (PDT)
Received: from freepad.. ([2a01:e0a:6f:bdf0:224a:2b64:3d43:500c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4871fb3c2besm8381345e9.8.2026.03.25.13.46.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 13:46:26 -0700 (PDT)
Sender: Maxime Leroy <maxime.leroys@gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
To: dev@dpdk.org
Cc: hemant.agrawal@nxp.com, stephen@networkplumber.org,
 Maxime Leroy <maxime@leroys.fr>
Subject: [PATCH v4 15/17] net/dpaa2: use check interval macro in link down path
Date: Wed, 25 Mar 2026 21:45:42 +0100
Message-ID: <20260325204544.101444-16-maxime@leroys.fr>
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

Replace hardcoded rte_delay_us(100 * 1000) with
rte_delay_ms(CHECK_INTERVAL) for consistency with the rest of the
driver.

No functional change.

Signed-off-by: Maxime Leroy <maxime@leroys.fr>
Acked-by: Hemant Agrawal <hemant.agrawal@nxp.com>
---
 drivers/net/dpaa2/dpaa2_ethdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/dpaa2/dpaa2_ethdev.c b/drivers/net/dpaa2/dpaa2_ethdev.c
index 9c384f6430..3091077269 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.c
+++ b/drivers/net/dpaa2/dpaa2_ethdev.c
@@ -2306,7 +2306,7 @@ dpaa2_dev_set_link_down(struct rte_eth_dev *dev)
 		}
 		if (dpni_enabled)
 			/* Allow the MC some slack */
-			rte_delay_us(100 * 1000);
+			rte_delay_ms(CHECK_INTERVAL);
 	} while (dpni_enabled && --retries);
 
 	if (!retries) {
-- 
2.43.0

