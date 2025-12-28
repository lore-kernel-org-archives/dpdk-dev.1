Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCE52E784BE
	for <dpdk-dev@archiver.kernel.org>; Sun, 28 Dec 2025 20:19:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D11FD40658;
	Sun, 28 Dec 2025 21:19:43 +0100 (CET)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47]) by mails.dpdk.org (Postfix) with ESMTP id D31A74065F
 for <dev@dpdk.org>; Sun, 28 Dec 2025 21:19:38 +0100 (CET)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-477a219dbcaso69423835e9.3
 for <dev@dpdk.org>; Sun, 28 Dec 2025 12:19:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1766953178;
 x=1767557978; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c85AU4P1C3tQ1LXq/w3KTTyJ+OfMU3cUrzEHUq9+fYQ=;
 b=s4mx700mUodSbwSwebE2FlLeF/ihjXN7R18Vo9Xdx5wSiCQIFHzq6iC7mBdbaRyV2/
 R/YNGBTfNlbyO6B3AyvP9eUyKVNlClH+M8I7dtUF+jowcRMLTHe0nfpmih2pNvrjHXrb
 DHR0SymoEd09khEJujKkNuGvBN6bkDtb7MuuBb+KWEFdHt2+tgjTxs8piAJeEhsNt1+r
 c5QyszzjixoC9WsIaqwhxaUdWjAvC1o3jAnsgD8EoMs/CSuqQIHGm/yNUFjNT6Lqm+9P
 OK7iKeX6JBlAsh7w3SwUDI1t2m/PG43Dy2GLz8H2YVCY1jcrws+8cCYae1y2nhIxSgAB
 euZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766953178; x=1767557978;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=c85AU4P1C3tQ1LXq/w3KTTyJ+OfMU3cUrzEHUq9+fYQ=;
 b=gkMX6s9Du64qbAL1Guv+6umQK7lDjlowC4XFAR5m6uhlpe2XlXUndsBnsncxNJ8Epr
 4arR6/CJUjcLT4KbcC/rOydJwbw+0V1jQ3T4RTGK/r1JY99F6PYh/NsGlZ69gSrgUu7z
 F2chojlYmfi9uLkstVpr1E+WPwf9LTkkLW+Ynzj0aJqC9C5zBUnQr7gyQcaWy7y3GkFQ
 pb5+GM/LDVwtpHJEXJDuvha4ccCvWiz9pghAg1f38cqM2mc8rSam2F+w6qm8CVjgojuH
 SNLMOXx+VGa4qhtsZOtGofNLjQCqw4WzH4Z6j4NZuN8J2L8NovZvw7ur5fnhj+HxPp9l
 YrDQ==
X-Gm-Message-State: AOJu0YyIlrySJHfCPhF9aETMJ8kpKBtaOiScLu66AI8SotaUR4vBgm0M
 myESn0apjnyeT/wRXRJ7zKgbMILT8Ni6cVorN/EbiOQDT2vjpoXPhygi6Yx/8MPJESsclF7x88v
 WZp5WiCE=
X-Gm-Gg: AY/fxX4wPqVq3oKjqMbtvLXolKm5Ya0taPEJSwq2emYFxZatSM/Ce/oTM2awPnogG0k
 1JHqDrKi96YtIuP2+eS4ydHfxSBPwxw89IE4zLMcuR4WBq1Y74R4vs6GjyuYs2SXN+O9dlWCFIr
 k4c1uRnTW+We7TGes7c0U22Zpxx3Hm8kLYtlaNwEPKJfU4NdgahjVkT80zLHgDaKt9yNTv/H3Wy
 Di72zpUpxvCuQo+B4z15PweOhzC8cskxyQ4CGNv87biEU6irc9CTSJ+/x3KXp3Pb2ScRwPshjRh
 xGeEgkTDTgw06sUBRCQ94hpsb1puDOZeDNrt/L5WTxPXA2Za10FLPYR6kOdtswtQP7fyvnWvxVK
 gTlbAEsezERpbYMjyKBx9RkDO8AKN6Qhy3Tgs4xENiqxp8ahlflNfnPadOVPSg7EEV6c+uj51qk
 +EXV/nGsGGEUcfo3UXqHTS+2E1Jp3vtiKr3gHNXRMsjExre1mVuBNZEZULW9W5
X-Google-Smtp-Source: AGHT+IF6cZFFbSuATl7iC4y1NbrDy5sKqWHwLPBFAPBKdeRatfbrxLhq2N5Bd/313wsOi7J6QArXhA==
X-Received: by 2002:a05:600c:3b94:b0:471:13fa:1b84 with SMTP id
 5b1f17b1804b1-47d19566b00mr383065455e9.12.1766953178399; 
 Sun, 28 Dec 2025 12:19:38 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be3964226sm240319655e9.0.2025.12.28.12.19.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Dec 2025 12:19:38 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Reshma Pattan <reshma.pattan@intel.com>
Subject: [PATCH v8 04/18] latencystats: add check for string overflow
Date: Sun, 28 Dec 2025 10:56:07 -0800
Message-ID: <20251228201236.547268-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251228201236.547268-1-stephen@networkplumber.org>
References: <20251202172626.283094-1-stephen@networkplumber.org>
 <20251228201236.547268-1-stephen@networkplumber.org>
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

