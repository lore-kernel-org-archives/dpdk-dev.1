Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F3D6CA0EE4
	for <dpdk-dev@archiver.kernel.org>; Thu, 14 Aug 2025 21:29:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2A7E240281;
	Thu, 14 Aug 2025 23:29:17 +0200 (CEST)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52]) by mails.dpdk.org (Postfix) with ESMTP id 45D7740281
 for <dev@dpdk.org>; Thu, 14 Aug 2025 23:29:16 +0200 (CEST)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-45a1b05fe23so7530705e9.1
 for <dev@dpdk.org>; Thu, 14 Aug 2025 14:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1755206956;
 x=1755811756; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Yk1U95FtyLamwaEXGLA+dWGe7eHTmFO45ejQyYTkjKU=;
 b=kI/NcQ3kVjw6wL75CPObmmDV4qFP2pFQ8PP0w2YvBXr5dn8mmRYGyTSWVwl+9qEb1f
 hS4r7HgLvDvlt7Vb1jULpXPzAOthyMg44J8FeOm8cUuNnXLEzFDoRS7H7j8evvO/6Gxw
 jfbiArRZQMqcFFcatlixUgQfgHQTlFq02lCDZXFc8Ti8Je4JGNldHWbXmlv0m7XFGKvJ
 CUHM10WyHMyxAFWkfnashMV9fEJ2G+23M1N3+6yL1RP86qLW6gYKL7QIbKV8OQIkS+4Y
 Tl3OGibUMxFhUyfOPzmVKYfVO5o0ompup1y7CzCoQ2DcyNJyx0Zhf7u4fPyZ082kU6bi
 uOLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755206956; x=1755811756;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Yk1U95FtyLamwaEXGLA+dWGe7eHTmFO45ejQyYTkjKU=;
 b=McNEFxIl5I6TZ6OpuQB4QJSMBwNQ+1iniKdPNLs3lGeYPtzbuckBVQ22B8/WNNUuic
 FMQJW4KpEo2EwKTLmx7rrSAseAePzoDwjfM6c4+83qJVBtMtJFGU3zdOwE/blyIYr8rz
 QHPVR5zU+TQDgA78B4qp/E2poPAOmELr2vSXesHBxphBpd9r1BVmk7r6BjvA4OmobYgI
 AiabmEe7if1lbuEoLiDUaWs7ZSBWBf3gArIPpCDYz8hp0R9ciyM2poYvukOtVo8ay3nF
 4MY5glrN+o42sJl0zgIivx+OsQjIUkl673NtXSrXpLcYpW/du8Ve5fBb6UJDwKp/i00b
 027g==
X-Gm-Message-State: AOJu0YxWB04hg+eq6qc6VZ14r3/4o9nke6KMgj2s01Vt2WBwjgi2EvBG
 mLxQapF+83Tjw9DniEPlX3hu/RKn7iBcaaGMW1FpjEVVDOlgb3VQJANqQCcJHC5Z6wy4f69eI8+
 CJOiZ
X-Gm-Gg: ASbGncvsnAWO6YNymqnvkfsnv3pJkInpHf1wzLfSCBEybHQDF+iWI8fGDilXjcotdFf
 k9pZHw7UvBrvR2XQ6Xu17n/wtY0ztUE08fvLbPW9i3cu4hBMtL7x8gB8dq0tfd5abwOqWYdiJKB
 YYhvLbyZBnwwkAUujXhKo3hqmwfUw1I48N6k7MPRhRQJ2sjnkjR80XLgpDKThrld3AGA+paq5Uj
 9JtSyBzmcfgu21pbs0MnfQVvhWs4CfIAOoN0DxR63kaQeneOTMB88cHVO++OA3wQ+IxF4OHFKK0
 TdU/GjWgcqqgn1LiqtAndhLUjW+IKilDGPFgP2IX+FDr74ROxmysFTIMQnA5sUZtYxS4YrsVhjN
 XgGAneQoB90i7B/EOLWfSR2TbgudcFMU1ocQ1w5JNIg4xHNr0cV1Y7iaQiGsgGoFleMhS038Ke4
 pdym7mtOk=
X-Google-Smtp-Source: AGHT+IHVY4/2pWernT2EAvlouOHRciSzh9Os8MZqJdTswPSxYQYGPCfHqz0EwHQ5+WmOxDx/qiA+tA==
X-Received: by 2002:a05:600c:154c:b0:456:19be:5e8 with SMTP id
 5b1f17b1804b1-45a206e529fmr6073665e9.20.1755206955776; 
 Thu, 14 Aug 2025 14:29:15 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45a1c78b410sm36404425e9.24.2025.08.14.14.29.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Aug 2025 14:29:15 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v2 2/6] ipsec: replace unnecessary comma operator
Date: Thu, 14 Aug 2025 14:28:48 -0700
Message-ID: <20250814212901.88863-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250814212901.88863-1-stephen@networkplumber.org>
References: <20250312232739.228295-1-stephen@networkplumber.org>
 <20250814212901.88863-1-stephen@networkplumber.org>
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

Use of comma as statement separator is discouraged and
reported as warning by clang with -Wcomma

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/ipsec/misc.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/ipsec/misc.h b/lib/ipsec/misc.h
index fd4d3f5256..54dc5c2d4d 100644
--- a/lib/ipsec/misc.h
+++ b/lib/ipsec/misc.h
@@ -126,7 +126,8 @@ cpu_crypto_bulk(const struct rte_ipsec_session *ss,
 
 	const uint32_t vnum = RTE_DIM(vec);
 
-	j = 0, n = 0;
+	j = 0;
+	n = 0;
 	vofs = 0;
 	for (i = 0; i != num; i++) {
 
-- 
2.47.2

