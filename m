Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F564C79FAA
	for <dpdk-dev@archiver.kernel.org>; Mon,  7 Sep 2026 18:33:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9828A40DD8;
	Mon,  7 Sep 2026 20:33:17 +0200 (CEST)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com
 [209.85.214.178])
 by mails.dpdk.org (Postfix) with ESMTP id 7BF6640B9C
 for <dev@dpdk.org>; Mon,  7 Sep 2026 20:33:16 +0200 (CEST)
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-2d9004f39d3so46148895ad.2
 for <dev@dpdk.org>; Mon, 07 Sep 2026 11:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1788805996;
 x=1789410796; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Jx8iaIf/0vGHOZtulQ1Opb6LIjH5Gt0pVLOS/yzw3f0=;
 b=ShhTJUDPzpQkJDD+4NY8sqPKI6lX4iqIfpSuuADhX246Dup4cs1qIpaS0wz8bgs1RK
 z5N0iMO+8ggOtn7XFn1l4ST6bETze+ew4Mw1+Ck5xlk2pmj2Y+Pmdsbj5TBHprnrG0l1
 iO3ivy7Ls0RVqfc0nuoDPVK3qU+I7u8v0JsZ5v8kX8Ly22VqQACLQj49ROvm1eV/IPtt
 uN7Ei6fkB0t1r9rGi/FS9iLmUrxPUgp8ef4M70IBdhqeMPbX5x1tWMoW/SzjLiR1p5B8
 v6mE6FNz58tbDAd2hkXAIFU2cp++DK3NzT59n0JGPqtaWIPyP+ETzPDNdWmhIOzV215Z
 +jfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788805996; x=1789410796;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Jx8iaIf/0vGHOZtulQ1Opb6LIjH5Gt0pVLOS/yzw3f0=;
 b=hwdGWpci4pw8AcJPcusy1XNYYaLHEr3SPjn68ZohQ6t/ExpU3hqaykiIgEKGkuWWY2
 W+X03SNQJEnpsdE6Ce//AJyAd/8nR908ear1M2VmI7a4TPktL7z0Ay5AUatn7S9iDP6v
 apgGJuU9faeB2A+lLWCyYIrkdR0plB1wOzUXCWbqwy8qCZcfiAKqJa+fuO2E87gjN1nR
 7Hjc35u//H2voNYyMK4FhrKZgqkNYPcxnXoVNxET/mYxNG5XQe+h1lqAtaIlTmYl0Ocz
 yw2qSMZCo/mY75eAI6olw5I1ZsKUoKyXlktvRhpJeCDWpniSnFAntu7TzCN3fi3cJk8n
 a7hQ==
X-Gm-Message-State: AFuF++mgHaAJLkMgCq9Iz+/SSvbRtIvGxd9ji/FapSybp5/YiO0SKDaQ
 aqbjXpnOgwUofyE3sVmWGqUZBK2PKXEqffDTchkKN+S2DL8AVB3gwUSYQe7KhsbdHfsvxzK8m4e
 YVbz/
X-Gm-Gg: AYBFou05RbWkiWRpQ8EVQ2biHABcqzcRvzi67vKb9PUZgLHKR3+2PMLRBUzEIGbLM68
 UwBkAtg0TnmAFhN3QwwK2VLjzi/4c4edsd6/IQnAo0Y5F10YdWgspL9PFn2CW0bPF6s3ZGZ+nCB
 G1y4QSvyK2YVfGGABEEH0v54K2Aj+0hX0e3Jdt1n/KHBmADxKSmyQMwfJc6t02t2rTPSwoMMmg7
 0CAyHjonEO1+/GyTbyk6Q3i6mKQcQnqQPAIcR1GG8/Y1WwV79rJ1KBDGSzyISieAwJS1cthzxtA
 QISbRx0K9ebNwc/DC9HW0aIfTw4RpkJlqU7sRbvSr7LkBgW0DFT1sC0uxz0uJFRQVdOqaBFmLrt
 Vrojbv0T7epN8l37otIwhSxvW/oy9OvY7CW5FqOnv734M+lYMlgbC6m9Q1cwzBOLLTSumW61r45
 Le6HADLZArpYaOE8oZfIRykmdQbV4gg421S3+of2ZZ4lnh0n+QRRtT/Hhs1eCCG2WklxhSNCCoz
 ZUjRiZ/6ol5EtYJA3Kq68boJkk=
X-Received: by 2002:a17:903:910:b0:2db:5c0a:f184 with SMTP id
 d9443c01a7336-2db5c0b1641mr90952265ad.17.1788805995637; 
 Mon, 07 Sep 2026 11:33:15 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2db1495a0c0sm47590795ad.17.2026.09.07.11.33.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 11:33:15 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v3 3/5] eal: make unaligned really unaligned
Date: Mon,  7 Sep 2026 11:31:22 -0700
Message-ID: <20260907183239.629053-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260907183239.629053-1-stephen@networkplumber.org>
References: <20260904220953.3105930-1-stephen@networkplumber.org>
 <20260907183239.629053-1-stephen@networkplumber.org>
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
 doc/guides/rel_notes/release_26_11.rst |  6 ++++++
 lib/eal/include/rte_common.h           | 13 ++++++++-----
 2 files changed, 14 insertions(+), 5 deletions(-)

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
index ed037be399..bb7dfb8ba5 100644
--- a/lib/eal/include/rte_common.h
+++ b/lib/eal/include/rte_common.h
@@ -149,14 +149,17 @@ extern "C" {
 #define __rte_aligned(a) __attribute__((__aligned__(a)))
 #endif
 
-#ifdef RTE_ARCH_STRICT_ALIGN
+/**
+ * Integer types with no alignment requirement.
+ */
+#ifdef RTE_TOOLCHAIN_MSVC
+typedef __unaligned uint64_t unaligned_uint64_t;
+typedef __unaligned uint32_t unaligned_uint32_t;
+typedef __unaligned uint16_t unaligned_uint16_t;
+#else
 typedef uint64_t unaligned_uint64_t __rte_aligned(1);
 typedef uint32_t unaligned_uint32_t __rte_aligned(1);
 typedef uint16_t unaligned_uint16_t __rte_aligned(1);
-#else
-typedef uint64_t unaligned_uint64_t;
-typedef uint32_t unaligned_uint32_t;
-typedef uint16_t unaligned_uint16_t;
 #endif
 
 /**
-- 
2.53.0

