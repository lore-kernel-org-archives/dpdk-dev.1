Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D8A9C982FE
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Sep 2026 01:07:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D6D0040DD2;
	Wed, 23 Sep 2026 03:07:48 +0200 (CEST)
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mails.dpdk.org (Postfix) with ESMTP id AFF5740041
 for <dev@dpdk.org>; Wed, 23 Sep 2026 03:07:46 +0200 (CEST)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2cfa4e4684bso7207685ad.2
 for <dev@dpdk.org>; Tue, 22 Sep 2026 18:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1790125666; x=1790730466; darn=dpdk.org;
 h=content-type:cc:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=14c8MNpjoTxwMW/+6J7ydau2TveV/ISeaxyDTbXtOtQ=;
 b=YskcX9em9jvOCClU1tAQmmOXis3xGRDDRdvEbL202x2yAruITLwQYZnvhlucRq/Iap
 UnkrJ/RBKDgtEOIxnp+1y0E0KTXetW5T8YI3gpdllutbdAs/vLb4h1OLZSzvdBZudr6g
 dz0GFHtpT+UOErAzrR+CwdzaqipqTAfhXyWwg7EFvUEugiRWDe/KAGq/VSnFql5uJLOL
 Rujbf7fNua6rTWbWcZQl4Jpd1lcdZ3gfwzrUW53ySAZg5DXPfm0ATYYYPatVLX/kdDfp
 WnXTzOxE+ni3s+tQ1lruM58CjcnVCMaZ42qeLX2SPJW5fFOo+5opY7FG7Da22u6Y9FQ4
 jrQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790125666; x=1790730466;
 h=content-type:cc:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=14c8MNpjoTxwMW/+6J7ydau2TveV/ISeaxyDTbXtOtQ=;
 b=Y+4KASbDCeNVFi8B8prNGi8lxxEMY/WWfAQWfurZODCPOzTGhnYNISfSImrnGpG6KZ
 M3Y6F7K+j/TOLdCGF5jDeRtMRv/QpYniHpJGCtB9pI09KyqVt+T/5F54MOW9Xpb9OXdT
 r9IyV+ywT/UrqOKsb4/Z8h6xvfzbmbUzs3IbqsGSRj5R8Bv2YznwhDtdgKsE01GsjUBo
 HJYO3dwdM+9FmKtB08HK8yA/zSp9xxLhuZ2wayKxQRiWWS0oQc0BLGqo+oUzQtRCA54i
 QlxLK9A8AOixhX5tVml2Fktz5/HH3X4LiHbNVUuQCFhBHLTnjkXb7aIx9TeSEip+cTXa
 jZeQ==
X-Gm-Message-State: AFuF++nzQYpdV1cJPbsc/Esa6d3vYOVw+n3WYWYi3QxNodsQJceLRqYF
 rjAHwq1ZuAgkF1jwPux+f7XAIhzjyyzqWwQRiyTgHbouBUOtNKGSHCZdvDR1X23kbCblvUJZ+OI
 0/StKtbbetSc8UUG3rLDSu60jbWRCdhAcj/S2Y6yso00V6eoSv7F1MJLKYq6NLFDxZR7Yc0CIrG
 8Eooq99YASjt29v9U7DfMdNwZ7ka6tdfcttQ==
X-Received: from plad12.prod.google.com ([2002:a17:902:e14c:b0:2df:69be:94b6])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:1112:b0:2dd:c100:313d with SMTP id
 d9443c01a7336-2df69df7524mr8950365ad.57.1790125665351; 
 Tue, 22 Sep 2026 18:07:45 -0700 (PDT)
Date: Tue, 22 Sep 2026 18:07:24 -0700
In-Reply-To: <20260923010742.2468145-1-joshwash@google.com>
Mime-Version: 1.0
References: <20260812223017.2980190-1-joshwash@google.com>
 <20260923010742.2468145-1-joshwash@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260923010742.2468145-2-joshwash@google.com>
Subject: [PATCH v3 01/16] eal: introduce division round up macro
From: Joshua Washington <joshwash@google.com>
Cc: dev@dpdk.org, Joshua Washington <joshwash@google.com>
Content-Type: text/plain; charset="UTF-8"
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

