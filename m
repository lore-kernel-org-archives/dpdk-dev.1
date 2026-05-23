Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEE01CD5BB1
	for <dpdk-dev@archiver.kernel.org>; Sat, 23 May 2026 20:06:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 37C28402D4;
	Sat, 23 May 2026 22:06:48 +0200 (CEST)
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com
 [209.85.216.51]) by mails.dpdk.org (Postfix) with ESMTP id 2A76E402A2
 for <dev@dpdk.org>; Sat, 23 May 2026 22:06:47 +0200 (CEST)
Received: by mail-pj1-f51.google.com with SMTP id
 98e67ed59e1d1-3665a90bcd3so9202432a91.1
 for <dev@dpdk.org>; Sat, 23 May 2026 13:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1779566806;
 x=1780171606; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QNUY6t5JrkqHM+hrcejEwEr3mqF78kdD25AyR8jVpCE=;
 b=hFmEgaxgFlLzA3mkmGfCT5pUyg/Kl9lLFGMJACWv4gdF4KrmlqIDL8EY7n/JuMQ3os
 zV1UOn4tChK3hSVeld+JwkgJb6OiHSD6AX0eB/Fq2gYJsn3439ZxzXLLwSiFeIP2puNI
 4yPzOJwQ05gr2N41GAufT+Ecq00Ozl02Y7MIyP/ni4PpPsnUGonQrlsAR7FqAfunk+Al
 peazpWmoM9sxgaY6QxMlAIkymE1uj6NdT6XgRHNw5ofzgGyksGdXlOjSbPCyg9AwFQDq
 chNiCNNMtRfneVFOtyUNqpQaiCy7UVSFuJFqU5QxjRt+ugfiD+lqCLygF8YzNlsOxPFv
 4usw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779566806; x=1780171606;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QNUY6t5JrkqHM+hrcejEwEr3mqF78kdD25AyR8jVpCE=;
 b=E6YCZn2T/VQaAgDAp/tMSgSsIUrlcdhnom1aO/L+KWKEbGiRc5gz0e9Xa/mL0t+Hui
 F7F2D9kZe4VFQAlxFkVFDvqzGjGFccjz/JFXXZsb7Fk1TImIQI7OkbkbDCygDa3V+9Gk
 tKeUcBxtA24H81NrFiBI0RBeI8ZU0eCHWcFBR1xkfMrpG6Ts94uH4pistVXEh898xIBT
 6+82ebqRpB3u7UX5MYl04hw0a+4vlp/jSKIlf0rSl8m0rDSnaMW6r3byHbsl2xtvx6Bc
 GhwfUOlrZezZ6YXUdbuVlE1N3T4tPDolB23LR5hBtomAi6LSYxjkBoFyibL+5g+jBsDm
 kDSg==
X-Gm-Message-State: AOJu0YyTREIKYL3CUhK+jzFQ2pwqvQ37cbF09MOpu5T9UrAMyp4n02oZ
 xEiMy/qdGOWFviJnMYCu07aaUzb1OtDTHZyPVC898j3Klg2c6OGQnpkZs7pjAdBKDtvbbejhP4c
 Q0BAp
X-Gm-Gg: Acq92OHzLujgShn2n6ozG1FnA+n3tXJKsRqZA7cNGl0lPqZnG9Ed/3rLbWFugzoEZFx
 NUFjR5AJ8Bin/B03BfziiFJqJ9UeuOBfJADsTCaHWhIaTgm3TgzSazzX5adNJhX39UsHAyc7mK8
 DIdcQT+BNdmkraljVHfOycods269/p1WDMSZenleo0Yph3Oriq66yt/9s1ovAwZ7ltXi+CZaTps
 ECytWgh9+zH7ramL/9FfXnmgHSR14rn9KTlrMkGP1rjlkZSdJdhA9x0N7gExyPfeBHQy/lcRf7+
 IfmxVEcmfNH6BD/Wc5JFIr+bhFY+0hFFeYVSDlZZStkDWoWvhv5q8FRgr93ICc6N1RHN4THffun
 U0cSiKiGfO12SgYCStwJ7S3TfC0dHlPnv0PHxBkZFFTSbVpiP11qss3HgSjZp8PYvbwjrbqhxlo
 Z9rq3Uted/lSMcJae4leVutWneGz6md2kn716l8uxVXwm64t8wXp/zBnUzMmcYZw==
X-Received: by 2002:a05:7301:6008:b0:2dd:2d70:8aba with SMTP id
 5a478bee46e88-3044904df4emr3927191eec.4.1779566348479; 
 Sat, 23 May 2026 12:59:08 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30452255234sm4838428eec.20.2026.05.23.12.59.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 May 2026 12:59:08 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v3 26/27] test/atomic: suppress deprecation warnings for
 legacy APIs
Date: Sat, 23 May 2026 12:56:40 -0700
Message-ID: <20260523195839.454952-27-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260523195839.454952-1-stephen@networkplumber.org>
References: <20260521042043.1590536-1-stephen@networkplumber.org>
 <20260523195839.454952-1-stephen@networkplumber.org>
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

The rte_atomicNN_* APIs are now marked __rte_deprecated.
Wrap the whole file with __rte_diagnostic_push / pop and a
GCC pragma -Wdeprecated-declarations.

In future, when the APIs are removed this test collapses to just the
128-bit compare-and-swap case and the suppression goes with it.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test/test_atomic.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/app/test/test_atomic.c b/app/test/test_atomic.c
index 2a4531b833..f32a1aeff4 100644
--- a/app/test/test_atomic.c
+++ b/app/test/test_atomic.c
@@ -100,6 +100,15 @@
  *   - At the end of the test, the number of corrupted tokens must be 0.
  */
 
+/*
+ * The rte_atomicNN_* APIs exercised below are deprecated in favour of C11 atomics.
+ * Suppress the deprecation warnings for the whole file;
+ * when the APIs are removed this test collapses to the 128-bit
+ * compare-and-swap case and the suppression goes with it.
+ */
+__rte_diagnostic_push
+_Pragma("GCC diagnostic ignored \"-Wdeprecated-declarations\"")
+
 #define NUM_ATOMIC_TYPES 3
 
 #define N_BASE 1000000u
@@ -645,4 +654,7 @@ test_atomic(void)
 	return 0;
 }
 REGISTER_FAST_TEST(atomic_autotest, NOHUGE_SKIP, ASAN_OK, test_atomic);
+
+__rte_diagnostic_pop
+
 #endif /* RTE_TOOLCHAIN_MSVC */
-- 
2.53.0

