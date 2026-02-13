Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B68BEF99DD
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Feb 2026 21:51:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0120F4042F;
	Fri, 13 Feb 2026 22:51:32 +0100 (CET)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45]) by mails.dpdk.org (Postfix) with ESMTP id 3F3834027A
 for <dev@dpdk.org>; Fri, 13 Feb 2026 22:51:30 +0100 (CET)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-483703e4b08so10315115e9.1
 for <dev@dpdk.org>; Fri, 13 Feb 2026 13:51:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771019490;
 x=1771624290; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bJntNgRLW0UiCXhFFKIHptVFzJN0sSi4Pnq7rs+yYWQ=;
 b=RNESYNjVsxoZDdeKHMya3Pu2V4BhAuEz7gIscqznTdlpPf+18CAaIItRiZc6Wt5mBI
 N70OygRlS3MfNZWtyirP9QMeuYq1DsqaFNZXrFvnmLkM6K3KrPF7YxqA97Z6Ah/zoKn+
 YO0ayy50Z2iquSGFkSgIe+NHfmPHrlnBUU58fhdEEVAcnGX1pOmhM51fOg7tWUi9U1u5
 tld3X0Qi7E+7Wz1mR3Hfv/MoOmbqNOPWgrsHj8LA4CU2EsE9C0x+7JdHe3VH/GqYSU3X
 ae+/GZEaX4RmjlBlh8rBTmXqkDPRYIBqdxKG/Tvo/uFs89CHTZTJyv8Ri7h1wQG25AmM
 1asA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771019490; x=1771624290;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bJntNgRLW0UiCXhFFKIHptVFzJN0sSi4Pnq7rs+yYWQ=;
 b=IXIRCo1OUtVqxu5KB9mnIMcfiwgn4GDcF1kOFS7nK5nm4jAnJZuEYcoix2rZ9QNIzI
 83IfuxacgeBjZkx7t+yGUhLvZwqp43f9COEcsh4cFDYzf/xF+UR4T7f4QreBwvLXGzLM
 HXNOZPr4SFHq89fJI0/JVcP4QQxaniIVpi94h4Jix5P+1V1n0mhY6iNBQDuq4V9J/Hwp
 rC4va8UNqHrWto+mh/WSQ/0MtKAeM4O1TKrjVROhXLyOYoPHFxAM0wocMQFTef4tjwsD
 G6WDdoeWiFZi5yFAibpD4LjmM0HS4nsKnWt/1Bz8I9/ZmUtdfaqWijxtUjKLkDrfZm8e
 0+Tg==
X-Gm-Message-State: AOJu0YzXp6eoadvc13wQdTFVLTws2P0hqry1fWh4u/Sf7Fy6N6erapST
 kXy8LSHdrOUCI58nUPXkK9PpcyVlzs7ef6FeN5kvcl0KnKNOiAXQHbcmDOGu+MuFh/QvXUITi58
 8JW+G
X-Gm-Gg: AZuq6aJCLNCCjvgflKSxiaWB7b1wINE1cNFOJwvnHzkk20kO2zJXySWes/pujZhxXix
 EFTbJ/U8qcsTUGmdMd6l1q5SUmPNfCJGs598vNzYpUE7NkI7YOZb0ayMIkTxi3KVeSK/EYw1SpH
 qpwlQ1FOnTzcwh4vd34UedVaQQpVl6qJIUvRlX6wr0821uMxAOyz8zbolvqZ+UICiOD8gQzHc1w
 6RlLfH3IpHxIWjf3d0hTnuly3fZVFrOnq0W2VmteSKIrYr4qH3v8i9/PmBzIjEEEdniK8apNagK
 EvAzZY1nsMfQw9ZOUvjY60uprXKCZUJnhFsPy1S/oMJTaAqlizIPDsxG9f0fHB2MreQfcoHlYF9
 afe5PoBqxDKdSDn/ehwL2CaUAXy3G3Zh2q9y//4fGzV4mtx1y1cSWZyPSf9eBlBF2oEzGVhEvd5
 +lZfoSAlz36nNDw7Opyef9JiJTjhy0MQpw6O0CzckZttDiWtUs1PTvt6CZsSjZaA==
X-Received: by 2002:a05:600c:1404:b0:47d:7004:f488 with SMTP id
 5b1f17b1804b1-48378d95794mr22771005e9.10.1771019489722; 
 Fri, 13 Feb 2026 13:51:29 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48371a41fd5sm24572845e9.27.2026.02.13.13.51.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Feb 2026 13:51:29 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Congjie Zhou <zcjie0802@qq.com>, stable@dpdk.org,
 Stephen Hemminger <stephen@networkplumber.org>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v5] Subject: eal/linux: fix fbarray name collision in
 containers
Date: Fri, 13 Feb 2026 13:50:53 -0800
Message-ID: <20260213215124.262773-1-stephen@networkplumber.org>
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
v5 - rebase after format-over fixes

 lib/eal/linux/eal_memalloc.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/lib/eal/linux/eal_memalloc.c b/lib/eal/linux/eal_memalloc.c
index 4dee224ac5..70f6335d03 100644
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
@@ -1397,9 +1399,16 @@ secondary_msl_create_walk(const struct rte_memseg_list *msl,
 	primary_msl = &mcfg->memsegs[msl_idx];
 	local_msl = &local_memsegs[msl_idx];
 
-	/* create distinct fbarrays for each secondary */
-	ret = snprintf(name, RTE_FBARRAY_NAME_LEN, "%s_%i",
-		primary_msl->memseg_arr.name, getpid());
+	/*
+	 * Create distinct fbarrays for each secondary using TSC for uniqueness,
+	 * since PID is not unique across containers (different PID namespaces).
+	 * The worst case name length is:
+	 * Base name: "memseg-1048576k-99-99" ~21 chars
+	 * Suffix "_<pid>_<16hex>" +24
+	 * Total = 44 < RTE_FBARRAY_NAME_LEN 64
+	 */
+	ret = snprintf(name, sizeof(name), "%s_%"PRIx64,
+		primary_msl->memseg_arr.name, rte_get_tsc_cycles());
 	if (ret >= RTE_FBARRAY_NAME_LEN) {
 		EAL_LOG(ERR, "fbarray name %s_%i is too long",
 				primary_msl->memseg_arr.name, getpid());
-- 
2.51.0

