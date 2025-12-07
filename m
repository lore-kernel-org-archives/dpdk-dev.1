Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5823D2CE17
	for <dpdk-dev@archiver.kernel.org>; Sun,  7 Dec 2025 19:13:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9E1304042F;
	Sun,  7 Dec 2025 20:13:00 +0100 (CET)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51]) by mails.dpdk.org (Postfix) with ESMTP id 205BA40156
 for <dev@dpdk.org>; Sun,  7 Dec 2025 20:12:59 +0100 (CET)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-47755de027eso27886385e9.0
 for <dev@dpdk.org>; Sun, 07 Dec 2025 11:12:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1765134779;
 x=1765739579; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c85AU4P1C3tQ1LXq/w3KTTyJ+OfMU3cUrzEHUq9+fYQ=;
 b=m3aff2g88zTFjntt4ZBinYrljt9TtWg05NVOyf2UZp+TtBkUTr+43e846UdnvOyBJ2
 FQkAJoVTWm34gP9gVHE2gJzU6KWcGSGZ87IpzvbbJleL11J75Tpdplz4vuOvwUf8WDG6
 DFD/e1Y9nxptTDqmH5qAWHdk3WwjHQEcgpHbuncMKCedalZRwcu2CGNU0wO+0Yq65y7G
 5FLhTnUNrjPeaxM2eQ2oCjCcGQDtRIBf0f3lhFW4c0XFNsxEKPNM8/qCSk8bGj1ec53c
 PZs3BthTdJZVzwpTVyh3fn935L2ysdDGB8eMPRXWsK4LXHL4O99JmwfGvIoM/4mfFuyq
 yrjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765134779; x=1765739579;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=c85AU4P1C3tQ1LXq/w3KTTyJ+OfMU3cUrzEHUq9+fYQ=;
 b=T/Y1zhwkiTKAIJr4ChQQHnN6HOt2bppjeXI2e5X5ibMqxm15denG/1o37zZkAdOAj1
 /dZPC2qRbbC7DWS9L4cbAPqhBkGoeFysCICuDx8wAELQQlWGbV1dH9Q4NuW3Gs+tGq+/
 Az/kFeW63osgJXNCyRPAc+8SKpiSfm1GeCOQKjuprM9VbxlLohGXLZcGIgnVFnajDhCS
 wZphJA0Cs8qBpk1yV+YfavTUud5zjPGb8h1SRg7AEXbcMCHS8akDUysPMr0iV7u0UsGH
 Xy94lr+wQSsX5pbJlA0pKMUmNPFG9Kyq0mp63/POJlb8qRyX+zHfaaDeRGaWG7cqnbit
 hx3Q==
X-Gm-Message-State: AOJu0YygBGNfSRvSgMBj9fPv6rwF5PXGF+M0mDgK3fhIpMH4bB2CtJhy
 Gkk7mPacxgg2hIz8jYgisS5lqfFbf5FddiHDsS8YNULXFY1h1U96vDAAXGFKwxw6mImQdfQ6fU6
 rSNNW
X-Gm-Gg: ASbGncvmobaC5ano8h9ukzCXuQJNxPurXtZpRs9gtjbsp9pvtWBx+E7VnWipEV7kh4D
 MHufxAURWVLOx3TKXoVcl4R75ghwk7IgQaEEOGlhdG7AyPnTgteyW2CMQduDyHm4CpyrFoe6ZN4
 Y3NuqbtwZbI4nk/zxNCsA0JM30q240uEyggGSkFo6A1Im/TC1RzZ1gR3Lkzvpu64jVqrwQCheIE
 iAsBL2b+YiaqwD0sbvNgr4MRvxqFlj+P92L7f37qXPyoz2ejxZZki7FNm+2egx7VkeqoEb7uN91
 SZHoPM1SeB6+3V5rlh3bJ7Y+TUliqv+7OgFDXCsLkDV3EPwr3p81eTZfBU09I8ZpAkkbGnHgzVK
 qTZ1AWW4D/+epHCc4RvAS4xI/GAt+E9oKaQv6HegsIJGbB2l1t0ji5bQo3mnJ+96YuMQ1LJENLj
 RnZMpZGt3RfECOjfZ4Y05xzRHDWqqtkz+MUZnqW5NJ7/4JnVwe0A==
X-Google-Smtp-Source: AGHT+IER977ThdG0rrnxRCy+Xn9BGXaea4F58BQan1Bvh5HVCAd4A6ws6EAFg4/cYmJsahaMjQnDoQ==
X-Received: by 2002:a05:600c:3b05:b0:46e:3d41:6001 with SMTP id
 5b1f17b1804b1-47939e59557mr58482855e9.34.1765134777824; 
 Sun, 07 Dec 2025 11:12:57 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-479310b8e70sm205124205e9.5.2025.12.07.11.12.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 07 Dec 2025 11:12:57 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Reshma Pattan <reshma.pattan@intel.com>
Subject: [PATCH v5 05/17] latencystats: add check for string overflow
Date: Sun,  7 Dec 2025 11:11:56 -0800
Message-ID: <20251207191242.165619-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251207191242.165619-1-stephen@networkplumber.org>
References: <20251205022948.327743-1-stephen@networkplumber.org>
 <20251207191242.165619-1-stephen@networkplumber.org>
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

