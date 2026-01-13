Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BABCD30CC1
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Jan 2026 20:25:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 634B240A89;
	Tue, 13 Jan 2026 21:24:07 +0100 (CET)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com
 [209.85.218.44]) by mails.dpdk.org (Postfix) with ESMTP id 66F6940649
 for <dev@dpdk.org>; Tue, 13 Jan 2026 21:24:06 +0100 (CET)
Received: by mail-ej1-f44.google.com with SMTP id
 a640c23a62f3a-b8716197f3eso415676066b.1
 for <dev@dpdk.org>; Tue, 13 Jan 2026 12:24:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768335846;
 x=1768940646; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1v8e6aUWm5WXNa+aLtAVXtjf0nt1Rr3FAXZlKwQAxao=;
 b=Koa1li84O/UVsei5XNYTFkDe82psHSsHFGsPN8YalPq9YqytWlRDfnup8s9JnJ8tYO
 mLmPpziwzNK9gVTDETjKoSSSwRCtTr7NUbv+r8ZKnP26r8QUjjf4a8h9iTaR778WJGi4
 TLhwplNouqBBWISmONF6X2p0bg4Fht6GiwQJxe/7B24Bh2LvdhH8UFCaAzNEsBC1iWdP
 SsLtGBSCe3O5DZvEFHi+MYIzS/t6/8xhoDR3E5cVmX6BvrrlQNVh3zHeWMNwKRApWDEt
 ecqapn6bT33yosU7FuB2bLv1qHT1zWzLHC65QpGnHOGUzZQYDgxIbgMy6QMOAEENsjTs
 E2XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768335846; x=1768940646;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1v8e6aUWm5WXNa+aLtAVXtjf0nt1Rr3FAXZlKwQAxao=;
 b=HW0wpuhROpQ8+KMoSgiohDv4/y4yit8dxYCDHIBpwkRrhKzWjts0ImwP6HfmsuQXZI
 nxFxe45M8PqAToqEM296sFjB86xsN9gWP68mkjlLc7WBMpHna7+NlvG/Gcnf5jRivjZE
 u2vbvikTGzQfA697KSTpLBB9AAVoyBmUnydetkG8bOjVaJgkwuvAC5ocyGE7eqDfMZUH
 QErI9vU/WLRkpycDGd/ypSxCtZ7JxL6XTlWs1QU7phWXF3XnBtHdyXb1V6zJAlObn9oz
 PXCSa4aWNhUZ56FyWJmqVg0cWg/mBQPDONnOT5sjG5Ql7dSFG75azHxxHQ2C3R6AZCwK
 SBKQ==
X-Gm-Message-State: AOJu0YzoDIPj0yTYHfySi1czNavWSh88QjM7ewDTE/PNr48CuHk6rV2V
 DRU1IkfdbH0635nmykgOdPQr8le3L+/SuvYdwRL+LrZQ+GHOdWi5bAe4i+zDyVS5PTg6LP6t/CK
 PSsnW
X-Gm-Gg: AY/fxX4Mpz8ebqNOWQYwM0BN6D3ZoOxKu8EXCn/x1VoDIbMjLAsigok+LKmFVvsYP9V
 5L5dRZUiJAV4OrBlg90/xglAZEYtV532zTDBEVrB35t/bxrr/N1GG1UkX996SwRKsJikpzTP0h3
 VjHibwj6ptQQ0eAKrZrfNJzAYHx0GGSFvJgr9rdPiBNy9yazf7/xWTegDPCGGZq/Eq3JaYz/auI
 NwI5sGXvzYo3nVDZu4G/8GGivybM23ZKWCTezoo29sUQYwKsil/kxl/BJLPLU8AbA43drNtTPRb
 hylOb+W5YdlaTmpaoEF6lEyw8oIKH/R/BAUbGKRuFb9HDwKVwyKUcOHjdH9DI93M0ntG5BfvJxT
 zjgYw0uqMNhJ+1QTzZhMW+Dt3SaRvbufbOM5wSl0eKW3OPhk2CwwSIFVQu/nm+DwtFNt8YXeto7
 urvhjGntCfnPJd5Krx/xc1YT3Qv7f6cyUHvyl+kuBokAp64G5rBQ==
X-Received: by 2002:a17:906:7312:b0:b79:f8ae:a893 with SMTP id
 a640c23a62f3a-b87612c0de9mr24495466b.49.1768335845983; 
 Tue, 13 Jan 2026 12:24:05 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b842a23433asm2314992166b.3.2026.01.13.12.24.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jan 2026 12:24:05 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Cristian Dumitrescu <cristian.dumitrescu@intel.com>
Subject: [PATCH v10 17/18] cfgfile: add length checks and increase line buffer
Date: Tue, 13 Jan 2026 12:21:56 -0800
Message-ID: <20260113202329.35190-18-stephen@networkplumber.org>
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

When adding values to config info, add string length checks instead
of silently truncating. Increase the size of the buffer used to read
from a config file so that there will be enough space for longest
entries.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/rel_notes/release_26_03.rst |  2 ++
 lib/cfgfile/rte_cfgfile.c              | 43 ++++++++++++++++++++------
 lib/cfgfile/rte_cfgfile.h              |  6 +++-
 3 files changed, 41 insertions(+), 10 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_03.rst b/doc/guides/rel_notes/release_26_03.rst
index d643206167..d0c504ba7b 100644
--- a/doc/guides/rel_notes/release_26_03.rst
+++ b/doc/guides/rel_notes/release_26_03.rst
@@ -94,6 +94,8 @@ API Changes
   * hash: name parameter must be less than RTE_HASH_NAMESIZE.
   * efd: name must be less than RTE_EFD_NAMESIZE.
   * tailq: name must be less than RTE_TAILQ_NAMESIZE.
