Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A2BBD46C16
	for <dpdk-dev@archiver.kernel.org>; Thu, 29 Jan 2026 01:44:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D2D024066D;
	Thu, 29 Jan 2026 02:43:58 +0100 (CET)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53]) by mails.dpdk.org (Postfix) with ESMTP id 385AB4042F
 for <dev@dpdk.org>; Thu, 29 Jan 2026 02:43:53 +0100 (CET)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-48069a48629so4475955e9.0
 for <dev@dpdk.org>; Wed, 28 Jan 2026 17:43:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769651033;
 x=1770255833; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RAlxnBkHlv5wSRNBXmOYYx02K+0gg6YQehuzT63SVWI=;
 b=pWQl7uIKQ+y1py+LhxFYs/VEtu/lfaaJNHpAUgKbVFnD5TUk5iKlORKKpJXNpErOuo
 C+fqL3yPt9ti5zBMlHKeEi9y6isFb6QQHwBNTIZEpTSUvrjEa70I8iV6vt6c7/5fD0RD
 R2FhF31ZT5hiXFPNRz382dyDcYrhBDKNcMqitmInmAJj7BNZVji8W56TKzAJA1RlQiud
 SJfOmj10jNOy5H8VLkvZqOLV/Al2/hvbOwjTlvGE2E9qFIRh8ctvntorQlThWwPi3n8P
 rd79gpyZHVhmOA5DDhDA78AynAixT/zJRP7rO71O6xumxtbJ/5WGFTgNml9OSbsFXUBK
 rz+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769651033; x=1770255833;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RAlxnBkHlv5wSRNBXmOYYx02K+0gg6YQehuzT63SVWI=;
 b=Lu2IfO7r3C62B4N5hEfgvXqPAH3UAPolbcFbr5hbzxLf59e4urvEowJolCNS+ZGCAW
 jPMKYsAGZ5iVpPNqILe0X/uWXj0BCKa3dRy+5+r5R0fBump+WEMcWIlLFma1CghCwAng
 8s3lB1hCiQPzsBU6CmnD+1WkovOJPQCsevTf27djjaGU/eSJ4Dzk9j9D0VaeiitL/qYR
 zgGAXcQ8xiKnmTCAlPeuI/F6huAOjYD/gfMkpdIxGar90hGmxCygyP/VBfr2itl4HX/R
 SN+HGo0lUCVvHc4hYMQfBxMZTP716UD0XwH6Hc8VAxI3/eLCM/phyvrdyNdDcYUYWLDe
 pOUQ==
X-Gm-Message-State: AOJu0YzpTYR7TX+P14W0icJTVKLowYXq30tItHULcHmOsdI69Le3waeh
 IBemghTkgmLzFvUysdIFppkt2P6RsmYZWcvjOm3Zlm0NGeHCnqbcZjhcQQDLAs2F4u5yfytolM7
 nrOxu
X-Gm-Gg: AZuq6aK/g0xaC+lSeOa6NpxlPfKtczYAgb2Y9cj4wflIVqBzETxgzTL/uBHpJfK70WK
 UjOnamOcLZB41Oj6uPEkatfy1R57e9z2uuW0CbQ2m2lUZQ1eLeYDD6xlcKO43M9sFq1zWL5j7uv
 YFTjtrCzJ0bXrgNpKwj8BvAM/wFUi7OIyyHomtXi38sMe6TdXJhSeJ8+66PYMbLOIi5eMjpCXCh
 8QRUbR3pfiTqun2hV9zeoDILs4/cSlwFLn3U7u166ffoVYqj2g2bhqEhIh7RWWwfW1i86RwRr4Q
 wDL+J4zNozBldFggyFkH/AnLF+kjW6BP7ZbMSWdYqjZLgynmrXfvp9S3hEiPhxJdwSf2cyUlmst
 KCJHRNfW7SoqIE0JytRyKTGGmibHj2qoVjRszh/2bir0WUl9h7OC/L5HDz2ppcbefIGZ4kOv1bs
 vAkDwG/BwfK5q66G4BXmMREJTcKVY1GzCzdaHJ+JU70qdN0G+ZodKXGZn8ojJd
X-Received: by 2002:a05:600c:190a:b0:47d:3690:7490 with SMTP id
 5b1f17b1804b1-48069c1c208mr93734015e9.9.1769651032791; 
 Wed, 28 Jan 2026 17:43:52 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-481a5e18427sm3217985e9.16.2026.01.28.17.43.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jan 2026 17:43:52 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Cristian Dumitrescu <cristian.dumitrescu@intel.com>
Subject: [PATCH v14 16/17] cfgfile: add length checks and increase line buffer
Date: Wed, 28 Jan 2026 17:41:19 -0800
Message-ID: <20260129014313.939831-17-stephen@networkplumber.org>
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

