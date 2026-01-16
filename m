Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD94BC2A06C
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Jan 2026 13:54:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8B39642E1C;
	Fri, 16 Jan 2026 14:54:45 +0100 (CET)
Received: from mail-ej1-f97.google.com (mail-ej1-f97.google.com
 [209.85.218.97]) by mails.dpdk.org (Postfix) with ESMTP id B98C042830
 for <dev@dpdk.org>; Fri, 16 Jan 2026 14:54:44 +0100 (CET)
Received: by mail-ej1-f97.google.com with SMTP id
 a640c23a62f3a-b8765be29d6so297176066b.0
 for <dev@dpdk.org>; Fri, 16 Jan 2026 05:54:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=6wind.com; s=google; t=1768571684; x=1769176484; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FXy+Wb6HZh3WZrnibL8e+yyhQzgE3q0Lk/Dgobqj0B4=;
 b=MYJjE2QiCMnvbWGGMaJUrh4KEyS/P0c5ykJKE/XYioXwZK8JHRxEN/rgrU7ltI7ek1
 NIeXl1NGxaSIzljP7AlhL7rSXw9ZVG4etkpvHN5vfmfg0KIZRwFoMP/bfOpb7ZyzVbPS
 N1vrPd5q0LId/6YMrPgOR9Sy6jsKVN4NSjLPQ1jfct3M7CC/cea+j3AsJXGxpbiomVVA
 mIGSC1Yxz35sEtl51uxmZGYlT8m5iBSGYSlcY/6lLCWmwZlNQjxORaw6sqGU0zm66stH
 qsYnHng/isG0DjQp3oqdzzppWrbqtTmzk1bjubgbjLLhe1LggujYhAqs6D6UHcrmq3wz
 O7EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768571684; x=1769176484;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FXy+Wb6HZh3WZrnibL8e+yyhQzgE3q0Lk/Dgobqj0B4=;
 b=k44yU+0x+XZ8ewhqlwGW6Zhe1Oa8U/Rz6u1fXbWeZy9P+FaznpIoyY7jomf5TbO2tH
 /MAIr03P5LpiYZNvREqVoLfgagF80lERlwACgGS1x16dRvzXygBC/O+lXGqSS/aNt5Ag
 xAebW+2feh9yKFyZgBN8+FzVW+tzT41VJu2aHPSLlShsUkXxMx0cGNsngNRmYhcr8WHC
 1/jE6Quq2SUOPkzYwM5w78EkDdvulNtxM0UJTXj8aIkHn9zETWOoHzUUkIKZg84IcKHq
 7gqXW2LZwMAWwQf8564u3ThXPYvmvLnvHfAhuXoRXfqeYzzAmhxmgfoNnc2zrzgGwrsG
 LsqQ==
X-Gm-Message-State: AOJu0YwPU9lQ55ctRGTgxSjPkzV6E+7SFi9BT3x1MjBl9C8b1RfETTsU
 EFT5k1UBt5J66edyQn9T4QNvBRtNtecQPRcFwcLVAyUkSaiBl3txUXi6eLn7s7zXKhiI1XAwB8J
 +ugEhx9KwxkKd52uyfml9MJg2WapIEqCqYGkrqy1vyx4=
X-Gm-Gg: AY/fxX5s5LpuoBxZ38w0pETKRI6ileWZ+R35V1t4JjctM4FKDl9riteNb9O5Ax4NS+D
 ZazjIDnYpUnBJwyUI9ZS1ug4ZKXaEAWyu/V+upeSiA48b1vQRXIXbDnddSExR5ktF7zqcKjCQIq
 chcEIrs3/HvGmUsw5romtPKk4MwvlRtl7T0RmJo8LjRWfUDZRohNCUZZPgffyeL5IOuUhieSMSC
 ouQFQKj1iz9rAkVGvw8LgpbVu1kM8Te89zIRO4aGWDjgX9bfJXcD68YtCfmC9gy5MRFEUgpMhBu
 CiuYTNiJRMEUgPYsrMGt3Azkz3YWVvhZ9c6p2OhqEbw9DWkw0f2LS0kAHLGQzVoINAXpr1hPSES
 mL+VLCIu7tc7PULcioo77NGwfvqHKAiUOv7LoFBHOYGUAwrrV5iNqYtGUhOy8l0fl
X-Received: by 2002:a17:907:9484:b0:b83:15cb:d4cf with SMTP id
 a640c23a62f3a-b8792f51456mr245679266b.29.1768571683977; 
 Fri, 16 Jan 2026 05:54:43 -0800 (PST)
Received: from smtpservice.6wind.com ([185.13.181.2])
 by smtp-relay.gmail.com with ESMTP id
 a640c23a62f3a-b8794f93cb0sm29374066b.0.2026.01.16.05.54.43; 
 Fri, 16 Jan 2026 05:54:43 -0800 (PST)
X-Relaying-Domain: 6wind.com
Received: from localhost (vader.dev.6wind.com [10.17.1.39])
 by smtpservice.6wind.com (Postfix) with ESMTP id 9DD341FDCA;
 Fri, 16 Jan 2026 14:54:43 +0100 (CET)
