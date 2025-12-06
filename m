Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 582F9D3B7E0
	for <dpdk-dev@archiver.kernel.org>; Sat,  6 Dec 2025 18:44:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4EFEC4042E;
	Sat,  6 Dec 2025 19:44:27 +0100 (CET)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43]) by mails.dpdk.org (Postfix) with ESMTP id 1C1BB4060F
 for <dev@dpdk.org>; Sat,  6 Dec 2025 19:44:26 +0100 (CET)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4775ae77516so38598235e9.1
 for <dev@dpdk.org>; Sat, 06 Dec 2025 10:44:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1765046666;
 x=1765651466; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c85AU4P1C3tQ1LXq/w3KTTyJ+OfMU3cUrzEHUq9+fYQ=;
 b=QLF1H2K66fgzSHYwDfEUC5H0z1MXPXjU0pKuSNq8N+V/kNqLimCCXuAvfEDSq2mvrX
 YfO7yIWpbCsZB1kApaqqh2QsgQI/VoGfyjAGbgs39Vf56QokHwlpHUBttWFCCRJqZ0hG
 WAk7z+lSgIcY954VbzwbhM4J1mSBabz4rKgeQbIFgNq8Ini7T0RTeUSeuhCBBPYh4hAj
 Tx3EDVEnzBgyn2n4FcQyQx5DWpojwnYfVcN5+liVjrOSOp3Q4mo6aIjrfgPQBPColJ1L
 BwvaJBAZeiC9yRjeaF0uwAmJTiBEKGlRDoenXEVM/50l77NzJKHw5834rWcqghoIQBc4
 V4Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765046666; x=1765651466;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=c85AU4P1C3tQ1LXq/w3KTTyJ+OfMU3cUrzEHUq9+fYQ=;
 b=loR4MADyj5Jr7PR4v4iscvGyfjQ5scwLmDA/e+aWZOQ3Ez3qVtii39zdTByaf9i2t2
 8m6WGpmrN2GOJ47NLEEnGmJVEu4XdQ0OTtRL+0tbRmzqfqB1uOZG0O4aGvih3DI1ydmy
 z2FccOzxY1xX4Mb2KyqUYx2rfApAbHwc56VvYbHBeK2R0bjhhNoffKu/TmrJeetCUubX
 lOQNOJD/rZXEVVivEMhUMpGjB9tGDwU+3Dh+08O1fW+3siE9+/beR3Tamvg7kuaEPwh8
 b/05QdporOgpQribLW848h8q4VdGkWLLZNe2I8BzdAmvcr3hGXWWWy736xOlsLgxCSd7
 ym9g==
X-Gm-Message-State: AOJu0Yx8KRYfcsTBGMiDowBqF9QRfEp5oHdDuBmgpYdkgO0zvDy/ILvh
 /muyNG39l+nUAg3A+myqDCZNtIJ8Si+W4AhcHSEA+esugshoz2cB9BGTiJCKbOis1Y99QOOnObI
 9Mz0N
X-Gm-Gg: ASbGncurE+2OEGjSUQrX7f2bD4UbW4K8qITDkbZyAvhWPoxQ3c2dYqohKpsM8Rjl0sB
 d8abljnekMq4TSMLl3CRGOpBm/NL/TrdFCBwUZ+VDnhatQvaZj6xFiiq/SGofL/jT5wIi1cat/1
 l78axVGR0OOZUPDNuvt73vN+NTYbCJyqQels10q6PAKlUZJ/LWeRpFy9Becpiexzd74LBthYnzI
 jJPKrUwD0oLnWwzGAMORfLO1pohLzdOaqqb1L+2ADVy8nov6mj4hRdM0ALqffJDdjC3XZJdsMTC
 ItcnJtFFXxv/bDjgkwOb0s0M8PtL5Np0MuWuK58xK9S+vGDxY7IdrJu1UK5aS8DowuayFPJX7/V
 /Q8HcIY5tndXxrw5oan8Pbvt+YG2ZVauMy3L4KXn0SRQABcGBE2rY3m9Mduxq3B00jvL7n3z5dl
 MDzU7jqQOgzlcgi+l2jjWnBMbTUMhzKudWQZHeWWhAzVbdyQNVBg==
X-Google-Smtp-Source: AGHT+IEV6hYVCEhrwqzXfq3ZfXUFvfdjfHpTYlz7+2MdZxTiRJXvnZSRFP1ofmT0HgbQejN8tWVPZA==
X-Received: by 2002:a05:6000:2008:b0:42f:8817:2b20 with SMTP id
 ffacd0b85a97d-42f89f93265mr3067839f8f.61.1765046665647; 
 Sat, 06 Dec 2025 10:44:25 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42f7cbe90fdsm15281616f8f.3.2025.12.06.10.44.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 06 Dec 2025 10:44:25 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Reshma Pattan <reshma.pattan@intel.com>
Subject: [PATCH v4 05/16] latencystats: add check for string overflow
Date: Sat,  6 Dec 2025 10:43:06 -0800
Message-ID: <20251206184410.542725-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251206184410.542725-1-stephen@networkplumber.org>
References: <20251205022948.327743-1-stephen@networkplumber.org>
 <20251206184410.542725-1-stephen@networkplumber.org>
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

