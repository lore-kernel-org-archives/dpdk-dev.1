Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F97EC88E56
	for <dpdk-dev@archiver.kernel.org>; Sat, 12 Sep 2026 16:17:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2E4BE4027F;
	Sat, 12 Sep 2026 18:17:57 +0200 (CEST)
Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com
 [74.125.227.140])
 by mails.dpdk.org (Postfix) with ESMTP id D4D8940041
 for <dev@dpdk.org>; Sat, 12 Sep 2026 18:17:54 +0200 (CEST)
Received: by mail-pj2-f12.google.com with SMTP id
 d9443c01a7336-2d8fe517774so11288625ad.0
 for <dev@dpdk.org>; Sat, 12 Sep 2026 09:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789229874;
 x=1789834674; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=asnxcwcbdVNQP2vCaqFWwN943wcTau0SKeD8qtOCr4Q=;
 b=zgSDIe1D+YD9q3LfoYHhaWTtnZbStF/JFFFcvW7iyGj5omNCZ/7lImtVVwArOf9VfJ
 zNlbmb7aJj+5RkjbP6s0WAyH1lcy6XhmAasySqP3DB7in+F0SeuYJ1xwTfvNHA7c8rue
 4gS+6i3eG7IRLcOHzmsDhX3f7Z9HaR9F/S94vkhQdB4HF7O5+eJDgfDm1sscNyvrthih
 6rpdiNiKhfSj0RaXreN5qQtgvGXewCSmNwi+eTedEQWbXCQhWBIhvOLnv6rEyULdTcal
 dEuO1fNJ+K/tV9NmtnbbFmV881kl2tOiMY5uqSk1Kx6yN1lCmMEBLHHPXxoFUSyETCLE
 jKcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789229874; x=1789834674;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=asnxcwcbdVNQP2vCaqFWwN943wcTau0SKeD8qtOCr4Q=;
 b=HQonaN/wMPl+lWOpvH2xg+P5DeUyFOe+8MoyNmlEj5C6CTnINygRxLzqpz38Wr6ngI
 Sf/EoyouiBfrnBur5BChXMaEv5L3jYoVvAno0w9EPOfTxXskOE/lWiT5obScRtg5Mv3V
 c5VZODk0ezkKqhMUczPu3R/rs1p9pN+mYYlZChwGyEB+/XEhGhPweT9Zcqmo1utDVham
 pv9Dz9GlSCMmqjtYizcrBVyQLwk0Yu0Gc0jh/ZcrJHRj5BFucuzMM54TdlVtNU+woDx/
 LkHpts28Sbtc+KnJ0qkfGayGt6DClEJlPpQLED6Cs/AUpAniE6nHA2WGXSUslhoV0vLb
 6voQ==
X-Gm-Message-State: AFuF++lSIq9+k6GCgzh0GHpRGQ6C/ZngKsnuBhGtKRwtT+UxZexLIHTt
 jzzd+PBFM0GUlLwnogQj6vgoQYrH1M/d0QVBjJQsSMbt2fWnZPgQbTV58G3taOwauotNY9Zj41q
 7+XGZ+wc=
X-Gm-Gg: AYBFou3Ni3TY6zgEfvVDEPc3F6NKC6xhifq9TQxgH3ncfx/8SZEcL4C3rCyfZivJcHs
 YWKTekDHiBvZiRjc4NmI5NmALgfOP3I6jPobTwhSqVNYEQ8mAZF75yDQ4WacuQUKpzUGLbFXazZ
 Xt9k45Ak6jOlDnY1RV5n/lg0MWcjL+lIwMzPzS2CmvSy6AtNWVID33vKnMzvQujKKfE2EPJE/qD
 kAkA9zU8fDfRv9FRgvlKGZBalaAxt+6xlV6eLVgvoKoGZU81yRhBqydgpfjyEKIt8FUI2jbnOPW
 OARMkCDTjrng6X/mwLD5uuqxNeklAW2uXZKE9jjGTtcOF8U7ryz6H4oNGOP2FSCZ1Tmb1Jl2KTk
 jueSL1OmiyQT/iSmUiZt+kgU67Pm8ouapFcf/r6gN6+EBOrp8XE1O2gH8SGuttTBClhqH9vigE/
 CzTrz0BambxpdL01h+dz17DVcbgrXzEXPzCG7n2gFTRtHvmYithQguu3XZUR0YU2rN2xXkI9k6c
 J+zXhQW7i9D7L9mowO6eMQJq69FkZw1n1bV+g==
