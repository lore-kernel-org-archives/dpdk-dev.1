Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC12FCA5FFD
	for <dpdk-dev@archiver.kernel.org>; Tue,  6 Oct 2026 02:31:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5A79D40DF5;
	Tue,  6 Oct 2026 04:30:59 +0200 (CEST)
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mails.dpdk.org (Postfix) with ESMTP id DE56440664
 for <dev@dpdk.org>; Tue,  6 Oct 2026 04:30:57 +0200 (CEST)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-cc7361c62b9so1599230a12.3
 for <dev@dpdk.org>; Mon, 05 Oct 2026 19:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1791253857; x=1791858657; darn=dpdk.org;
 h=content-type:cc:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=TzfGJdkfjy5n+V5HI7q9414YKUy4A+F2ah+ZBW/ZlQI=;
 b=ucA8RTLvBjIQuiPM94qG8LQ3gWEuVSYqs1zBN1iuWJQsh6FLrqVnZErJuy7gzxOvFV
 +MMr+fL5VsMywPNO7DT1GlWiJ+kdprlnU9ItV2Qi8aUK6G8rsbBbg/h6IW5dunu3szZh
 SF2dVyBSmZvjIj1bERtjBfir78R3i3Czwo+tnlkFMv0InyBTXQuopormUsuRJkZLEG6i
 WfGqkai94iX+Pe2McbwWgKo+WgseKIpfDEyhOqS76MxhP7APP5ZQGjPTyDmR13ZjL/wl
 VO9GC1vrSmK3iTggcw0vi25SSYh0TwmFCPTFn2ImQ/jD1ruVOplUaB3NXyyN4crZT0cT
 Ku8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791253857; x=1791858657;
 h=content-type:cc:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TzfGJdkfjy5n+V5HI7q9414YKUy4A+F2ah+ZBW/ZlQI=;
 b=rytPoPiC1kXlMiygrjntRTd/hNZ8LhlzwRiJWNZUuxAVpsi2BlfZ0EqQKh8a/canOj
 hrLTpKEH0dVZVTvwAwK3z/+6fxFTWJ1XrLwBLMaNj2jiqvfoidVWXxqvtHcOECR/goxC
 E4xZ9ZT8YzJ3BAuI55NjLqZo5WsaGO+mM5kcnSFui8S3/+0+dZPz6KruMWqSXUC8s1sP
 au2Mm0IpDLoPADs6WsiX1/5BnCagS1F5KFZnNAAEsjcH7OVSj+EMFvH1qX2wl3O1/iQO
 tzzHpFr1IQ/tl0tS0gUDR8j2OILLPgCDWqUyMvS6C3KFo53nhff4J/KQzahQTmTjm0R0
 SITw==
X-Gm-Message-State: AFq9FYIoJAuJHQXnEzaxHFRkHjT+dqiSU1HTSLjDkxn9GQwy+HWkksYD
 o4wv3XozLQsVO2TQiNt6G0lg9aQE2K3VeQcU1A+37dwZVzW2uP/hA8IjGopLTPKVbODq6kAySGK
 CE+oTvOJcqbNI2KJYKmIorEq0hRv3LchTTW0jpROOdI/gizkb3DHCwabPSaW2kq197eZZZjUzlk
 lLnRXWwM/UzVD9gto3fomj0cTASg2OuyoR+g==
X-Received: from plbml11.prod.google.com ([2002:a17:903:34cb:b0:2e4:a84a:1ccb])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:3c26:b0:2df:8aea:7d92 with SMTP id
 d9443c01a7336-2e5dcdda5ffmr399165ad.47.1791253856549; 
 Mon, 05 Oct 2026 19:30:56 -0700 (PDT)
Date: Mon,  5 Oct 2026 19:30:37 -0700
In-Reply-To: <20261006023053.2572501-1-joshwash@google.com>
Mime-Version: 1.0
References: <20260923010742.2468145-1-joshwash@google.com>
 <20261006023053.2572501-1-joshwash@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261006023053.2572501-2-joshwash@google.com>
Subject: [PATCH v4 01/15] eal: introduce division round up macro
From: Joshua Washington <joshwash@google.com>
Cc: dev@dpdk.org, Joshua Washington <joshwash@google.com>, 
 Bruce Richardson <bruce.richardson@intel.com>,
 Chengwen Feng <fengchengwen@huawei.com>
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
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
Acked-by: Chengwen Feng <fengchengwen@huawei.com>
---
Changes in v4:
  - Rebased changes
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
index 030bd84cea..430e5ab1c1 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -138,6 +138,11 @@ New Features
   Added ``rte_bbdev_queue_stats_get()`` function to retrieve statistics
   for a specific queue, complementing the existing device-level statistics API.
 
+* **Added division round up macro.**
+
+  Added the ``RTE_DIV_ROUND_UP`` macro in ``rte_common.h`` to divide dividend
+  by divisor, rounding up to the nearest integer.
+
 
 Removed Items
 -------------
diff --git a/lib/eal/include/rte_common.h b/lib/eal/include/rte_common.h
index f872d3eabb..f3ff632713 100644
--- a/lib/eal/include/rte_common.h
+++ b/lib/eal/include/rte_common.h
@@ -704,6 +704,24 @@ static void __attribute__((destructor(RTE_PRIO(prio)), used)) func(void)
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
2.56.0.rc1.315.gc6ed9934b7-goog

