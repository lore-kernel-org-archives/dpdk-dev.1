Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3814DCD98F8
	for <dpdk-dev@archiver.kernel.org>; Sat, 20 Jun 2026 02:33:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2D78A40E43;
	Sat, 20 Jun 2026 04:32:13 +0200 (CEST)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com
 [209.85.128.178])
 by mails.dpdk.org (Postfix) with ESMTP id F073540DD2
 for <dev@dpdk.org>; Sat, 20 Jun 2026 04:32:10 +0200 (CEST)
Received: by mail-yw1-f178.google.com with SMTP id
 00721157ae682-7fdb04d774aso30015437b3.2
 for <dev@dpdk.org>; Fri, 19 Jun 2026 19:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1781922730;
 x=1782527530; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QNUY6t5JrkqHM+hrcejEwEr3mqF78kdD25AyR8jVpCE=;
 b=ou+6hS3cO6RUqUoulmlehLSg+RaPcpdg7oAq4aYWbUFNyos6+/18RsgXjGmyVlJp+j
 Nzsa+Dxp4Cx/05dIYYsPBFFH8g+cKWZnfOwR01BNVdCSSpn9MWgjq+TPhdEYMSNVR/jz
 fjzZHL3m+JsWBl+wTX9330834QcVK+NNvXfa62FbekI8oJdJN5Ng4j4ADwqIoehOkXkT
 0YPuIv/GReGPNElmHKN3lPw83RZbWTtYu79a0BaolhP8iBRSIRMrcBJlRPqhtggVIn2i
 q3qUQqiaDp27uYvcjs9GV/KGVd5oj0kBbkrKM61Bdjjth2yBCzoEMOwhp0LpLSDJwvIB
 4b5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781922730; x=1782527530;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QNUY6t5JrkqHM+hrcejEwEr3mqF78kdD25AyR8jVpCE=;
 b=IKbGlmRDBN7kqrVJs75bi4ITtIePYborTbjC6awgmrDCuTYuSlVzHpUrF68KXe/P9O
 I+6J6Kn0XdkD2mqW/uoIZgg9UwKISgGB/ZTbagVVY6Gcx5/FZEjUALx80Nh+CgdBZuFJ
 pU6BxRoOFUqigfENnALFjBKknA5kSS7aMwMQ72jF/8Fy5RzMHpvP8SmhX/f3gzkOw90v
 DlbIRKEZeEBwgICXuEUxH5gH1VZi9qBwnEfsCJqyJJswgg99VGA2GZ77eCpJ2bT71X50
 nSIQxo1I/oqhtXXDd4QPSyC99WwOepWzSmgGtAFnVD3hxI8XW/8P/2NmQ0bdU9VV9RcD
 62Fw==
X-Gm-Message-State: AOJu0YxfzI3WO3RVFhgsaxw3BjfTCUunLM8uEmH6qxTFSSlxDKAnDAIx
 SGZu8QVdwZ7iuu7E/3S4xbzsjAM3Omb2WKuBwrAZF482NQZz/WGTcWpz3/WwjQ1KT/dkix4vv1Q
 A1Xde
X-Gm-Gg: AfdE7cmwTNKDJNlN5QrLMFjtx1u8YWgUHdshM1ffy+r6fxuoDcS1TcKS7TT5xDMTDLl
 9C6JDRElxuBTTZKBMecuWmisRcLXRn6Vnx3zELEOYtR+YPiiFT84KuBCJEAVL0+CpdTwFubZP7D
 3Q0gChUnXuonS8OoNjTkizXfaEZaizKeatqmTWsbhK1Gvp+TV7tzgieddGtQgRukhILEPw1ANvY
 hb7qsRBMd1w452ZK8fbHp6VGaIHAfkEq7Z9Un6ScymIEZSoZjrph9zcQlAzNmsbbkxfOsPzFWRb
 22CNxlyKonOsYe/s8lOs/pdzwnOlPRZjQYFJqVBvd/SO4Fs4BarBQbRRbROW8PEeK6WzY6K6E/1
 ibklvrkSBrVx4fAOPBKeZsGPRGa/i7yaj2H0b1YvL5i9zNream1SHelNQXJ65hE9MOS3txvFqjS
 LCsGW8k67aNkGMHhQ4NKuUKWPVXY7qKs3qAvIoBBCi9cYEjqn35AE=
X-Received: by 2002:a05:690c:498b:b0:7cf:f7be:f4f6 with SMTP id
 00721157ae682-80263fc8022mr21837067b3.8.1781922729807; 
 Fri, 19 Jun 2026 19:32:09 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-8025c96ffd5sm6045897b3.9.2026.06.19.19.32.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jun 2026 19:32:09 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v5 23/24] test/atomic: suppress deprecation warnings for
 legacy APIs
Date: Fri, 19 Jun 2026 19:28:48 -0700
Message-ID: <20260620023134.42877-24-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260620023134.42877-1-stephen@networkplumber.org>
References: <https://inbox.dpdk.org/dev/20260521042043.1590536-1-stephen@networkplumber.org>
 <20260620023134.42877-1-stephen@networkplumber.org>
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

