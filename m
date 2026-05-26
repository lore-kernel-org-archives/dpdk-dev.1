Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02969CD5BD5
	for <dpdk-dev@archiver.kernel.org>; Tue, 26 May 2026 23:28:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8DA8140E0C;
	Wed, 27 May 2026 01:26:24 +0200 (CEST)
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com
 [74.125.82.169]) by mails.dpdk.org (Postfix) with ESMTP id 4618740B8F
 for <dev@dpdk.org>; Wed, 27 May 2026 01:26:14 +0200 (CEST)
Received: by mail-dy1-f169.google.com with SMTP id
 5a478bee46e88-30246cfd41aso1027466eec.1
 for <dev@dpdk.org>; Tue, 26 May 2026 16:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1779837973;
 x=1780442773; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QNUY6t5JrkqHM+hrcejEwEr3mqF78kdD25AyR8jVpCE=;
 b=gfO8YCdtkXVG7rHzJfJyGEh1ZMg8Jru9LfcNbC2V8ZtMbSEYYMqrrIolEN8ek08mlU
 bU4pKe0XgQ2fsHUJiaYf+xfB7CAXDmU9qPTvx5z8SN04MIGry17rvTdxOP56zwMhdCXq
 y3lasA6VoAxVoiiResrmZK0Eq0+LBZQGjdwzWQLCrGp0nmGVYHGRuyAw0Sg4C7RzJHmA
 1wvw7Cp9pQv1FaU78lEOyeEanq6uxtMQba/9i8Q1wVNeU0mP2DpcJribMJ6NsnTM8Vny
 zg9pZ31sZpgWb12XBFIkHWoTLJ3o2PiKxhQZONJD6HBzcWiXQYOJiT5cgCp/WFYctvVM
 Pthw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779837973; x=1780442773;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QNUY6t5JrkqHM+hrcejEwEr3mqF78kdD25AyR8jVpCE=;
 b=lEcddceWaoSopWTJBQby8qMPrX0NXtYRHTJFgbz1/B/0URX/K3mTBaYcU4XBjzlRSk
 43hm8MwQ0lMzbL1z9p1XBmKtS2PiaqaYsOMM/7og1vVCLpH1eX2UDvtAvOUEMXMQX7M+
 xU+vCa2rX7Pxx7XyY2PFCXUtYSeaZ4m6GX3T2A0px0ljvft2Je5LY/Ll3TCKrVCGZeSY
 vfRzt7lHbzEMvXC019UqXIp4FwJnUYmvjKTinjn6GX7bRxZJEyDovSz/U+24YTt2ynfx
 8CZImsacG+TfQ9UvL7XTHSAE9dsy1TaER2ttiXmjoDAckHiGg4ynrbS0SZXBE7HSXClf
 3QVw==
X-Gm-Message-State: AOJu0Yy2PtkRn6Rxu0htV+BCmM9nSts+fXncRBQKxB2bL8Phoj7rOw/s
 u70uK2dOxhAHU3o/SU4LiktKGRSD8jyYa90Bc0IIXMhcjkFNum7j5lE6NNL9OzCbGs1ZOl+M31k
 xmaMZ
X-Gm-Gg: Acq92OEhth6lwE8AF2jkikRQkYTkseXqot98hxeROXl7/WiukFg8QMslp2HqXgzcMNs
 aqm5y9uhs54U0KH+9GSBG/ootE/e5Mle8PA2pVBerKg209+4s+LXNcNLfPDMZUH14I7xUg6LbaO
 iICOheGwp/wt+L0ucuXiRIU8/m1SLT36bBPL4qzxnSVM4Od0Q3w3PIRkqjzRI7xyOB/HSfe1/TT
 rPqT3KnUpZYkeXgimMRwdY+Mh3FvvPn3tREk/tcyjaL6uld3GZIMbLLA2yeDIiSv7td5nf1X4M3
 1RJaU0O6xCZDKE3LsyQ5FXR5IjxoR2P9v+Zwel7CCc4Uxip/bBsv42ARFwU0QTpDvK/AlZaRaQE
 KzYU4rMu10KUV78VhOW9HHurYa10QrJx2lk1+EdImFc5cXsQm6MHie52Q0Rvk1Nd/y96PFxMCON
 xlXZQeRJt23rcUG1+MOdlvTbYIl+SHIkgQjhltlgM9U+0EhWKjERur0ylsueVHerGoUORafToWq
 T665c4iEgM=
X-Received: by 2002:a05:7300:cb86:b0:2ed:e12:3773 with SMTP id
 5a478bee46e88-304491faf02mr10936234eec.35.1779837973288; 
 Tue, 26 May 2026 16:26:13 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30452230f1bsm11296132eec.14.2026.05.26.16.26.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 16:26:12 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v4 26/27] test/atomic: suppress deprecation warnings for
 legacy APIs
Date: Tue, 26 May 2026 16:24:16 -0700
Message-ID: <20260526232542.620966-27-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260526232542.620966-1-stephen@networkplumber.org>
References: <20260521042043.1590536-1-stephen@networkplumber.org>
 <20260526232542.620966-1-stephen@networkplumber.org>
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

