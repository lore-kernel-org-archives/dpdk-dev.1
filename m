Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3A77D37497
	for <dpdk-dev@archiver.kernel.org>; Fri,  5 Dec 2025 20:16:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EDC2740648;
	Fri,  5 Dec 2025 21:15:54 +0100 (CET)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42]) by mails.dpdk.org (Postfix) with ESMTP id 4D8C94064C
 for <dev@dpdk.org>; Fri,  5 Dec 2025 21:15:53 +0100 (CET)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4779cb0a33fso32240975e9.0
 for <dev@dpdk.org>; Fri, 05 Dec 2025 12:15:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1764965753;
 x=1765570553; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c85AU4P1C3tQ1LXq/w3KTTyJ+OfMU3cUrzEHUq9+fYQ=;
 b=L7k+5ydqS23woezAzYHgTXuAVyIiXUvzvm6zwIj0fnODzYJehbnyga2f6Yb5IWImwa
 54Apo1NsaiRewaQjd0C05OHqvr9wCNGENEJ6fFIcyhBRnKX4FnSuhMXnbYm4HweiYBJp
 7PwPD3qI9zg8S2fGnorEPRrNc1ogQvgRFhVVZ4rWk6wYXLVtLHO4j/ulIswNJ6KIKZDv
 QnaX6gz/pg2iYhSkQz+MNmRQ3SWPmSmgOaaiZFoEXrY0lE/zmU+mJB9oTRMkX6AR/v9H
 cOoMH8dqDNIp6GvPcyJNYroYXUCGzGBjb4VPAHNG2FpJxy/ffoqsqnRbyDjv3+d5PsC1
 UU8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764965753; x=1765570553;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=c85AU4P1C3tQ1LXq/w3KTTyJ+OfMU3cUrzEHUq9+fYQ=;
 b=eEN6StxedmAuFje5NfhPMXefhQW82C2yGTUAUWAltOHmS+pvzBV4ymUAYzoNaQ4MSv
 ZfZi35trL6crbVfYLJLbF8k6Gd7OPYxe77uZ9xxtnej709sFXegklVnnd1hQEoaEyVmh
 +8pnBOS19snPXV4mI1a2Xn5tET4jiCJKzAWRn1Ha7LqXAflFDDgTEKukPIrva4SVp2uS
 8nkybmxy8MIQ91Gqz6tRHbniMo2deLrGx/bFa2yeE05LB/EBC7mTcB8+FWi3UKtbFTF7
 rzEZ0lRTe8LNwrm89DjgjikZMLzLEXfqLi3I6c7mVcfh6cI47lRoox918ust1iXU4cig
 KORQ==
X-Gm-Message-State: AOJu0YwCP+cUdgJ2PICCU9C1HAd4k/J9BNqcjG28lvw2gkpkxe7ONJhZ
 J/bS981hIH6tZ7R0ZO7Y79jXtNQhYo79yE4o7o8jkz1rsAMXCwA4hLtd4sWEhe6gXjKgM+n6xfe
 SzELV
X-Gm-Gg: ASbGnctEC+v8uLnqo9IjkK+FXslNW98+Fyy0Dw5An2NQdq/qR8IZIzYHOkOyt3FGRrf
 JeSGQvRT6PbD+jQ/JCQKVpF3Up3KxADQae0U6pO/Vv0sh5O1Vle/uTXt2GvevDjews2Ld43xA9w
 T1DuDM48zadWBgRdzzGwKRL60qW25dP0ZuhT4pl682qh1yeIPH8yFbeb2GQYK1rIfiIa/vsOcBF
 28EoPTQeiebcJNbnrBJf846377+xxpwib6hSU3qGV7hpT0GUlX6NOqRDBtT3fpvyMBR+6jSEiDB
 nJIa1IgTBzblGqOTQmjEmwzWrlRBe6Kh5yVoBre1EJNLfnNBfrRtayXva96+HfngMEA8bNVUlzr
 TwlgwJgpnAvstUJndZFS4/wfBf0jtpzQ/4rZy53h6nbkBmglYukC0WMaTN6gt0XED5sxsFRBeyI
 4q+LWtjq5Iepso8WdT+CwME7cf3Vb6BQnfsvNDqWxOypsrGdzPzZJbtmnw7zob
X-Google-Smtp-Source: AGHT+IFVw0j+NnDnLn9juaXw9N3JDNKdNggVKW9ZJYqBlKhywTgvt9Laem9BzATve6woGQ7CxhuCxg==
X-Received: by 2002:a05:600c:3b99:b0:477:93f7:bbc5 with SMTP id
 5b1f17b1804b1-47939dfa082mr5696645e9.10.1764965752918; 
 Fri, 05 Dec 2025 12:15:52 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47935fce542sm45344875e9.0.2025.12.05.12.15.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Dec 2025 12:15:52 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Reshma Pattan <reshma.pattan@intel.com>
Subject: [PATCH v3 05/16] latencystats: add check for string overflow
Date: Fri,  5 Dec 2025 12:11:34 -0800
Message-ID: <20251205201537.251131-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251205201537.251131-1-stephen@networkplumber.org>
References: <20251205022948.327743-1-stephen@networkplumber.org>
 <20251205201537.251131-1-stephen@networkplumber.org>
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

