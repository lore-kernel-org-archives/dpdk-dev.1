Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7198CC88E77
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Sep 2026 19:22:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CA4E242E48;
	Tue, 15 Sep 2026 21:22:26 +0200 (CEST)
Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com
 [74.125.227.141])
 by mails.dpdk.org (Postfix) with ESMTP id 0854C42E4C
 for <dev@dpdk.org>; Tue, 15 Sep 2026 21:22:25 +0200 (CEST)
Received: by mail-pj2-f13.google.com with SMTP id
 98e67ed59e1d1-396ccd4f99cso126896a91.0
 for <dev@dpdk.org>; Tue, 15 Sep 2026 12:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789500144;
 x=1790104944; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1qyO6lbG8tcvpPlqDAJnZh3MAaJmcgm2Anc4D4dwEko=;
 b=YFURskZZfHEyj1nN6cvACn/UPg1dneR+1e/+yiAG5wXxW5HMoQ7iuflQxhqOPDuunJ
 mrtjojFPxC7bhoZFS9HPA0TS7h9hKlqesYNGYa8ZaZMkq85NSPd6e13exFqK+yq36wTp
 UeSq2i55u2KVdfFmvb+xcRijw92A1dBGN2sWbyFEPwzBPU1jGpN9IfTQYP4ksydhvida
 3e+UEn6oufcjhUlKCOG6HjzV19h4a2gRfnQNxdw4zI6m8r7ctb7mqycbTWvuhKWgnUBA
 oxShBDnAy73ffmb0o5+lW07GIHRME5g9lKqgfVgYVJHIezE4l773yzqHL94CAKpHi2Id
 gH9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789500144; x=1790104944;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=1qyO6lbG8tcvpPlqDAJnZh3MAaJmcgm2Anc4D4dwEko=;
 b=Z5JbvYFu0HfdgPv8gRMyLil3u9gFgJFzNyafWObn36n2N3FPNRAX4pKR8IfmnlpEYe
 9Bp/vXH/naw9EVx9b4tXdFsUCukHJCMpsjKC8Z8yZVEhxV34i0EYnqN4GdX1fyCFFJgT
 z8UWkoBwqt82LyhE444K9C4MIjpMACGvm+unxIzikZ8an7PX1ZOGibpxSnp+wJ3fDxKG
 V42D19uYnYib3EpXfdAbhWhUHf0zJlwuXcvsFiSdee+ZoIN9z9vJodaNbLjoRxsvIpvK
 c66gfYZGudAJRt8cIak0iXaVQaXJzSGgvWJ5iNPT1ABP0/hS0dbajhVypTIcDU3bO+l3
 EfSg==
X-Gm-Message-State: AFuF++n45sbzMK50ObRueG6DphEvvPtm1Dd5wgKKkGZDtpcbQKhQlmHQ
 K58XCt9rhtvwno08V6Q/tVpgIeeAzU0QwcBaW4K+E1wnX/zCCcMIgvh/oH97UgZTcuAMb3wQD7t
 GURV9BoAPcQ==
X-Gm-Gg: AYBFou3a88DeYxuVvtvf08zy2XXJY1mTh0Zr2bHTOmyJQt50aceY2h+xqrDNaHdBp6j
 zHd1Q98vBHXON88a/7f1xkoWz738dQQalobFeplqLN5JgC06EkB2qaasIbaRgakj1IQMBUaMQD+
 ll2qpsg6pygcn5w8DGEql2GMG5yAyDcmpygQTNjtHi3rY2vrBJ/smWWiWVZb/JyQqs1GBlqS7OX
 5cxHsWSq1g4q5YmhPUtLJBouteM445dIibH/eJ3KkIK2xXX47Tvy6Ji2D10tZgf1Ls+qwcI2Qdd
 fVZlt41lPiMi7DK8eGAK89/PmnYtmCnmzhZGMOneGr0fcVoyrnvPPO2jlZreJebwroLzyhDM3k3
 pLbsVOn+ReX3RUn6ymFzgrH2thND1A2y55M/07P/JtL5A44iqUgttqHK9OK3FKiJxSETSDxQfkX
 BVCgtQi5i10qvH9+YWH5T5SbdRjPtZ22J5GsKCcvLSK7aLPSfSAk5h1h+5ZCneQlMPqIJPs1gr6
 n9rdz2u540TPuK680j83Dbo5bOOQKsaJSyW7Q==
X-Received: by 2002:a17:90a:2ce2:b0:39e:1633:d29e with SMTP id
 98e67ed59e1d1-39e1633d707mr1550964a91.5.1789500144132; 
 Tue, 15 Sep 2026 12:22:24 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39e1bbfdd49sm217535a91.11.2026.09.15.12.22.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 12:22:22 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 =?UTF-8?q?Mattias=20R=C3=B6nnblom?= <mattias.ronnblom@ericsson.com>
Subject: [PATCH 03/18] eal: add 32 bit random number function
Date: Tue, 15 Sep 2026 12:21:01 -0700
Message-ID: <20260915192207.3926217-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260915192207.3926217-1-stephen@networkplumber.org>
References: <20260915192207.3926217-1-stephen@networkplumber.org>
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

