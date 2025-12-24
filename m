Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4DB9E78497
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Dec 2025 22:13:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A5BE440655;
	Wed, 24 Dec 2025 23:13:21 +0100 (CET)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com
 [209.85.221.54]) by mails.dpdk.org (Postfix) with ESMTP id 142F640655
 for <dev@dpdk.org>; Wed, 24 Dec 2025 23:13:21 +0100 (CET)
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-42fbc544b09so4775188f8f.1
 for <dev@dpdk.org>; Wed, 24 Dec 2025 14:13:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1766614400;
 x=1767219200; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c85AU4P1C3tQ1LXq/w3KTTyJ+OfMU3cUrzEHUq9+fYQ=;
 b=GSCmIbUS+hq40Ts6MqQHXRCHovIUAE2yLq0IhzXnyARndcuCgKU3odNfUgrkAgAc3h
 LmbzOcPFWiWh7d7KeW9PeKA/NnB7Fm1p4aVGSyrYkCReak8BUTbRgTpV12qK9fZlisDE
 5OHfWd98oQAAvZQUs/gEQjXAoU1JaR/TROS6v0AeZPCBmNpCU/ke0lVDA2rxQfDuE3gE
 9IT+ynDz4QVhdM3VFeQlEB1jcfFtc4JmilKLLTV6OpKlt/cCG31H8LE6tN2bx7IN0amv
 g+ilyKax/HgLki/wTuCv6VRzrEPcYJ0IVTwLS8eeeZL50imdpvBWS5uSi9yMLI4P7mRw
 pOGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766614401; x=1767219201;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=c85AU4P1C3tQ1LXq/w3KTTyJ+OfMU3cUrzEHUq9+fYQ=;
 b=Uu/bgPSSyisnx++NSyK22q54OllBOEcHpHXvICbwoIaECIb1gle92+ZUY02zj8Xy3e
 c+aOCJ0zXQBYBqzh3M8rYfBTp9VQ5wk+91ppe2Fbo4QCo/aVIjixqLI9V583PNcwPyxp
 OledW5nevRIopFQUDUz31KntzBLimDtDwgF6ejcG71/dvvkHQFS6vSs1HmlRFwH8eZq5
 3qfKVtWZEN6eEUHsCOB/EozQkbRKr5pGFZrt/z8FgANCvdowfegy+ElDNH/g2zoYN4Zx
 F0TmkfGOS5F9sxnWy4RqnvbXigAeN+Sd+EnMamRpHVooRIsVVt2gfdho69AfhPBm8RiZ
 syew==
X-Gm-Message-State: AOJu0YxCbRrDTLHDUKOuWAVte6OXENgpp8G7ISPYu1yOi9QcyRjjbl2b
 1PsqwRBDO1egQTtJUCkh2fIwYgF7ALKm4SpdSp3goPIsfyyX6DB0hXB8Dj196FiaF2b8gRcIUt4
 DMF4a1t4=
X-Gm-Gg: AY/fxX70YJQGXVWUj8zEuSxcrvWxRnEQDw+PgjqAnjMiSEEaIiFDXjs/04uwJt/Nz1q
 DH4stCF3p6JVTXW1BoEUHKPApfD5+s7FElEXKynVR595xsNOn4EUxImPIGClNpvQV0ug3uS7LHd
 5fIg56Fk80auKxMHGifxGjI1DZb3YsfjfdKmeTdSb8Q1PwM+Ca3toyRX/hRgQ5eA4E/gumXf00Q
 PUJHQN19rI57dnwg5+53oC0BQmWY5uwoVySD1eleKRAYAwGZW1J7t1IKh2oyAQA9s8dGAaeoURD
 cl1tFjSfmWxRCAivgyFfg0GYvcfjqDlQSogjZgW+TtHCM1taxfSRYkJGVdxMdH8GQZJipOcNW1u
 MERxRXwSRbJkSrCHovDUJL6dSd6AXaXGO8wkl7JYTiftAPepd4+pRGBHYvQjrQhOkOzDo5kH1bP
 ZrOjNmAUQ4V0NRjc78HKog9sPKZ2kHdl8oiBPgTu9AZH4+7g6tPQ==
X-Google-Smtp-Source: AGHT+IHvyJxajVxvnGTahfZe/Xiic8uoEgQs5/3iSU8RX5jHuOWrc2eH0R+ZqqPcnCNvvcHUdN2ZRQ==
X-Received: by 2002:a05:6000:2285:b0:431:1d4:3a82 with SMTP id
 ffacd0b85a97d-4324e4c6405mr22569041f8f.11.1766614400626; 
 Wed, 24 Dec 2025 14:13:20 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324ea830fesm36796622f8f.20.2025.12.24.14.13.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Dec 2025 14:13:20 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Reshma Pattan <reshma.pattan@intel.com>
Subject: [PATCH v7 04/18] latencystats: add check for string overflow
Date: Wed, 24 Dec 2025 14:11:45 -0800
Message-ID: <20251224221301.52714-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251224221301.52714-1-stephen@networkplumber.org>
References: <20251202172626.283094-1-stephen@networkplumber.org>
 <20251224221301.52714-1-stephen@networkplumber.org>
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

