Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19501E92FDA
	for <dpdk-dev@archiver.kernel.org>; Mon, 29 Dec 2025 20:48:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E251440616;
	Mon, 29 Dec 2025 21:48:35 +0100 (CET)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44]) by mails.dpdk.org (Postfix) with ESMTP id EFD0440615
 for <dev@dpdk.org>; Mon, 29 Dec 2025 21:48:32 +0100 (CET)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4775ae5684fso30778355e9.1
 for <dev@dpdk.org>; Mon, 29 Dec 2025 12:48:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1767041312;
 x=1767646112; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c85AU4P1C3tQ1LXq/w3KTTyJ+OfMU3cUrzEHUq9+fYQ=;
 b=bCGBezM8Os1fG94eMolC8APnJ13G5cyfM4kda0KSGh3BGzeDXvFJVWMldVlb5w4nWd
 vSzyKBku4ReHBDj2b+ChmCJaTon2EGS1rp652e5hF59Vh7mWVB0c1GQ4oeojNvPH1D/g
 yiarO+c6To7AAh+LOgSawqtsddPDRw9mwZ2Sn++l9OmunariT0VWPIBV4gOzI+9O6FAw
 05+DcP8XgCv+CaV6ivNZfEA7Q+AXaQPp8TlYDwy0idNeFH4FceiVZf2sYssn8DbhrYyK
 ueoWvzh2bB/jeabeIOqpj9SX6hY44rjGf2vIgu0pT1kAz2nR/4ISDIY/vNHOLt+5AsuG
 MepQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767041312; x=1767646112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=c85AU4P1C3tQ1LXq/w3KTTyJ+OfMU3cUrzEHUq9+fYQ=;
 b=RNZWu9b2p3XFMnoT+xhJHCKTSmAqfIS0jVsx+TYj6aELINPvzHe9LjbMalXGZln6kO
 bDkouFiHBCFEtYxMORIQUVUOeSwDtBUZscUuzgsNZvsZ24QbMvMA9ZJTTnYZI9CmMmm+
 M5A9Kt/GPCe5HEA9ptkt29PQwUpg/qU9uoOOo+ns8r8refqxrwLz5SwXfjxdpi0+ZTSG
 7rRVqJvbBi2hjQXm2vk+YuQLH/EYKblIcH5vPiJakOzqw1e0gXMppnyDdCSiK+vGw2Hu
 TKcc0UFA1xGqDWnR+rFEGttW1q8tcICCsYY4YtK4Zn18fCnLTrgBujdczCjPCXcrf6E5
 CRCw==
X-Gm-Message-State: AOJu0Ywuo2J9GcQ86H+80j25zCv6LfrgOtv29qVzemUDLg1DUPWLn49G
 OvpyLt/Qmn5e+aL9s0Qcb2SGyDUjubldTU1l1pB+ck1SfOqgDim3jtaOUB0k4gaI8MNvSL4bzF+
 vBNKeyhQ=
X-Gm-Gg: AY/fxX5SA7zcj2/pLuf8ZsuOwSUBAvMZ/5MN+TlxSj0Ksxigq0sNr10NqgaWMLJG66l
 aA1akrmvWmhKkSm41Hz8kftVwuBGUuW8yqpW9FdKrk149RxmPWURqyPylGLOa4fHDgGGhKwVHD9
 0kcYNJZCVMS2rIaAZuZyCWQmUmJQBUsjDiNAsK3YSMkcv3xHyalRFMJ++sU61CVT51Ajtk0hiig
 gFm046h92yejFXb9bwuNPK1ckslJyHu0G80VArHcaq5IjoXzWNtBNacYnxJ9nZJtL2bytn8wjlO
 BnlgjxoaMLSUUaURhCl8QPgTkbS0U0c0TOpfPnMlCLlxetxz3vQCM89ndaJgWLBsb4p6iTOf67p
 HFZ9nFjiI/WnMmFJRoT5CoOmxgrv9IQptXrYYshRwyuR70dwF1fA+TQHUvywYTJMl5hPZRbjYIM
 e3dNepSDXSaiMi5W1ZoESnYU3YpXgSe4vtOjr+epN1Zw+aCRojSQ==
X-Google-Smtp-Source: AGHT+IEzm9SeprwhowRlTHxpxHPYorvLZuRzzBrAautvPGjZ1YN2lMnkJjXGl+HYIpxopl/1WNWLVg==
X-Received: by 2002:a05:600c:4706:b0:477:9b35:3e49 with SMTP id
 5b1f17b1804b1-47d195495e1mr361557715e9.3.1767041312594; 
 Mon, 29 Dec 2025 12:48:32 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324eab2c4fsm64676298f8f.42.2025.12.29.12.48.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Dec 2025 12:48:32 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Reshma Pattan <reshma.pattan@intel.com>
Subject: [PATCH v9 04/18] latencystats: add check for string overflow
Date: Mon, 29 Dec 2025 11:38:02 -0800
Message-ID: <20251229204818.61231-5-stephen@networkplumber.org>
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

