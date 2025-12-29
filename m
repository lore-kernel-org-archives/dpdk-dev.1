Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE1C9E92FD6
	for <dpdk-dev@archiver.kernel.org>; Mon, 29 Dec 2025 20:49:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CA2E14066F;
	Mon, 29 Dec 2025 21:48:54 +0100 (CET)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46]) by mails.dpdk.org (Postfix) with ESMTP id BA9E34065A
 for <dev@dpdk.org>; Mon, 29 Dec 2025 21:48:51 +0100 (CET)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-47796a837c7so60536725e9.0
 for <dev@dpdk.org>; Mon, 29 Dec 2025 12:48:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1767041331;
 x=1767646131; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=abw719rhYkgH1OwePPZEJ0D3gjIN0vOEFGcXODNTTE4=;
 b=M580xtgX8BzlgOh5W2y3NHCqTc8XobmG/0hpBYhoPTSrn020AX6yW7CRq8hwe1okBM
 4Yvhl7qcwJvaqjT7HyPhJqh0F0r8IYPHNkz+ef/Bg8deQXej37Y0bjpkDr+YtECYyt88
 DIWXl314qdJG28hGBfH1z9w/OdH/lFVbOLVlG/ufG2ZsKQWtCNJX/bGjX/wdLYzWgpFj
 GzSHxRG1Nu3Xq3q7oU9GyVvsQxj9KgSSJ8JEjzMTBqqE0oDM4ARCInjd4VE0wLnBJfFy
 hd09Js+eazFdpgrcDmdrcbLWtIk82RNNqE56JT/Xtz355UZHNGWnjoJFX6xXbgWVH2qM
 m5sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767041331; x=1767646131;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=abw719rhYkgH1OwePPZEJ0D3gjIN0vOEFGcXODNTTE4=;
 b=e5Fay3Vsfjm3VTINYfOfLzALnPDd/G3eYzgwVjQo4Z7JlfLlnBKN7dEO9c0fYazlX3
 xLkORQD3age7mLMwOGzbJe4Po4+b+w+X4biJEBC2P/bnSsGgDul+qDal8tCDBDPGmzBm
 c3AxGoHgTsRX8neyU+GUvOs4vvpatIRYoDPZJ8HreAwAjrkTJ/3vvBejev1p6SznlYVU
 WfSJL2vmEHzuuTr+4TNbvaPkBHINpsRABr6Sk9OqTEWkiFGmz6402rom+nBRjvC6yRhv
 ClVocc7KFCt8Octra6ZuwA1yEjUCsuMA5+TncEgrhRXYRjHsu8dxASTjQWkH3ajvETdL
 tNtw==
X-Gm-Message-State: AOJu0YzIcgVgRL8iyYILp6mFvckOaeFPClY9olIFwdEEhfR1rwz4d7JU
 w+1/aLqocXZQk42GVsHIK60vwtG4JRHdUbnbp+8Zuw/3PBlzFQbAkVGv1z5LFX6m3T3OvTdMBmC
 gtPcoD0M=
X-Gm-Gg: AY/fxX6ZM5mJKHfeRFPJj2sJuWmAHbIFMT6E/Cd3I/BzoE8p7EktouViaCdUKHN9lfr
 68/xASN4EESU4Hoi+Ho+Nu9/NsZG11WybsXfuOP92pXxzasCgyzo4arvplw2znAXH7qwiKRnd/v
 sX+Xl+hqN/Won6VIYqC6U1DC0p1dtSraNQmpF3H3gahCrg2ZvEDyBACTiFN2sSDn/Z/IAXfeNId
 t8GU4aU0zNeA1p5r0UXgisllJsGS41UB8Ju0wWx85u5oP0ZkDDhRsdz7KI2YbGet3IfqZytpkO4
 b+PEO539x/uFH/YEwAI0OAO7vAG7kd8NAIa+eJ3T96dNzTFoVXbdlCjUTW1bmycP69vpxum8Piq
 WdI9ei/Pf4eIewMAZaVD3Oqc4bN0cJNnm0HK8hSVmSCOB5gaf1anZdNq5lzbaYo99iQBP2RdMQh
 g9vIBNEkJmhZDrFKQ9teZHzVAdFIySSc5uajIWUGyTlYpYb7hmVQ==
