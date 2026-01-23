Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E6C7D6CFBB
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Jan 2026 04:30:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 555E3402D3;
	Fri, 23 Jan 2026 05:30:01 +0100 (CET)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45]) by mails.dpdk.org (Postfix) with ESMTP id 75721402E6
 for <dev@dpdk.org>; Fri, 23 Jan 2026 05:30:00 +0100 (CET)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-47d59da3d81so18375095e9.0
 for <dev@dpdk.org>; Thu, 22 Jan 2026 20:30:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769142600;
 x=1769747400; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c85AU4P1C3tQ1LXq/w3KTTyJ+OfMU3cUrzEHUq9+fYQ=;
 b=cqtq4GHchAPKNdkg02WgTVoM5DktxXUhPq+uCD2F5sOaKQNG3mRPkHPhk60c2Ti0TJ
 Ap2tUAhEQFfed1M4d4WzaH9Hkaw412rs1yn8yUuopu5JSKvLv7r4afNTYENPFDnC/I/9
 /25g4ZCskxexWv4uNUchj97z8m2vUItBxEdUMF1De5M3zpaN5CbozFelaBL7JKMSmdrn
 x2ltxO8trgcT0maDumsZ4NSY2tUPtoPTqbqmg3XxC5jsOiTuDJ006qt05tBglBFcxp47
 WcuKleT1MrDsrN3leLdFBglnSU6y7pGmA8unvaLV/9nVJ9zxgAjJBjHy8V/U1ONUJ7La
 1pDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769142600; x=1769747400;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=c85AU4P1C3tQ1LXq/w3KTTyJ+OfMU3cUrzEHUq9+fYQ=;
 b=QPzByucKFLTXXIui6JZ+vDWsLUhFhIXkXFHfrskD/fPh3+pzhYFMoGTA5o05n+3qzv
 O7EE8Xz0PnZqAeUHKigL91iveJoA/GXnFo25MR4yipu2vpWI8OJFKyVsJYDUpRGojZzV
 UGL6CEyAp5upfeVxNzHd602CNTe3yt+CCU/GJNYXJHL4+wctrjO6+jvTna2wdIeaRFUg
 6ibYUz3mLeZMR2tMNz/d//y/y9HLZ1f7liz42nJzwlgPk6ohTtUcnx2yr8vWOm+nPwbO
 eT+m5gziaUeeyThLU9gSV/siAZOlEOJ8l7W9XO0iFcXNgQ2xysG8TI+Upm7oWt88AKz4
 HmUw==
X-Gm-Message-State: AOJu0YyxO7Mj9c9C21OzJX8tv/DVybthjKgCAsrIB25kSW/qLHMJpudC
 Rg4EzGoDhvnO9aHIw+6qOfVrKjoelth19JX8+UjuQk1Y71DEQlaOX4yVZCr7ZYRJvqzn+JwJz6Q
 BO3J/
X-Gm-Gg: AZuq6aLSCtbR0w+n755yCRepPK0BCcM32aGMn64Xm7dQhpEIWTPrl+m2x1AprBEVoJ5
 4aMWGO2ZwiwNzPYYDqMtYlu2C1EMzMeZ85fnGQGx1pZ8JGOmctJBVt3iPIynOCVzHTPf3asdSCq
 xcBM40bk8PjGRNduTdlbpvWJSsg/j3veWHB8mdmjoagoFygqOuw00sSQRCVrjabjhj4fIGq1UA9
 WbJJavucIWVaXSt1ZFERMUzSfEM+y2Zzvek9+mNl9KwCio60YsJPNPN2sm2j7F52f1G2gk6OgbG
 HeuzClz5nmgb+afSur4luBLeX1c1vwB7MMBmSH6CtveHfbEwwB6++TrTZmjdZT3+8XMiNf2WVvd
 o9ABawklTr/ZIP3yn2d1n3ABZZV+LQRTfyFWljaKowoN14l0QC+ZCwoHT/W1kp3nC7/4mAmQS3P
 bzD/9rR0sDYw47iLFevfaYlP/07Oo1GWpRTWHb14bLnH+eapuxrJGOc1z2cqOe
X-Received: by 2002:a05:6000:2911:b0:430:f2ee:b21f with SMTP id
 ffacd0b85a97d-435b1b778d1mr2624022f8f.22.1769142600013; 
 Thu, 22 Jan 2026 20:30:00 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1f7b41asm3603771f8f.39.2026.01.22.20.29.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jan 2026 20:29:59 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Reshma Pattan <reshma.pattan@intel.com>
Subject: [PATCH v11 04/18] latencystats: add check for string overflow
Date: Thu, 22 Jan 2026 20:28:02 -0800
Message-ID: <20260123042945.159075-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260123042945.159075-1-stephen@networkplumber.org>
References: <20251202172626.283094-1-stephen@networkplumber.org>
 <20260123042945.159075-1-stephen@networkplumber.org>
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

The copy of latency stat names could get truncated if in the
future a new value is added. Add warning if that happens.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/latencystats/rte_latencystats.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/lib/latencystats/rte_latencystats.c b/lib/latencystats/rte_latencystats.c
index f61d5a273f..0861d00c6b 100644
--- a/lib/latencystats/rte_latencystats.c
+++ b/lib/latencystats/rte_latencystats.c
@@ -405,9 +405,12 @@ rte_latencystats_get_names(struct rte_metric_name *names, uint16_t size)
 	if (names == NULL || size < NUM_LATENCY_STATS)
 		return NUM_LATENCY_STATS;
 
-	for (i = 0; i < NUM_LATENCY_STATS; i++)
-		strlcpy(names[i].name, lat_stats_strings[i].name,
-			sizeof(names[i].name));
+	for (i = 0; i < NUM_LATENCY_STATS; i++) {
+		if (strlcpy(names[i].name, lat_stats_strings[i].name, sizeof(names[0].name))
+		    >= sizeof(names[0].name))
+			LATENCY_STATS_LOG(NOTICE, "Latency metric '%s' too long",
+					  lat_stats_strings[i].name);
+	}
 
 	return NUM_LATENCY_STATS;
 }
-- 
2.51.0

