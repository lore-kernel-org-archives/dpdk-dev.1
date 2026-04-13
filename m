Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21103F34C63
	for <dpdk-dev@archiver.kernel.org>; Mon, 13 Apr 2026 16:47:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8D70440649;
	Mon, 13 Apr 2026 18:47:04 +0200 (CEST)
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com
 [209.85.210.46]) by mails.dpdk.org (Postfix) with ESMTP id AEC49402EF
 for <dev@dpdk.org>; Mon, 13 Apr 2026 18:46:59 +0200 (CEST)
Received: by mail-ot1-f46.google.com with SMTP id
 46e09a7af769-7d4be94eeacso4977494a34.2
 for <dev@dpdk.org>; Mon, 13 Apr 2026 09:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1776098819;
 x=1776703619; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fybNn5bZOKiAetItQVqSLGHGAWjQemEtc8WTzlZP/bE=;
 b=WSRqFPkeQUowmTrauHF7X5iDA6xwzBseHIAAZvxU8f7mPWAfE0HoPVCw+7MhX3Lnkg
 99mKJH7ekejb011Dx46pdXKcRCuqU/nUZa7YY5fNo+D/nrbHw6lcvNkZQxdImFqYPgkm
 jhZ8cEgCMwG/Hn2XsAUDi/t4yopTTRCXcMDhCbqXhp6jhdHougFKM90esjWpkF1XpbMG
 NNIOJs2s14P6jS100GJhS5CDF+ZDgX3PJF/gWI3/y82pqCNdo4mNIeOz4JQKXV4Q/Jco
 z4Id80dBYizb5aX7piHJYbapgOS+BnuCeMPCwg5Y0McNfQIXtcZc0/qwT/F+h55B63Hg
 wkQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776098819; x=1776703619;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fybNn5bZOKiAetItQVqSLGHGAWjQemEtc8WTzlZP/bE=;
 b=ghLfYMgpxVbqXsjP5hLPbqUY3EKm/8uOqIk/UUPZ8ITcFd1BlrkGwSz8meSwkE2Vfe
 ++xTzBANzczB7cp/yDehMG8gH4pAg4YRqPiPVH9NS7tZiGYv9vB7GbpcWYR6i2hjj9ul
 I90CG8L04M7CJeGVPKhQoOUnY51q30c4z4ImX1H8vJ0NPK2NeD+gjQ5UKhVipWrsD393
 d+wmaXwR4m2LwxbNQAtJTFGHUb41j82NwNt3rmW7b9CFQy3EPWdI0d0ZpyxxMCTgZG0w
 uxQMaj1b9cqlD9CgsJSGibYfxZrGBy5l12uvswZLlDAMFIFxZdHBvoZpKWFERQoowRDZ
 boZA==
X-Gm-Message-State: AOJu0YzPvRYtT35cTsLhwk/FbCUJnI/aRtngyk+LSXcgBPWhqpLV6K0B
 llfhq9cUr6Ssk5sn06AGd1ODbROM+bKKZ0ZghUSMNCxWt+Gf0CNrFpSzYa8vqzGMwfzF9vEQdGI
 F38eB
X-Gm-Gg: AeBDieuoOHfubJmcqYCp2ATBkj/wN0nfyLcjfPd2rxWMPqzycwLfF0P4dDmwOOHilLu
 awtjNzyQ2WAU0HGts45rgDx+e4NK1ccYOmwVsJXjgzTv3j5OuXxHCtSfz6u8QGj80AoB9pfs7vB
 pLEokqD+ePsRAyeph9UR8LHtPrKwakXTaDByXXqWbvrM+nFpLRbUa/zJt0ATfFQoAorVBt09KDr
 zt+IFcLPJpbt7oKKw2GSjo8sLD4jOcztJScEImelFaTW9wrbpUuRnKGc9y+868yY5Z7z0eIKEiA
 9ptQ81llV2IE+jF84xrZ613M+BSVTACeSCfGL9RpS4ZmXWCONeOs1b6+exHQdLND+H1X/GaPMVJ
 IIEnXn9+TvE3Hvl46cNQ895LXpnyC4lvSojbWuScSKFbGO9qaNnuJrRKDAq0AZ/UUBVnH5RB12J
 6BMHrYrQfQWSxWmeiQ7j2cAskWAw+avZT1iSLqnyEbgMOoa0fiyycBjA==
X-Received: by 2002:a05:6830:67f4:b0:7d7:d2e4:630a with SMTP id
 46e09a7af769-7dc27ecd2cfmr8498664a34.14.1776098818944; 
 Mon, 13 Apr 2026 09:46:58 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7dc3959099fsm6218089a34.9.2026.04.13.09.46.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Apr 2026 09:46:58 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v2 3/3] devtools/cocci: add script to find empty spinloops
Date: Mon, 13 Apr 2026 09:45:31 -0700
Message-ID: <20260413164652.33291-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413164652.33291-1-stephen@networkplumber.org>
References: <20260121180845.889190-1-stephen@networkplumber.org>
 <20260413164652.33291-1-stephen@networkplumber.org>
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

This script finds and fixes many variations of the pattern:

   while (!atomic(&flag));

to add a rte_pause() to the loop.

This type of loop was causing failures in the standalone atomic
tests on high core system. The script generalizes that to find other
places with the same problem.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 devtools/cocci/fix_empty_spinloops.cocci | 165 +++++++++++++++++++++++
 1 file changed, 165 insertions(+)
 create mode 100644 devtools/cocci/fix_empty_spinloops.cocci

