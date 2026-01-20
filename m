Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFDBDD2629C
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Jan 2026 19:55:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ADC8C410FA;
	Tue, 20 Jan 2026 20:54:42 +0100 (CET)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49]) by mails.dpdk.org (Postfix) with ESMTP id 89EE741156
 for <dev@dpdk.org>; Tue, 20 Jan 2026 20:54:38 +0100 (CET)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-47ee4539adfso48118515e9.3
 for <dev@dpdk.org>; Tue, 20 Jan 2026 11:54:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768938878;
 x=1769543678; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fN3W3Fewn7dD1q7UlMLuVoZ/oFpOjGuvl4saG2rHGIQ=;
 b=TYhBJvMNtrosM7sgeiGpTpxgKKEL7z8Vt3KJJAA6ZVHWvtD1CyUtlJGJ/AhYagIl3v
 PpfET+4Vjd8tD/2+VbbR34pxOKioqwj9PhwlPfnwxAnnoXL5BaT4PHHKcbODVnhwzij6
 i9tg3ZN7NQgluRlhhC4qMVe8/C6XHIImUhE2B3KESK9NIEFT3THu0l7m1Kof69jbcGL0
 4SxWVeS+k1LOEVS2n+V7seExnzk2WlUjcBW45H7ECbJPE4aOt5NwxaavafjtXfl4Pz3w
 0T0G+XTG0D88bsmeupvr/dxEClBN4jc3+z/9clAh41E61mYzeZjAIk8EyoEhQ0cpWamu
 Fm0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768938878; x=1769543678;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fN3W3Fewn7dD1q7UlMLuVoZ/oFpOjGuvl4saG2rHGIQ=;
 b=g6V9qqkBVTZcshgKLOX/s8E41TgZxrN47E3aHLpKgEFvj5kJqaRzveRWaNadBGlmBG
 cTzippQ1Aj1wl34RFW9CE77/NHVgfc7M9osh7aL2/WpIbKoHFqFyb0NoKGpfgbn7jEpF
 uF7GWAkI9X2xwEoCzvfXsUV2WRIlah/TvZRamR2ieN1kFi3ru9pC2kTRi8Hg8doBkZ+3
 jyGERMAns0FI+xA3IvtjVJVHrxzAyLOvlLJ6zwIbrmwY5lXdy+vkM3qlUqlNbCbSHtK7
 wNKee/7WxUBS9LVFLgRaGlosx39CgY8jEVk6rrV1bDBaCqYtSFEIte4jVKV01bvEEN4Q
 EzEg==
X-Gm-Message-State: AOJu0YyvIFGFAfFwVOWYQk08YK2u3mkLOrLGcolYVOdvOOvz6GQq3s+T
 aoS3Q44iXG4Vhz8Xw2BAzIuc/RQyUCPlq7/j8+lTaGW5VfunnDEzkKxFz7WEhOEfFWU6NHgpZka
 LcYBC
X-Gm-Gg: AZuq6aLHOzmlj9gg7mi0cN6NnQROsZzboBygfofwwwjYhbLT2/yTo7qE0XkjQoWg97I
 aYhtd0J6GUka/2ZjLT22bRIW88LI3/gXdn7sabDqxrsriEbVvqyIOXgZLm43cNU6zD1nlUY0/uB
 jN8YiUtuxamDPnHjmyAsG+RkysvJcZsGbHoWDZEpKPOkVKJasVwdPlYx3QxLQWaLrGf7aI9Zzu5
 jYK8yynj4v9LtU1sRQOSxEn7DeqtGE7+hwV9DXo++xJPBLekscuuUb09HMziktrwbZUPrRWA7J/
 FQRBSvYeNNQsTjtfG9GjS0ocmrsLvl9gGm7gZ61DbRgOonCM2I5ZH3ddKppg1waKSrfE48hwFZd
 wN7vOrmAv+sjk1nrjyaVkthDM1zg4HislF81XUIaAx+sNwkSLZ8egkjWdFUGauW5Ktv+tm6iaTB
 vV1SW3R9HMckxKcO4oW877BUzqY7wkcPUu5RnXx25u9fv8LZEGFA==
X-Received: by 2002:a05:6000:230d:b0:432:e00b:8687 with SMTP id
 ffacd0b85a97d-4358ff5683amr4815024f8f.31.1768938878157; 
 Tue, 20 Jan 2026 11:54:38 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43597bda41esm1354644f8f.28.2026.01.20.11.54.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jan 2026 11:54:37 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Honnappa Nagarahalli <honnappa.nagarahalli@arm.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
Subject: [PATCH v5 6/6] ring: use inline instead of always inline in soring
Date: Tue, 20 Jan 2026 11:52:11 -0800
Message-ID: <20260120195418.466318-7-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260120195418.466318-1-stephen@networkplumber.org>
References: <20251023194237.197681-1-stephen@networkplumber.org>
 <20260120195418.466318-1-stephen@networkplumber.org>
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

When LTO is enabled, GCC inlines through the entire soring call chain
from test code into the ring element copy functions. With always_inline,
the compiler is forced to inline __rte_ring_dequeue_elems_128() which
copies 32 bytes per element. GCC's static analysis then warns about
potential buffer overflow because it cannot prove the 128-bit element
path is unreachable when the ring is configured for 4-byte elements:

  warning: writing 32 bytes into a region of size 0 [-Wstringop-overflow=]

By using plain inline instead of always_inline on the soring enqueue
and dequeue functions, the compiler regains discretion over inlining
decisions. This introduces an analysis boundary that prevents GCC from
connecting the test's buffer sizes to the unreachable 128-bit code path,
eliminating the false positive warning.

Performance impact is expected to be negligible. At -O2/-O3, the
compiler will still inline these small, hot functions based on its
own heuristics. The difference only matters in debug builds or with
-Os, where slightly less aggressive inlining is acceptable.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/ring/soring.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/ring/soring.c b/lib/ring/soring.c
index 797484d6bf..3b90521bdb 100644
--- a/lib/ring/soring.c
+++ b/lib/ring/soring.c
@@ -249,7 +249,7 @@ __rte_soring_stage_move_head(struct soring_stage_headtail *d,
 	return n;
 }
 
-static __rte_always_inline uint32_t
+static inline uint32_t
 soring_enqueue(struct rte_soring *r, const void *objs,
 	const void *meta, uint32_t n, enum rte_ring_queue_behavior behavior,
 	uint32_t *free_space)
@@ -278,7 +278,7 @@ soring_enqueue(struct rte_soring *r, const void *objs,
 	return n;
 }
 
-static __rte_always_inline uint32_t
+static inline uint32_t
 soring_dequeue(struct rte_soring *r, void *objs, void *meta,
 	uint32_t num, enum rte_ring_queue_behavior behavior,
 	uint32_t *available)
-- 
2.51.0

