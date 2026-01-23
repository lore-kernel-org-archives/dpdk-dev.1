Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B98B5D6CFC1
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Jan 2026 04:31:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7C8F2406B7;
	Fri, 23 Jan 2026 05:30:29 +0100 (CET)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53]) by mails.dpdk.org (Postfix) with ESMTP id A524E40299
 for <dev@dpdk.org>; Fri, 23 Jan 2026 05:30:28 +0100 (CET)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-47edd6111b4so20395535e9.1
 for <dev@dpdk.org>; Thu, 22 Jan 2026 20:30:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769142628;
 x=1769747428; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1v8e6aUWm5WXNa+aLtAVXtjf0nt1Rr3FAXZlKwQAxao=;
 b=N6vMsGdYi6t7NzaU5eZ9GfFRBe5kCWftA/i50dcn1HUwfGeHpuTIiMeVjXmL8FcLNr
 LqG6HIBfS6VrnYiVsSKskv3UKsx5EON7c7dtYPEgwVxMt5ePI/u3y2P9akY0BelgIwtp
 cDyw3pJcjNBlvPQ7KEU1MJd+gWkJlM/p3HnkQFfqVtScwaLLBpcxRH9NotIcEbegqvrA
 Zric8txN6Zu5uVui3wrx53zyLRAADaMqB3PUqTRGyWSI6uggqCfLkeDjjvuPK6VIfBRK
 0WGbcccAhePOYFRgJjFD5YcgsW1shCiTzUOIWiECYozC9AUREfwbSN18M17Ln1EkpV8b
 rbTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769142628; x=1769747428;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1v8e6aUWm5WXNa+aLtAVXtjf0nt1Rr3FAXZlKwQAxao=;
 b=gIZivYRZUuQF4kJGHDMVvqEDNjq9hN1S3KfI3SXlgpMIar9qKSfVVtty9TW1vepgNQ
 Pu7SxU8nLkoEGfVUDljAX2ytaILB9nRoRVRjuGTEDXFGaOrWydor2QdtX2aw83A7Rj7w
 2qCu1T3G1BluRjRF5UrPP+xls31yitnyompcihNeqjpeRgGc2zuBV/zrE/5wEde6COJa
 CCGcnj8XncM5FVYTXEKQIuqyUJNumy1dYJ+7B7weL9Pv1BWJf4Vc3vAyglJtApqIVcjM
 WhPuufmDPsI3iZdF9SktZ5X7f+rM0Z+JIaJrMJyg9GbZznGA6Mhn5HAMOEJfxmAvnoTz
 Afrw==
X-Gm-Message-State: AOJu0YzhFiXsFMIrrGI5HvwxZg/6J1zBSPczUQD3v8WvDiSJ5wIZP/iW
 /Vkty3XcZveF+bbx62I4660MlCBsfQm+92qUEDVxbmFFnkZYlc9aO6FrlT8N8Fzvjr0446A6pZy
 6jP6+
X-Gm-Gg: AZuq6aKaBJpEGa8TeIUHiuqGPP667OqzubTZbKe6AIohz9xtBIFSlBZsCwAf/Ks3quq
 bXQBGWxa7rYKzxf6LR9O+EFS2eQ2K6AuWrRrxjhvvrec5s5Yh5F0zaV6Pcms32oL2wVI8u/Ot/d
 iuQ4NKjro0nKNwo60IXmExbEUZKrw5uDkLEdk41KPs3hNUbv2fb15eQ5ALQCpaEQ4wA0TRxe+j8
 nLdvcvFvNfSnqtBB3mbJKPOLPR3s8A3af5m2H3z13FqzSxUzGEO6poaq0D3AXi3ykdjuF4G31z6
 DZSUu+CZNvDbnb6HCCU9mWy6zn0uFVgdbRyeILMpZ69yDrhhm4rbuHv0xBD711DxzYULKXPT7YO
 QAy1VZ6KWbFVuST6dqMHNTyzE0o3gB/QmE6w8xFR2I7CWhouxqLU4rb7JV8yri/h+B572A5K4t8
 K0wjpwt7qG2SR/kvVqzfYNb8B0+XEbQ3XoHlc4W4PMfEDeB680PA==
X-Received: by 2002:a05:6000:144a:b0:435:9653:e151 with SMTP id
 ffacd0b85a97d-435b1587d3bmr2713517f8f.3.1769142628254; 
 Thu, 22 Jan 2026 20:30:28 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1f7b41asm3603771f8f.39.2026.01.22.20.30.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jan 2026 20:30:27 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Cristian Dumitrescu <cristian.dumitrescu@intel.com>
Subject: [PATCH v11 17/18] cfgfile: add length checks and increase line buffer
Date: Thu, 22 Jan 2026 20:28:15 -0800
Message-ID: <20260123042945.159075-18-stephen@networkplumber.org>
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