A number of drivers define the DIV_ROUND_UP macro -- add it to
rte_common.h so that other code looking to use that functionality
doesn't have to re-define it.

Signed-off-by: Joshua Washington <joshwash@google.com>
---
Changes in v3:
  - Add unit tests in app/test/test_common.c.
  - Add release notes entry.
  - Enhance Doxygen documentation to document parameters and caveats
    (divisor evaluation, non-negative inputs, wraparound).
Changes in v2:
  - Split out patches replacing usages
---
 app/test/test_common.c                 | 10 ++++++++++
 doc/guides/rel_notes/release_26_11.rst |  5 +++++
 lib/eal/include/rte_common.h           | 18 ++++++++++++++++++
 3 files changed, 33 insertions(+)

diff --git a/app/test/test_common.c b/app/test/test_common.c
index 3e1c7df0c1..bce2776ea6 100644
--- a/app/test/test_common.c
+++ b/app/test/test_common.c
@@ -47,6 +47,16 @@ test_macros(int __rte_unused unused_parm)
 		"RTE_MAX");
 	RTE_TEST_ASSERT_EQUAL(RTE_MIN(SMALLER, BIGGER), SMALLER,
 		"RTE_MIN");
+	RTE_TEST_ASSERT_EQUAL(RTE_DIV_ROUND_UP(10, 5), 2,
+		"RTE_DIV_ROUND_UP exact");
+	RTE_TEST_ASSERT_EQUAL(RTE_DIV_ROUND_UP(11, 5), 3,
+		"RTE_DIV_ROUND_UP remainder");
+	RTE_TEST_ASSERT_EQUAL(RTE_DIV_ROUND_UP(0, 5), 0,
+		"RTE_DIV_ROUND_UP n=0");
+	RTE_TEST_ASSERT_EQUAL(RTE_DIV_ROUND_UP(0, 1), 0,
+		"RTE_DIV_ROUND_UP n=0, d=1");
+	RTE_TEST_ASSERT_EQUAL(RTE_DIV_ROUND_UP(5, 1), 5,
+		"RTE_DIV_ROUND_UP d=1");
 
 	RTE_TEST_ASSERT_EQUAL(RTE_PTR_ADD(arr + 1, sizeof(arr[0])), &arr[2],
 		"RTE_PTR_ADD(expr, x)");
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index c8cc86295d..7720fd9f96 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -55,6 +55,11 @@ New Features
      Also, make sure to start the actual text at the margin.
      =======================================================
 
+* **Added division round up macro.**
+
+  Added the ``RTE_DIV_ROUND_UP`` macro in ``rte_common.h`` to divide dividend
+  by divisor, rounding up to the nearest integer.
+
 
 Removed Items
 -------------
diff --git a/lib/eal/include/rte_common.h b/lib/eal/include/rte_common.h
index 79d2a0ab93..9707f7e255 100644
--- a/lib/eal/include/rte_common.h
+++ b/lib/eal/include/rte_common.h
@@ -717,6 +717,24 @@ static void __attribute__((destructor(RTE_PRIO(prio)), used)) func(void)
 		(ceil - (v)) > ((v) - floor) ? floor : ceil;	\
 	})
 
+/**
+ * Macro to divide dividend @p n by divisor @p d, rounding up if @p d does not divide @p n.
+ *
+ * @param n
+ *   Dividend. Must be a non-negative integer to round correctly.
+ * @param d
+ *   Divisor. Must be a positive integer. Evaluated twice.
+ * @return
+ *   Result of dividing @p n by @p d, rounded up.
+ *
+ * @note The divisor @p d is evaluated twice. Arguments must not have side effects.
+ * @note Both @p n and @p d must be non-negative to round correctly.
+ * @note The sum @c (n) + (d) - 1 can wrap around if @p n is close to the maximum
+ *       representable value of its type (e.g. RTE_DIV_ROUND_UP(UINT32_MAX, 2)
+ *       on uint32_t wraps to 0).
+ */
+#define RTE_DIV_ROUND_UP(n, d) (((n) + (d) - 1) / (d))
+
 /**
  * Checks if a pointer is aligned to a given power-of-two value
  *
-- 
2.55.0.1082.g2b9226bbc0-goog

