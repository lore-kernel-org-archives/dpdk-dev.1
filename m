Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0179FC5DF7D
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Aug 2026 19:30:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D277C40696;
	Fri, 21 Aug 2026 21:29:33 +0200 (CEST)
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com
 [209.85.215.180])
 by mails.dpdk.org (Postfix) with ESMTP id A677240DD3
 for <dev@dpdk.org>; Fri, 21 Aug 2026 21:29:31 +0200 (CEST)
Received: by mail-pg1-f180.google.com with SMTP id
 41be03b00d2f7-ca97d139d5fso1239547a12.0
 for <dev@dpdk.org>; Fri, 21 Aug 2026 12:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787340571;
 x=1787945371; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=W6ydOYIKLRPPhXmRJxYXbDfp18Mna0EX1gbJAC1l4+E=;
 b=YRDubnBW5boHiOLd3AMhkoEzeiHdb0uQqj0JvEo0Dv1kwOuYmyM3IM1RX8bvlyK0NU
 Uvbd+Lm7/ZSs8wh7Gs3e8KsGuq/7nlxJe2vwj8Wfvr0OrrPfFINPI9Ug9mUcKtTHa/ba
 eMlfyiX1WhN9esjUwzzbDb9+TvUj9uJmKp093mPoAjIn4EGsvNI3kNnMKIm+qFTJ6V32
 JKamc6JmGYVgbYgGbn4/c6SC+M7fWAE2dzfbin36k8P8lU+ktK3Hx1zBVNX9c8HMxEiN
 w3y2/ozB7wTIetU9QTtT9ANFzr3b08dlNCbTrljQc1yYNb6GS6gxFAZLXNQoW5+Rm0+Y
 gsYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787340571; x=1787945371;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=W6ydOYIKLRPPhXmRJxYXbDfp18Mna0EX1gbJAC1l4+E=;
 b=Afxv3yM1Iwaumrl+OXnHKD12L4uodr8uOdUbkxkDohmNI+kIv1Y/Y2yKS55tx/dKCC
 xfn+Kvi/j+8Xn9y8HLoP58niKkIFO1vqvNnz3009QT7TfuDoCLyWfV227+qybzYuQj9u
 r6tLMzMhHE0mm6AIMwbLcDaVsH7m+PVIW73vLqjGG3FnKwPkoZ0iz/DTf5uhYPdhKTgP
 G0Ryj45QKPY+OhK4FSbkSJKIvw1j338dJEWU7q9x1y73cxC2ld8GPwmKJ2nDgtNkem0F
 DCm5xU1zT9jWS4iDI5YS1INmLdN86k9A3JaYzbc63m3jIUEZbbCB4pb0JEuQAR8YDZnO
 Zvow==
X-Gm-Message-State: AFuF++lSscdl6vU6n2oz8fCjsXVU18+DwUYebwOyh1GdcXMTeCl3FTRy
 KM310nZsqAQ+8rOyLIcpnVNenorh5VCXTy/B97bUpuOxc3qYv9/YREV6QwdFkennQ9MoKO7JX+I
 aZbT6
X-Gm-Gg: AR+sD13BmUrJI5ObQ7cO2zneeB2v/bt69Q/iN5rfDmSXQuGAzGl59gAjtb4KGjsXfM1
 hT66yxmwfC2wzT47OwLImVqhlGk1nY+ymG++I1xKGm5VKpY/2+e0HPT3+CQFVQxeSpKpeQYaMGu
 gGR7eTQ1wjZ19tgHEGFcXnwQ4w98vJCnQqkgXvBSwQyYpOtRPh17r1SVt2DlP6nKAh50cjp3Zxx
 u9hdwBlDBHuHuLU22oOyP+rauFFu0o/MJlfnk5NoXpPJVPzec8nsKfgoZhIj9tDUtlre/zvd/iS
 JUCAF1MtGthRjLck6JlKxqEf0V/ETCiA8jJ1m+RrybAQ7C0znbmSzMJbxUbfvH+z0ehm/IVjjnk
 c5O/5dZVkxCe0DuYC+9SJI4LYStjHkpCKewem37MgV66ojnxhEGzAvelfVMfkwgCtm9Y1L+o20p
 7J7ODtQPBkvIz5HSViJHd9cUHPhgYJzu4fXaRoXp4dZ+tzoHLMbj5Cmk87RNJuZhnfrPSONQ3vE
 JK+gmMQWySy+hXbj+KKRJrSY5bRWldfM1KULg==
X-Received: by 2002:a05:6a21:3511:b0:3bf:6acf:2940 with SMTP id
 adf61e73a8af0-3cd30060d76mr18882880637.11.1787340570919; 
 Fri, 21 Aug 2026 12:29:30 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc16c6dd2f4sm1860304a12.17.2026.08.21.12.29.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 12:29:30 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Selwin Sebastian <selwin.sebastian@amd.com>
Subject: [PATCH v2 26/68] net/axgbe: replace use of rte_memcpy
Date: Fri, 21 Aug 2026 12:24:21 -0700
Message-ID: <20260821192646.146382-27-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260821192646.146382-1-stephen@networkplumber.org>
References: <20260820052251.1453273-1-stephen@networkplumber.org>
 <20260821192646.146382-1-stephen@networkplumber.org>
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

Don't need rte_memcpy for fixed size value.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/axgbe/axgbe_ethdev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/axgbe/axgbe_ethdev.c b/drivers/net/axgbe/axgbe_ethdev.c
index 61725d55ca..edd16dbaab 100644
--- a/drivers/net/axgbe/axgbe_ethdev.c
+++ b/drivers/net/axgbe/axgbe_ethdev.c
@@ -599,7 +599,7 @@ axgbe_dev_rss_hash_update(struct rte_eth_dev *dev,
 
 	if (rss_conf->rss_key != NULL &&
 	    rss_conf->rss_key_len == AXGBE_RSS_HASH_KEY_SIZE) {
-		rte_memcpy(pdata->rss_key, rss_conf->rss_key,
+		memcpy(pdata->rss_key, rss_conf->rss_key,
 		       AXGBE_RSS_HASH_KEY_SIZE);
 		/* Program the hash key */
 		ret = axgbe_write_rss_hash_key(pdata);
@@ -642,7 +642,7 @@ axgbe_dev_rss_hash_conf_get(struct rte_eth_dev *dev,
 
 	if (rss_conf->rss_key != NULL &&
 	    rss_conf->rss_key_len >= AXGBE_RSS_HASH_KEY_SIZE) {
-		rte_memcpy(rss_conf->rss_key, pdata->rss_key,
+		memcpy(rss_conf->rss_key, pdata->rss_key,
 		       AXGBE_RSS_HASH_KEY_SIZE);
 	}
 	rss_conf->rss_key_len = AXGBE_RSS_HASH_KEY_SIZE;
-- 
2.53.0

