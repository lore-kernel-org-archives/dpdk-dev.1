Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C17DCE92FDA
	for <dpdk-dev@archiver.kernel.org>; Mon, 29 Dec 2025 20:49:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EED0E40667;
	Mon, 29 Dec 2025 21:48:43 +0100 (CET)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46]) by mails.dpdk.org (Postfix) with ESMTP id 9812A40659
 for <dev@dpdk.org>; Mon, 29 Dec 2025 21:48:41 +0100 (CET)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4775ae77516so93505555e9.1
 for <dev@dpdk.org>; Mon, 29 Dec 2025 12:48:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1767041321;
 x=1767646121; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PnyqqAR4lxNz2L/jcPUa3d1OVH/z/Sw4mH+pS117ZWk=;
 b=sYho6jG+K85otSVOZsJHlIGiyH74oSNUmR4oXt+11eKT0uFlbcWIwNoBOtrA2v+Ktu
 gDFe2qL5B5XLD/3ch6z9ZpIWgohTnf114RJucV78sRHFbNqO1HE9mLDaM8iMFQSq4Ig9
 opIMEpVFWotDfnMIyjVY9ys521/X9j0wSoopunZXjQXjk9toWMWMWB6b8D7DTAbuIzBY
 dHVRbtNPP/vMyIWg9s1cdGls4y70IFPY/iuQrP7cTKBt9ttPrDcmBdB4I9cIG4aZnEX3
 iJmaKETZJpx8jYTu2IjiBD6YsMB3vMFJ056YGYZpjCv9WnIMibuZu9xW9SXQtrGK2Jl5
 X6EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767041321; x=1767646121;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PnyqqAR4lxNz2L/jcPUa3d1OVH/z/Sw4mH+pS117ZWk=;
 b=eFi9yYR4lJKb0Yh1VtynauxNhyZnw9ulw1JS9NzaN8Ta1SvxCBKs1+GXB911IUV3o5
 AqRiARVjo0Hbhy6BIDO3ehsIVBefYWmX7RdJZQzk1p784Vt3fjvUs/8aLclknoO/2/rJ
 TwbjCVem6JjuPXks2KujzRvHKLvOksqkR/rZlQHMn8TDBgn8+irrgm3hU1PaJWSxtqu5
 BwDI5bPFXfNaF+Za73iR7cM9qMB1I8hQVhCrtxjLLfBrF9kI7a2DaLxyZ9XtAxfvz/iY
 PecqChXzeCkdTTUWc+01+TyIqGzR1Bvm/6ZPYM450bfHpg905XJTTR0QrIcn8Aqz8qjC
 5ChA==
X-Gm-Message-State: AOJu0YwH5HdfgBfQ2Dzcdtc/c/PrNb2XrZ/FZU8pwb+J3BPMyjyX97xI
 K+kCJ7W+Kf5dNOtQIaopWylrERv6jTxFLtZG01K734X5UCPWlEUYAaQnMQAYoaNrtMFUivQqxLc
 oc/MvRcY=
X-Gm-Gg: AY/fxX4Eo4BHQBS+EfSP/srDIZX0xFBZaP15NJQVLYhzfPgx7yAT+LCepj6dICStnON
 H03C//mAzVoaSJnSILqcan48+piFCVM4g9OZIeXviZsMJFI91S5ShvhhhdY4R6/VgM09kemCWqH
 7rFskWrdJWWtcC6hCwENWiohHdNzsM1gURdlQr7HRLRAbtxKKeiJPolz3NsgQQW7dPMGhIDfawY
 ywFs7WOMd1NZKZGm8xXloZS4GmV+6uIkUarXBDJmxTUwQ66AZyGgLCKnZPhsIWB0ULpzsn5HpvL
 6D3IA1qBzxSNpR/E5qsvG7cDfpi3YRIsTWzU7svGnixjEh6l+jFeIwE2LrhqOMxYJwdc/zlw92v
 Tsh6TVJQ+QwDgF57znrJZ/5u7LBXGJ8s17MoHlSNWQUCBxBWT5x0FketUwR5GM8VXZeEDcBMgNh
 tY2e18c2LRtZgj1W9hgD5ZcstoDEY/v2r/Vf9HG40zvkD9ImkQ7w==