From: Thierry Herbelot <thierry.herbelot@6wind.com>
To: dev@dpdk.org
Cc: Thierry Herbelot <thierry.herbelot@6wind.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>, stable@dpdk.org,
 Olivier Matz <olivier.matz@6wind.com>
Subject: [V2] net/intel: update key_len when getting RSS key
Date: Fri, 16 Jan 2026 14:54:35 +0100
Message-Id: <20260116135435.3463443-1-thierry.herbelot@6wind.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20260112135311.2507243-1-thierry.herbelot@6wind.com>
References: <20260112135311.2507243-1-thierry.herbelot@6wind.com>
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

When adding the i40e PMD, the rss_hash_conf_get function was changed
to update the RSS key len.
The corresponding functions for ixgbe & e1000 were not updated to
follow the new convention.

Fixes: 8a387fa85f02 ("ethdev: more RSS flags")
Signed-off-by: Thierry Herbelot <thierry.herbelot@6wind.com>
---
V2: For igb & ixgbe, a hard-coded integer is replaced a symbolic constant.
---
 drivers/net/intel/e1000/igb_rxtx.c   | 3 ++-
 drivers/net/intel/e1000/igc_ethdev.c | 1 +
 drivers/net/intel/ixgbe/ixgbe_rxtx.c | 3 ++-
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/intel/e1000/igb_rxtx.c b/drivers/net/intel/e1000/igb_rxtx.c
index cdd7a3338f61..14b28588174f 100644
--- a/drivers/net/intel/e1000/igb_rxtx.c
+++ b/drivers/net/intel/e1000/igb_rxtx.c
@@ -2035,13 +2035,14 @@ int eth_igb_rss_hash_conf_get(struct rte_eth_dev *dev,
 	hash_key = rss_conf->rss_key;
 	if (hash_key != NULL) {
 		/* Return RSS hash key */
-		for (i = 0; i < 10; i++) {
+		for (i = 0; i < IGB_HKEY_MAX_INDEX; i++) {
 			rss_key = E1000_READ_REG_ARRAY(hw, E1000_RSSRK(0), i);
 			hash_key[(i * 4)] = rss_key & 0x000000FF;
 			hash_key[(i * 4) + 1] = (rss_key >> 8) & 0x000000FF;
 			hash_key[(i * 4) + 2] = (rss_key >> 16) & 0x000000FF;
 			hash_key[(i * 4) + 3] = (rss_key >> 24) & 0x000000FF;
 		}
+		rss_conf->rss_key_len = IGB_HKEY_MAX_INDEX * sizeof(uint32_t);
 	}
 
 	/* Get RSS functions configured in MRQC register */
diff --git a/drivers/net/intel/e1000/igc_ethdev.c b/drivers/net/intel/e1000/igc_ethdev.c
index b9c91d2446c0..9f6ada3bc6cd 100644
--- a/drivers/net/intel/e1000/igc_ethdev.c
+++ b/drivers/net/intel/e1000/igc_ethdev.c
@@ -2559,6 +2559,7 @@ eth_igc_rss_hash_conf_get(struct rte_eth_dev *dev,
 		/* read RSS key from register */
 		for (i = 0; i < IGC_HKEY_MAX_INDEX; i++)
 			hash_key[i] = E1000_READ_REG_LE_VALUE(hw, E1000_RSSRK(i));
+		rss_conf->rss_key_len = IGC_HKEY_MAX_INDEX * sizeof(uint32_t);
 	}
 
 	/* get RSS functions configured in MRQC register */
diff --git a/drivers/net/intel/ixgbe/ixgbe_rxtx.c b/drivers/net/intel/ixgbe/ixgbe_rxtx.c
index a7583c178a14..e830bb9495b8 100644
--- a/drivers/net/intel/ixgbe/ixgbe_rxtx.c
+++ b/drivers/net/intel/ixgbe/ixgbe_rxtx.c
@@ -3749,13 +3749,14 @@ ixgbe_dev_rss_hash_conf_get(struct rte_eth_dev *dev,
 	hash_key = rss_conf->rss_key;
 	if (hash_key != NULL) {
 		/* Return RSS hash key */
-		for (i = 0; i < 10; i++) {
+		for (i = 0; i < IXGBE_HKEY_MAX_INDEX; i++) {
 			rss_key = IXGBE_READ_REG_ARRAY(hw, rssrk_reg, i);
 			hash_key[(i * 4)] = rss_key & 0x000000FF;
 			hash_key[(i * 4) + 1] = (rss_key >> 8) & 0x000000FF;
 			hash_key[(i * 4) + 2] = (rss_key >> 16) & 0x000000FF;
 			hash_key[(i * 4) + 3] = (rss_key >> 24) & 0x000000FF;
 		}
+		rss_conf->rss_key_len = IXGBE_HKEY_MAX_INDEX * sizeof(uint32_t);
 	}
 
 	if (!ixgbe_rss_enabled(hw)) { /* RSS is disabled */
-- 
2.39.2