Add a function returning a 32 bit random value. Callers that only
need 32 bits currently have to truncate the result of rte_rand(),
which assumes that the low bits of the generator are as good as the
high ones. That happens to hold for the current generator but is not
a property callers should have to know about.

Returning the high bits keeps the function correct for the common
case where a generator has weaker low order bits.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/rel_notes/release_26_11.rst |  2 ++
 lib/eal/common/rte_random.c            | 10 +++++++
 lib/eal/include/rte_random.h           | 39 +++++++++++++++++++-------
 3 files changed, 41 insertions(+), 10 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index 5852f7acfb..1dc634d504 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -58,6 +58,8 @@ New Features
 * **Updated random number generation.**
 
   * The initial seed is now always taken from ``getentropy()``.
+  * Added ``rte_rand32()`` for callers which only need 32 bits and would
+    otherwise have to truncate the result of ``rte_rand()``.
 
 
 Removed Items
diff --git a/lib/eal/common/rte_random.c b/lib/eal/common/rte_random.c
index b036c50349..1368b70e27 100644
--- a/lib/eal/common/rte_random.c
+++ b/lib/eal/common/rte_random.c
@@ -158,6 +158,16 @@ rte_rand(void)
 	return __rte_rand_lfsr258(state);
 }
 
+RTE_EXPORT_SYMBOL(rte_rand32)
+uint32_t
+rte_rand32(void)
+{
+	/* Use the high bits, they are the ones that stay good if the
+	 * underlying generator is ever changed.
+	 */
+	return (uint32_t)(rte_rand() >> 32);
+}
+
 RTE_EXPORT_SYMBOL(rte_rand_max)
 uint64_t
 rte_rand_max(uint64_t upper_bound)
diff --git a/lib/eal/include/rte_random.h b/lib/eal/include/rte_random.h
index 978ecda203..9d3ecc596e 100644
--- a/lib/eal/include/rte_random.h
+++ b/lib/eal/include/rte_random.h
@@ -13,6 +13,8 @@
 
 #include <stdint.h>
 
+#include <rte_compat.h>
+
 #ifdef __cplusplus
 extern "C" {
 #endif
@@ -27,7 +29,7 @@ extern "C" {
  *
  * This function is not multi-thread safe in regards to other
  * rte_srand() calls, nor is it in relation to concurrent rte_rand(),
- * rte_rand_max() or rte_drand() calls.
+ * rte_rand32(), rte_rand_max() or rte_drand() calls.
  *
  * @param seedval
  *   The value of the seed.
@@ -40,9 +42,9 @@ rte_srand(uint64_t seedval);
  *
  * The generator is not cryptographically secure.
  *
- * rte_rand(), rte_rand_max() and rte_drand() are multi-thread safe,
- * with the exception that they may not be called by multiple
- * _unregistered_ non-EAL threads in parallel.
+ * rte_rand(), rte_rand32(), rte_rand_max() and rte_drand() are
+ * multi-thread safe, with the exception that they may not be called
+ * by multiple _unregistered_ non-EAL threads in parallel.
  *
  * @return
  *   A pseudo-random value between 0 and (1<<64)-1.
@@ -50,15 +52,32 @@ rte_srand(uint64_t seedval);
 uint64_t
 rte_rand(void);
 
+/**
+ * Get a 32 bit pseudo-random value.
+ *
+ * Prefer this over truncating the result of rte_rand() since not
+ * every generator produces equally good values in all bit positions.
+ *
+ * The generator is not cryptographically secure.
+ *
+ * This function is multi-thread safe, with the exception that it may
+ * not be called by multiple _unregistered_ non-EAL threads in parallel.
+ *
+ * @return
+ *   A pseudo-random value between 0 and (1<<32)-1.
+ */
+uint32_t
+rte_rand32(void);
+
 /**
  * Generates a pseudo-random number with an upper bound.
  *
  * This function returns an uniformly distributed (unbiased) random
  * number less than a user-specified maximum value.
  *
- * rte_rand(), rte_rand_max() and rte_drand() are multi-thread safe,
- * with the exception that they may not be called by multiple
- * _unregistered_ non-EAL threads in parallel.
+ * rte_rand(), rte_rand32(), rte_rand_max() and rte_drand() are
+ * multi-thread safe, with the exception that they may not be called
+ * by multiple _unregistered_ non-EAL threads in parallel.
  *
  * @param upper_bound
  *   The upper bound of the generated number.
@@ -76,9 +95,9 @@ rte_rand_max(uint64_t upper_bound);
  *
  * The generator is not cryptographically secure.
  *
- * rte_rand(), rte_rand_max() and rte_drand() are multi-thread safe,
- * with the exception that they may not be called by multiple
- * _unregistered_ non-EAL threads in parallel.
+ * rte_rand(), rte_rand32(), rte_rand_max() and rte_drand() are
+ * multi-thread safe, with the exception that they may not be called
+ * by multiple _unregistered_ non-EAL threads in parallel.
  *
  * @return
  *   A pseudo-random value between 0 and 1.0.
-- 
2.53.0

