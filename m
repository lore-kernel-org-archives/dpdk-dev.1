Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C303C9EC90
	for <dpdk-dev@archiver.kernel.org>; Mon, 12 Jan 2026 13:53:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 36A6D402EA;
	Mon, 12 Jan 2026 14:53:31 +0100 (CET)
Received: from mail-wm1-f98.google.com (mail-wm1-f98.google.com
 [209.85.128.98]) by mails.dpdk.org (Postfix) with ESMTP id 985CE40156
 for <dev@dpdk.org>; Mon, 12 Jan 2026 14:53:29 +0100 (CET)
Received: by mail-wm1-f98.google.com with SMTP id
 5b1f17b1804b1-47775fb6cb4so35287125e9.0
 for <dev@dpdk.org>; Mon, 12 Jan 2026 05:53:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=6wind.com; s=google; t=1768226009; x=1768830809; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=V7D3dbHaVBGkAtBDbY1V4VnFT4XGSuCJhwN4COWpSAU=;
 b=JgUOk0foWrphU5sTEk9yPLMj2HnnFehDMrG4iRCkYiR7Q+h7FoB+AUvqCoOr4MUeXV
 qiwqrGpsJKfxE8YQqh2IHKWMdWFgL8rsxRpLy3cHy9//VLvXDjHXq+cJa7or/cH4LE+Z
 0njtrKuVdXFAZvDcHR8zEbFctzGcem1T0FzE38x8kNDjwomGaUBd20tzpIMnO/Yhvxla
 o1WYqUNo0ntd4cXH/NbjCyn8Yl9Kn8xhPoM4cfWwV+EisFSS31I/8CH0KOwpU8Qz8h9Z
 JvfhjCLMCeYFW4H+0MGxuaMoae/Dpi/tzpX3i6Opxl7l/5EV4CmuRqG4AdSAB+e1+8vk
 xD0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768226009; x=1768830809;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V7D3dbHaVBGkAtBDbY1V4VnFT4XGSuCJhwN4COWpSAU=;
 b=CpK1Mn+69RCNtx8dLk+gLWs1JG+qvhTqW13IsUrW54ohYAP/PM7jFAvdHeotySyKxJ
 Ds71M3xvRGwZGpwlkUpMXCPWaBj0cxrgmr0uJ1xWgcasxNs9o7J1Q/Qs6TMK45906M46
 8A80yprObK8UjZAjddz4zSMnZzMearp1Wx0o1/jdo3DYIvmMoR61PbK6t4GqxWoaqvlF
 uLJWx3l5ijF8+aGJbvoxR+ZVagvFC1b1+QzOAEwJL9LjGElGzysds9udU5/NVc6zPfzg
 GBS3+2WVySOu+tECwLyYjVkBeMIW4KLNezL/AQy8WtppTHE1NT8nObdXfb1tvTNi7stS
 DLeQ==
X-Gm-Message-State: AOJu0YxOMTBd3jFvLqDsGBsUMFuvZR1bsl29Vx1BfArhhs6uoWuLF5tY
 4JbSaHKN8ydVktkcTss8PmQpMLi3ZT4JWAR8ecwKrSuy+kRxqkEGC+s3Um7pUEekZmeySw2BEFw
 D/vmn5JsK4qwVVAePuMrxZ8kQ09x8xz/PjLshxTF+ndk=
X-Gm-Gg: AY/fxX61DOHRV7yYRo0nYWzXCFgo7B5246afOvJSYWFPpdyJpWh7de7sWLYtYrc/Ubq
 K1zz5oyZ8ega02oKRI0W24yO/hdWBg80iOGjaUK/gvKcmYcSCQORF6g2gcOiRp3znLY4UmEYzqE
 2kyBdaJog5ZltKgEKWgFjNI+rSFForT+aT46Hwrca5/B5shlsqv3bdfWlVk88nmhAXozfcc9IuL
 Uc5ogYjOk/EcvrF95nUSQF1e8spZfpEN8qWoW8wMeNDL7x9cn6+Pca35qWfElxYBfEmZ8jcgYdu
 7f+Czq9aCADc+3na2jDEuzpfP8J3jrNXVMTJFYcOEa93lISsJ8xbUceATPp+T3kNWbX3nT/4LQp
 IIHkhyrk3Y0rLrFZEMa22gRP7AA33ORkve8QshPihgFZYX6FmcXg3RPInaNzmalbh
