Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 651E6CA9EBD
	for <dpdk-dev@archiver.kernel.org>; Sat, 10 Oct 2026 02:29:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B521740608;
	Sat, 10 Oct 2026 04:28:56 +0200 (CEST)
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com
 [209.85.216.41]) by mails.dpdk.org (Postfix) with ESMTP id D669B402B4
 for <dev@dpdk.org>; Sat, 10 Oct 2026 04:28:54 +0200 (CEST)
Received: by mail-pj1-f41.google.com with SMTP id
 98e67ed59e1d1-3ab9268d90eso3702a91.3
 for <dev@dpdk.org>; Fri, 09 Oct 2026 19:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791599334;
 x=1792204134; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/b9sJ8O9pBnWflnn7haHR88BHJzkNqZdO94AJviHC9U=;
 b=yfClVL9QbD5TNYt+fMk6YUdG3eiRPcFW+7MoY7ccwNwzZPkHo9xrKO18dw3tEGqs9S
 kwJ1VxaKQ1ixvclQnvrxfFLzHpfMF1l1k24p14dAvol2o7WAcKIyINOCGLCuF6fUliIF
 nYGgpaG0JMvT/NYYcrXE6TGGdGm2ErORFB+S0+fiRcZswm+G5wDvrUX0/JSj4cZdAlyJ
 i8W0BQUxRcpsmRB3xnvTtR4YIjNcAK0AbuvU93DIZvOcpAz5vU84sox/p6iMxtqewswX
 U1bWYk7QWAL+viNj2UcQaIHN7F/2s3nnPah5IfWvHNhiU17CQ21e2k3Z6cdG6ye+pn+H
 yKoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791599334; x=1792204134;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=/b9sJ8O9pBnWflnn7haHR88BHJzkNqZdO94AJviHC9U=;
 b=2Dc310isn678KCTl9pV44ZFoCQrmLoAzg/6JE1PnUZWy+K3fIPjrUton5ez8jVkTzR
 LI01o62JATZKROAB7ItNJTvH5tzXMFb/4SGsDd2rc5KThRzoRMKp3alXV1JM/Bh1tMF0
 NBz9wwZNEQaBLoY2l8lQV81e76ghcaptsCdbWQ+DVH7vyzyg7izGYwMaWb3mUj6xssrf
 ckS6EYE0le6B6G0+FvZrC8nwqUn2LQ9nDB6ZIOYyvjJIjXSQT4Km+rIs2Lu2fMAdEjcI
 TmFh+Jmtvl2ajmaFnnxq/2/lSuQE47fj6pYok+skAxzxK5T4Z7lPRP33rYPKC/3If1Bv
 Xj6Q==
X-Gm-Message-State: AFq9FYLd1b9PEZC44VrTQdSwZeDHkSM5CdwxPGL6Cbgw4tR1TwONLxKd
 z4b8X7zHSG6d/Q3BUG3oeS6+JJeP9DYMt0UvnxYz4uNMRhZ0LrA2gkeFoASBA/7tv/51q844Bom
 ZtEGI
X-Gm-Gg: AYBFou0Mhkh8ArgsUsD4VQSN32P9A2J7MiGtXeHzUNbk/HjuIcV5TT6eeyJ8wNEFDxz
 FHpEJOuj38R66ziDkObMp3Gdmaq/Jw9M8N/RG0YQrr8xQap5UA7A+/nKr+2hbLukvmEY52FTVA2
 JChmA8J0z4kJ/NKMaCII6rRKMXg0YU6HVEI0wBR7/AwMhMWfijktKhrb/VMCJNW9y97StHKSBCA
 PApNEeoNWfU7ayAjTFDG11P4uuOSnUWFWmF91anJoILIzH6HUibguaaeCk3yWHw4xkIzzq5unO1
 AzdFqRrePJKDgLvf2fEU88vJtNY/Rv72WuPbhKoBVORgBB0kzzA4U9HzKjVwDNVJap9au/YYp+z
 7IqVpPDGhFbtumX78kH4rj+1cjGNykgiygCABsVQlic7kg/rIxxekrrNne6gSWqcjIPJH660pPg
 YXrbcsXvAGPgqGrfcd7kd7aKVMY0nLRy5bjt/czKFsYaBHPAYrsP6HA3la04a1pf874v2jIwebS
 uXcGB6XL2rrz0kTxzTCMfASvEmS9WRWFdD7Eg==
X-Received: by 2002:a17:90b:164b:b0:3a7:a6bc:9d58 with SMTP id
 98e67ed59e1d1-3ab3af76821mr2977169a91.54.1791599333895; 
 Fri, 09 Oct 2026 19:28:53 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ab3690474esm6202882a91.0.2026.10.09.19.28.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2026 19:28:53 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	stable@dpdk.org
Subject: [PATCH v2 1/5] eal/windows: add getentropy shim
Date: Fri,  9 Oct 2026 19:27:03 -0700
Message-ID: <20261010022851.1872825-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261010022851.1872825-1-stephen@networkplumber.org>
References: <20260915192207.3926217-1-stephen@networkplumber.org>
 <20261010022851.1872825-1-stephen@networkplumber.org>
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

