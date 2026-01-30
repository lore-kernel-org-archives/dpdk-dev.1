Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAF9AE6BF31
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 Jan 2026 17:35:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 52F63402DB;
	Fri, 30 Jan 2026 18:35:03 +0100 (CET)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44]) by mails.dpdk.org (Postfix) with ESMTP id D7484402D3
 for <dev@dpdk.org>; Fri, 30 Jan 2026 18:34:58 +0100 (CET)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4806f3fc50bso24318495e9.0
 for <dev@dpdk.org>; Fri, 30 Jan 2026 09:34:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769794498;
 x=1770399298; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LxM2HRjGamIffMHAjPjIF4Jwgs3HKhOV9JWmbdVBwOU=;
 b=N09iSTGOa9bu6gl0cT0AYKBYgcpz13VDKIin4qyNn9dqZDAOtvvgzzIMgc81e8c5PU
 k+21jUav3Uxhs9fZHsex0nL8lq1QpKrzt0mvmN6SsQ9BnSrP53jOoQ4aH0gaYwEj2wcN
 ymJ7MbyrQRs5DXPGLis20JnNyp+jwGfcDhh60yUuadQ1hh+jP4sfnZROtFMLdguemQyy
 eC0TKQwnlLK8vNsqAHytGHWeJ3pcjCsKFdOfmbbt0ZJTRRhYEhR1SZITfotf2RAjZmeZ
 wMAYQQ+VkmQmSk45bZlXb4swGNKrK9hY5VREUAuPwAkiY8NgMJ8z85U2mJtbgIdhK/rL
 Vkwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769794498; x=1770399298;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LxM2HRjGamIffMHAjPjIF4Jwgs3HKhOV9JWmbdVBwOU=;
 b=rtFlScTMB81tt1cY3NBW+OkHbhtCac0rNmmgSlbHNvGqiTRI5azUlxgQcjHXl9WiC2
 ZU0HMg4mGcImiFUSH8217qhAS/aB/IApe9ViDhaid9vPJfHBGipMhXWoyXOFLyA/zibR
 QZLoLEq+/y0eVW//nAaZOS112kTe9gLN8scMkuv3wJFRjEUMMUReYajjHUIHkIG4NF0m
 OJjIfi+YipbVt5VaVXwTmB5J9CF3rB4xqvUb8ExyH5s307do9F+17fAVvBY8QMOCVX89
 wVNgjltvgBaevwaJJtKVELHXMnYsFTSM4rIN99OyY82hlOPT0m7z9r0Z5Kt95K9HqDGo
 Gq5A==
X-Gm-Message-State: AOJu0YxFs7d+Ux7FzaFhAvQuTd0LDKOjoLkH8y3VOodcTvtz1hbj5RLZ
 t52GImN1d1IivCKomLS+NMNuS4mhEgqdplvm7TwQOCgSINyNeAx3S+ifUjw5RAzsQQBWJAmaJHu
 tgOc9
X-Gm-Gg: AZuq6aJlGNjyr1zky+mRNKs4qpVtNaCdOj/X5eAB6/djPeHYQQFsNhZ5cIY2EH/ggxe
 c0xlcEhZXsh/iRNe34Hiyz8RzXX9SMnuB5TjcDbnH9av1NS54hATCfl1mut7E3l8ltzcaFM7mP2
 n7B1bdMO06cLRtL1J9Hp62HLnWEmLZ7nfYe6PgJA5jJsoDpvvi2ZLDg+PvKeKRrlXZzblCuLl4r
 bgmswT6UWn42uD8UIiyfs9yLSNwSXMNSWbWv2lU+jVas9rsyS+vM27caIJ3khQXJVjg/ftHfe7K
 1d89u7f47wmU8nBBcl9uAoQZRSvds2nzy//yiu8F4wGEgNFEmWPqBWDFR0iGGKSLiEiihSVWxyW
 K+UOnUHgWZSFDAwTI2cFur7cmvJo0vK4dR17kGxPrdtv+T8GEaL3ppcmHNRKk66MkD5P90VGRvR
 F80TRdtqsDhdqrcDyl7nRcAPDUZtVj5Sy7u92pbTvW2qYFj+5RmQ==
X-Received: by 2002:a05:600c:4f47:b0:47d:403e:4eaf with SMTP id
 5b1f17b1804b1-482db460714mr51995465e9.10.1769794498491; 
 Fri, 30 Jan 2026 09:34:58 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4806ce56490sm201085325e9.12.2026.01.30.09.34.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Jan 2026 09:34:58 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Thomas Monjalon <thomas@monjalon.net>
Subject: [PATCH v11 01/19] maintainers: update for pcap driver
Date: Fri, 30 Jan 2026 09:33:14 -0800
Message-ID: <20260130173447.14546-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260130173447.14546-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260130173447.14546-1-stephen@networkplumber.org>
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

Nominate myself to take care of this since already doing pcapng
and pdump code.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5683b87e4a..28a3269568 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1118,6 +1118,7 @@ F: doc/guides/nics/zxdh.rst
 F: doc/guides/nics/features/zxdh.ini
 
 PCAP PMD
+M: Stephen Hemminger <stephen@networkplumber.org>
 F: drivers/net/pcap/
 F: doc/guides/nics/pcap_ring.rst
 F: doc/guides/nics/features/pcap.ini
-- 
2.51.0

