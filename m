Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C82ECD19512
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Jan 2026 02:02:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 994EB40A77;
	Tue, 27 Jan 2026 03:02:55 +0100 (CET)
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com
 [74.125.82.170]) by mails.dpdk.org (Postfix) with ESMTP id CF660402A7
 for <dev@dpdk.org>; Tue, 27 Jan 2026 03:02:51 +0100 (CET)
Received: by mail-dy1-f170.google.com with SMTP id
 5a478bee46e88-2b6fd5bec41so1111843eec.1
 for <dev@dpdk.org>; Mon, 26 Jan 2026 18:02:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769479371; x=1770084171; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G2ttW+poCNellPsidppR0WnkDktUDbUlxzlcorPDF2I=;
 b=KYKaqHPHpB/74LgGEWjuUSu5zPKGlW4wj5VvymYHib5PPakjOJuTSzjFimfwITUjn3
 8jUve8lcRZflY6n5N08oyPRKfPIXtVQGsXHFz5OugzphNZdONfoWeX84vOXTHcpWVvL6
 BD9rf62K1jpt1cH7gZ+G7V7rcaVIQCvaAn5qs7L1hAwqT6wBZqyXvQTQ8gPYLQonIMxq
 n0d1S3LOAsKQ6j1zR5ffhoK0A8isvwx0pWeMX+P2LOP53/sq63BZG8JsvLp+tPe+kVEC
 77oIQBAJB/5Phk70Y206kz/q0JzEaKleZ7yWypwsa+6HuB4CfD4Th7+92gJv8tYVNRGB
 sJBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769479371; x=1770084171;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=G2ttW+poCNellPsidppR0WnkDktUDbUlxzlcorPDF2I=;
 b=NwiICFQIkhym+wktt2jXhyNTcRfH9lnvOfT0b7j60lWAkaeZCLisTXZ2J4OSzHF4CW
 QIBgcgILycR70VKbXWvmB9x5xYQQwqyjGGiffoytw9FhSfnXQWIZaaya1Vfxg2AIeLmj
 dSexbo39LaYq7TkoPCr3O7t4pIj9A3gRgWIahru+WI8Hmx5ySDCwidGTRCygGNQeZ+U8
 ju6ZIwEAqL+Gq5M4XCNixqmgV0zBLyhx9vp174DewKQrYAr1JFAR6X87dnWwvIRWM6TC
 /EiDYbN/3KN7ww3bPaNu72igKvZB2MB+33ekcOWWnXQutOJ7FNLt7PgOixrIL9IYxrqR
 LAYQ==
X-Gm-Message-State: AOJu0YzJJoFzBmAl86Z520/721T9hOCfe+rwAhTO7S86U/F5XUgbpw9u
 iyr886kDc644ylfFfqpvIhgKDc9QsyY+NNZjfibFffN5COC282wcDtqiJd9aVA==
X-Gm-Gg: AZuq6aLeOZX6riycj+u1w11Ma3HVwEBURdrfBtkVHtK72jG1JdVQZcLYznbwy1UjXtA
 9Nx4l9KfZm7MBWDhsUoiDABsWko9cnXM8tGF06U+GZcGlEKEJ5NypMHfh1TZwflzV34AovvwXyv
 H1tZ5QEGXgUbbfHE0duG5oz4Kmmcxjpjk+bZ6FPJFn9B3NQeIlXmDTRFq56mIZhgkrYzgx52ZVz
 ti5dTX3bVF8A+Vgibg6xV8ABSUk71TofA8Dv8sUZgxel8VjzidACt4H5INl8c8RWN2nkPvMd85N
 aPti+5zsIv7m7cBTs9UW1CyVbLWns357gmYnNznqgR9qi63Vvt4Hr8jd+gbBIf8Fvhl4YIQbHxg
 E+1R+m2oK+CL4DvkwLd1UA3u6N8uHWGqu7dv6GaSe11GPYPV62057V0eCdz0tnJM7Tt081RyXzH
 MU1K5wYmBbPZVRBKNddNniaQ==
X-Received: by 2002:a05:693c:23c5:b0:2b7:1b54:6081 with SMTP id
 5a478bee46e88-2b78d8d38abmr170565eec.11.1769479370667; 
 Mon, 26 Jan 2026 18:02:50 -0800 (PST)
Received: from mac.com ([136.24.82.250]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2b73aa2b1f6sm15458584eec.32.2026.01.26.18.02.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 26 Jan 2026 18:02:50 -0800 (PST)
From: scott.k.mitch1@gmail.com
To: dev@dpdk.org
Cc: mb@smartsharesystems.com, stephen@networkplumber.org,
 bruce.richardson@intel.com, Scott Mitchell <scott.k.mitch1@gmail.com>,
 mattias.ronnblom@ericsson.com, stable@dpdk.org
Subject: [PATCH v15 1/2] eal: remove alloc_size from rte_lcore_var_alloc
Date: Mon, 26 Jan 2026 18:02:45 -0800
Message-Id: <20260127020246.53057-2-scott.k.mitch1@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260127020246.53057-1-scott.k.mitch1@gmail.com>
References: <20260126080328.11567-1-scott.k.mitch1@gmail.com>
 <20260127020246.53057-1-scott.k.mitch1@gmail.com>
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

From: Scott Mitchell <scott.k.mitch1@gmail.com>

The __rte_alloc_size(1) attribute on rte_lcore_var_alloc() is
semantically incorrect and causes false positives with FORTIFY_SOURCE
runtime checks.

The attribute tells the compiler that the function returns a pointer
to 'size' bytes of usable memory. However, rte_lcore_var_alloc()
actually returns a handle to a per-lcore variable scheme. The
allocator internally allocates 'size' bytes per lcore
(size * RTE_MAX_LCORE total), partitioned into per-lcore sections.
The handle points to lcore 0's copy, and accessed via
RTE_LCORE_VAR_LCORE(lcore_id, handle) which computes:
handle + (lcore_id * RTE_MAX_LCORE_VAR). Access is expected
beyond 'size' bytes beyond the returned pointer when 'lcore_id != 0'
but FORTIFY_SOURCE may terminate the program due to out of bounds
access.

This can be observed on CI with gcc 13.3.0 in lcore_var_autotest with
'*** buffer overflow detected ***: terminated' if pointer provenance
is preserved (e.g. if offsets avoid casting to uintptr_t).

Fixes: 5bce9bed67ad ("eal: add static per-lcore memory allocation facility")
Cc: mattias.ronnblom@ericsson.com
Cc: stable@dpdk.org

Signed-off-by: Scott Mitchell <scott.k.mitch1@gmail.com>
---
 lib/eal/include/rte_lcore_var.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/eal/include/rte_lcore_var.h b/lib/eal/include/rte_lcore_var.h
index ca31dff6fd..48b022e84e 100644
--- a/lib/eal/include/rte_lcore_var.h
+++ b/lib/eal/include/rte_lcore_var.h
@@ -202,7 +202,7 @@ rte_lcore_var_lcore(unsigned int lcore_id, void *handle)
 __rte_experimental
 void *
 rte_lcore_var_alloc(size_t size, size_t align)
-	__rte_alloc_size(1) __rte_alloc_align(2);
+	__rte_alloc_align(2);
 
 #ifdef __cplusplus
 }
-- 
2.39.5 (Apple Git-154)