+  * cfgfile: name must be less than CFG_NAME_LEN
+    and value must be less than CFG_VALUE_LEN.
 
 
 ABI Changes
diff --git a/lib/cfgfile/rte_cfgfile.c b/lib/cfgfile/rte_cfgfile.c
index 9723ec756f..1aa8f4a597 100644
--- a/lib/cfgfile/rte_cfgfile.c
+++ b/lib/cfgfile/rte_cfgfile.c
@@ -2,16 +2,24 @@
  * Copyright(c) 2010-2014 Intel Corporation
  */
 
+#include <assert.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
 #include <ctype.h>
 #include <errno.h>
+#include <limits.h>
+
+#ifndef LINE_MAX
+#define LINE_MAX 2048
+#endif
+
 #include <eal_export.h>
 #include <rte_string_fns.h>
 #include <rte_common.h>
 #include <rte_log.h>
 
+
 #include "rte_cfgfile.h"
 
 struct rte_cfgfile_section {
@@ -106,6 +114,9 @@ static int
 _add_entry(struct rte_cfgfile_section *section, const char *entryname,
 		const char *entryvalue)
 {
+	if (strlen(entryname) >= CFG_NAME_LEN || strlen(entryvalue) >= CFG_VALUE_LEN)
+		return -ENAMETOOLONG;
+
 	/* resize entry structure if we don't have room for more entries */
 	if (section->num_entries == section->allocated_entries) {
 		struct rte_cfgfile_entry *n_entries = realloc(
@@ -167,12 +178,16 @@ rte_cfgfile_load(const char *filename, int flags)
 					    &default_cfgfile_params);
 }
 
+/* Need enough space for largest name and value */
+static_assert(LINE_MAX > CFG_NAME_LEN + CFG_VALUE_LEN + 4,
+	      "not enough space for cfgfile name/value");
+
 RTE_EXPORT_SYMBOL(rte_cfgfile_load_with_params)
 struct rte_cfgfile *
 rte_cfgfile_load_with_params(const char *filename, int flags,
 			     const struct rte_cfgfile_parameters *params)
 {
-	char buffer[CFG_NAME_LEN + CFG_VALUE_LEN + 4];
+	char buffer[LINE_MAX];
 	int lineno = 0;
 	struct rte_cfgfile *cfg;
 
@@ -219,7 +234,13 @@ rte_cfgfile_load_with_params(const char *filename, int flags,
 			*end = '\0';
 			_strip(&buffer[1], end - &buffer[1]);
 
-			rte_cfgfile_add_section(cfg, &buffer[1]);
+			int ret = rte_cfgfile_add_section(cfg, &buffer[1]);
+			if (ret != 0) {
+				CFG_LOG(ERR,
+					"line %d - add section failed: %s",
+					lineno, strerror(-ret));
+				goto error1;
+			}
 		} else {
 			/* key and value line */
 			char *split[2] = {NULL};
@@ -260,8 +281,13 @@ rte_cfgfile_load_with_params(const char *filename, int flags,
 			if (cfg->num_sections == 0)
 				goto error1;
 
-			_add_entry(&cfg->sections[cfg->num_sections - 1],
-					split[0], split[1]);
+			int ret = _add_entry(&cfg->sections[cfg->num_sections - 1],
+					     split[0], split[1]);
+			if (ret != 0) {
+				CFG_LOG(ERR,
+					"line %d - add entry failed: %s", lineno, strerror(-ret));
+				goto error1;
+			}
 		}
 	}
 	fclose(f);
@@ -341,6 +367,9 @@ rte_cfgfile_add_section(struct rte_cfgfile *cfg, const char *sectionname)
 	if (sectionname == NULL)
 		return -EINVAL;
 
+	if (strlen(sectionname) >= CFG_NAME_LEN)
+		return -ENAMETOOLONG;
+
 	/* resize overall struct if we don't have room for more	sections */
 	if (cfg->num_sections == cfg->allocated_sections) {
 
@@ -376,8 +405,6 @@ int rte_cfgfile_add_entry(struct rte_cfgfile *cfg,
 		const char *sectionname, const char *entryname,
 		const char *entryvalue)
 {
-	int ret;
-
 	if ((cfg == NULL) || (sectionname == NULL) || (entryname == NULL)
 			|| (entryvalue == NULL))
 		return -EINVAL;
@@ -391,9 +418,7 @@ int rte_cfgfile_add_entry(struct rte_cfgfile *cfg,
 	if (curr_section == NULL)
 		return -EINVAL;
 
-	ret = _add_entry(curr_section, entryname, entryvalue);
-
-	return ret;
+	return _add_entry(curr_section, entryname, entryvalue);
 }
 
 RTE_EXPORT_SYMBOL(rte_cfgfile_set_entry)
diff --git a/lib/cfgfile/rte_cfgfile.h b/lib/cfgfile/rte_cfgfile.h
index 232c65c77b..c2caa830d6 100644
--- a/lib/cfgfile/rte_cfgfile.h
+++ b/lib/cfgfile/rte_cfgfile.h
@@ -131,7 +131,11 @@ rte_cfgfile_add_section(struct rte_cfgfile *cfg, const char *sectionname);
  * @param entryvalue
  *   Entry value to add.
  * @return
- *   0 on success, -EEXIST if entry already exist, -EINVAL if bad argument
+ *   0 on success
+ *   -EEXIST if entry already exist
+ *   -EINVAL if bad argument
+ *   -ENAMETOOLONG - entry excess CFG_NAME_LEN
+ *                   or value exceeds CFG_VALUE_LEN
  */
 int rte_cfgfile_add_entry(struct rte_cfgfile *cfg,
 		const char *sectionname, const char *entryname,
-- 
2.51.0