X-Google-Smtp-Source: AGHT+IG22DyvPi+X7TFeZYeZBKiIFKiEwXvpf1PO8A8JRJJVlu7tNbW1PvLvklwZpOwGR4wDFJo5Yg==
X-Received: by 2002:a05:600c:458f:b0:46f:b32e:5094 with SMTP id
 5b1f17b1804b1-47d19592a3dmr341390245e9.32.1767041331387; 
 Mon, 29 Dec 2025 12:48:51 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324eab2c4fsm64676298f8f.42.2025.12.29.12.48.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Dec 2025 12:48:51 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v9 13/18] eal: check tailq length
Date: Mon, 29 Dec 2025 11:38:11 -0800
Message-ID: <20251229204818.61231-14-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251229204818.61231-1-stephen@networkplumber.org>
References: <20251202172626.283094-1-stephen@networkplumber.org>
 <20251229204818.61231-1-stephen@networkplumber.org>
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

The tailq name should not be allowed to exceed limits.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 doc/guides/rel_notes/release_26_03.rst |  1 +
 lib/eal/common/eal_common_tailqs.c     | 13 ++++++++++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/doc/guides/rel_notes/release_26_03.rst b/doc/guides/rel_notes/release_26_03.rst
index 91b1808455..d643206167 100644
--- a/doc/guides/rel_notes/release_26_03.rst
+++ b/doc/guides/rel_notes/release_26_03.rst
@@ -93,6 +93,7 @@ API Changes
   * lpm: name must be less than RTE_LPM_NAMESIZE.
   * hash: name parameter must be less than RTE_HASH_NAMESIZE.
   * efd: name must be less than RTE_EFD_NAMESIZE.
+  * tailq: name must be less than RTE_TAILQ_NAMESIZE.
 
 
 ABI Changes
diff --git a/lib/eal/common/eal_common_tailqs.c b/lib/eal/common/eal_common_tailqs.c
index 47080d75ac..c581f43b6f 100644
--- a/lib/eal/common/eal_common_tailqs.c
+++ b/lib/eal/common/eal_common_tailqs.c
@@ -8,6 +8,7 @@
 
 #include <rte_eal.h>
 #include <rte_eal_memconfig.h>
+#include <rte_errno.h>
 #include <rte_log.h>
 #include <rte_string_fns.h>
 
@@ -30,8 +31,10 @@ rte_eal_tailq_lookup(const char *name)
 	unsigned i;
 	struct rte_mem_config *mcfg = rte_eal_get_configuration()->mem_config;
 
-	if (name == NULL)
+	if (name == NULL) {
+		rte_errno = EINVAL;
 		return NULL;
+	}
 
 	for (i = 0; i < RTE_MAX_TAILQ; i++) {
 		if (!strncmp(name, mcfg->tailq_head[i].name,
@@ -39,6 +42,7 @@ rte_eal_tailq_lookup(const char *name)
 			return &mcfg->tailq_head[i];
 	}
 
+	rte_errno = ENOENT;
 	return NULL;
 }
 
@@ -67,6 +71,12 @@ rte_eal_tailq_create(const char *name)
 {
 	struct rte_tailq_head *head = NULL;
 
+	if (strlen(name) >= sizeof(head->name)) {
+		EAL_LOG(ERR, "tailq name '%s' is too long", name);
+		rte_errno = ENAMETOOLONG;
+		return NULL;
+	}
+
 	if (!rte_eal_tailq_lookup(name) &&
 	    (rte_tailqs_count + 1 < RTE_MAX_TAILQ)) {
 		struct rte_mem_config *mcfg;
@@ -115,6 +125,7 @@ rte_eal_tailq_register(struct rte_tailq_elem *t)
 	if (rte_eal_tailq_local_register(t) < 0) {
 		EAL_LOG(ERR,
 			"%s tailq is already registered", t->name);
+		rte_errno = EEXIST;
 		goto error;
 	}
 
-- 
2.51.0

