Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C271C88E75
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Sep 2026 19:22:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A802342DDC;
	Tue, 15 Sep 2026 21:22:20 +0200 (CEST)
Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com
 [74.125.227.141])
 by mails.dpdk.org (Postfix) with ESMTP id C175B42DB4
 for <dev@dpdk.org>; Tue, 15 Sep 2026 21:22:18 +0200 (CEST)
Received: by mail-pj2-f13.google.com with SMTP id
 98e67ed59e1d1-396ccafb752so116483a91.0
 for <dev@dpdk.org>; Tue, 15 Sep 2026 12:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789500137;
 x=1790104937; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/b9sJ8O9pBnWflnn7haHR88BHJzkNqZdO94AJviHC9U=;
 b=hnoc3vj4qOt500HXT/hXkAqKLavFHEE6zNTJHanc5qK26JKolI1QzTjYGnPrl4XSI9
 padzzPrmCrLKfwHRwjv3VI+H2w/ZiyGwRz2+X8YyUOd0dx2CSIPu8OaXslHmnuQ5rbEC
 VDhDU8HZOKP6ZNk9qI9YVNZGHIJA9gyefvOgOss1uBQ33ZiXVokhOzrVq3mef70QqrI9
 /fcFww2+xHXq3E1at1bOvsZrM2UobcYx4/C40Y+dG9qE5xSzqaQp2AApkTiE1Jz7MFZp
 Xnp+CcPl+NnM667c6ibvBF45JefaoDrY1qZAhMVZ0aq/+OXv7aFfTaxGkjUWHA+jrFd6
 Q0Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789500137; x=1790104937;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=/b9sJ8O9pBnWflnn7haHR88BHJzkNqZdO94AJviHC9U=;
 b=BA2AH8VMa8VTqEWFmdL/cYX1T4BKHQv2k4hJEtpKrlPdhifkDDSaRm0BNDNhl22yQi
 luGOLT1t6xRr3XmDdl9c7Gs9wplzJM7tpb4XiHuT+sKUQvaQcjBtotp1RRkJ/cAGiY6x
 0iCVIeqXatNns9bj/nbIGL/gMpyFhGBSANRydmLZroQnyw+p6+KSaWFd/D8GitZo+t0g
 D22wCNMXRj5ehcU1f0RSBtxmSvD16/DydPhrfNc0JMAEz6tMy/qc+vmFAIeFtgbWHHqL
 bYGw+ASP3H/GykYp20LDULM5J9FY09i5q9cpaPDq+VNHPDfOPV0WwZNBAbB0CTWia9TA
 Kobg==
X-Gm-Message-State: AFuF++mmMYT+4NP/w6MlGBlwA1+nm8okjTu0vmgiM3eTBEueMJzukwp/
 RpOehVGTcP7q0kGcycFFZGos6d3qjGlOlo5RZs4cBmPQ04ZfItBvJ8XLMPsxINBJwusB8cRZN8b
 ZIB1skXmK5A==
X-Gm-Gg: AYBFou2bB43a3mTvqJp5KCvL3w16uX7X3DquAau4jRTw+DNywRO463mNudxnp7t83Xs
 BSvdui5+k7nK99SCArp73fmUwcCXuQ41wth5Gt3ynd+gqG31JZ+pu55T85FKFl4qKpN7hGixZZy
 N1KCTPqlbalmLcUbDk7fEqAKwLQmd7OBE5SUvVw817XIhFfKtAYc0/AGaR7Wbkq63jov9K/CYbb
 SiUKFLuCiECnb+UrV7HT/y7cejJ+GP4SDIO4S3P42OMWrtjXg3rBDcW6mch322U8HbHbu3eMuz5
 5qDL9L3S0V1oDDREUBDoeMsfSYsPR2uPfILO60dmnYLNB42+5rzLQfP3aNH1Ds//VHmihUWTUzJ
 SzkVHMVMRDL7fUA5kZb1DUTk2JpaTNjFu9fDYYyH8bKqveDBov6ley/fNaJUjcyvcT/Cf1A+g44
 yAGq2FdBmtpeUD0a5EUqt08N4vqKkjyLviO8rQ8fwYrZdQOr+tq7613WnGPdYQmEQpE9VN+TJcw
 gF61Wnf0+p2EGwU54YtEPovLxkP/4xOOY8JLQ==
