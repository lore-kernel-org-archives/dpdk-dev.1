Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81D23106B504
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Mar 2026 20:46:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6CF94427A3;
	Wed, 25 Mar 2026 21:46:04 +0100 (CET)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42]) by mails.dpdk.org (Postfix) with ESMTP id 979514279A
 for <dev@dpdk.org>; Wed, 25 Mar 2026 21:46:02 +0100 (CET)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-48558d6ef83so2599555e9.3
 for <dev@dpdk.org>; Wed, 25 Mar 2026 13:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774471562; x=1775076362; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DWsny5NaAZW8DUf/+mybIx996nDiIL8Gg1OVc/eKHtU=;
 b=aOuQ+7NzYDNTqqCJDrOBQhfdUjNk9f8ILrYIAlPsAUzzVKn6CsxqwI8UJzjLWDnWdA
 VGkScFO3CIb3l+JGi+e+Rb9boFSmpbJx8GF1MgfpoRplAFTSQPDpWkdfGoGoIDtTcLXw
 5075DYPGCryew64NGj8h7calLsgUhF7ZMjCfPFGnoTz2CGp0Xr63DuKbT/fZejSFj+yc
 SC/p+H6o7SKsKw1+cW+KroaNogbAyu8anqiSX+0GpV3vr180bZUgg4HO80vCZo+ofJBX
 +gVOdtmOzV60+U14H8MrioS4cpM5QR7hSA5Np5rvvMgYiCwgbvCKlkInsSsIeiFH+a2J
 XBEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774471562; x=1775076362;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DWsny5NaAZW8DUf/+mybIx996nDiIL8Gg1OVc/eKHtU=;
 b=O7RUbAno6EsbzoXND6MnXM1/7lRa6HQscJOmZCFdsMHUjLgmy4Q/8WBhsQFF732WLS
 P8HxS9eMGUOEA1mAbMY5HztOJbqodG3Bbj+PqPvgln+qWmjeh22CWlvQ9GRO9TDTK1Rs
 MawUUHISLwA5SNL3Z6w6ER3sALEzkxKQQYL52vJn+6pt610jM0Emav/yJu6+oKCewSUj
 StrwrL72MPP/dKG0cHVV64QoiqbJaxHty5ROiQcTVafRJG8W/qu8xZBKuDWGMFb4kmgx
 4Sjr0+aTiwnCJ4fyEqCFTeIqyRqoCCmI6p4SrP+kngmfH9CyY9Uq0XuFWxcQB2lecCBp
 QCww==
X-Gm-Message-State: AOJu0YwNjmiOnq7Fnm58/zWkx+keJLBJ2EiHY/3y+cpzVyUohGbF3Nc2
 ZzuaqTYMM0BhhC3uo0nt9AdvHT0Ge8LJezqAyaM3QBWPmyfeY81epz9YACMZeTbS
X-Gm-Gg: ATEYQzzJIgKraxBgeCxXXo3JHG5NUCDsFU6aASdlKZp0RX6uzU6uPDhbUKuYrcTDT8F
 NRAUCHXoOuNz6Jut9hPVaf3Y4D1/+vI3o3v1vbOG1jnFFeTA4lwHNeVJXqCz10Pxk2VxI+GglwO
 ovDTX+lHKDSQegxv5q4l7ASiZg/40ZBwt5DOlE4EI8y90iuyOnQ8LeHYsuaV4a9rtmicL9PXl49
 m8iWwOEn16g5PeD+93j5g/hRVBZKCh7iqH1QxvALvqaK4LeoRtzLDhN+PFzbvtKsO/j74doxJhW
 FI1tZaK2ipWdtG1p78g5MozIja475gJaW12dgkSfqfpHUTrOkWXnZ6WyBXctnLiBjwmmJcdiCGa
 7JtRfohsz8THybZgmqELWyWA0Dl27vVJ243CnbEVvDKg3ljZVxyQw3OOd4aMLLj8I9nytbq0zYJ
 LtR3tQoy+FrSajMbPr
X-Received: by 2002:a05:600c:5020:b0:486:fc61:541f with SMTP id
 5b1f17b1804b1-4871606c94bmr76016665e9.29.1774471562137; 
 Wed, 25 Mar 2026 13:46:02 -0700 (PDT)
Received: from freepad.. ([2a01:e0a:6f:bdf0:224a:2b64:3d43:500c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b919cf2bdsm2301439f8f.21.2026.03.25.13.46.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 13:46:01 -0700 (PDT)
Sender: Maxime Leroy <maxime.leroys@gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
To: dev@dpdk.org
Cc: hemant.agrawal@nxp.com, stephen@networkplumber.org,
 Maxime Leroy <maxime@leroys.fr>, stable@dpdk.org
Subject: [PATCH v4 04/17] net/dpaa2: fix resource leak on softparser failure
Date: Wed, 25 Mar 2026 21:45:31 +0100
Message-ID: <20260325204544.101444-5-maxime@leroys.fr>
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

When soft parser loading or enabling fails during probe, the error
path returns directly instead of going through the init_err label.
This skips dpaa2_dev_close() and leaks all resources allocated during
probe (queues, MAC addresses, extract params).

Fixes: 72ec7a678e70 ("net/dpaa2: add soft parser driver")
Cc: stable@dpdk.org

Signed-off-by: Maxime Leroy <maxime@leroys.fr>
Acked-by: Hemant Agrawal <hemant.agrawal@nxp.com>
---
 drivers/net/dpaa2/dpaa2_ethdev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dpaa2/dpaa2_ethdev.c b/drivers/net/dpaa2/dpaa2_ethdev.c
index 605c75ad70..5e0a897ed3 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.c
+++ b/drivers/net/dpaa2/dpaa2_ethdev.c
@@ -3165,7 +3165,7 @@ dpaa2_dev_init(struct rte_eth_dev *eth_dev)
 		if (ret < 0) {
 			DPAA2_PMD_ERR(" Error(%d) in loading softparser",
 				      ret);
-			return ret;
+			goto init_err;
 		}
 
 		ret = dpaa2_eth_enable_wriop_soft_parser(priv,
@@ -3173,7 +3173,7 @@ dpaa2_dev_init(struct rte_eth_dev *eth_dev)
 		if (ret < 0) {
 			DPAA2_PMD_ERR(" Error(%d) in enabling softparser",
 				      ret);
-			return ret;
+			goto init_err;
 		}
 	}
 
-- 
2.43.0

