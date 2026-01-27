Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E3EAD340A6
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Jan 2026 16:34:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5116341143;
	Tue, 27 Jan 2026 17:33:39 +0100 (CET)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
 [209.85.221.43]) by mails.dpdk.org (Postfix) with ESMTP id 6F64841149
 for <dev@dpdk.org>; Tue, 27 Jan 2026 17:33:38 +0100 (CET)
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-42fb6ce71c7so5476909f8f.1
 for <dev@dpdk.org>; Tue, 27 Jan 2026 08:33:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769531618;
 x=1770136418; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RAlxnBkHlv5wSRNBXmOYYx02K+0gg6YQehuzT63SVWI=;
 b=qBLh3qOyl8Fa7jyuTUAbFPJ/Jrd1fMBeaHVm7RiGxdslCrt/W9fqFhvacOl8jwr46t
 mTkGA7js6TECKQAxtFPK9juqhE19kmqw1PTKVWPFbucMWgvkm93QnPcNYpWw2Dyb7SCn
 2cys8gR+5bRSt59yd6yZZef84AwnN0Yfd1EpDD8gED9KUsbidI47kcvxMG6VwJTKvQLW
 MQ5IBxt9niLwiN7eluQ/4dT+dSXaeTZ3FIJhMqvB6JKe+yR9F65YTCjqlZQFQ/wzYyTi
 Oe63r1DZ2IGL5X1rrxWxapFFvrHY4uPbzUSfBC2yTs5wn932cCUI9kditAqg4lozd0f7
 5BoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769531618; x=1770136418;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RAlxnBkHlv5wSRNBXmOYYx02K+0gg6YQehuzT63SVWI=;
 b=X4fljuP//trWO2Imm6VVnLVBrw07mPUlWXxJ2D51PkRMnC4etlPKrJJy2dpDEdO/lL
 4Cv+42SohIQ66IvDhZ5WZkk/F2h4J7lPDjqLTGd7vFUV4cdTw6M0KtJRrOlBHR+AEqVg
 JD5gHly4JDuP8plCntxyKBRUCKsv+qIEoF2mQi2tJOqpw0UlMqbDPjBvVFG+Y3SA/uSO
 pkzhT3jEPD6I/FLJNmccK1J5jyG3wr6Mdzw9mriLVz/E1L2afHAULssQt+SLM5oOn+6L
 5G2Ks0X5LXCmhegkSYQV4zAb0cd4iBlRqOwDxmN2sqOxAww/TdVi0TEmU41HUviyBV7N
 8UkA==
X-Gm-Message-State: AOJu0YytrSy4Z+9/ekIHyMljfoF15zDqSXBd5CdrJ4WGtrZ8wmTIC5Ll
 OQyDkbJ0IR+EKj4o3M9Fxkgq9FnRXSuRdH1CxV40gQm6xpv2qUEXAmpnk26gvDaGSih209IloQF
 o/4d5
X-Gm-Gg: AZuq6aIC976m4SEb6xsjv/tyQQg3STrDbVw7qAMdcu28TrrmmHUm48b6X2It7qzPGCt
 fHkfzbxDxXLhpTFghAZ/yyNEi+Hk1e3bgn3P3SMPX9ypKi5SU1luY3aSUqgsdv9JowYo8mv7sBN
 WVMADfrS+x19egToK19Y2YSeuTKWC3ZhY+Tt0JCgpjo2xjjq9fMaXHoxeFq4XHS2NNYGf0CN1Df
 TOAJ81gctU73XPut/HEfq6yZT3dcgvv0RLHccWfi3dSQ6ZKdT8wmJ+3LvrKTaVFbMafTko+86r4
 6AX0JgDm+pcLDUbw/HVyP3EIIOFDVP8ZWVLitlV/YbT178Yb+qqnl7Z6XlXrDUt6X9L3DE13Zb8
 yHy9xDKX6MljT/CbrnchCsxEXkmy9jEvIMWimXqEJvGhHUFMupktfwY/6fWHz9gXANUHXrtMETb
 Zq4hrCei1dOqFiPwVuIxP/9rx05TgZSCQNtFd89Xn6D9y0Q6vZIw==
