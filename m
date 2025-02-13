Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52134C021A4
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Feb 2025 22:18:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F099340608;
	Thu, 13 Feb 2025 23:18:33 +0100 (CET)
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com
 [209.85.216.51]) by mails.dpdk.org (Postfix) with ESMTP id 1D1E2402EF
 for <dev@dpdk.org>; Thu, 13 Feb 2025 23:18:32 +0100 (CET)
Received: by mail-pj1-f51.google.com with SMTP id
 98e67ed59e1d1-2f9b91dff71so2087394a91.2
 for <dev@dpdk.org>; Thu, 13 Feb 2025 14:18:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739485111;
 x=1740089911; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xqVLAx5biK9uIXkfwAeH7h8x7zd3oHWqcf7QBwDDR7U=;
 b=BL2yTeNYwfQEpUYOYxGFUNm67VoLItzOho7ZD0oCa7o/UkNqLS94DdH6c80aZftXIl
 L9H8bSd/xqjJMxyYJf0OnLTtDr1VebMXeA9+SQTzUneaZLb+oDpqNdbxSONDp8aQEBP+
 vIfovY1OR+iVz0sHDaGqoDlxzBhvhxx5gqy/bmpDOCdpESpYKDpVQuE7j/CCd+4z7Ro/
 DyKvr2/Y/w+CZCclzJdJxjH24CCSgWAaMGGE+PG/U8lB53xuA72pYKD1C2i5dAVWrwhG
 Zrcj0OO/m1TcJkTLAWlkUsKu17UMttvtz4f0pUP1fnLfUOUVFbw24CHMMGIEb3jWYOqc
 mR3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739485111; x=1740089911;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xqVLAx5biK9uIXkfwAeH7h8x7zd3oHWqcf7QBwDDR7U=;
 b=iMz/mFLlC//l8xzv6iJLLYWr5lSuQO5n/GFupmQv0TM4RSS08MGITaxPE0IObSwSPO
 jhqHDjcyyl8nSTB1wQCZZb25rp+aYZe7hAQQQOmuQA7XU+Davh6FbIAzJEccQKi9XqqZ
 UEumUEG3sv2fOuOsIK/8Z8yVhuvtsh1ZNKes2jwaFv8avWy1pVdxxtvUZoso2fpC5lJf
 hktrdhgT9XjzLnrEkH5nkeMm3uJ7exm36iLjGLycp1+cNFDpPXk9ELTjxgcl6SC77JiX
 CxevDfaBwh1hgYdbYHJuiu547OzMhm5KiQGeluQMnR7+0W9/ukQG97rlXNDrEQxj6Eed
 Bs3Q==
X-Gm-Message-State: AOJu0Ywx8LCPBO0wBQrJp9X58Jz7HxXBAHdYs7q7SIr3UH+LJ5wzGgDo
 g/XCRZclxSdKExGY/NZ785jmS+2E5h+KQvqr5RBnMfS7iyaeIho1LeDlLKjxbstKJakxcAbenHb
 6
X-Gm-Gg: ASbGncv7IlOci2Db9IOBeDhzLqTmgQPbnUesq+x4XvYVwt+IHpD2Q+9Lvt7UwtZsId9
 TAF4vXonJATUbZ654HrbASaJzlIkT0L2xdks084fe+BGEKSkd6pV3VDMf+kcMz4LryAYbaMFY87
 1aTxw8LeBXBEI8/kNoI8s5JiTCgF7MNY5ipyyDBZX4hTyrIV8N9w5SXt5H6Nx8NpNZ/ExTYwtR+
 AX0pqY/TZN30G6dgW582ROmVaGVjLrs8/G+CYBLZSjpbcl50TaFPTQ8X7xWEDGKeqjivFUmwrS3
 7olDkPOVeQw4Fp9Vxb65tvGVnBQ4uzENjZYYTy9UoryZbXVr6521RBmvNcl7pS/QlzC4
X-Google-Smtp-Source: AGHT+IELEyXtMDuvTpDIzBYeVzIDjXsL8AEZWyMlfXuqUaLs4XAXM24IG7/Y6pMNgCoDl5IZCZjD9w==
X-Received: by 2002:a17:90b:540f:b0:2ee:e317:69ab with SMTP id
 98e67ed59e1d1-2fbf5ad2ab1mr15465704a91.0.1739485111276; 
 Thu, 13 Feb 2025 14:18:31 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fc13ad726bsm1706826a91.28.2025.02.13.14.18.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2025 14:18:30 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Tyler Retzlaff <roretzla@linux.microsoft.com>
Subject: [PATCH v6 01/11] eal: introduce new secure memory fill
Date: Thu, 13 Feb 2025 14:16:14 -0800
Message-ID: <20250213221819.1856769-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250213221819.1856769-1-stephen@networkplumber.org>
References: <20241114011129.451243-1-stephen@networkplumber.org>
 <20250213221819.1856769-1-stephen@networkplumber.org>
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

When memset() is used before a release function such as free,
the compiler if allowed to optimize the memset away under
the as-if rules. This is normally ok, but in certain cases such
as passwords or security keys it is problematic.

Introduce a DPDK wrapper which is equivalent to the
C23 memset_explicit function.
Name ot the new function chosen to be similar to
Linux kernel internal memzero_explicit().

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/eal/include/rte_string_fns.h | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/lib/eal/include/rte_string_fns.h b/lib/eal/include/rte_string_fns.h
index 702bd81251..93aae66614 100644
--- a/lib/eal/include/rte_string_fns.h
+++ b/lib/eal/include/rte_string_fns.h
@@ -15,6 +15,7 @@
 #include <stdio.h>
 #include <string.h>
 
+#include <rte_atomic.h>
 #include <rte_common.h>
 #include <rte_compat.h>
 
@@ -149,6 +150,29 @@ rte_str_skip_leading_spaces(const char *src)
 	return p;
 }
 
+/**
+ * @warning
+ * @b EXPERIMENTAL: this API may change without prior notice.
+ *
+ * Fill memory with with zero's (e.g. sensitive keys)
+ * Normally using memset() is fine. But in cases where clearing
+ * out local data before going out of scope or freeing,
+ * use rte_memzero_explicit() to preven the compiler from optimizing
+ * away the zeroing.
+ *
+ * @param dst
+ *   target buffer
+ * @param sz
+ *   number of bytes to fill
+ */
+__rte_experimental
+static inline void
+rte_memzero_explicit(void *dst, size_t sz)
+{
+	memset(dst, 0, sz);
+	rte_compiler_barrier();
+}
+
 #ifdef __cplusplus
 }
 #endif
-- 
2.47.2