X-Received: by 2002:a17:90b:2e52:b0:39d:f70f:f034 with SMTP id
 98e67ed59e1d1-39df710bfa9mr16198175a91.10.1789500136830; 
 Tue, 15 Sep 2026 12:22:16 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39e1bbfdd49sm217535a91.11.2026.09.15.12.22.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 12:22:15 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 =?UTF-8?q?Mattias=20R=C3=B6nnblom?= <mattias.ronnblom@ericsson.com>,
 Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>
Subject: [PATCH 01/18] eal/windows: add getentropy shim
Date: Tue, 15 Sep 2026 12:20:59 -0700
Message-ID: <20260915192207.3926217-2-stephen@networkplumber.org>
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

Provide getentropy() in the Windows OS shim using BCryptGenRandom()
with the system preferred generator, which needs no algorithm
provider handle. The POSIX 256 byte limit is kept so that callers
see the same behaviour on all platforms.

This is needed EAL change that always uses getentropy().

The next patch is tagged for stable, and it does not build on
Windows without this shim, so this one is tagged as well.

Bugzilla ID: 2035
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/eal/common/rte_random.c           |  1 +
 lib/eal/windows/include/rte_os_shim.h | 30 +++++++++++++++++++++++++++
 lib/eal/windows/meson.build           |  6 +++++-
 3 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/lib/eal/common/rte_random.c b/lib/eal/common/rte_random.c
index 576a32a46c..537fa035ee 100644
--- a/lib/eal/common/rte_random.c
+++ b/lib/eal/common/rte_random.c
@@ -17,6 +17,7 @@
 #include <rte_random.h>
 
 #include <eal_export.h>
+#include <rte_os_shim.h>
 #include "eal_private.h"
 
 struct __rte_cache_aligned rte_rand_state {
diff --git a/lib/eal/windows/include/rte_os_shim.h b/lib/eal/windows/include/rte_os_shim.h
index 44664a5062..4f9611d642 100644
--- a/lib/eal/windows/include/rte_os_shim.h
+++ b/lib/eal/windows/include/rte_os_shim.h
@@ -3,12 +3,16 @@
 #ifndef _RTE_OS_SHIM_
 #define _RTE_OS_SHIM_
 
+#include <errno.h>
 #include <time.h>
 
 #include <rte_os.h>
 #include <rte_windows.h>
 #include <getline.h>
 
+/* Needs Windows SDK types, so must come after rte_windows.h. */
+#include <bcrypt.h>
+
 /**
  * @file
  * @internal
@@ -124,4 +128,30 @@ rte_localtime_r(const time_t *timep, struct tm *result)
 }
 #define localtime_r(timep, result) rte_localtime_r(timep, result)
 
+/*
+ * Windows has no getentropy(), use the system preferred random
+ * generator which does not require a provider handle.
+ */
+static inline int
+rte_getentropy(void *buffer, size_t length)
+{
+	NTSTATUS status;
+
+	/* Match the POSIX limit so callers behave the same everywhere. */
+	if (length > 256) {
+		errno = EIO;
+		return -1;
+	}
+
+	status = BCryptGenRandom(NULL, (PUCHAR)buffer, (ULONG)length,
+				 BCRYPT_USE_SYSTEM_PREFERRED_RNG);
+	if (!BCRYPT_SUCCESS(status)) {
+		errno = EIO;
+		return -1;
+	}
+
+	return 0;
+}
+#define getentropy(buffer, length) rte_getentropy(buffer, length)
+
 #endif /* _RTE_OS_SHIM_ */
diff --git a/lib/eal/windows/meson.build b/lib/eal/windows/meson.build
index 6f909c2131..6387786530 100644
--- a/lib/eal/windows/meson.build
+++ b/lib/eal/windows/meson.build
@@ -37,7 +37,11 @@ ws2_32_dep = cc.find_library('ws2_32')
 if not cc.links(min_c_code, dependencies: ws2_32_dep)
     error('broken dependency, "ws2_32"')
 endif
-ext_deps += [dbghelp_dep, setupapi_dep, ws2_32_dep]
+bcrypt_dep = cc.find_library('bcrypt')
+if not cc.links(min_c_code, dependencies: bcrypt_dep)
+    error('broken dependency, "bcrypt"')
+endif
+ext_deps += [dbghelp_dep, setupapi_dep, ws2_32_dep, bcrypt_dep]
 if is_ms_linker
         # Contrary to docs, VirtualAlloc2() is exported by mincore.lib.
         mincore_dep = cc.find_library('mincore')
-- 
2.53.0

