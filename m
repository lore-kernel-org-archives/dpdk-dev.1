Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CDF0D46C16
	for <dpdk-dev@archiver.kernel.org>; Thu, 29 Jan 2026 01:43:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C008040676;
	Thu, 29 Jan 2026 02:43:28 +0100 (CET)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44]) by mails.dpdk.org (Postfix) with ESMTP id C496540676
 for <dev@dpdk.org>; Thu, 29 Jan 2026 02:43:27 +0100 (CET)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4801d7c72a5so3021795e9.0
 for <dev@dpdk.org>; Wed, 28 Jan 2026 17:43:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769651007;
 x=1770255807; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WBcQXCL9e7ygnYAJlzBMo7/tu31fXUYw1CrLRLAJ2+4=;
 b=FBVrPTYjNgZ7i+mYTwgOn0uox7SqSQcc5zA96P3buu68NlNg4DxH2yWaymSmh4uxLA
 HyZiWCsymI2bfYSYL95zDRyPecT9C4fAxxFJ2NHr8uEBHY0smMqwMbJTHPUL6pxuS1ZY
 fE/Fm1Z4NMHD6ap3X3bWYsFwBWdnIUKkrKGvN889fvXFsMbNS0f3si6WbWZlBmjrMeBv
 Qs+CQZFJP/k5Ncngkdy65SNEotzT6OckyQNtrgIC3nY4tLZ3Kk6HEVBoGNbQ3ULz4H3e
 Q+a7rDF5WU8H6hr5AWwNavdcpe1POWetMBWv9xdxUAHGxAzfKmW1FowpTWwWBNHIVXiL
 yo9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769651007; x=1770255807;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WBcQXCL9e7ygnYAJlzBMo7/tu31fXUYw1CrLRLAJ2+4=;
 b=ApJWTjP8NwjITRzomCZTiWr9T0mHSYNUacjl0HeUOxQ3mT7IkapSsF/bwHC13iPzPu
 4s1SIPM8pKFlSJj1NVXAhFSy1nyjZdndgGowUDpCiyTKi928SdWbf3n8u8oCJQwTtPu7
 jOHc1iMYF+LRnmfrNMQJaHofMq4dftSTP0L/+53SmiIHKlaRLH/Yjr+0VmM0qOHmZQGS
 j9mp/5q5mfLOFW3Xb5J4rqetpBBRYrmSjRSmmRaxvwUsKsDcKNTzXTgKXSFAyl7Zv8IC
 kyEoOk39sWFINY4lLmpdgtfLSasLOpoYg5/XswpGpP5AqHIqBt7cL5KlIfWeRoTDKZmk
 UBPQ==
X-Gm-Message-State: AOJu0Yz3rM+39yUrJEsxh6GRS2Beqq6zqUXYpeuCh7p8oApuMkMjEkuW
 93EktGbtfIYn/CZXKZDL7RLTqjqdciqw/Ylz7dKSxKMWJtL0FdtIMchXIEKlFdZgbTekg2nDgnB
 IBRNI
X-Gm-Gg: AZuq6aI5Mb7smhhBXletdAZ1BQl17JbR+MWIXJSEdOTzruJVfUzULHC+/+b+ZfU4fgu
 mw0nhwwyeGflmfBhilPKeBisUHOC6qDQsM1rn7r2gI6bevM17YztS7ZvDIMItrLj1C8HEKMPQo3
 yEiekR2Y3CdvYhX7Y6CP4OxQIZYM4tv+l8fklhWR//oau0L8pIMOihnBbDVKjEmThmu+Xdijxyq
 20haMaV9uvySYPHp/v2TjUjkLMy1wUc0cs9bPY6C6uRtHrWJOJULqVTYx+2MJq8E6iwFcP3AUyx
 kGNsepIdsOZVKv2AbY9pi2ZnajKHGa1reg1C3ek8ab0dTBLLWET92M99CniNZziRgRtgpGGqisF
 h1c8wUfdsIHlRQ5tncR/FKZGoZdRow6I/Xlg2ZqNp73VCmdGbsSUEDgFpJyhEo1cKRnwX8fW7Rp
 mcSyGY+EDGYSfOJmGamxT99QvS7WomTTMJk0Qz8DRvPCZLuJk+RA==
X-Received: by 2002:a05:600c:4e94:b0:480:4b5d:9ec with SMTP id
 5b1f17b1804b1-48069cafa29mr96476025e9.33.1769651007343; 
 Wed, 28 Jan 2026 17:43:27 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-481a5e18427sm3217985e9.16.2026.01.28.17.43.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jan 2026 17:43:26 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Reshma Pattan <reshma.pattan@intel.com>
Subject: [PATCH v14 04/17] latencystats: add check for string overflow
Date: Wed, 28 Jan 2026 17:41:07 -0800
Message-ID: <20260129014313.939831-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260129014313.939831-1-stephen@networkplumber.org>
References: <20251202172626.283094-1-stephen@networkplumber.org>
 <20260129014313.939831-1-stephen@networkplumber.org>
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
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
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