X-Received: by 2002:a5d:588d:0:b0:435:a83e:88e with SMTP id
 ffacd0b85a97d-435dd02173amr3204789f8f.2.1769531617943; 
 Tue, 27 Jan 2026 08:33:37 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1f745dbsm39978513f8f.34.2026.01.27.08.33.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jan 2026 08:33:37 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Cristian Dumitrescu <cristian.dumitrescu@intel.com>
Subject: [PATCH v13 16/17] cfgfile: add length checks and increase line buffer
Date: Tue, 27 Jan 2026 08:30:30 -0800
Message-ID: <20260127163258.75566-17-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260127163258.75566-1-stephen@networkplumber.org>
References: <20251202172626.283094-1-stephen@networkplumber.org>
 <20260127163258.75566-1-stephen@networkplumber.org>
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
 lib/cfgfile/rte_cfgfile.c              | 42 ++++++++++++++++++++------
 lib/cfgfile/rte_cfgfile.h              |  6 +++-
 3 files changed, 40 insertions(+), 10 deletions(-)

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
index 9723ec756f..95151b231c 100644
--- a/lib/cfgfile/rte_cfgfile.c
+++ b/lib/cfgfile/rte_cfgfile.c
@@ -2,11 +2,18 @@
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
@@ -106,6 +113,9 @@ static int
 _add_entry(struct rte_cfgfile_section *section, const char *entryname,
 		const char *entryvalue)
 {
+	if (strlen(entryname) >= CFG_NAME_LEN || strlen(entryvalue) >= CFG_VALUE_LEN)
+		return -ENAMETOOLONG;
+
 	/* resize entry structure if we don't have room for more entries */
 	if (section->num_entries == section->allocated_entries) {
 		struct rte_cfgfile_entry *n_entries = realloc(
@@ -167,12 +177,16 @@ rte_cfgfile_load(const char *filename, int flags)
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
 
@@ -219,7 +233,13 @@ rte_cfgfile_load_with_params(const char *filename, int flags,
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
@@ -260,8 +280,13 @@ rte_cfgfile_load_with_params(const char *filename, int flags,
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
@@ -341,6 +366,9 @@ rte_cfgfile_add_section(struct rte_cfgfile *cfg, const char *sectionname)
 	if (sectionname == NULL)
 		return -EINVAL;
 
+	if (strlen(sectionname) >= CFG_NAME_LEN)
+		return -ENAMETOOLONG;
+
 	/* resize overall struct if we don't have room for more	sections */
 	if (cfg->num_sections == cfg->allocated_sections) {
 
@@ -376,8 +404,6 @@ int rte_cfgfile_add_entry(struct rte_cfgfile *cfg,
 		const char *sectionname, const char *entryname,
 		const char *entryvalue)
 {
-	int ret;
-
 	if ((cfg == NULL) || (sectionname == NULL) || (entryname == NULL)
 			|| (entryvalue == NULL))
 		return -EINVAL;
@@ -391,9 +417,7 @@ int rte_cfgfile_add_entry(struct rte_cfgfile *cfg,
 	if (curr_section == NULL)
 		return -EINVAL;
 
-	ret = _add_entry(curr_section, entryname, entryvalue);
-
-	return ret;
+	return _add_entry(curr_section, entryname, entryvalue);
 }
 
 RTE_EXPORT_SYMBOL(rte_cfgfile_set_entry)
diff --git a/lib/cfgfile/rte_cfgfile.h b/lib/cfgfile/rte_cfgfile.h
index 232c65c77b..761420facd 100644
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
+ *   -ENAMETOOLONG - entry exceeds CFG_NAME_LEN
+ *                   or value exceeds CFG_VALUE_LEN
  */
 int rte_cfgfile_add_entry(struct rte_cfgfile *cfg,
 		const char *sectionname, const char *entryname,
-- 
2.51.0