X-Google-Smtp-Source: AGHT+IEzRoc599hLj7L0Y7r4QD35oxp1xh+E4MrjEN+KySH7atuw6O3092VVBJjFzKW/jSPVjxvb9qrMm1Xg
X-Received: by 2002:a05:600c:3e8f:b0:477:5897:a0c4 with SMTP id
 5b1f17b1804b1-47d84b0b315mr191388775e9.4.1768226009059; 
 Mon, 12 Jan 2026 05:53:29 -0800 (PST)
Received: from smtpservice.6wind.com ([185.13.181.2])
 by smtp-relay.gmail.com with ESMTP id
 5b1f17b1804b1-47d7f3bfbbcsm31969625e9.2.2026.01.12.05.53.28; 
 Mon, 12 Jan 2026 05:53:29 -0800 (PST)
X-Relaying-Domain: 6wind.com
Received: from localhost (vader.dev.6wind.com [10.17.1.39])
 by smtpservice.6wind.com (Postfix) with ESMTP id B4D181D4FE;
 Mon, 12 Jan 2026 14:53:28 +0100 (CET)
From: Thierry Herbelot <thierry.herbelot@6wind.com>
To: dev@dpdk.org
Cc: Thierry Herbelot <thierry.herbelot@6wind.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>, stable@dpdk.org,
 Olivier Matz <olivier.matz@6wind.com>
Subject: [PATCH] net/intel: update key_len when getting RSS key
Date: Mon, 12 Jan 2026 14:53:11 +0100
Message-Id: <20260112135311.2507243-1-thierry.herbelot@6wind.com>
X-Mailer: git-send-email 2.39.2
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

When adding the i40e PMD, the rss_hash_conf_get function was changed to
update the RSS key len.
The corresponding functions for ixgbe & e1000 were not updated to
follow the new convention.

Fixes: 8a387fa85f02 ("ethdev: more RSS flags")
Signed-off-by: Thierry Herbelot <thierry.herbelot@6wind.com>
---
 drivers/net/intel/e1000/igb_rxtx.c   | 1 +
 drivers/net/intel/e1000/igc_ethdev.c | 1 +
 drivers/net/intel/ixgbe/ixgbe_rxtx.c | 1 +
 3 files changed, 3 insertions(+)

diff --git a/drivers/net/intel/e1000/igb_rxtx.c b/drivers/net/intel/e1000/igb_rxtx.c
index cdd7a3338f61..d5c2bc013702 100644
--- a/drivers/net/intel/e1000/igb_rxtx.c
+++ b/drivers/net/intel/e1000/igb_rxtx.c
@@ -2042,6 +2042,7 @@ int eth_igb_rss_hash_conf_get(struct rte_eth_dev *dev,
 			hash_key[(i * 4) + 2] = (rss_key >> 16) & 0x000000FF;
 			hash_key[(i * 4) + 3] = (rss_key >> 24) & 0x000000FF;
 		}
+		rss_conf->rss_key_len = 40;
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
index a7583c178a14..a2c5ffe0b3b0 100644
--- a/drivers/net/intel/ixgbe/ixgbe_rxtx.c
+++ b/drivers/net/intel/ixgbe/ixgbe_rxtx.c
@@ -3756,6 +3756,7 @@ ixgbe_dev_rss_hash_conf_get(struct rte_eth_dev *dev,
 			hash_key[(i * 4) + 2] = (rss_key >> 16) & 0x000000FF;
 			hash_key[(i * 4) + 3] = (rss_key >> 24) & 0x000000FF;
 		}
+		rss_conf->rss_key_len = 40;
 	}
 
 	if (!ixgbe_rss_enabled(hw)) { /* RSS is disabled */
-- 
2.39.2