X-Google-Smtp-Source: AGHT+IHc5YAHQ9Sah2366oL/XD8ABt9dXcr8vYLT7FnWLXR/3nreB1FkdyjWAt5nhohVV7YBNmUoxA==
X-Received: by 2002:a05:600c:310e:b0:479:2a3c:f31a with SMTP id
 5b1f17b1804b1-47d1956eb70mr374693295e9.1.1767041321189; 
 Mon, 29 Dec 2025 12:48:41 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324eab2c4fsm64676298f8f.42.2025.12.29.12.48.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Dec 2025 12:48:40 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>
Subject: [PATCH v9 08/18] eal: warn if thread name is truncated
Date: Mon, 29 Dec 2025 11:38:06 -0800
Message-ID: <20251229204818.61231-9-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251229204818.61231-1-stephen@networkplumber.org>
References: <20251202172626.283094-1-stephen@networkplumber.org>
 <20251229204818.61231-1-stephen@networkplumber.org>
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

Thread name is very short 16 characters and therefore the name
dpdk-worker-%d will overflow with more than 9999 worker cores.
Error should be non-fatal since name only matters for debug.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 lib/eal/freebsd/eal.c | 6 ++++--
 lib/eal/linux/eal.c   | 6 ++++--
 lib/eal/windows/eal.c | 6 ++++--
 3 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/lib/eal/freebsd/eal.c b/lib/eal/freebsd/eal.c
index 6215245ad5..beda7e0c5c 100644
--- a/lib/eal/freebsd/eal.c
+++ b/lib/eal/freebsd/eal.c
@@ -690,8 +690,10 @@ rte_eal_init(int argc, char **argv)
 			rte_panic("Cannot create thread\n");
 
 		/* Set thread_name for aid in debugging. */
-		snprintf(thread_name, sizeof(thread_name),
-				"dpdk-worker%d", i);
+		ret = snprintf(thread_name, sizeof(thread_name), "dpdk-worker%d", i);
+		if (ret >= (int)sizeof(thread_name))
+			EAL_LOG(INFO, "Worker thread name %s truncated", thread_name);
+
 		rte_thread_set_name(lcore_config[i].thread_id, thread_name);
 
 		ret = rte_thread_set_affinity_by_id(lcore_config[i].thread_id,
diff --git a/lib/eal/linux/eal.c b/lib/eal/linux/eal.c
index b12f325ddd..d848de03d8 100644
--- a/lib/eal/linux/eal.c
+++ b/lib/eal/linux/eal.c
@@ -863,8 +863,10 @@ rte_eal_init(int argc, char **argv)
 			rte_panic("Cannot create thread\n");
 
 		/* Set thread_name for aid in debugging. */
-		snprintf(thread_name, sizeof(thread_name),
-			"dpdk-worker%d", i);
+		ret = snprintf(thread_name, sizeof(thread_name), "dpdk-worker%d", i);
+		if (ret >= RTE_THREAD_NAME_SIZE)
+			EAL_LOG(INFO, "Worker thread name %s truncated", thread_name);
+
 		rte_thread_set_name(lcore_config[i].thread_id, thread_name);
 
 		ret = rte_thread_set_affinity_by_id(lcore_config[i].thread_id,
diff --git a/lib/eal/windows/eal.c b/lib/eal/windows/eal.c
index 21fe7cb1d9..8b539f8601 100644
--- a/lib/eal/windows/eal.c
+++ b/lib/eal/windows/eal.c
@@ -378,8 +378,10 @@ rte_eal_init(int argc, char **argv)
 			rte_panic("Cannot create thread\n");
 
 		/* Set thread name for aid in debugging. */
-		snprintf(thread_name, sizeof(thread_name),
-			"dpdk-worker%d", i);
+		ret = snprintf(thread_name, sizeof(thread_name), "dpdk-worker%d", i);
+		if (ret >= (int)sizeof(thread_name))
+			EAL_LOG(INFO, "Worker thread name %s truncated", thread_name);
+
 		rte_thread_set_name(lcore_config[i].thread_id, thread_name);
 
 		ret = rte_thread_set_affinity_by_id(lcore_config[i].thread_id,
-- 
2.51.0

