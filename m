Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C41C8EF99DF
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Feb 2026 22:01:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 089A7402B2;
	Fri, 13 Feb 2026 23:01:35 +0100 (CET)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41]) by mails.dpdk.org (Postfix) with ESMTP id B0A194027A
 for <dev@dpdk.org>; Fri, 13 Feb 2026 23:01:33 +0100 (CET)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4836f363ad2so15426775e9.1
 for <dev@dpdk.org>; Fri, 13 Feb 2026 14:01:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771020093;
 x=1771624893; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T1nfcDuLzP/9SjLAKCaSbkUBZRAMrHQfNnGOj2e5gEU=;
 b=Fyfihb5CD5/c8QkH2u8iqE/F1tS0nxemrAGEUgi0WwoFysCzesbjAHs1U7VRGKM8l9
 stAVBN/6Q3PuRwxXithXabTNkzarDDlrVEGyBeEcGXwnFeDkj2dspN+hV8PsIbwjGXsV
 d/6pSd7TPv+7Pjv6XzXjEKxemaqFp5iIKmbTFCEyfpsunalirkr7fB2Qu2+XLaNWZ9HU
 fqybtYWT7/RjOBZUVlLyGmzrnSSllravB7Dn1sw2h0d7YIcDhC8ca4jZW1yORI3GCtow
 52Mqf8m1f5FcHCEIBg9oAOOECPaPrE1LgUak/A/gI10h8iRvbGwDbV8QyD9gzz1rqzVp
 G+Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771020093; x=1771624893;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=T1nfcDuLzP/9SjLAKCaSbkUBZRAMrHQfNnGOj2e5gEU=;
 b=K5zGtdDcz5/9AZEfKMczwVo8ewQ4yv7YVaY0iwbSrMhFxOOqf0DPomi1qWY/z+gYw+
 hNThJTZH35nYKuOoZjqF+q5e7SN0Ovpy2yyit4GzBReS+RTeAI2azVvsKNLfJHuMj1DY
 cXXzfhnlQ4EZcFNIQRHbhIYqIccHOd+6eXyXeFd+wDUnQslUtXUZ5svfODb5ztHNO+JI
 PZ2V6abXh23Qrvj667YxTpo20HOHQkadIn3GvCp+26NpMBNEQQzzqHswo83y8Y6BdfPj
 d7/RHfou9w6tfoaVYg9owT1p5u8uOKi39BkCZ6h2cBW93CE2MdeYGgbIe4ynCt1thmJh
 +uVw==
X-Gm-Message-State: AOJu0YyfeKx0ZYzI8eR9SJdFagzPrQ+JRcun8Az4uy8/6/1y1lOG5VxC
 O6NymEfEZaJNA0bYnhlIu0BgDU5AVuTbnuaFMaRAHS4Q8cWSgsqhGwmrUm2gr0fjiPNaQ5JrUqa
 gU8ON
X-Gm-Gg: AZuq6aJkNs7GoP4GdAyCUgjfcGjO46UNvrAyHUMyvtpvkyzIeffHKUz+FrvylhqV6c+
 vtKZhbd8DM7XFO93+lb1Jp/pcUBlhKxIaENpuXQBV+5H51JFSBA1BbR7Ry2OyoHoYCyj2ULNh/a
 V2jI+U1WQqiiS6K47fg2etuSEVaQS+Ns62S/QnvYbhE3HvtT8a1tI8jVYeUG68XXRcyT+kZNVnE
 2X6+ksTJpg8z2H75NhXkwWM4fe8CIAJtG0j+h5iq7Fe2GefvXb2hM6aTMHp5NXLzCuV1AJbBNZs
 cSISKn5ghUCwpl2UyCazlPUwhXygtRUdbKaYvQS58h6Vr75xtHex/9rhiBtOpiUDrtZMrNZJYaY
 82D/9AqejCCqCuKKDU+8kJZJVeb5I7ADTxMRJKgk97y5m0nBn1JnGMFWNvyc8v3kd/rNpuvkT78
 onhylGDqvOl/8i109jlhV9zLoSAlmL7/RHLYIjL4bX2v0KIVKCW8T6genTyPCWLA==
X-Received: by 2002:a05:600c:8706:b0:480:6999:27ec with SMTP id
 5b1f17b1804b1-48373a0b559mr52810135e9.13.1771020093223; 
 Fri, 13 Feb 2026 14:01:33 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4835dcfb28dsm216470825e9.11.2026.02.13.14.01.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Feb 2026 14:01:32 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Congjie Zhou <zcjie0802@qq.com>, stable@dpdk.org,
 Stephen Hemminger <stephen@networkplumber.org>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v6] eal/linux: fix fbarray name collision in containers
Date: Fri, 13 Feb 2026 14:00:23 -0800
Message-ID: <20260213220127.265020-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <tencent_B09D0FCCA142E4AE5ABFE584E92DCED8CB0A@qq.com>
References: <tencent_B09D0FCCA142E4AE5ABFE584E92DCED8CB0A@qq.com>
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

From: Congjie Zhou <zcjie0802@qq.com>

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

Fixes: 046aa5c4477b ("mem: add memalloc init stage")
Cc: stable@dpdk.org

Signed-off-by: Congjie Zhou <zcjie0802@qq.com>
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
v6 - fix typo in subject
   - add pid to name because if two secondary spawn at once
     in theory could collide.

 lib/eal/linux/eal_memalloc.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/lib/eal/linux/eal_memalloc.c b/lib/eal/linux/eal_memalloc.c
index 4dee224ac5..dfbedf4626 100644
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
@@ -1387,7 +1389,7 @@ secondary_msl_create_walk(const struct rte_memseg_list *msl,
 {
 	struct rte_mem_config *mcfg = rte_eal_get_configuration()->mem_config;
 	struct rte_memseg_list *primary_msl, *local_msl;
-	char name[PATH_MAX];
+	char name[RTE_FBARRAY_NAME_LEN];
 	int msl_idx, ret;
 
 	if (msl->external)
@@ -1397,12 +1399,21 @@ secondary_msl_create_walk(const struct rte_memseg_list *msl,
 	primary_msl = &mcfg->memsegs[msl_idx];
 	local_msl = &local_memsegs[msl_idx];
 
-	/* create distinct fbarrays for each secondary */
-	ret = snprintf(name, RTE_FBARRAY_NAME_LEN, "%s_%i",
-		primary_msl->memseg_arr.name, getpid());
-	if (ret >= RTE_FBARRAY_NAME_LEN) {
-		EAL_LOG(ERR, "fbarray name %s_%i is too long",
-				primary_msl->memseg_arr.name, getpid());
+	/*
+	 * Create distinct fbarrays for each secondary using TSC for uniqueness,
+	 * since PID is not unique across containers (different PID namespaces).
+	 * The worst case name length is:
+	 * Base name: "memseg-1048576k-99-99" ~21 chars
+	 * Suffix "_<pid>_<16hex>" +24
+	 * Total = 44 < RTE_FBARRAY_NAME_LEN 64
+	 */
+	uint64_t tsc = rte_get_tsc_cycles();
+	pid_t pid = getpid();
+	ret = snprintf(name, sizeof(name), "%s_%d_%"PRIx64,
+		       primary_msl->memseg_arr.name, pid, tsc);
+	if (ret >= (int)sizeof(name)) {
+		EAL_LOG(ERR, "fbarray name \"%s_%d_%"PRIx64"\" is too long",
+			primary_msl->memseg_arr.name, pid, tsc);
 		return -1;
 	}
 
-- 
2.51.0

