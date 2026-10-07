Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18CFDCA5FFF
	for <dpdk-dev@archiver.kernel.org>; Wed,  7 Oct 2026 21:41:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0C33E427A9;
	Wed,  7 Oct 2026 23:41:27 +0200 (CEST)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
 [209.85.214.174])
 by mails.dpdk.org (Postfix) with ESMTP id E5648402DF
 for <dev@dpdk.org>; Wed,  7 Oct 2026 23:41:25 +0200 (CEST)
Received: by mail-pl1-f174.google.com with SMTP id
 d9443c01a7336-2e61ac64ec3so6947155ad.2
 for <dev@dpdk.org>; Wed, 07 Oct 2026 14:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791409285;
 x=1792014085; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cC9+CNDDaxuizQopBoEqxbqtB42gM7uQ7zCp2XEP6rc=;
 b=dKTQgwK9QJjTSrzmzMpHXFGxjKdyT8W/yz7wao24mpSQXoB5VRAGfJZsVOSMVNHHNo
 Kf2mhu8ms2rxO3LhpApA1yDHD8USUz6CQEfaAV7AEVDwlpy6JW5zBolvdFUOL+Jk2IcQ
 FjWrct0AXLrCUO41pihe4xH45w9p5Aec4MOHn5U6oy26kehAdsF9IhUA6j4/30nqsvV4
 1Sd1S5OYIiTU72v41uDWEbLzONC/AttHHbqp8CvIOvG/o2j61CgwO+lQKl+YzgswSrpC
 M/Bs7yWBEJRUYbkGxvH/IO2xE6c6xMdCioftf9e6VQ1SFh5U8tSjYSPI4n2q3GyifO5g
 XqSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791409285; x=1792014085;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=cC9+CNDDaxuizQopBoEqxbqtB42gM7uQ7zCp2XEP6rc=;
 b=carl4jWdex/YtnhC+rHXTXx8qkurCdfNPP16bmabCaNmmwlcWfxVIyoJ7rDEGVSgTs
 rZZTBRd1SWE+9rE61YNEak4LIbuYq/yRmU5RGIJiFQEm3fYyh9mPBA925u+Bvudb9g1f
 FkNnXlEboSvQ1k7bYiXNopUGzCZeZsmrVVJOXwXu9Zibaiy9VwJnkqjC0/9ltV9Lz5+v
 izTVtyHCs/k/x7dcmjf2ZhWFLFPv1K1ceLqb8gkushWijAgVlW+NaXchKXC2KZnnzSnb
 PfOS8I1/MgBMJyqhLpJWf6g5s45KdHoBxO+oR4WEQf/wltmaBOCbuOAyVvldsSL+45xh
 NK+w==
X-Gm-Message-State: AFq9FYL1Z9i0Ndc7STdtYGhbTHRD5224Rt/gFqbEhzCHZ3XpI0Vh14Bt
 jZ+dqsb+kWbZQX+Ri/vV7gT9/lX3BuA2SvTxD79pGr3LPM1QaxeYLkdloZasOH1lRtg7BXxzHfD
 YDvK91Y0=
X-Gm-Gg: AYBFou24UmzqOkOL5kZcOopcSoyOPVm4r3Ixc6oAyTdXm8btbBsZji5gbQ1thAWTd28
 70i0yjlQHpzWY0DEUu+O22yyYthmVr3glEVPvFq1Ilk9Qd9NwY5q/zl1xneQt4WaoS4EoVagM4j
 r8q86tRKuQdtKQZLQoR0EK7rlXthsr67a/r0rMK/KeJtesj07eNvdlparVs1Qv9++3tic2SAlG2
 QgwdQ8E5Cu5zm7KSbqz6C6DRBm16YjnWFVubW7GZPb4CQ0B8OShD2zMfZFaiRhNrNUfHdwwRSAb
 OzTqmrEOaMsCYEKj1g8MHKLXEfbftD5wuVncMULQZtNzX7J8JtVUwHJknCuDFJTrGkQOJ0+6htN
 d+F0LsEAB8CaajsoJzYMrvUHtbkS/GvEtppoxNdoRZ/s2t+/PLVGpKz9NUQ7putCrkwPfn+OOWd
 6j9tbdLzbmJ7GmKCbDZzltlRQD2LhKBMIY92v7K50uBMTc1KuVxiZMUoQbfCspgyrzP0puZ1KLY
 lzQsN6RkLpNuM8DXeDW9NwvzaT/NFC2TAbbZ31B6UaLcefL
