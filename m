Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B28FD31A09
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Jan 2026 05:55:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0B7314028F;
	Wed, 14 Jan 2026 06:55:17 +0100 (CET)
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com
 [209.85.208.66]) by mails.dpdk.org (Postfix) with ESMTP id 7543E40289
 for <dev@dpdk.org>; Wed, 14 Jan 2026 06:55:15 +0100 (CET)
Received: by mail-ed1-f66.google.com with SMTP id
 4fb4d7f45d1cf-6536e4d25e1so1960199a12.1
 for <dev@dpdk.org>; Tue, 13 Jan 2026 21:55:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768370115;
 x=1768974915; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vKfLe3RXmiplUyq763aCGioW643g7cyeFLBMDe8cPS8=;
 b=HUWD7jdRCSNlXmL/Kh/rUuNetWTGZ2o6IlRVAfWksFgLZ1BsHK6hI0X1NhCq0oxzSw
 FbarMmnieOezQV5Dac/ZT96chc5P8LNf8WlKB/dnF2nVZATAz/k8fE5Gj0/lnU4az5uW
 W4XvJJP555WlV+3qBW04ix1zONBVq54RC4ohqVS/N1i/LlhbmgzUw2k/Y64KJLYXKzyV
 xFWdqveseTIwtmTesedgFLPxDRXflxLtZT2cGMmtaBlR3ABx9YcdL7DmHk0r+n63+Ctk
 OewxJwA+9/hKz8SartgbD5F6fH8VsgVcoG8Zz4v3zbT2FEZTsessvv3PLZyYktWxV5Pq
 Ajxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768370115; x=1768974915;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vKfLe3RXmiplUyq763aCGioW643g7cyeFLBMDe8cPS8=;
 b=duGBbygpitu+99vgU4RwtZMufZ0LatsQ2gZJsIu6z5OotSaNxNExeB6+UNFkKxqcRi
 ndvOoWL1G+8zNVUasaZ/sKGnzi9LufPKfprKLZaH8Xpb1rp5aRrmI9Yt0Wr9gANxrGYA
 5D6Uxm0dXv/Dootpp/nyiiCyluPnFyUvKUjYksKzKxtsIHGU8TGxDf2TIOaS3USaS6OL
 sSXOpx+RbJhOEEVxXFBzVpaQiYkDsmBA3y/sgdJX/INI18UrSAR4TpYJHaj+EiyNsZKJ
 jzC/BJSNSIe12bzR/P+3nihdQcv7laBru836+xvjDIz+wW50Mss+YOjPKumRqLmeMmJP
 w8cA==
X-Gm-Message-State: AOJu0Yytx4LHjtFwsA6l4DYxN7KPF+vfiFqZQBgBYWInUhr8/HTcV7ed
 7lSjuV8Jj857508c3rhx/zbiCP5VQWMevnRuEzYHk4seCQnHunb0wx03zVwVnax5GSLPC4sMoqX
 toWc6
X-Gm-Gg: AY/fxX4TsbI+6pdaij6356naKI2+imSA+rKMFeeI3Llwwhv6Mif6hoDs03V5L18cLC2
 TKRr0AZD4kB1WxAoV5DOz89bBUmbM33bFWu4v9qkEf958sgw89Z3JhuBnZ8szn46l4EY6+ZBaW2
 77LhmOi8MPw0ikJQe1mE+/PLs9YqUR78xaNhPhypcExhpzYXgGECTxN3rdRdwb33GiVv3mkOoQd
 8xsY7QfKTaKwSxDcMcvO45sjI0UiCbw7NMc4yZcL3cfJpNMlHdcvTi9GJyNdq6ifnpW00uDmqxc
 RpfrSJNsvNfAcUal6351lUE+vZh5D5Ym13UtYbCdoF8lItiGCz8Fosp09WvTdQPTN4jtlRd0Jqp
 KIyFhj/2BH+uHAoMM04ENRxM9Y7Bvf4RXGRrCzT2d317YcQatYRTmFAgQQLaaQCIM7Mp3dEwAky
 SCo0p9D5QooRgTPpsNvslcGh2skSyo+XjKX5Pur1ZvGI3jRTZUqw==