diff --git a/devtools/cocci/fix_empty_spinloops.cocci b/devtools/cocci/fix_empty_spinloops.cocci
new file mode 100644
index 0000000000..ff64b30eac
--- /dev/null
+++ b/devtools/cocci/fix_empty_spinloops.cocci
@@ -0,0 +1,165 @@
+// SPDX-License-Identifier: BSD-3-Clause
+// Find and fix empty spin loops that should call rte_pause()
+//
+// Empty spin loops waste CPU cycles and can cause performance issues.
+// This script finds various forms of busy-wait loops and adds rte_pause()
+// to give hints to the CPU and reduce power consumption.
+
+// Rule 1: Handle rte_atomic*_read() variants
+@fix_atomic_read@
+expression ptr, val;
+@@
+
+(
+- while (rte_atomic16_read(ptr) == val);
++ while (rte_atomic16_read(ptr) == val)
++     rte_pause();
+|
+- while (rte_atomic16_read(ptr) != val);
++ while (rte_atomic16_read(ptr) != val)
++     rte_pause();
+|
+- while (rte_atomic32_read(ptr) == val);
++ while (rte_atomic32_read(ptr) == val)
++     rte_pause();
+|
+- while (rte_atomic32_read(ptr) != val);
++ while (rte_atomic32_read(ptr) != val)
++     rte_pause();
+|
+- while (rte_atomic64_read(ptr) == val);
++ while (rte_atomic64_read(ptr) == val)
++     rte_pause();
+|
+- while (rte_atomic64_read(ptr) != val);
++ while (rte_atomic64_read(ptr) != val)
++     rte_pause();
+)
+
+// Rule 2: Handle rte_atomic*_read() with comparison operators
+@fix_atomic_cmp@
+expression ptr, val;
+@@
+
+(
+- while (rte_atomic16_read(ptr) < val);
++ while (rte_atomic16_read(ptr) < val)
++     rte_pause();
+|
+- while (rte_atomic16_read(ptr) > val);
++ while (rte_atomic16_read(ptr) > val)
++     rte_pause();
+|
+- while (rte_atomic32_read(ptr) < val);
++ while (rte_atomic32_read(ptr) < val)
++     rte_pause();
+|
+- while (rte_atomic32_read(ptr) > val);
++ while (rte_atomic32_read(ptr) > val)
++     rte_pause();
+|
+- while (rte_atomic64_read(ptr) < val);
++ while (rte_atomic64_read(ptr) < val)
++     rte_pause();
+|
+- while (rte_atomic64_read(ptr) > val);
++ while (rte_atomic64_read(ptr) > val)
++     rte_pause();
+)
+
+// Rule 3: Handle C11 atomics with rte_atomic_load_explicit()
+@fix_c11_atomic@
+expression ptr, order, val;
+@@
+
+(
+- while (rte_atomic_load_explicit(ptr, order) == val);
++ while (rte_atomic_load_explicit(ptr, order) == val)
++     rte_pause();
+|
+- while (rte_atomic_load_explicit(ptr, order) != val);
++ while (rte_atomic_load_explicit(ptr, order) != val)
++     rte_pause();
+|
+- while (rte_atomic_load_explicit(ptr, order) < val);
++ while (rte_atomic_load_explicit(ptr, order) < val)
++     rte_pause();
+|
+- while (rte_atomic_load_explicit(ptr, order) > val);
++ while (rte_atomic_load_explicit(ptr, order) > val)
++     rte_pause();
+)
+
+// Rule 4: Handle __atomic_load_n() directly
+@fix_gcc_atomic@
+expression ptr, order, val;
+@@
+
+(
+- while (__atomic_load_n(ptr, order) == val);
++ while (__atomic_load_n(ptr, order) == val)
++     rte_pause();
+|
+- while (__atomic_load_n(ptr, order) != val);
++ while (__atomic_load_n(ptr, order) != val)
++     rte_pause();
+|
+- while (__atomic_load_n(ptr, order) < val);
++ while (__atomic_load_n(ptr, order) < val)
++     rte_pause();
+|
+- while (__atomic_load_n(ptr, order) > val);
++ while (__atomic_load_n(ptr, order) > val)
++     rte_pause();
+)
+
+// Rule 5: Handle volatile variable reads (simple dereference)
+@fix_volatile@
+expression E;
+identifier v;
+@@
+
+(
+- while (*v == E);
++ while (*v == E)
++     rte_pause();
+|
+- while (*v != E);
++ while (*v != E)
++     rte_pause();
+|
+- while (*v < E);
++ while (*v < E)
++     rte_pause();
+|
+- while (*v > E);
++ while (*v > E)
++     rte_pause();
+|
+- while (v == E);
++ while (v == E)
++     rte_pause();
+|
+- while (v != E);
++ while (v != E)
++     rte_pause();
+)
+
+// Rule 6: Handle negated conditions
+@fix_negated@
+expression ptr, val;
+@@
+
+(
+- while (!rte_atomic32_read(ptr));
++ while (!rte_atomic32_read(ptr))
++     rte_pause();
+|
+- while (!rte_atomic64_read(ptr));
++ while (!rte_atomic64_read(ptr))
++     rte_pause();
+|
+- while (!rte_atomic_load_explicit(ptr, val));
++ while (!rte_atomic_load_explicit(ptr, val))
++     rte_pause();
+)
-- 
2.53.0