X-Received: by 2002:a17:902:d983:b0:2e2:cc25:b232 with SMTP id
 d9443c01a7336-2e6004ebcafmr31205255ad.42.1791409285074; 
 Wed, 07 Oct 2026 14:41:25 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e60484ca89sm16573335ad.57.2026.10.07.14.41.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2026 14:41:24 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 =?UTF-8?q?Mattias=20R=C3=B6nnblom?= <mattias.ronnblom@ericsson.com>
Subject: [PATCH 05/20] eal: promote lcore variables API to stable
Date: Wed,  7 Oct 2026 14:39:35 -0700
Message-ID: <20261007214115.3092715-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261007214115.3092715-1-stephen@networkplumber.org>
References: <20261007214115.3092715-1-stephen@networkplumber.org>
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

rte_lcore_var_alloc() was added in 24.11 and has not changed. The
RTE_LCORE_VAR_* macros that form the public interface were never marked
experimental, so the header carried a file level warning while the
macros applications actually use looked stable.

The API is used by rte_random, rte_service, the x86 power intrinsics and
the power PMD management code. Promote the allocator and drop the file
level warning.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/rel_notes/release_26_11.rst | 4 ++++
 lib/eal/common/eal_common_lcore_var.c  | 2 +-
 lib/eal/include/rte_lcore_var.h        | 3 ---
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index 934efaaf93..62e7df5728 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -240,6 +240,10 @@ API Changes
   are now declared with an alignment of 1 on all architectures.
   The compiler may generate narrower loads and stores than before.
 
+* eal: Promoted ``rte_memzero_explicit``, ``rte_free_sensitive``,
+  ``rte_basename``, ``rte_size_to_str`` and the lcore variables API
+  from experimental to stable.
+
 * ethdev: Updated VMDq related API.
 
   * At port configuration time, the number of VMDq pools advertised by a driver
diff --git a/lib/eal/common/eal_common_lcore_var.c b/lib/eal/common/eal_common_lcore_var.c
index 8a7920ed0f..a2af0e19d8 100644
--- a/lib/eal/common/eal_common_lcore_var.c
+++ b/lib/eal/common/eal_common_lcore_var.c
@@ -76,7 +76,7 @@ lcore_var_alloc(size_t size, size_t align)
 	return handle;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_lcore_var_alloc, 24.11)
+RTE_EXPORT_SYMBOL(rte_lcore_var_alloc)
 void *
 rte_lcore_var_alloc(size_t size, size_t align)
 {
diff --git a/lib/eal/include/rte_lcore_var.h b/lib/eal/include/rte_lcore_var.h
index 48b022e84e..2737ae947b 100644
--- a/lib/eal/include/rte_lcore_var.h
+++ b/lib/eal/include/rte_lcore_var.h
@@ -15,8 +15,6 @@
  *
  * Please refer to the lcore variables' programmer's guide
  * for an overview of this API and its implementation.
- *
- * EXPERIMENTAL: this API may change, or be removed, without prior notice.
  */
 
 #include <stddef.h>
@@ -199,7 +197,6 @@ rte_lcore_var_lcore(unsigned int lcore_id, void *handle)
  *   The variable's handle, stored in a void pointer value.
  *   The value is always non-NULL.
  */
-__rte_experimental
 void *
 rte_lcore_var_alloc(size_t size, size_t align)
 	__rte_alloc_align(2);
-- 
2.53.0