X-Received: by 2002:a05:6402:35ca:b0:64d:88c:c2b7 with SMTP id
 4fb4d7f45d1cf-653ec312f7dmr1050699a12.14.1768370114842; 
 Tue, 13 Jan 2026 21:55:14 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6507bf6d4acsm22184980a12.30.2026.01.13.21.55.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jan 2026 21:55:14 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Congjie Zhou <zcjie0802@qq.com>
Subject: [PATCH v4] Subject: eal/linux: fix fbarray name collision in
 containers
Date: Tue, 13 Jan 2026 21:54:01 -0800
Message-ID: <20260114055508.106779-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <tencent_C757C0BA2AC7438F65C6522E700005F53605@qq.com>
References: <tencent_C757C0BA2AC7438F65C6522E700005F53605@qq.com>
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

When multiple secondary processes run in different containers that
share the same hugetlbfs mount, the fbarray names can collide.
This happens because containers use separate PID namespaces, so
different processes in different containers can have the same PID.

Fix by replacing the PID with a timestamp-based value. The TSC
(timestamp counter) provides sufficient uniqueness since containers
starting at the same CPU cycle is practically impossible - even 1ms
of startup time difference means millions of cycles apart at GHz
frequencies.

Also, reduce the name buffer from PATH_MAX to RTE_FBARRAY_NAME_LEN
since it is only used for the fbarray name.

Signed-off-by: Congjie Zhou <zcjie0802@qq.com>
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
v4 - update comment and commit message
   - reduce name buffer from 4K to 64 to save stack space
     and catch any future format overflow
 lib/eal/linux/eal_memalloc.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/lib/eal/linux/eal_memalloc.c b/lib/eal/linux/eal_memalloc.c
index 1e60e21620..cbe22c98d0 100644
--- a/lib/eal/linux/eal_memalloc.c
+++ b/lib/eal/linux/eal_memalloc.c
@@ -7,6 +7,7 @@
 #include <stdlib.h>
 #include <stdio.h>
 #include <stdint.h>
+#include <inttypes.h>
 #include <string.h>
 #include <sys/mman.h>
 #include <sys/stat.h>
@@ -28,6 +29,7 @@
 #include <rte_log.h>
 #include <rte_eal.h>
 #include <rte_memory.h>
+#include <rte_cycles.h>
 
 #include "eal_filesystem.h"
 #include "eal_internal_cfg.h"
@@ -1380,7 +1382,7 @@ secondary_msl_create_walk(const struct rte_memseg_list *msl,
 {
 	struct rte_mem_config *mcfg = rte_eal_get_configuration()->mem_config;
 	struct rte_memseg_list *primary_msl, *local_msl;
-	char name[PATH_MAX];
+	char name[RTE_FBARRAY_NAME_LEN];
 	int msl_idx, ret;
 
 	if (msl->external)
@@ -1390,9 +1392,16 @@ secondary_msl_create_walk(const struct rte_memseg_list *msl,
 	primary_msl = &mcfg->memsegs[msl_idx];
 	local_msl = &local_memsegs[msl_idx];
 
-	/* create distinct fbarrays for each secondary */
-	snprintf(name, RTE_FBARRAY_NAME_LEN, "%s_%i",
-		primary_msl->memseg_arr.name, getpid());
+	/*
+	 * Create distinct fbarrays for each secondary using TSC for uniqueness,
+	 * since PID is not unique across containers (different PID namespaces).
+	 * The worst case name length is:
+	 * Base name: "memseg-1048576k-99-99" ~21 chars
+	 * Suffix "_<pid>_<16hex>" +24
+	 * Total = 44 < RTE_FBARRAY_NAME_LEN 64
+	 */
+	snprintf(name, sizeof(name), "%s_%"PRIx64,
+		primary_msl->memseg_arr.name, rte_get_tsc_cycles());
 
 	ret = rte_fbarray_init(&local_msl->memseg_arr, name,
 		primary_msl->memseg_arr.len,
-- 
2.51.0

