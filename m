Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8560BD1951B
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 Jan 2026 23:25:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BB44D40A79;
	Tue, 27 Jan 2026 00:24:44 +0100 (CET)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47]) by mails.dpdk.org (Postfix) with ESMTP id C0B9C40A75
 for <dev@dpdk.org>; Tue, 27 Jan 2026 00:24:43 +0100 (CET)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-47ee76e8656so73708885e9.0
 for <dev@dpdk.org>; Mon, 26 Jan 2026 15:24:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769469883;
 x=1770074683; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c85AU4P1C3tQ1LXq/w3KTTyJ+OfMU3cUrzEHUq9+fYQ=;
 b=BwlKg6c6byJLuFw7aAlY0yWpezF943Tlib9rznvbFX5WkO3GFLLvHZLVR1zWKSMPD6
 9nyhEPa7uOsIXIu6DD3jzC3/wJ+5riktWjBtGw/kfQBrozoEOMEr5B6sYYUKarx7K0cG
 HINqI7pQ/gs1jrPGwjGt5TXzmVbY81IU96QA/b4mXhrpjPwzrnKEp1zxu7AljaHH37Bj
 OXiJYJohw9g+NziFFY4NxdzhGyNrCUBvJ3dvVe9L0Yl20IeyvNUfIhK65hVOMl6O2WZX
 Fdb1Z+iAsQccbOhnWU+hJwFWtKVh3vMgQg2SwnpG7FPPUM1qvaxzu6LdEQs42uUGcsD5
 n7Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769469883; x=1770074683;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=c85AU4P1C3tQ1LXq/w3KTTyJ+OfMU3cUrzEHUq9+fYQ=;
 b=C0nCqkriefNEAx5ehJunEism56pjsfoY9zhnGQzbpMN7vaHNm6g13POpD+mSz2ML5z
 cDOm3RN9QDhoO7MZKCGYHcc70KvofjIbWWNPAtaEnQQYUL6/SGDNav/M8sXBFBaC8Vdd
 z+kXZRMrZ4A3JxTNEVxQJQJVN4RpcWv31EFh+NhWfD7XPJwyCJ6AMSvhkqJ59nttOMcw
 RPDq+oR8bw6Bo02aeVSb8QBlJSKyl8Ym6QCMChyMFMbapqmk13ydq8/hxvGST5rLgtpw
 etG0oV1J89JBlAqVGFE0HZybnWwNkWiiHPoweMSNJFnTeJQQFhivyIekkQEZc9jbfOx8
 y1kA==
X-Gm-Message-State: AOJu0YwiFx5nYUduQaED3aapoXhjpEJhnkJncgasDQI4FJAbvPjGgPC8
 Mi4lBrW9DcXlukqXFHKuOG13wn5ACtAicrBpRSgIuuUarNsm1yPjum03eYMfn5+lGPmFByBYo8b
 Btebg
X-Gm-Gg: AZuq6aJ2i408ctfST7CjtAJD+in4pScGf/BKOAfVwZSJr4DYk0q4rS2NQkClXq7Y9iJ
 LfJx1GalYq5UscbdM/r53fyYUcd8Gn6faO10Q4mgKoHEYEspXuSnYY9xjC9fV1Hw0Pyi6BJWKm/
 oXEHM9dX+BvT03gBdJP6E4DZIRaBX3eqvzbC5sT9rCxWxhdCBEn73fJ2Sk6MDl4C00OTL3L+nSu
 qWYGfN1LE0Oktg8yR8e/yfnGKEwjiiBkzCwwzWzKmAZ1MmFF4Tv0esH+hpmki5BJIM9jTickCBQ
 evyy3GlTq+dEowarORpvURd/vZdV8Qo8Kp3X8rQJQLploApeMWbm9OLzgLVl6P994ONyhsjN+o9
 GW+8SU/lndC9JqIum13M2C+ZXYNVDyT+8W4CPPJQ7sfi4h4svv1GDS2zo4XLCizabq0tA0rDxxf
 H4N2SshI2a5ckvDu5elzyHS4wyxe0BdQvfne/EseIsUdghH+rcig==
X-Received: by 2002:a05:600d:486:10b0:47e:e57d:404 with SMTP id
 5b1f17b1804b1-4805d9e0dfemr80491435e9.16.1769469883433; 
 Mon, 26 Jan 2026 15:24:43 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1c24a6fsm33711846f8f.16.2026.01.26.15.24.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 15:24:43 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Reshma Pattan <reshma.pattan@intel.com>
Subject: [PATCH v12 04/17] latencystats: add check for string overflow
Date: Mon, 26 Jan 2026 15:22:12 -0800
Message-ID: <20260126232428.276534-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260126232428.276534-1-stephen@networkplumber.org>
References: <20251202172626.283094-1-stephen@networkplumber.org>
 <20260126232428.276534-1-stephen@networkplumber.org>
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

