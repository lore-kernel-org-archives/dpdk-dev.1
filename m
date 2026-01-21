Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51ADEC44508
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 Jan 2026 17:05:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D7C8742DDF;
	Wed, 21 Jan 2026 18:05:51 +0100 (CET)
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com
 [209.85.128.67]) by mails.dpdk.org (Postfix) with ESMTP id D6E2D42DDF
 for <dev@dpdk.org>; Wed, 21 Jan 2026 18:05:50 +0100 (CET)
Received: by mail-wm1-f67.google.com with SMTP id
 5b1f17b1804b1-47f3b7ef761so669225e9.0
 for <dev@dpdk.org>; Wed, 21 Jan 2026 09:05:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769015150;
 x=1769619950; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y4tsiy756vWRsKs3qNlWJrCNI+w8DahDtyb5BwWA3Wk=;
 b=bzjdLQGz4uY7+4HQd8tUi2DeIFxsMuPjXml1jRJJ4BvanK3i6EeyE7mc73xAT8hTWU
 Ygdht/IKGVSvgef3b5LsndYM41zNkC110BxrLNolhIYaNGRoJt/OJwD0AloZqFwgHtP4
 M4ecuBitr2/mYnlejORdsQLVZvF7AtraLxafLUs/Ufki8ga6v/GouLNn9JIcazTJbHHm
 7FhWPQxxkBAoLCJgzq1qE05XLStrGtaBVhQbP+gMDMPxZzu7LiIiJHhLl2ORXVLT42E6
 /r1LsbnytNTqhE9fRs1wFUIBlRsF+NaaUBaEQwxMp30aSPJD61s98YR7eVvq7jI/Faew
 klvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769015150; x=1769619950;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Y4tsiy756vWRsKs3qNlWJrCNI+w8DahDtyb5BwWA3Wk=;
 b=TSONwcm2CH4NDJkTrowVxcvgTUKSJDbYhWmUrhvk+hcqfNSllHqfubuTsHSi9TXpbW
 JIRWxkcSvAJPIzVkpGt2IWVGxUG4LwkRb0JeUYlSFOU2ppE3o3ijC/6z9kpK4hzObrm6
 NPyrFGbgLMnqR4MtUC+Jqj3R8HtYyFY5DVmeuX4f2cfHgxwVqv9VefJOUiLexROT+6tN
 I9FV2/SN8ywPfIprbQrYimVsxCC3z0VbWjUVtvk/f3gu9yM4WlM2y1Uo4Ylsg8e3bfuE
 7N4H/nskdRuUggc0WWtGDorMqm842bSuTc19E40NbsuqS2QD42TKEOYF5ZDaJosrxYFk
 Y8CQ==
X-Gm-Message-State: AOJu0YwG+u/xlMYs6rNj3wEOG3T4U80AsCo/bpI6WfYyj4FcumlDovNT
 GFTAeNbbk8OANiadp77LV0bS+vd6NwibiYB6w911DCAm0HJoku7PH8b1YqKlc2iADG/M9xB9Hfb
 m48/fc8A=
X-Gm-Gg: AZuq6aLN1Hg70m6u0Fb9aynI/BubeqR47BiF6JLDRsgSRVbJOx/bkrD08qwPt4AdVuw
 Y8uBCqTj/A0mCBOobLL3nz3WciVMPV8D7BrXKSDs3SQSmD88IILbhw1Ok9XavxpLULQjx/ul2Ja
 LCgTmAAkzsY3u76aXik1ckXJ919cW7AultTowmj2VNxLU1eHCMxfhwlRdEPOyeZilpK4WLAcVgh
 wIMvNsOmPBHNhVdcZsMKaPYnYdQl2H6neHo1WxXXEUPI62gSK19ZL0hN2Odi1WCtXu4GRv6Pwt/
 QTBTErNRoF8oGXAKZGt43In38Ne5qc9wJfl8/0md9MKKE5pV9qq4re/sh29e/LjnE0wAkBguYoC
 SeybmYhZOHDyxVcRlyzgQGgZwUDyUGzuq/PoPr71Q47URs/XIvGrOybUu2m1g21GB/U7kaKqkxY
 xlPfgZhwFiPnTchVqEnCPWAUYh6rY8odO/LN3IAjCqlHEfa0a4cg==
X-Received: by 2002:a05:600c:3e1b:b0:479:3a86:dc1c with SMTP id
 5b1f17b1804b1-480469fd331mr9623515e9.36.1769015150470; 
 Wed, 21 Jan 2026 09:05:50 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48042c1e381sm25653555e9.11.2026.01.21.09.05.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jan 2026 09:05:49 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 2/4] examples/vmdq: replace memcpy with structure assignment
Date: Wed, 21 Jan 2026 09:04:55 -0800
Message-ID: <20260121170540.785735-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260121170540.785735-1-stephen@networkplumber.org>
References: <20260121170540.785735-1-stephen@networkplumber.org>
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

Better to keep type safety and use assignment rather than
rte_memcpy.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 examples/vmdq/main.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/examples/vmdq/main.c b/examples/vmdq/main.c
index 4a3ce6884c..12ef5bffc2 100644
--- a/examples/vmdq/main.c
+++ b/examples/vmdq/main.c
@@ -17,7 +17,6 @@
 #include <rte_common.h>
 #include <rte_log.h>
 #include <rte_memory.h>
-#include <rte_memcpy.h>
 #include <rte_eal.h>
 #include <rte_launch.h>
 #include <rte_cycles.h>
@@ -151,9 +150,9 @@ get_eth_conf(struct rte_eth_conf *eth_conf, uint32_t num_pools)
 		conf.pool_map[i].pools = (1UL << (i % num_pools));
 	}
 
-	(void)(rte_memcpy(eth_conf, &vmdq_conf_default, sizeof(*eth_conf)));
-	(void)(rte_memcpy(&eth_conf->rx_adv_conf.vmdq_rx_conf, &conf,
-		   sizeof(eth_conf->rx_adv_conf.vmdq_rx_conf)));
+	*eth_conf = vmdq_conf_default;
+	eth_conf->rx_adv_conf.vmdq_rx_conf = conf;
+
 	if (rss_enable) {
 		eth_conf->rxmode.mq_mode = RTE_ETH_MQ_RX_VMDQ_RSS;
 		eth_conf->rx_adv_conf.rss_conf.rss_hf = RTE_ETH_RSS_IP |
-- 
2.51.0

