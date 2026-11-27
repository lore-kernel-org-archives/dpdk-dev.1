Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31283606A31C
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Nov 2026 19:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=S26QKtxL
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 553CC4064C;
	Fri, 27 Nov 2026 20:42:17 +0100 (CET)
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com
 [209.85.210.177])
 by mails.dpdk.org (Postfix) with ESMTPS id 3288C402C4
 for <dev@dpdk.org>; Fri, 27 Nov 2026 20:42:14 +0100 (CET)
Received: by mail-pf1-f177.google.com with SMTP id
 d2e1a72fcca58-8b29b83fdf1so4365045b3a.2
 for <dev@dpdk.org>; Fri, 27 Nov 2026 11:42:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1795808532;
 x=1796413332; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/b9sJ8O9pBnWflnn7haHR88BHJzkNqZdO94AJviHC9U=;
 b=S26QKtxLqzBQwcRElw90clsdhC0/D7Kj5sXMVElLk5UjJ07C87CRKUq6s/QWyhLecm
 KSbv9dluZ5iJVcGWXlG6FYn2qvaUhKcT+r1as+tgJQ44V6O/FM+u6qX8XS7hxnRPYPsh
 FVWQhGWsS+ZuwhGJipnfa7sjdNXc/xHJqhUeHBnbnkA0cnbT9kPXVwb0KNSPfkEkN1PG
 YRzAXuP8v7aHCgnzkh5al/aiK6xvAwxiYJ/K/G38hbKpfTlO8WVkjmE8rzaiUDcf/4GZ
 04ykYXIFPaUD80GmOBPimEv1F5JhlB7TrHIixK/Aqn0i5G53EaBAZGWLz9NEclh5eGFH
 1i2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795808532; x=1796413332;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=/b9sJ8O9pBnWflnn7haHR88BHJzkNqZdO94AJviHC9U=;
 b=awa22tiMXilXoIYJIVJl6zskNHDFfKvI/R+YDF0+77MN98TV9jw9UAKCcM9Cy+LRma
 nMUGQmjlcL9WJJGQm5vVfemMw4buMjBpPo5NjpyUuIEmnwi1877/8gl/5MU71or9jNg2
 thBHH5VyPQjAM4uYm+jHc4uFCbETpP2LE/a4ZIoz0C/uPgb5O/3M9HD9UNkRLeX/XQhn
 v2soWJmG27WJ/jNezzJqd5NmC02m5Ku75o8LuVbcT/XhSFm1g4pVeCn1ebnM0hw7/102
 O+ZfEForI8+sYnIpEhfAzAenAkFOWR3gCSJRjjopc3yRdxsLrD6K2DoErrwCCOboVF/A
 fTtg==
X-Gm-Message-State: APuU4Z80gh1KXnbRKI4DqzjddoWIrXICZfnjPvn//9s4dLbK3X03ctAq
 DLutSUW1U6rRssAYQ+rWNqJxauMx6wdOYsMydjh+Xysogd+Oi/sVIgFqYRhZQSSCrcEM7anz5AY
 6Wdspt3c=
X-Gm-Gg: AZFdTZeZRFHMw1Nv/0ZF0B2pcI/MPGYyyho1ugGdLlxboY9b5PakgG0ueFI7eBWO005
 55rZp5uW3VicuaxPdFWNaBcDg9MWQMyfdLYbPlrTS3yHl+3IeUGVmVPgHLQseDleI2reKDD9iMQ
 Ki63ybUxDJt69MnHhC9Xge8H1R/h7QssJtlJEs+4jTQtNnJ6npU87WGk85VX3aHlr22aSo7a15h
 /Lv8ASUO8LUSoCNklJLIx57ABj7WY206CPgSgANYsDD5hDEVoUU65NYUYj61JI89lf4j5cuuoda
 qOaGBbLuzEl1oH5nAwUYwehmfvss8ynkrHZl13W7jBxIq7XQK4lIYq5h+vBKtl56ezKKyll99f1
 PTrY5LnIrHIGHIAwVbvIFKV2aYl/O/nmFTxbkzeR1zlMGVWh6hLGlKsNkydLdgoEVROH4++B2I4
 /WM95JXSlTRlLmfi4RG3oQKsIW6hZjT8fLa0YMNm+qv6eiDH0awTr+MXPDQyYt0SynlzU38r0vu
 z5ScxIhUX/zUXYTsw88HHs99UIZiQq+ULlVB9eN+ViLwyO/3r/mZT9Pfa72yQjy8XCuCAS7Bf5j
 jTUxdm06kElU2QvQRLoaHMkjK9XYOOCt1iCGnwwbD6hY0WFe9bcC3Pl55XNaMeiRl50M8g==
X-Received: by 2002:a05:6a00:b56:b0:881:8b53:f64 with SMTP id
 d2e1a72fcca58-8c87d9fbdd0mr23609276b3a.59.1795808532485; 
 Fri, 27 Nov 2026 11:42:12 -0800 (PST)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8c872951febsm12881051b3a.14.2026.11.27.11.42.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 11:42:12 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 =?UTF-8?q?Mattias=20R=C3=B6nnblom?= <mattias.ronnblom@ericsson.com>,
 Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>
Subject: [PATCH v3 1/5] eal/windows: add getentropy shim
Date: Fri, 27 Nov 2026 11:39:33 -0800
Message-ID: <20261127194209.107396-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261127194209.107396-1-stephen@networkplumber.org>
References: <20260915192207.3926217-1-stephen@networkplumber.org>
 <20261127194209.107396-1-stephen@networkplumber.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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