X-Received: by 2002:a17:902:ccc9:b0:2d7:3f6e:5cb9 with SMTP id
 d9443c01a7336-2dd2a1efc6amr176955195ad.8.1789229873762; 
 Sat, 12 Sep 2026 09:17:53 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2dd2cfe80fdsm24951725ad.67.2026.09.12.09.17.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 09:17:53 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>,
 =?UTF-8?q?Mattias=20R=C3=B6nnblom?= <mattias.ronnblom@ericsson.com>
Subject: [PATCH v2] eal: allow setting random number generator seed
Date: Sat, 12 Sep 2026 09:16:57 -0700
Message-ID: <20260912161744.201627-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260911225845.3168061-1-stephen@networkplumber.org>
References: <20260911225845.3168061-1-stephen@networkplumber.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Many performance tests use rte_rand() and the random number
can perturb the results. Add an ability to override the automatic
random seed on DPDK startup.

This is not a security problem since rte_rand() is documented
as not being cryptographically secure.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Reviewed-by: Morten Brørup <mb@smartsharesystems.com>
---
v2 - fix header inclusion
   - add docbook comment

 lib/eal/common/rte_random.c  | 14 +++++++++++++-
 lib/eal/include/rte_random.h |  8 +++++---
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/lib/eal/common/rte_random.c b/lib/eal/common/rte_random.c
index 576a32a46c..3cc0e3ec5f 100644
--- a/lib/eal/common/rte_random.c
+++ b/lib/eal/common/rte_random.c
@@ -8,6 +8,7 @@
 #endif
 #endif
 #include <unistd.h>
+#include <stdlib.h>
 
 #include <rte_bitops.h>
 #include <rte_branch_prediction.h>
@@ -247,7 +248,18 @@ eal_rand_init(void)
 
 	RTE_LCORE_VAR_ALLOC(rand_state);
 
-	seed = __rte_random_initial_seed();
+	const char *env = getenv("DPDK_RANDOM_SEED");
+	if (env != NULL && *env != '\0') {
+		char *end;
+
+		errno = 0;
+		seed = strtoull(env, &end, 0);
+		if (errno != 0 || *end != '\0')
+			rte_exit(EXIT_FAILURE,
+				 "invalid DPDK_RANDOM_SEED: %s\n", env);
+	} else {
+		seed = __rte_random_initial_seed();
+	}
 
 	rte_srand(seed);
 }
diff --git a/lib/eal/include/rte_random.h b/lib/eal/include/rte_random.h
index 15cbe6215a..bdd4001e78 100644
--- a/lib/eal/include/rte_random.h
+++ b/lib/eal/include/rte_random.h
@@ -20,9 +20,11 @@ extern "C" {
 /**
  * Seed the pseudo-random generator.
  *
- * The generator is automatically seeded by the EAL init with a timer
- * value. It may need to be re-seeded by the user with a real random
- * value.
+ * The generator is automatically seeded by the EAL init with
+ * a system provided random entropy source. But for testing
+ * it can be useful to force a repeatable starting point by
+ * setting the initial seed. This can be done by setting
+ * the `DPDK_RANDOM_SEED` environment variable.
  *
  * This function is not multi-thread safe in regards to other
  * rte_srand() calls, nor is it in relation to concurrent rte_rand(),
-- 
2.53.0

