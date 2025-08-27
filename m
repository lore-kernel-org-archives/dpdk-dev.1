Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E74DCCA0FED
	for <dpdk-dev@archiver.kernel.org>; Wed, 27 Aug 2025 23:16:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9A85740689;
	Thu, 28 Aug 2025 01:15:55 +0200 (CEST)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48]) by mails.dpdk.org (Postfix) with ESMTP id 338A74067A
 for <dev@dpdk.org>; Thu, 28 Aug 2025 01:15:54 +0200 (CEST)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-45a1b0c8867so2421785e9.3
 for <dev@dpdk.org>; Wed, 27 Aug 2025 16:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1756336554;
 x=1756941354; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JkuInd3XpEUlnaEJEpTnM15RbLMfHC1ph/MBZCr0dcU=;
 b=TRrT9Zson6dKsE9G+F2y7Hj5QwuqN5T9OnEMrz0eiYeU4J26NFds0ZkzHn6hwSOLg/
 HesYM6r3CvbzG3riUp9KSQ0sEZqKzO1sPxJZfB9guoFTFu0YQExGYhaoKsqtPFJ/tuzu
 GpP9Ve/28XH4/vqvlPJH93yfTv9kgxPNn3EgDHBGZ7H+XRrFs8zpBQAeDulmM/GnjeQi
 ut99PK/0aRYQnucXc2FRiViAC4lrd/GdaGqGALSvfa82E010zjwCgtaaC5TzqdlHhL3j
 /Fa9sE4YOzCVfaQ9E1vn9tIZxCu2ho5neOGJt8dlJ4+vnRhvh4KAvW4AhHLn1+T9d8jN
 xxWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756336554; x=1756941354;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JkuInd3XpEUlnaEJEpTnM15RbLMfHC1ph/MBZCr0dcU=;
 b=gsXv7GMW1hvTsRlZiUekAgWVbzYz+RaUnJu/bUeoNW0KS0HE3KRNoZ+RmVDn99328e
 XavpIqCvDrFMQY9IFDPw0EPjpSlUfqlBRvmnX4/f6GXyDVvK6r+FoSzeM0KnYROauTaX
 b7rdVxtEMzU6xaHu7Kck9DucXSZHV2K/Ob4ZBbjYU52xGwFqJX44KuN/mMlw8pvL/829
 ka8oex9W2K4hBm4sctQWGzA5HUygh5J6+S2QVunKXdJlSXlN/qTETq8yZPln5IGfLzT8
 gzXpPLjZ4TvEdvvM1W6E6jf9MqeDGWru0Pg3QUw+v/v36yOA7GQQ//CsURaaEe1vDMPO
 p7Lw==
X-Gm-Message-State: AOJu0YwdUZNGDJJSlSGRZ7xsXmoGOW6F7EG1lP+mi3iN6LmDM3n9CjCr
 zgNAoAtPvYejx3ZnsZ90WkeTqKs3APaoFPlbY/KR1sxynG+rLaHRdU/JZ8XcP2mWLUCV2SPTit2
 ldNHa
X-Gm-Gg: ASbGncslK/fvUZiTETsmESVe+NeqCkgeTT1iwQqsE2ZhEGo7UCHSUM5+uhBIm31FMbS
 6zi9sPBlqD2LfmJTS1+gbtlVjkna3R0qj+pkyhJzkNxcVZ1wEhlTZx/2uy1Pditjk5x4ey5LzFH
 Enz017iZ7JkjsE5MAB1Kn4GbylK+Q9yiR3AQmUcN+YSi9EpxDcw29fx1ZvzFf1pvW+glU/qTxvk
 vvOkINAMkOGeeEeKPMKFEOkBQ26W0457wWpgtMWsZ/GWYWeKoYeeE+i/ZNTorOS9wSrAgk3Q48/
 nJcqPTNJqT0w+eGCnfo+5jmnfdnmUbo56HF7d9ynXlq+ISmWOcu0mXaKjxejY7jgk+lTbsic8yl
 NxYBlUqdSaWc5yU4YWQDHHD5IfhggQxbLpjrtp8ZxE5awrfwFbzy7b8Zb4WxSRYwgUlgRR4Qekg
 9DPvN+ISk=
X-Google-Smtp-Source: AGHT+IEMAVglujP2gLMRYz761rrgk5FiEKp4bT75J2W603zPq4GsMDrC9xDyrwxoZ6h+Gpb35fWTTw==
X-Received: by 2002:a05:600c:45ce:b0:458:b4a6:19e9 with SMTP id
 5b1f17b1804b1-45b517a0b56mr190538135e9.13.1756336553826; 
 Wed, 27 Aug 2025 16:15:53 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c70e4ba046sm24254652f8f.1.2025.08.27.16.15.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Aug 2025 16:15:53 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Reshma Pattan <reshma.pattan@intel.com>
Subject: [RFC 8/8] pcapng: avoid shadow declaration warning
Date: Wed, 27 Aug 2025 16:14:11 -0700
Message-ID: <20250827231528.236172-9-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250827231528.236172-1-stephen@networkplumber.org>
References: <20250827231528.236172-1-stephen@networkplumber.org>
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

The BPF filter insert logic had shadowed declaration of len.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/pcapng/rte_pcapng.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/lib/pcapng/rte_pcapng.c b/lib/pcapng/rte_pcapng.c
index 2a07b4c1f5..a46f4bf0bf 100644
--- a/lib/pcapng/rte_pcapng.c
+++ b/lib/pcapng/rte_pcapng.c
@@ -296,16 +296,15 @@ rte_pcapng_add_interface(rte_pcapng_t *self, uint16_t port,
 		opt = pcapng_add_option(opt, PCAPNG_IFB_HARDWARE,
 					 ifhw, strlen(ifhw));
 	if (filter) {
-		size_t len;
+		size_t filter_len = strlen(filter) + 1;
 
-		len = strlen(filter) + 1;
 		opt->code = PCAPNG_IFB_FILTER;
-		opt->length = len;
+		opt->length = filter_len;
 		/* Encoding is that the first octet indicates string vs BPF */
 		opt->data[0] = 0;
-		memcpy(opt->data + 1, filter, strlen(filter));
+		memcpy(opt->data + 1, filter, filter_len - 1);
 
-		opt = (struct pcapng_option *)((uint8_t *)opt + pcapng_optlen(len));
+		opt = (struct pcapng_option *)((uint8_t *)opt + pcapng_optlen(filter_len));
 	}
 
 	opt = pcapng_add_option(opt, PCAPNG_OPT_END, NULL, 0);
-- 
2.47.2

