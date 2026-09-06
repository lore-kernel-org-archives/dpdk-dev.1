Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78851C79F85
	for <dpdk-dev@archiver.kernel.org>; Sun,  6 Sep 2026 17:12:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6DBF640431;
	Sun,  6 Sep 2026 19:12:21 +0200 (CEST)
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com
 [209.85.210.177])
 by mails.dpdk.org (Postfix) with ESMTP id 1AD29402B9
 for <dev@dpdk.org>; Sun,  6 Sep 2026 19:12:19 +0200 (CEST)
Received: by mail-pf1-f177.google.com with SMTP id
 d2e1a72fcca58-8556ec44e9aso2331312b3a.3
 for <dev@dpdk.org>; Sun, 06 Sep 2026 10:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1788714738;
 x=1789319538; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OtCr77T6SQOx/wy6QjQjHsKHu6iLYnW76M/T747HIDI=;
 b=mlttmZyA7VgDu2oJjQ4jDs325zO2fLMZBI12ly/TeZerMUAvIKnoNhCfTcVH6iWds9
 QBa5A6Ql1mPkFL+tAtlvRWYJ3ShspSgj36rkyy1znrjcqo4ZXGoWauOuIEMzX6Gh4QGN
 EjN1B52fsshJDnrozwfV1TcizTzvIMed7R8CPkW8xJHO7zoK8oOi8tljfBjKA2ReuyEH
 nmMRFyCh8ZNytj5N5GBsKLJeMALbj3yMIMwRW+Fkork2YvY56rtLP5cR5MWRcfLu7TSb
 g7LxG0sx+3zMC6sxj63wrtEtacXWwWTt6fXRcMxQtPQTFtP6ZB1nyvwyc5ugoOFuigd3
 WUnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788714738; x=1789319538;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=OtCr77T6SQOx/wy6QjQjHsKHu6iLYnW76M/T747HIDI=;
 b=g/T50Htd7j4WdASyAUCLxpUtg2jmI2z/u2iHnkie1HCLK/PbFugGIa1fUSycYxq63f
 /i6lDAOvZF4M4cSY3Qf+l9ZPYs6s72DC31FOQt5RDQYzVzDHwt5uCmad5YvZy8dTOzgk
 LMmuTDc9mfwSTRZ5mt9yJ3Qas7sz8BFRJ+pX2i2hRWnzN4wHQM6wzrp1I6B32ymYKFGw
 1jScsJjXwhJYGRUQS2p+pUGCVpqyjoiXdebFOjCGjJhwPA898N9hzJw0/IuaVYpZq0SE
 ijTUrfxyDi3pN5hh1GBiSuNeS69CTVD6s+tDTj+9ih+9fXMX0grdEJw4neineq1UY0XL
 AIbw==
X-Gm-Message-State: AFuF++lVYK36s9h53cKPnGlcsL/3xtRk37FM5Pjkm0gJBMloXfg7z1dT
 8yKhemkNMhlRR+3kkeXnqp7jDC3sqW5drdprFjBcOC6J5u1BrMJ40MJ4mi0SDBULJqUtcdf0eC/
 uydcq
X-Gm-Gg: AYBFou0RoyAV9/j9fyRAZnBhMER79HFgVEohsk4nLmtFhJyzbF7aADjkDTQDzCnbzuG
 t6908DabgyNiTgPZeBWK/WG23kyQhRf88wGk2rZWNF4kcQEjz8rP8YP372LccaVh/rfKUBbc/2H
 ZbzkyD5XtzE0ThT3ydIMqsgEyVI5MpbgGDz0uHHopM/B+UnswxJ5fcW0SF8i3DdVIz7xcrZZzOg
 yCE9SC6nZeA1NAsJ6egHaRKjIJf2hFl5KYbfZw6CFNNsGHMn9jIchovzz8kFG8fJwIbExqRhhhQ
 Rsov7msBBiB88rE80XxiKZnAizCi7VYlK4XP9UH7PgRhrx4mO7qPnb8yKFDNZo+eUS7C1gdWNQC
 H72Yb6BOIev/M6KxiRmGWyoxpyFjgdjnT56BzVoDDaK913vaNUg8oaFgCiLYUf1ubtSDD59Gpgh
 CPDRJwbTQJH/Armq1q+dgQGmyOLAwnIQsiSjumYkW187N9U5KL7OrJGcHSOCVPDpA4m4SYPAWXs
 lz9ApZ0LP2V9gv0nqqOaYqPaDg=
X-Received: by 2002:a05:6a00:2883:b0:84f:dfa8:57c5 with SMTP id
 d2e1a72fcca58-8616a36d642mr29310499b3a.13.1788714738261; 
 Sun, 06 Sep 2026 10:12:18 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-86152f32447sm3309910b3a.38.2026.09.06.10.12.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Sep 2026 10:12:17 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v2 3/5] eal: make unaligned really unaligned
Date: Sun,  6 Sep 2026 10:09:56 -0700
Message-ID: <20260906171142.3503868-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260906171142.3503868-1-stephen@networkplumber.org>
References: <20260904220953.3105930-1-stephen@networkplumber.org>
 <20260906171142.3503868-1-stephen@networkplumber.org>
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

The common tests that expected unaligned to really have no
guaranteed alignment would fail with UBSAN. The root cause
was the definition of unaligned still implied alignment on x86.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/rel_notes/release_26_11.rst | 6 ++++++
 lib/eal/include/rte_common.h           | 9 +++------
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index 4cadfc1918..4b219cbc97 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -109,6 +109,12 @@ API Changes
     compile with an integer argument, but this is deprecated usage: existing code
     should use ``RTE_ALIGN``, ``RTE_ALIGN_CEIL`` or ``RTE_ALIGN_FLOOR`` instead.
 
+* **eal: Unaligned integer types are now really unaligned.**
+
+  ``unaligned_uint16_t``, ``unaligned_uint32_t`` and ``unaligned_uint64_t``
+  are now declared with an alignment of 1 on all architectures.
+  The compiler may generate narrower loads and stores than before.
+
 
 ABI Changes
 -----------
diff --git a/lib/eal/include/rte_common.h b/lib/eal/include/rte_common.h
index ed037be399..ee2ca75908 100644
--- a/lib/eal/include/rte_common.h
+++ b/lib/eal/include/rte_common.h
@@ -149,15 +149,12 @@ extern "C" {
 #define __rte_aligned(a) __attribute__((__aligned__(a)))
 #endif
 
-#ifdef RTE_ARCH_STRICT_ALIGN
+/**
+ * Integer types with no alignment requirement.
+ */
 typedef uint64_t unaligned_uint64_t __rte_aligned(1);
 typedef uint32_t unaligned_uint32_t __rte_aligned(1);
 typedef uint16_t unaligned_uint16_t __rte_aligned(1);
-#else
-typedef uint64_t unaligned_uint64_t;
-typedef uint32_t unaligned_uint32_t;
-typedef uint16_t unaligned_uint16_t;
-#endif
 
 /**
  * Force a structure to be packed
-- 
2.53.0

