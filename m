Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 020FED46C16
	for <dpdk-dev@archiver.kernel.org>; Thu, 29 Jan 2026 01:44:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 73A2D40662;
	Thu, 29 Jan 2026 02:43:49 +0100 (CET)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50]) by mails.dpdk.org (Postfix) with ESMTP id A86D640A82
 for <dev@dpdk.org>; Thu, 29 Jan 2026 02:43:45 +0100 (CET)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4806f80cac9so2790525e9.1
 for <dev@dpdk.org>; Wed, 28 Jan 2026 17:43:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769651025;
 x=1770255825; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=abw719rhYkgH1OwePPZEJ0D3gjIN0vOEFGcXODNTTE4=;
 b=cJLmLL7vADlpogENrlkl+5pIIgqcKfUVmckABTwvEGOZUupnKhHYgB6CeaVypb0HQq
 OMVkmtO6uEBShuVRnzKSKSuteVNrbFuZeto7QwKeIGsyUtHHQkDGvrjuvXqhNDETFpX8
 /wFok88bqMw+gTc7ScyBudgRgukpVxxejbGWjlANfBPCQ2PlfBAnwyIm5aLiihp5YFol
 41bmg1+ovGs+TG8NR6UWLjQp9K3NfrZ6Y0PS4axZOX1s+WUB3ql8xy0kSe1EHInwCE++
 Nhxp08ObZR7prCxOfr0oJ6irbj7ge0qQxfkDyxDi24RK5m6vZKcAVCv3ijyQ4p3cSYkz
 ituA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769651025; x=1770255825;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=abw719rhYkgH1OwePPZEJ0D3gjIN0vOEFGcXODNTTE4=;
 b=l0/Ln6YDK6QJH77slXwsgRE7dRWWrdZY/k9q7RHu5Q9Tu0gGfR5YRTClLvGgY6MGue
 xHlkvaYGQhagq0yyBUD1vDD0xRKpkOJHvYtVundYGB7i6e5pQfRzPtw6NLyKm6jzrHl2
 oxDz0FN7akmWzl3EbtfklFF2VR/q2NEsDbEL2qlXSn36IBSC7FAyRf9YNJRuvTzStZsz
 DlxpOZQeh2msk34MbKgDQzgRbNGMpHupwlCbkh9q1xslxe8zXU3tJAlrByNzXlwWGJD4
 RYzE5WDah9o7HLdRyzCCjNl7cqtU7hivxI2FlBGIPzzcAnUuLzSlxgRLU4dVHVA6N1zz
 4YaA==
X-Gm-Message-State: AOJu0Yyn9aifZzYX3DBsbJY2mKQd06RKXgMHdYWRjn/BZR5RC3CRfnXk
 Kll3hMYSuSm7vcNtdPYCSto19mwuTkfMVmhyLIINDOAqCxRs/DcJv6uV72eShAKscgIqMGnfpNO
 WpriI
X-Gm-Gg: AZuq6aJxhz3tCrUMKPi0qUIyFC8Skz3C3RrUbvNISKrSlCEdG4M1Qqfw+jRggtpcJ1m
 q1hTZg569aw99ZHMFYi7Pl5ByxalX5zV9dwgO631GLiPb1+IoDhOeT0n9gpopG2yv72NntIJVaV
 ifX8JI/CgYZBWKGChW7WceUXyN3wWYhIVtR89PHDLo52jZi70XtqLbs7gUWwfawOWWSQ0/W8MqU
 6YyxIfub4RC2i5X66NspThA+K6zkF9RK5U/ewcg5dmJYSrpWGzP4oVxiic69GHh0ajE0NAkfwmH
 Af5XPROfMrP7TBSHE16FM9xEBpf8V7ETksKpa4jsWJCwj2Wi0IJrKQmXRKYwJaJkrsnf1vruUwd
 +6IMBd6+wjdk60WbMVl68H0YlxNtUTQzgUmwF7xUQcPrl/mrGKb6VAm5JXqOwmWxmIdw6zTwz5C
 JNZV+gSHZT0AGFibdNA10tZwL7FMWpLKA+Fcq05gMtipJd7HBgZA==
X-Received: by 2002:a05:600c:530c:b0:477:7b16:5f9f with SMTP id
 5b1f17b1804b1-48069ca23e3mr98500415e9.31.1769651025008; 
 Wed, 28 Jan 2026 17:43:45 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-481a5e18427sm3217985e9.16.2026.01.28.17.43.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jan 2026 17:43:44 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v14 12/17] eal: check tailq length
Date: Wed, 28 Jan 2026 17:41:15 -0800
Message-ID: <20260129014313.939831-13-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260129014313.939831-1-stephen@networkplumber.org>
References: <20251202172626.283094-1-stephen@networkplumber.org>
 <20260129014313.939831-1-stephen@networkplumber.org>
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

