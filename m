Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A433BD6CFBB
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Jan 2026 04:31:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C699640671;
	Fri, 23 Jan 2026 05:30:22 +0100 (CET)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
 [209.85.221.48]) by mails.dpdk.org (Postfix) with ESMTP id 238114027C
 for <dev@dpdk.org>; Fri, 23 Jan 2026 05:30:21 +0100 (CET)
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-4359249bbacso1803446f8f.0
 for <dev@dpdk.org>; Thu, 22 Jan 2026 20:30:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769142621;
 x=1769747421; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=abw719rhYkgH1OwePPZEJ0D3gjIN0vOEFGcXODNTTE4=;
 b=eABwpf1gU+yLTDY6caFPy3/0KIfUdWVxF/i+dmgSb0/T/UssinvFm+xL0sfGeOZ5t7
 y33fQT7xoIO6pvlUeFNKFIAFB1F6lHkaGR1fjgjiV5wqWxhwTeUKbKT9WL/0sNxOMoEY
 9q4R+PLYNpdL9tSeZcC20cqRgvxqQknTYNBGc+eM4Aa2BqzhPaqWy+jX92JYUqOF/Uor
 +7clIXZbiNKLwn26V4fATvylbYVAVVSxWPJ4/ztETG0sFuT+jwd6P3QNpUYA4IhwOTXc
 rDb0E9gtH6avdLRvB71qdRBo+THBeqlsXpBkqHBFXlULOQ5N5h//7Gg1CqMYQjvGHX4A
 Q+XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769142621; x=1769747421;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=abw719rhYkgH1OwePPZEJ0D3gjIN0vOEFGcXODNTTE4=;
 b=aIMmUWmBGdMn3BM0QkgGvhJald8dvGRjinDLKptIsQm26f5kJB86VfTrmdqf6hWehO
 Y3N4Ul/zBGXFyBxZBAZBxJbE5xQBztT5S+ZvMb0UkVRgrrbWgd0+9kmVfl90ikMePhhm
 bk06NAoNgh32qYh/e62LdnIaORHf3d4heLIZsjYFjKZOExp8oSBaasKLV7gA4A5wuxCA
 hlvHND8glHwb3axaAbqQ80mjF0DOABA7EmBCq1FIhyUx9FmjzngSyhTpBGEbI7mfe4RQ
 IzW5Egq6A7+XvyIAuTExapxnQTLwi6HPoS+c+9HCyI52oGVeR5kEOOBlKnv4mjtrUMKb
 wJcw==
X-Gm-Message-State: AOJu0Yzae7g/rUGX/+BNu09a9LdKHPuX6SmapzqNoH1L0yqS8QUtJJSS
 3lHKCoEcwEgFJw0UDxlKEcO9WEgSGbFK7eQIhcgnMOpl4bqiOg1s5EUR8IzCRayzz2fp8HHDvwn
 j7qa+
X-Gm-Gg: AZuq6aId1IuoDoGRv0HKIDCkX3ku7d9EEfMwj8/ulhypD/DKNyEDWZ9NCJG0tn4Fwbd
 BcAI4Fq14LFpSXUoJ8BDHKd38VPSXedBk6NRlNUl0yr7cDK+/yRCLfJyB1bUNI0sPVpBJgDriHp
 UTh403zv1zPPdSN4hHuQKeHQaazSWjlTrCz2IgYneKL/gOFSwnXq1SYqdKb7msdt/mx6t4o8N6c
 RNRAndOAYI4UNQ+TPn0cRPv8EKVfRktYmV9g9TZLdbt/HigCZ7CkoE328OeBASc2aIbZHRglhKQ
 4k0MblZ35ShrlB/OnQuHo/qI0uQy6KqdFL8gZyjKAX/ylFENPhyoRPny2A6m8NrDnIQE6ru9KGi
 5mHKYU+UXKUWsbnWADcsYQdIyqMwCLe4SDIunoGq4JWsNHb5tcizAk5U+YuhhIYip2PKZGdTA8M
 rEcrzMNrTM5Q64FSppQ6gkJ9nZiYM6w+RANYK07V5xpN12kFEixA==
X-Received: by 2002:a5d:584b:0:b0:431:66a:cbda with SMTP id
 ffacd0b85a97d-435a5b7a944mr9973934f8f.0.1769142620734; 
 Thu, 22 Jan 2026 20:30:20 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1f7b41asm3603771f8f.39.2026.01.22.20.30.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jan 2026 20:30:20 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v11 13/18] eal: check tailq length
Date: Thu, 22 Jan 2026 20:28:11 -0800
Message-ID: <20260123042945.159075-14-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260123042945.159075-1-stephen@networkplumber.org>
References: <20251202172626.283094-1-stephen@networkplumber.org>
 <20260123042945.159075-1-stephen@networkplumber.org>
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

