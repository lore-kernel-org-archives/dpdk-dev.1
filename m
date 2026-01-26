Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC2EED19523
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 Jan 2026 23:26:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9F86540DD5;
	Tue, 27 Jan 2026 00:25:08 +0100 (CET)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43]) by mails.dpdk.org (Postfix) with ESMTP id 579D2402DE
 for <dev@dpdk.org>; Tue, 27 Jan 2026 00:25:06 +0100 (CET)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-47fedb7c68dso50933765e9.2
 for <dev@dpdk.org>; Mon, 26 Jan 2026 15:25:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769469906;
 x=1770074706; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8FZ8L2XW48aLy3Uelu7PoqbSCGYSLcGqLis8wRDRENQ=;
 b=Y8jEQt044GoR+e0cEqPNCQJe+SvnsEPOQ4gsyMtUVrxHHZydtueMc61yemP/KhcNl1
 Eb6jG6bSgVF4tiV/jIm9G0wdPXmsWgoKcCnI4r8BwB8AbBznAlWvaZl3daPvHSAF/nlk
 LS88QueSLJSILuM4R0fjyZC1TON3CaNktEbJCWj4WqUvTYjuX6PlRRuaQPgMSTbXHmLO
 +2OiL7Nwr1qPfuYICnS3EIfVTuUHXJNze4Mv4csTECiB2SQ508KmktvwSJXYutLOcRIC
 ArgIKVbPhMmKJFY8fz7aFc51q1ANCi3suldPJd7p9V6r5vapO5wPlDOapHORKxVkRw11
 RqIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769469906; x=1770074706;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8FZ8L2XW48aLy3Uelu7PoqbSCGYSLcGqLis8wRDRENQ=;
 b=cKHKs1z/Ft/3JqEF/DKOo3miDcN3wZD1Mo3PkE9AXNPJYfW33BtkmrtDvsqZfQpQDO
 Vplmmfii4prE+oNHRaJm7uK1N02fWwJ9vRmo2MiSBMPc0ReCD7l1/IIDzbvw/ufc9YqS
 mu1UDd4HJ/TxYpwXppK3q5+dxT7ESpSi1orquQ2B6AXwV/9EYGYR1r0NhXXvth42H2M2
 rKQpMYrJSQ8cfVU1zgxyZGGWRvzo7uxxTfum8yXZdxFIjx347cHTvbOhpNYnq+jidGnO
 zc1u+mxwHOFFv8CpkmbdZrHgeVDZ+DX+lsozY99wVMpT0FH3SjTHBQZhQZV9Eh47SHo2
 dAkw==
X-Gm-Message-State: AOJu0Yz2gjDqW1T1Se8eCs6FMPqM3+2fzOUyvbZ9GFuDy6MQZjRkNIg3
 zR26ptX4mRGTF61jVOiQGdYJNZNfk/J1kvWyYZaUbelhiKZf7AAxxgi+P/X7BUpIs8nO8PSY4od
 ecCLw
X-Gm-Gg: AZuq6aL7lDNA2axCT+woAZba9CxXSVRZty10EsW3QPHqXZgfqV9/07ubfxyqlUrYjiZ
 F/MY1GtWh4BXoKTpImFN5fMjd02pkZUDfJSj4sOoCYeGlglrLJ7ncEVCkGL34EMY0+K/ZGyWSF8
 yI+tP15UKIoolztBIohAe7la3rKDHwuFdcc9P1W+ZuX75hvyQgIvWc6QlUYTKYYBeiHx8AlJGNj
 bpY1qXt0drM9s/10U8iya08UR4y5b1dJZiPBeZO+LBNAbDlQR4MH28IDkdpqFX6sgkRs2/EySvc
 tzrXsCLt9svCSOKYiHA+wQ9rkaqqPkgHzwXiOiImO/6Q1v2m2+JXE8ibe859vUOrsy9uz45NeSf
 uxvg1Cl5mZUO6ehubm8z6/fGb7EMG36o5Ihoqt6L4JewwJRxMiRUIA0qsb5eJCyvOZzSoksVfwd
 4G4zH5FSA9hT4BK9QBJyNaXDbaXJTl81xc80YAQQrYWCgqx75LrMowCmxP4uva
X-Received: by 2002:a05:600c:1994:b0:480:6852:8d94 with SMTP id
 5b1f17b1804b1-48068528e9fmr2408135e9.27.1769469905919; 
 Mon, 26 Jan 2026 15:25:05 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1c24a6fsm33711846f8f.16.2026.01.26.15.25.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 15:25:05 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Cristian Dumitrescu <cristian.dumitrescu@intel.com>
Subject: [PATCH v12 16/17] cfgfile: add length checks and increase line buffer
Date: Mon, 26 Jan 2026 15:22:24 -0800
Message-ID: <20260126232428.276534-17-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260126232428.276534-1-stephen@networkplumber.org>
References: <20251202172626.283094-1-stephen@networkplumber.org>
 <20260126232428.276534-1-stephen@networkplumber.org>
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

