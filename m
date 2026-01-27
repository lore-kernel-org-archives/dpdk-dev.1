Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73FB7D340A4
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Jan 2026 16:33:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B70C540EDC;
	Tue, 27 Jan 2026 17:33:14 +0100 (CET)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50]) by mails.dpdk.org (Postfix) with ESMTP id 8409B40E7C
 for <dev@dpdk.org>; Tue, 27 Jan 2026 17:33:13 +0100 (CET)
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-42fb2314eb0so4948524f8f.2
 for <dev@dpdk.org>; Tue, 27 Jan 2026 08:33:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769531593;
 x=1770136393; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WBcQXCL9e7ygnYAJlzBMo7/tu31fXUYw1CrLRLAJ2+4=;
 b=rmTVkY2JITVV/kPR2T0kcNZ9inu1feefBHZz6NAhjm15FY0hnG7TwIo0OQN4kiDiM4
 lrHga6akeAZ/qxfHQ3LilIzljqWVilHAfdwYFd+8TtbfgZxG6p0u532gxacTIDAtX3k9
 ERBmlTmcBra8KYUaFVannhxJd0aAXgPkRRGvYnOwlfIPtRaXEuYb5M5Szec3HGLGNRF/
 l8WfBFNfVnFo5Gjjj0tOlbuglIlBP8OnL7iQqMyxVgbDve84Yi1lqEal/txNQZmsVSYp
 d0ux3cADS0GJMeRXNniJw84z2hqWjmIjxXR4PsQVhf8EsrzKDr+OPbEDkhNLvmocRP4V
 JXEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769531593; x=1770136393;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WBcQXCL9e7ygnYAJlzBMo7/tu31fXUYw1CrLRLAJ2+4=;
 b=veaodhqVWDeAfZsx4GMdCeMqjiuQGLWXbSNokrjhpECx3cf5fGWp9OoOyhsAvad+0R
 ubSazchOPrylUEamp6OwSM/jpr1nwMIP7qKmIQnH6TxdXkoXdzQQjeYYBG282HTdzp3w
 jMNKoSz3imOlOdKDsHzuUqMvlD0+5ElBNNAGupmT37bS/zn0UGOvuDBPv5HhVMN8ebRU
 x6nbrLofrI/SfQogFT0Q28QPYJnpFruqMMBdLsmAhRgvpyY7nqwDyQQg2gmMv+LivFHq
 YNTKtcvIQthHi6VtdgSty69w+uh5XwQVwDQIfPQeu3InAw1O3SapP4q3pilj8L9+qUAc
 fi2g==
X-Gm-Message-State: AOJu0YzyfsQsexsLBmF2Qbu05cezlik3Wo3Ed7+VXJJChFd5AXqT4oK2
 zX5JxyVqK3lMkzNheV5QplFsTHZZOpqjfJIqwj517QUIAFhz1BwzMGccNeqrEYf29w9NfWSVbKD
 6ReyA
X-Gm-Gg: AZuq6aLA+Awx+lu1WSNL5ORcJJWovFP3BwyhkEeA0wBTHQgnYuis+jlth6eYrNOxS2L
 o2I2+kxBS4/UzEEa/anCTLdc7hn4BQWJMgAl9YdbF698dyHfBbI3rOkWXWeQslKF58oO7uBl+yl
 07NQ8K2XucAnBnBUe8zrxjO0kPB88xOkTR++FVizA9fzDpU+XbXlB+yPi4ZaUPmP+MgiEzdkBvG
 grwp7gL8X3Yg2wcur6/dXbow2fCN+dXNjMIAiPAFNMZ0gwxjb5sxoOqSEyji5lo6vSS+Qp5kpxa
 wjN9a6K+Bva3Ce9KDbdZdUXmsTjEUjEfJuKlHMUDc/UilTMbtP3h7plWmQmERftP2I7rFmX8eRH
 77o6644ZRsws53gIx3PXix+13RkC4Y8DQc5kg5e5UH/ePYUjLnNMV59gwtyna6IJykpqDanYRI/
 uEJTB7jJNgwTfc0AY6MuFhKThyRzMDCOJktgtfMv0Zm9a3Kg113g==
X-Received: by 2002:a05:6000:1786:b0:430:f68f:ee97 with SMTP id
 ffacd0b85a97d-435dd1c1d82mr3810066f8f.40.1769531592554; 
 Tue, 27 Jan 2026 08:33:12 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1f745dbsm39978513f8f.34.2026.01.27.08.33.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jan 2026 08:33:12 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Reshma Pattan <reshma.pattan@intel.com>
Subject: [PATCH v13 04/17] latencystats: add check for string overflow
Date: Tue, 27 Jan 2026 08:30:18 -0800
Message-ID: <20260127163258.75566-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260127163258.75566-1-stephen@networkplumber.org>
References: <20251202172626.283094-1-stephen@networkplumber.org>
 <20260127163258.75566-1-stephen@networkplumber.org>
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

