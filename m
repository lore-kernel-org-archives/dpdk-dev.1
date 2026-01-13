Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4686CD30CC2
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Jan 2026 20:24:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AF98840B8F;
	Tue, 13 Jan 2026 21:23:59 +0100 (CET)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com
 [209.85.218.44]) by mails.dpdk.org (Postfix) with ESMTP id 2936940B8D
 for <dev@dpdk.org>; Tue, 13 Jan 2026 21:23:59 +0100 (CET)
Received: by mail-ej1-f44.google.com with SMTP id
 a640c23a62f3a-b86f212c3b0so33589866b.0
 for <dev@dpdk.org>; Tue, 13 Jan 2026 12:23:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768335839;
 x=1768940639; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=abw719rhYkgH1OwePPZEJ0D3gjIN0vOEFGcXODNTTE4=;
 b=kEGa+fUtMg+XVoBEJffhR+RSXKkOitPkQIJsIxeOnDlDRli/OTqewbR04ZPognClJr
 ZaJKMnyuyzgrX443qbNIDHHHulsj/Kr0u6lyPJH+kqF7vX8PeZiQfR01PAuLAWaoFmb4
 Ogqsq1QxsOfHfH6KHI+7VhUDPRdaRzzx4/rcj++DhDWCw4bGCZ6fvTuN2j5OVqz7nQlT
 bGYaXEF6rjyT4+LiHa4y/X24ldCI3LvF87AfmjE9qCHs1X6jAkZjuYQoBE80mzZyVTze
 bu/pxZ/DSLO0G2iIlXsitAoEw0NOZgxWe3rz7Ky/QHORYMQ4XY4nBMqQkx2s5sDo9n24
 jxyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768335839; x=1768940639;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=abw719rhYkgH1OwePPZEJ0D3gjIN0vOEFGcXODNTTE4=;
 b=DDiKf7iLr/Xp6lXchOyO3OXJoDduZX4Bq/GvtYcp3X6Lv73CPuMFTpU/mu9LDyrjd8
 pD7pJPKiOXQbDElL49snyK2Vl2OmH47Yzlkr9yt+gPSf4hITbzrQXTRKG7ON5sDGCbO1
 jJJedinY0EX2w9evYCTSh5XPyQm8fKtxaYd9ep6Fkxocej2qy34L/8LP8DxSMeLSGubI
 8E3etCG43kaVyCW3Fex2gHyeUPYbySeBO15qXixUFC4T+20SmErj0GMN+pQc1dvRj+1D
 HgQYRKzvS7LdC34cYim64el/qFFQxTdm+GqY4V5Dwu+S/EviNqjNsvuFQjS4M98FXhyu
 Zs2Q==
X-Gm-Message-State: AOJu0YzsYHBWfT3tU3KpdxC5/PZQVNpQ4UCzmjojIUulnPXYiCdijsfE
 w6FcxmteC5NWwjm+owaQFBajsm4tFxajXE8sy6tf0an8I9GUHVPpy7Sgo0SR8IaZLOdN6jjecO7
 Q7eA8
X-Gm-Gg: AY/fxX4n55dPeMWq2vtjHDTg0OmqAQQv9OAGlJQjRsumvS1gggw1abciykbifhRKru/
 1ZjpwVt471u1gu9J0qhbqmlQOicQf4nqHDDWM3m0OXiyy1gk0l3CNYMmWJRKfkNxsuU/6zjh+dl
 o0pLg9gWXAPovAax6Zf8aIasSRJnX4E1DNZUlWYeevxdFItSM+ypQtF0vlR0rPFoMg51KQ3N1Xw
 08DUx5TVMGqnx6BXvIlZTn3nkb885HgbQZVZFolkDQ7Wr6W6Jhb7DewMv4tJj1aunDakre14PQu
 K0lxD0YeRvVYfXIxFz++5QjQPID10NogdYvUmN/JldzeoAOCvvkiC9ZXsFvTxG7A4VgtYNbFmhx
 JkcH8K2aiIXhNenP9oIE+IWR6WV3N3OGrHNX2M8h79rnbjqgB45mXXxfRpwZ80fr78UNZzv9HYM
 jh8XDOCDSd8NsA+HRH6slKFQIEmk3EBoiDO0xYqMocsrhg9Fbceg==
X-Received: by 2002:a17:906:4789:b0:b76:d4fb:c30b with SMTP id
 a640c23a62f3a-b8761d92cd1mr20811266b.27.1768335838726; 
 Tue, 13 Jan 2026 12:23:58 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b842a23433asm2314992166b.3.2026.01.13.12.23.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jan 2026 12:23:58 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v10 13/18] eal: check tailq length
Date: Tue, 13 Jan 2026 12:21:52 -0800
Message-ID: <20260113202329.35190-14-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260113202329.35190-1-stephen@networkplumber.org>
References: <20251202172626.283094-1-stephen@networkplumber.org>
 <20260113202329.35190-1-stephen@networkplumber.org>
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

