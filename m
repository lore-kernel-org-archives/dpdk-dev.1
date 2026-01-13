Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D474CF45D4
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Jan 2026 00:52:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D673B4065D;
	Tue, 13 Jan 2026 01:52:08 +0100 (CET)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47]) by mails.dpdk.org (Postfix) with ESMTP id A478E40656
 for <dev@dpdk.org>; Tue, 13 Jan 2026 01:52:07 +0100 (CET)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-4779cb0a33fso75020285e9.0
 for <dev@dpdk.org>; Mon, 12 Jan 2026 16:52:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768265527;
 x=1768870327; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f77kBtOcgEdz63P8J3PmPI2HMrzeVND+zX545RrB3qI=;
 b=d+J8NO6F3re8rJn80YGW55GCkJhYY5CCJ2V5uKqo8SRvuEActMb/8yckcM7iHi8Vwf
 e9l4wOWG+PK8KXciDN30rnzztLBAwaPfbk8/nX6iW4y8SOx7I23+vvQzRiQUBuUAZpCy
 MIjWOcFufEscz+rd5PxZNw699Abcm6LaxtZGtmHYD0ZNjdq3ZqpikrNCqtKdRbnPWOc4
 Z6wnr+BfmvBQNBA7/71hGLjU7E3rqm973u44ZoxoKmJwFjj/X19a3AZ9QegZ/bK5Zey2
 j8/MmgyngR191TSapv8aFnaucYYfTw/cgv7jsWcPTneVRMRoq/hzWpNzLCr5OeX6VnZw
 Im6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768265527; x=1768870327;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=f77kBtOcgEdz63P8J3PmPI2HMrzeVND+zX545RrB3qI=;
 b=FAyIMwhEHcys5nd0e3r+H1x2adpHik7oNjnRzOhHIBRE9zATm0zjB6KPkG5T0CakmD
 wUWcelsMD43FXFuTgYr+8ye1lqitPp6ZMjvAMNyQZoaRsidyDNNi9trGeaCdxICIWQgb
 wrk9B+Id/kDvBDmKTgZd0Kt4Ba1i8B086l74L2v0R2mZQXyd/2x1f04tgPbv0udmxrJe
 OaKOjAoUcgRehHIoByCbIDV530EA8uQDG+T/2DuW3XlS/wtM5VGhpXbBy1iY4Xbi2m7+
 DtrRZkmSP6jlmDK/kctqT7tU9japhio/ujFHM3n5NuEvasVlA1Q2oywzQDcaN4fOmD9c
 0AQA==
X-Gm-Message-State: AOJu0Yxxg8XX+ll7hAgOdA7LQgbNzB9SeDG3P9Nk3aBmi+oPsijyY39G
 C/TIoDzVwzquFV7jgsYj9iENvNQG8TLmPAXS8jSxqvULPj056Xnt/e4ruAjkymmFWwrCPUij4r7
 xSvDE
X-Gm-Gg: AY/fxX51I7Undq2D3CzO+FyYrrstN5DC2kIWb6vL7yywCzN8/0VpQ2IIf0V+5DAuZQo
 mph76tcnIoylLdc1nRU2bY1NvPPiaiyOGKHXYKmqxrDzoCldBEsuflWLV1Vp9OTAat2R68PAFfG
 wu9XIUzMCBisde8pgUfEMs7nlwYqSaTPxEHbmGQaMApAPv9GGdLZQMyMPd+/TuK9sFKtmXbhNGQ
 TMRkPl4kuJcAiQi+A6mCoMpyzMsRXl6yGn0ekw1jcVULmRhhXf1LtX/nFRmWwH8yhDGsr00pKvv
 5lpWV5xREYWS12IPBN1/5WLCSHUmsHqsEGpcPxw85JTAgAEl6o4UoI5PW3zWewNLUOYohlvfNIB
 JX0UBkcHFT8eo/17SCTOniIh1j7qcKL4FeOvBvDz9zYE9VE8bHPkZux2boVjj2NXeaUgBjwi0jD
 wa2YtgIN/iseCXY2hBI1OHRUS4GzuM4Q0ZY5MtuA0GF77fVH9Hdw==
X-Google-Smtp-Source: AGHT+IGE/IdcbKGrDaWvt3o/xUI8algofmTBdMDmg3pcNid2DUoLvPj2UH6Qu+rU2dw/554LS9936A==
X-Received: by 2002:a05:600c:8506:b0:477:9ce2:a0d8 with SMTP id
 5b1f17b1804b1-47d849bd201mr191394235e9.0.1768265527281; 
 Mon, 12 Jan 2026 16:52:07 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd0dad8bsm41603051f8f.8.2026.01.12.16.52.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Jan 2026 16:52:06 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Reshma Pattan <reshma.pattan@intel.com>,
 Amit Prakash Shukla <amitprakashs@marvell.com>
Subject: [PATCH v4 3/7] pcapng: add additional mbuf if space required on copy
Date: Mon, 12 Jan 2026 16:51:26 -0800
Message-ID: <20260113005154.44551-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260113005154.44551-1-stephen@networkplumber.org>
References: <20251126051218.50568-1-stephen@networkplumber.org>
 <20260113005154.44551-1-stephen@networkplumber.org>
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

If comment is passed to rte_pcapng_copy(), additional space
may be needed at the end of the mbuf. To handle this case generate
a segmented mbuf with additional space for the options.

Fixes: c1abd1e93dbd ("pcapng: support comment in enhanced packet block")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/pcapng/rte_pcapng.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/lib/pcapng/rte_pcapng.c b/lib/pcapng/rte_pcapng.c
index c2635d8b03..f53e6dfecd 100644
--- a/lib/pcapng/rte_pcapng.c
+++ b/lib/pcapng/rte_pcapng.c
@@ -568,11 +568,24 @@ rte_pcapng_copy(uint16_t port_id, uint32_t queue,
 	if (comment)
 		optlen += pcapng_optlen(strlen(comment));
 
-	/* reserve trailing options and block length */
+	/*
+	 * Try to put options at the end of this mbuf.
+	 * If not use an mbuf chain.
+	 */
 	opt = (struct pcapng_option *)
 		rte_pktmbuf_append(mc, optlen + sizeof(uint32_t));
-	if (unlikely(opt == NULL))
-		goto fail;
+	if (unlikely(opt == NULL)) {
+		struct rte_mbuf *ml = rte_pktmbuf_alloc(mp);
+
+		if (unlikely(ml == NULL))
+			goto fail;
+
+		opt = (struct pcapng_option *)rte_pktmbuf_append(ml, optlen + sizeof(uint32_t));
+		if (unlikely(opt == NULL || rte_pktmbuf_chain(mc, ml) != 0)) {
+			rte_pktmbuf_free(ml);
+			goto fail;
+		}
+	}
 
 	switch (direction) {
 	case RTE_PCAPNG_DIRECTION_IN:
-- 
2.51.0

