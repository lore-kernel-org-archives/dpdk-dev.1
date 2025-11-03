Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 093C4CCF9F8
	for <dpdk-dev@archiver.kernel.org>; Mon,  3 Nov 2025 16:53:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CDF9540EE3;
	Mon,  3 Nov 2025 17:50:19 +0100 (CET)
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com
 [209.85.215.172])
 by mails.dpdk.org (Postfix) with ESMTP id 2909240ED3
 for <dev@dpdk.org>; Mon,  3 Nov 2025 17:50:16 +0100 (CET)
Received: by mail-pg1-f172.google.com with SMTP id
 41be03b00d2f7-b991ddb06a9so1144785a12.3
 for <dev@dpdk.org>; Mon, 03 Nov 2025 08:50:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1762188615;
 x=1762793415; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OjHCW9ekGwX2R7gLAhHtN43KCGcROSUiJXgL0KXemCI=;
 b=ILx6lRhX7hPbHjJ4yLHgE7HtbaKDzzEdq61+667yrJp+wPdL7Wvm/l/MtSLAi4EZtj
 Z5HgenuafgOTLabIGArMY5YZtNfJ6Rkn1fiXNeHNxzDnSC7hxGX4NXg8kfFu1ahT6w+A
 UGXQ+mKgAWoA9bCG+Uq9KjddCeTIlV3+pMMHmjkAEz2wXhAVE/gzQFyNcwlmnrLhFqcv
 IC23kqjGHLaNa7tfG7uW4BLPLEXaTzZVSnX8eX4wcLCsXGJDB3h5FUY2WBm4bWyGrgyV
 Ur2g6C4tPr0g+wmh8RYhVhIlFkmbFr3SF63vY8YSDAo+1N8kgE9Wvfbq05iOfTfI79SZ
 C+bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762188615; x=1762793415;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OjHCW9ekGwX2R7gLAhHtN43KCGcROSUiJXgL0KXemCI=;
 b=JNjZcvbK1VRnaglfHP1wu98Qy+WCiGvuykZHKQZ23on7eZvFP7woCjkVOpB5T7xVN0
 srL0ny24+C3wPBXmjT/44iEmDe/RX3KLK5Mqk2NkmkIWEttTB/VJrZ2rPkE1CNp+FIM4
 H8DDU/TXdYT8n3BubkYboM8wNSFXdmwaUnu1F1G1yoWd9WmXzdXn3Q4pR+J/WgZyCpBF
 /k69+KCPG6fWks/2KZSkeuocBuyGx/5hY17krWgtqTi3A8LjylyhwGjKIixfznKsxwzQ
 gzpiyh69tSAu+jmDte+6o0i0f0d0T9ERUsT0SS4tIzpFjARIxhQsgS5iL29pc/+mWma2
 oVHQ==
X-Gm-Message-State: AOJu0YykPV1VVg4gqghIX9PJhjpy1MbeFZIQsntUVUQ0Kk2Au7nPQUp1
 JsRw6wXhf8U0eDVqrPSi1CHIogUNJqPn8xzrWsO1U7mH/bmsURtZUNaifQmfnzu/ABjaLBOry8d
 6ezpW
X-Gm-Gg: ASbGnctsyVyOqnvF/uQxdK5L4e1+XOrVxyQumI+r+M2IzRbyFBdHrWd8dlPHzx17RNZ
 0afb8N77tOiEllpSRLR0p8KB5qQqjj1fgmTrEoUju/jNJ1q4dLMJ6dJHQZKe0KVdov67s1ptVz9
 89ePRpiMAL8iez67ELKjMUkQZIEAjKH195LRlirahsLHSAhvM8nqbnC12u2cG/Mie/UsBqDisrK
 m0sdATydKUZNXYhZhMVGDpmtglQDyZh65sdeqRUBiOPFKEOTatrWydisEBWwUydDpIfH3qopTQx
 UwewQtT3CvMLYCYcdkslLE2u2fw14V+dvUHwKUGbzw3TAp9sABwln2e+qxZmhQTjjAffg37Jrsx
 DRUAcUKdGQvSEOcOVXzvxjd2oiDxvtfb/9ChGXKWao2dt2l7OKTVq7ZjaluXae0jgQi87zJPjyS
 cyuOLX5yuSiznlGoDApX6bgWc4AIXdDa79nVNHVkQ9nAGeMS5RVQ==
X-Google-Smtp-Source: AGHT+IFqFVfUL3KdG/2R0sAzivQckHP5us0qph/BgkcFsy6Z7+vL/A3Ha/dAAqp8L4BnG/cA2apfGA==
X-Received: by 2002:a17:903:2f8d:b0:294:ecba:c7f with SMTP id
 d9443c01a7336-2951a49dd5emr182406485ad.48.1762188615248; 
 Mon, 03 Nov 2025 08:50:15 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3407f26e0a6sm6779040a91.5.2025.11.03.08.50.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Nov 2025 08:50:14 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Long Li <longli@microsoft.com>, Wei Hu <weh@microsoft.com>
Subject: [PATCH v3 44/44] net/netvsc: use LIST_FOREACH_SAFE
Date: Mon,  3 Nov 2025 08:47:49 -0800
Message-ID: <20251103164915.101713-45-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251103164915.101713-1-stephen@networkplumber.org>
References: <20250818233102.180207-1-stephen@networkplumber.org>
 <20251103164915.101713-1-stephen@networkplumber.org>
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

Fix use after free in in remove_cache_list by using LIST_FOREACH_SAFE

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/netvsc/hn_ethdev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/netvsc/hn_ethdev.c b/drivers/net/netvsc/hn_ethdev.c
index dc765e88f7..bc243bf229 100644
--- a/drivers/net/netvsc/hn_ethdev.c
+++ b/drivers/net/netvsc/hn_ethdev.c
@@ -1479,14 +1479,14 @@ static int populate_cache_list(void)
 
 static void remove_cache_list(void)
 {
-	struct da_cache *cache;
+	struct da_cache *cache, *tmp;
 
 	rte_spinlock_lock(&netvsc_lock);
 	da_cache_usage--;
 	if (da_cache_usage)
 		goto out;
 
-	LIST_FOREACH(cache, &da_cache_list, list) {
+	LIST_FOREACH_SAFE(cache, &da_cache_list, list, tmp) {
 		LIST_REMOVE(cache, list);
 		free(cache);
 	}
-- 
2.51.0

